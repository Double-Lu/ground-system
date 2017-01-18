#include "ros/ros.h"
#include <geometry_msgs/Pose2D.h>
#include <turtlesim/Pose.h>
#include <geometry_msgs/Twist.h>
#include <turtlesim/Spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <string>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <signal.h>
#include <sys/wait.h>
#include <pthread.h>
#include "turtle_position_service.h"

#define BACKLOG 10     // how many pending connections queue will hold
#define PORT "7755"    // the port users will be connecting to

#define COMMAND_PORT "8888"

#define MAXBUFLEN 100

int sockfd;
struct addrinfo hints, *servinfo, *p;
int rv;
int numbytes;

double current_x_goal = 0.0, current_y_goal = 0.0;


double prev_x = 0.0, prev_y = 0.0, prev_theta = 0.0;


geometry_msgs::Twist vel_msg;

int listener_sockfd, new_fd;  // listen on sock_fd, new connection on new_fd
struct addrinfo listener_hints, *listener_servinfo, *listener_p;
struct sockaddr_storage their_addr; // connector's address information
socklen_t sin_size;
struct sigaction sa;
int yes=1;
char s[INET6_ADDRSTRLEN];
int listener_rv;
bool STOP = false;


pthread_t * command_listener_thread;




// get sockaddr, IPv4 or IPv6:
/*void *get_in_addr(struct sockaddr *sa)
{
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }

    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}*/

int run_server(void)
{
    fd_set master;    // master file descriptor list
    fd_set read_fds;  // temp file descriptor list for select()
    int fdmax;        // maximum file descriptor number

    int listener;     // listening socket descriptor
    int newfd;        // newly accept()ed socket descriptor
    struct sockaddr_storage remoteaddr; // client address
    socklen_t addrlen;

    char buf[256];    // buffer for client data
    int nbytes;

    char remoteIP[INET6_ADDRSTRLEN];

    int yes=1;        // for setsockopt() SO_REUSEADDR, below
    int i, j, rv;

    struct addrinfo hints, *ai, *p;

    FD_ZERO(&master);    // clear the master and temp sets
    FD_ZERO(&read_fds);

    // get us a socket and bind it
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;
    if ((rv = getaddrinfo(NULL, COMMAND_PORT, &hints, &ai)) != 0) {
        fprintf(stderr, "selectserver: %s\n", gai_strerror(rv));
        exit(1);
    }
    
    for(p = ai; p != NULL; p = p->ai_next) {
        listener = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
        if (listener < 0) { 
            continue;
        }
        
        // lose the pesky "address already in use" error message
        setsockopt(listener, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int));

        if (bind(listener, p->ai_addr, p->ai_addrlen) < 0) {
            close(listener);
            continue;
        }

        break;
    }

    // if we got here, it means we didn't get bound
    if (p == NULL) {
        fprintf(stderr, "selectserver: failed to bind\n");
        exit(2);
    }

    freeaddrinfo(ai); // all done with this

    // listen
    if (listen(listener, 10) == -1) {
        perror("listen");
        exit(3);
    }

    // add the listener to the master set
    FD_SET(listener, &master);

    // keep track of the biggest file descriptor
    fdmax = listener; // so far, it's this one

    // main loop
    for(;;) {
        read_fds = master; // copy it
        if (select(fdmax+1, &read_fds, NULL, NULL, NULL) == -1) {
            perror("select");
            exit(4);
        }

        // run through the existing connections looking for data to read
        for(i = 0; i <= fdmax; i++) {
            if (FD_ISSET(i, &read_fds)) { // we got one!!
                if (i == listener) {
                    // handle new connections
                    addrlen = sizeof remoteaddr;
                    newfd = accept(listener,
                        (struct sockaddr *)&remoteaddr,
                        &addrlen);

                    if (newfd == -1) {
                        perror("accept");
                    } else {
                        FD_SET(newfd, &master); // add to master set
                        if (newfd > fdmax) {    // keep track of the max
                            fdmax = newfd;
                        }
                        printf("selectserver: new connection from %s on "
                            "socket %d\n",
                            inet_ntop(remoteaddr.ss_family,
                                get_in_addr((struct sockaddr*)&remoteaddr),
                                remoteIP, INET6_ADDRSTRLEN),
                            newfd);
                    }
                } else {
                    // handle data from a client
                    if ((nbytes = recv(i, buf, sizeof buf, 0)) <= 0) {
                        // got error or connection closed by client
                        if (nbytes == 0) {
                            // connection closed
                            printf("selectserver: socket %d hung up\n", i);
                        } else {
                            perror("recv");
                        }
                        close(i); // bye!
                        FD_CLR(i, &master); // remove from master set
                    } else {
                        // we got some data from a client
                        printf("Just received %s\n", buf);
                        std::string x_str = "", y_str = "";
                        bool reading_x = true, done = false;
                        for(int k = 0; k < sizeof(buf)/sizeof(buf[0]) && !done; k++){
                            char cur = buf[k];
                            if(cur == ','){
                                reading_x = false;
                                continue;
                            }
                            if(cur == '('){
                                continue;
                            }
                            if(cur == ')'){
                                done = true;
                                break;
                            }
                            if(reading_x){
                                x_str.append(&cur);
                                printf("adding %c to x_str...\n", cur);
                            } else {
                                y_str.append(&cur);
                                printf("adding %c to y_str...\n", cur);
                            }

                        }

                        /*vel_msg.angular.z = vel_msg.angular.z > 0 ? 0.0 : 4.0;


*/
                        printf("I read x: %s, and y: %s\n", x_str.c_str(), y_str.c_str());
                        vel_msg.linear.x = vel_msg.linear.x > 0 ? 0.0 : 0.5;

                        double new_x_goal = atof(x_str.c_str());
                        double new_y_goal = atof(y_str.c_str());

                        printf("I have a new_x_goal %f and a new_y_goal: %f\n", new_x_goal, new_y_goal);
                        if (send(i, buf, nbytes, 0) == -1) {
                            perror("send");
                        }
                    }
                } // END handle data from client
            } // END got new incoming connection
        } // END looping through file descriptors
    } // END for(;;)--and you thought it would never end!
    
    return 0;
}

