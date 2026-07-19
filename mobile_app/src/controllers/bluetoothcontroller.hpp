#pragma once

#include <QObject>
#include <QtQml/qqmlregistration.h>

class BluetoothController : public QObject
{
    Q_OBJECT
    QML_UNCREATABLE("ro")
    QML_SINGLETON

public:
    explicit BluetoothController(QObject *parent = nullptr);

signals:
};
