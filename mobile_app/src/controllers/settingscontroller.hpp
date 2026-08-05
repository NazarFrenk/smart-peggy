#pragma once

#include <QObject>
#include <qqmlintegration.h>

class SettingsController : public QObject
{
    Q_OBJECT
    QML_UNCREATABLE("ro");
    QML_SINGLETON

public:
    explicit SettingsController(QObject *parent = nullptr);

signals:
};