void sigchld_handler(int s)
{
    // waitpid() might overwrite errno, so we save and restore it:
    int saved_errno = errno;

    while(waitpid(-1, NULL, WNOHANG) > 0);

    errno = saved_errno;
}


void * command_listener_routine(void * arg){
    run_server();
    exit(0);
}
/*void * command_listener_routine(void * arg){

    printf("in command_listener_routine....\n");

    memset(&listener_hints, 0, sizeof listener_hints);
    listener_hints.ai_family = AF_UNSPEC;
    listener_hints.ai_socktype = SOCK_STREAM;
    listener_hints.ai_flags = AI_PASSIVE; // use my Ilistener_p
    if ((listener_rv = getaddrinfo(NULL, COMMAND_PORT, &listener_hints, &listener_servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(listener_rv));
        return NULL;
    }

    // loolistener_pthrough all the results and bind to the first we can
    for(listener_p= listener_servinfo; listener_p!= NULL; listener_p= listener_p->ai_next) {
        if ((listener_sockfd = socket(listener_p->ai_family, listener_p->ai_socktype,
                listener_p->ai_protocol)) == -1) {
            perror("server: socket");
            continue;
        }

        if (setsockopt(listener_sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
                sizeof(int)) == -1) {
            perror("setsockopt");
            exit(1);
        }

        if (bind(listener_sockfd, listener_p->ai_addr, listener_p->ai_addrlen) == -1) {
            close(listener_sockfd);
            perror("server: bind");
            continue;
        }

        break;
    }
    printf("done binding TCP socket\n");

    freeaddrinfo(listener_servinfo); // all done with this structure

    if (listener_p== NULL)  {
        fprintf(stderr, "server: failed to bind\n");
        exit(1);
    }

    if (listen(listener_sockfd, BACKLOG) == -1) {
        perror("listen");
        exit(1);
    }

    sa.sa_handler = sigchld_handler; // realistener_pall dead processes
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGCHLD, &sa, NULL) == -1) {
        perror("sigaction");
        exit(1);
    }


   
    printf("server: waiting for connections...\n"); 


    while(1) { // main accept() loolistener_p        sin_size = sizeof their_addr;
        new_fd = accept(listener_sockfd, (struct sockaddr *)&their_addr, &sin_size);
        if (new_fd == -1) {
            perror("accept");
            exit(0);
        }

        inet_ntop(their_addr.ss_family,
            get_in_addr((struct sockaddr *)&their_addr),
            s, sizeof s);

        printf("server: got connection from %s\n", s);
        char buf[512];
        int byte_count;
        while (byte_count > 0){
            byte_count = recv(listener_sockfd, buf, sizeof(buf), 0); 
            printf("Received command: %s which had %d bytes\n", buf, byte_count);

        }
        if(byte_count < 0){

 
        }

        vel_msg.angular.z = vel_msg.angular.z > 0 ? 0.0 : 4.0;
        vel_msg.linear.x = vel_msg.linear.x > 0 ? 0.0 : 0.5;




        close(new_fd);  // parent doesn't need this

    }
	exit(0);

}*/


