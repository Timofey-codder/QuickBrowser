#include "database.h"
#include "QDebug"
#include "QDir"

QString CurrentName;
QString CurrentAge;
QSqlDatabase db;

Database::Database(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(QDir::currentPath() + "/usersdatabase.db");
    qDebug() << QDir::currentPath();
    db.open();
}

bool Database::databasecheck(QString username_enter, QString password_enter)
{

    QSqlQuery query;
    query.exec("SELECT username, age, password FROM users");

    while (query.next())
    {
    QString username = query.value(0).toString();
    QString age = query.value(1).toString();
    QString password = query.value(2).toString();

    if (username_enter == username && password_enter == password)
    {
        CurrentName = username;
        CurrentAge = age;

        return true;
    }
    }
    return false;


}

QString Database::setname()
{
    return CurrentName;
}

QString Database::setage()
{
    return CurrentAge;
}


bool Database::registration(QString username_enter, QString password_enter, QString age)
{
    if (age.toInt() >= 100 || age.toInt() <= 0 || username_enter == "" || age == "" || password_enter == "")
    {
        return false;
    }

    QSqlQuery query;
    query.exec("SELECT username, age, password FROM users");

    while (query.next())
    {
    QString username = query.value(0).toString();

    if (username_enter == username)
    {
        return false;
    }
    }

    QSqlQuery query_write;
    query_write.prepare("INSERT INTO users (username, password, age) VALUES (:q1, :q2, :q3);");
    query_write.bindValue(":q1",username_enter);
    query_write.bindValue(":q2",password_enter);
    query_write.bindValue(":q3",age.toInt());

    if (!query_write.exec()) {qDebug()<<"не записалось";}
    else {qDebug()<<"записалось";}


    CurrentName = username_enter;
    CurrentAge = age;

    return true;
}



QStringList Database::words()
{
    QStringList list;
    if (CurrentAge.toInt() <= 18)
    {
        QSqlQuery query_words;
        query_words.exec("SELECT age_18 FROM words");

        while (query_words.next())
        {
            list << query_words.value(0).toString();
        }
        return list;
    }
    else
        return list;
}
