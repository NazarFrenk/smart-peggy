#pragma once

#include <QObject>
#include <QtQml/qqmlregistration.h>

class AppController: public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("ro")
    QML_SINGLETON

    Q_PROPERTY(float windowScale READ windowScale WRITE setWindowScale NOTIFY windowScaleChanged FINAL)
    Q_PROPERTY(float displayScale READ displayScale WRITE setPixelDensity NOTIFY displayScaleChanged)

public:
    explicit AppController();

    ~AppController() override;

    void initQmlTypes();

Q_SIGNALS:
    void windowScaleChanged();
    void displayScaleChanged();

private:
    float windowScale() const { return m_windowScale; }
    void setWindowScale(float val);

    float displayScale() const;
    void setPixelDensity(float val);

    float m_windowScale{};
    float m_pixelDensity{};
};
