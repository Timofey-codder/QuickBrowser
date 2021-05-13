#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qtwebengineglobal.h>
#include <QString>
#include <QQmlContext>

#include <database.h>

int main(int argc, char *argv[])
{
    Database database;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::applicationDirPath();

    QtWebEngine::initialize();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("database", &database);

    engine.load(url);

    return app.exec();
}
