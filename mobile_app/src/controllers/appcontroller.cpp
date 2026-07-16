#include "appcontroller.hpp"

#include <QDebug>
#include <QThreadPool>
#include <QQmlApplicationEngine>

AppController::AppController()
{
    initQmlTypes();
    qInfo() << "AppController::AppController()";
}

AppController::~AppController()
{
    qInfo() << "AppController::~AppController()";

    QThreadPool::globalInstance()->waitForDone(3000);
}

void AppController::initQmlTypes()
{
    qmlRegisterSingletonInstance("smartpeggy", 1, 0, "AppController", this);
}

void AppController::setWindowScale(float val)
{
    if (qFuzzyCompare(m_windowScale, val))
        return;
    m_windowScale = val;
    emit windowScaleChanged();
}

float AppController::displayScale() const
{
    const float normalPixelDensity = 5.5;
    const float maxScale = 2.5;

    if(m_pixelDensity > normalPixelDensity) {
        float const scale = m_pixelDensity / normalPixelDensity;

        if(scale > maxScale)
            return maxScale;
        return scale;
    } else {
        return 1;
    }
}

void AppController::setPixelDensity(float val)
{
    if(qFuzzyCompare(m_pixelDensity, val))
        return;
    m_pixelDensity = val;
    emit displayScaleChanged();
}
