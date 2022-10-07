#ifndef MAINWINDOW_H
#define MAINWINDOW_H
#include <QPushButton>
#include <QFile>
#include <QMainWindow>
#include <QMap>
#include <QList>



QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    QList<QString> Commandlist;
    QMap<QString , QPushButton*> mapList;
    QMap<QString,int> coordListH;
    QMap<QString,int> coordListV;
    int counter = 0;


    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    void assignvalue();
    void readfile();

private slots:
    void on_pushButton_11_clicked();
    void timeF();
private:
    Ui::MainWindow *ui;
    QTimer *timer;
};



#endif // MAINWINDOW_H
