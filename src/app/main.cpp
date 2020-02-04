#include <cstdlib>
#include <cstdio>

#include <QApplication>
#include <QDebug>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlProperty>
#include <QQmlContext>
#include <QQuickStyle>
#include <QSettings>
#include <QSurfaceFormat>
#include <QDebug>

int main(int argc, char* argv[]) {

#ifdef __linux
  putenv((char *)"MESA_GL_VERSION_OVERRIDE=3.2");

  // Fixes decimal point issue in vtkSTLReader
  putenv((char *)"LC_NUMERIC=C");

  // _putenv_s("QML_BAD_GUI_RENDER_LOOP", "1");
#endif //LINUX

  //QSurfaceFormat::setDefaultFormat(QVTKOpenGLWidget::defaultFormat());
  QApplication app(argc, argv);

  QQmlApplicationEngine engine;

  app.setApplicationName("Right");
  app.setOrganizationName("Organization");
  app.setOrganizationDomain("Domain");

  // Load main QML file
  engine.load(QUrl("qrc:/res/qml/main.qml"));


  int rc = app.exec();

  return rc;
}
