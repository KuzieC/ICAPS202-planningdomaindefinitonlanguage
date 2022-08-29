
#include <QFile>
#include <QTimer>
#include <QTextStream>
#include <QVector>
#include <QtDebug>
#include "mainwindow.h"//双引号的头文件放到最后
#include "./ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::readfile(){//这个函数实现应该挪到cpp里面。
QFile file("../klostki2/result.txt");//用相对路径，不要用绝对路径
   if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
           return;
       QTextStream in(&file);//头文件没有加
       while (!in.atEnd()) {
           QString line = in.readLine();
           //std::string comm = line.toStdString();
           Commandlist.push_back(line);
       }
}

void MainWindow::assignvalue(){
    mapList["g41"] = ui->g41;
    mapList["g11"] = ui->g11;
    mapList["g12"] = ui->g12;
    mapList["g13"] = ui->g13;
    mapList["g14"] = ui->g14;
    mapList["g2h1"]= ui->g2h1;
    mapList["g2v1"]= ui->g2v1;
    mapList["g2v2"]= ui->g2v2;
    mapList["g2v3"]= ui->g2v3;
    mapList["g2v4"]= ui->g2v4;
    coordListH["s1"] = 230;
    coordListV["s1"] = 230;
    coordListH["s2"] = 280;
    coordListV["s2"] = 230;
    coordListH["s3"] = 330;
    coordListV["s3"] = 230;
    coordListH["s4"] = 380;
    coordListV["s4"] = 230;
    coordListH["s5"] = 230;
    coordListV["s5"] = 280;
    coordListH["s6"] = 280;
    coordListV["s6"] = 280;
    coordListH["s7"] = 330;
    coordListV["s7"] = 280;
    coordListH["s8"] = 380;
    coordListV["s8"] = 280;
    coordListH["s9"] = 230;
    coordListV["s9"] = 330;
    coordListH["s10"] = 280;
    coordListV["s10"] = 330;
    coordListH["s11"] = 330;
    coordListV["s11"] = 330;
    coordListH["s12"] = 380;
    coordListV["s12"] = 330;
    coordListH["s13"] = 230;
    coordListV["s13"] = 380;
    coordListH["s14"] = 280;
    coordListV["s14"] = 380;
    coordListH["s15"] = 330;
    coordListV["s15"] = 380;
    coordListH["s16"] = 380;
    coordListV["s16"] = 380;
    coordListH["s17"] = 230;
    coordListV["s17"] = 430;
    coordListH["s18"] = 280;
    coordListV["s18"] = 430;
    coordListH["s19"] = 330;
    coordListV["s19"] = 430;
    coordListH["s20"] = 380;
    coordListV["s20"] = 430;
}
void MainWindow::timeF()
{

    QString comm = Commandlist[counter];
    counter = counter + 1;
    if (counter >= Commandlist.length())
    {
        timer->stop();
    }
//
    int start = 0;
    int end = comm.indexOf(' ');
    QVector<QString> lis;
    lis.clear();
    while(end != -1){
        lis.push_back(comm.mid(start,end-start));
        start = end + 1;
        end = comm.indexOf(' ',start);
    }

    lis.push_back(comm.mid(start));
    //qDebug()<<lis[0]<<lis[1]<<lis[3]<<comm.length()<<"\n";
    if(lis[0] == "g1movedown" || lis[0] == "g1moveup"||lis[0] == "g1moveleft"||lis[0] == "g1moveright"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[3]], coordListV[lis[3]], 51, 51));
        //qDebug()<<lis[0]<<lis[1]<<lis[3]<<"\n";
    }
    else if (lis[0]=="g2hup"||lis[0] == "g2hdown"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[4]], coordListV[lis[4]], 101, 51));
    }
    else if( lis[0] == "g2vdown"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[3]], coordListV[lis[3]], 51, 101));

    }
    else if( lis[0] == "g2vup"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[4]], coordListV[lis[4]], 51, 101));

    }
    else if( lis[0] == "g2hright"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[3]], coordListV[lis[3]], 101, 51));

    }
    else if( lis[0]=="g2hleft"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[4]], coordListV[lis[4]], 101, 51));

    }
    else if( lis[0] == "g2vleft"||lis[0] == "g2vright"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[4]], coordListV[lis[4]], 51, 101));

    }
    else if(lis[0] == "g4down"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[4]], coordListV[lis[4]], 101, 101));

    }
    else if(lis[0] == "g4right"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[3]], coordListV[lis[3]], 101, 101));

    }
    else if(lis[0] == "g4left"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[6]], coordListV[lis[6]], 101, 101));

    }
    else if(lis[0] == "g4up"){
        mapList[lis[1]]->setGeometry(QRect(coordListH[lis[6]], coordListV[lis[6]], 101, 101));

    }

}
void MainWindow::on_pushButton_11_clicked()
{
    MainWindow::assignvalue();
    MainWindow::readfile();

    timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(timeF()));
    timer->start(50);
}

