#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QTimer>
#include <QWindow>

#include "appcontroller.hpp"

int main(int argc, char *argv[])
{
    // Threaded rendering handles Surface recreation after screen lock.
    qputenv("QSG_RENDER_LOOP", "threaded");
    qputenv("QT_QPA_PLATFORM", "android");

    // Use OpenGL ES instead of Vulkan.
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);

    QGuiApplication app(argc, argv);

    // Android may recreate the Surface after applicationStateChanged.
    const auto requestFrame = []() {
        for (QWindow *window : QGuiApplication::topLevelWindows()) {
            if (auto *quickWindow = qobject_cast<QQuickWindow *>(window)) {
                quickWindow->requestUpdate();
            }
        }
    };

    QObject::connect(&app, &QGuiApplication::applicationStateChanged,
                     [&app, requestFrame](Qt::ApplicationState state) {
        if (state != Qt::ApplicationActive)
            return;

        requestFrame();
        for (const int delay : {16, 100, 300, 700}) {
            QTimer::singleShot(delay, &app, requestFrame);
        }
    });

    AppController c;

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("smartpeggy", "Main");

    // Request another frame when the window becomes visible again.
    for (QWindow *window : QGuiApplication::topLevelWindows()) {
        if (auto *quickWindow = qobject_cast<QQuickWindow *>(window)) {
            QObject::connect(quickWindow, &QWindow::visibilityChanged,
                             [&app, requestFrame](QWindow::Visibility visibility) {
                if (visibility != QWindow::Hidden) {
                    QTimer::singleShot(0, &app, requestFrame);
                    QTimer::singleShot(100, &app, requestFrame);
                }
            });
        }
    }

    return app.exec();
}