std::string turtle_name;


void positionReported(const turtlesim::PoseConstPtr& msg){

	std::ostringstream myString;
	myString << "" << msg->x << "," << msg->y << "";
    if(msg->x != prev_x || msg->y != prev_y){

        std::string position = myString.str();
        //printf("looking at message: %s\n", position.c_str());

        if ((numbytes = sendto(sockfd, position.c_str(), strlen(position.c_str()), 0,
                 p->ai_addr, p->ai_addrlen)) == -1) {
            printf("packet error!\n");
            perror("talker: sendto");
            exit(1);
        }
        else {
            //printf("sent packet!\n");
        }

    }
    prev_x = msg->x;
    prev_y = msg->y;
    prev_theta = msg->theta;

}

int main(int argc, char ** argv){

    command_listener_thread = (pthread_t*)malloc(sizeof(pthread_t));

    printf("Starting main...\n");
    vel_msg.angular.z = 0.0;
    vel_msg.linear.x = 0.0;

    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_DGRAM;

    if ((rv = getaddrinfo("127.0.0.1", PORT, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        return 1;
    }

    // loop through all the results and make a socket
    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((sockfd = socket(p->ai_family, p->ai_socktype,
                p->ai_protocol)) == -1) {
            perror("talker: socket");
            continue;
        }

        break;
    }

    if (p == NULL) {
        fprintf(stderr, "talker: failed to create socket\n");
        return 2;
    }


    printf("done setting up UDP socket\n");



	ros::init(argc, argv, "uas_turtle_pose");
    ros::NodeHandle node;   

	if (argc != 2){ROS_ERROR("need turtle name as argument"); return -1;};

	turtle_name = argv[1];
	ros::Subscriber sub = node.subscribe(turtle_name+"/pose", 10, &positionReported);
    ros::Publisher pub = node.advertise<geometry_msgs::Twist>(turtle_name + "/cmd_vel", 100);

    printf("done setting subs and pubs\n");

    ros::Rate loop_rate(10);                                            // freq to run loops in (10 Hz)

    printf("Ready to send position commands");                        // let user know we are ready and good


    pthread_create(command_listener_thread, NULL, command_listener_routine, NULL);
    printf("finished dispatching listener thread\n");

    while (ros::ok() && node.ok() )                                        // while ros and the node are ok
    {
        ros::spinOnce();
        if (STOP == false)                                              // and no stop command
        {
            //printf("Processing...\n");
            pub.publish(vel_msg);
        }
        else
        {
            printf("Waiting...\n");
        }
        loop_rate.sleep();                                              // sleep to maintain loop rate
    }

    pthread_join(*command_listener_thread, NULL);
    free(command_listener_thread);
	exit(0);
	return 0;
}
