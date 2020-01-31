#include <QtQuick
int main(int argc, char* argv[]) {
#ifdef __linux
  putenv((char *)"MESA_GL_VERSION_OVERRIDE=3.2");

  // Fixes decimal point issue in vtkSTLReader
  putenv((char *)"LC_NUMERIC=C");

  // _putenv_s("QML_BAD_GUI_RENDER_LOOP", "1");
#endif //LINUX

  QSurfaceFormat::setDefaultFormat(QVTKOpenGLWidget::defaultFormat());
  QApplication app(argc, argv);

  QQmlApplicationEngine engine;
#ifdef _WIN32
  engine.addImportPath(QTVTK_QML_DIR);
#endif
  app.setApplicationName("Right");
  app.setOrganizationName("Organization");
  app.setOrganizationDomain("Domain");

  // Register QML types
  int retval = qmlRegisterType<QVTKFramebufferObjectItem>("QtVTK", 1, 0, "VtkFboItem");

  // Create classes instances
  m_processingEngine = std::shared_ptr<ProcessingEngine>(new ProcessingEngine());

  // Expose C++ classes to QML
  QQmlContext* ctxt = engine.rootContext();

  ctxt->setContextProperty("canvasHandler", this);

  QQuickStyle::setStyle("Material");

  // Load main QML file
  engine.load(QUrl("qrc:/resources/main.qml"));

  // Get reference to the QVTKFramebufferObjectItem created in QML
  // We cannot use smart pointers because this object must be deleted by QML
  QObject *rootObject = engine.rootObjects().first();
  m_vtkFboItem = rootObject->findChild<QVTKFramebufferObjectItem*>("vtkFboItem");

  // Give the vtkFboItem reference to the CanvasHandler
  if (m_vtkFboItem) {
    qDebug() << "CanvasHandler::CanvasHandler: setting vtkFboItem to CanvasHandler";

    m_vtkFboItem->setProcessingEngine(m_processingEngine);

    connect(m_vtkFboItem, &QVTKFramebufferObjectItem::rendererInitialized, this, &CanvasHandler::startApplication);
    connect(m_vtkFboItem, &QVTKFramebufferObjectItem::isModelSelectedChanged, this, &CanvasHandler::isModelSelectedChanged);
    connect(m_vtkFboItem, &QVTKFramebufferObjectItem::selectedModelPositionXChanged, this, &CanvasHandler::selectedModelPositionXChanged);
    connect(m_vtkFboItem, &QVTKFramebufferObjectItem::selectedModelPositionYChanged, this, &CanvasHandler::selectedModelPositionYChanged);
  } else {
    qCritical() << "CanvasHandler::CanvasHandler: Unable to get vtkFboItem instance";
    return;
  }

  const QString DEFAULT_MODEL_DIR_KEY("default_model_dir");

  QSettings MySettings;

  m_fileDialog = rootObject->findChild<QObject*>("myFileDialog");
  if (m_fileDialog) {
    QString tmp = MySettings.value(DEFAULT_MODEL_DIR_KEY).toString();
    m_fileDialog->setProperty("folder", QUrl::fromLocalFile(tmp));
  }

  int rc = app.exec();

  qDebug() << "CanvasHandler::CanvasHandler: Execution finished with return code:" << rc;


  return 0;
}
