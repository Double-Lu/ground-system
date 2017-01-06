#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>


#include "roscontroller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    ROSController rosController;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("ROSController", &rosController);

//    cv::Mat toDisplay(cv::Size(800, 600), CV_8UC3, cv::Scalar(50, 200, 50));
//    cv::imshow("Test", toDisplay);
//    cv::waitKey();

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
