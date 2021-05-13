#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QSqlQuery>

class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = nullptr);

public slots:
    bool databasecheck(QString username_enter, QString password_enter);
    QString setname();
    QString setage();
    bool registration(QString username_enter, QString password_enter, QString age);
    QStringList words();
};

#endif // DATABASE_H
