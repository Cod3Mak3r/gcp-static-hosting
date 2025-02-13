# 📌 Documentación: Hosting Estático en GCP con Terraform

## 📌 Descripción
Este proyecto implementa un hosting estático en Google Cloud Platform (GCP) utilizando Terraform. Se crea un bucket de almacenamiento en Google Cloud Storage configurado para servir contenido estático de un sitio web.

## 🚀 Requisitos Previos
Antes de ejecutar este proyecto, asegúrate de tener lo siguiente:
- Cuenta de GCP con un proyecto configurado.
- API de Cloud Storage habilitada en GCP.
- Terraform instalado en tu sistema.
- Configurado `gcloud` con las credenciales de autenticación.

## 📂 Estructura del Proyecto
```
.
├── .gitignore
├── index.html
├── main.tf
├── outputs.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── variables.tf
└── .terraform/ (ignorado en Git)
```

## 🔧 Configuración de Variables
El archivo `variables.tf` define las variables necesarias para el despliegue:
```hcl
variable "bucket_name" {
  description = "Nombre único del bucket de almacenamiento"
  type        = string
}

variable "project_id" {
  description = "ID del proyecto en GCP"
  type        = string
}
```

## ⚙️ Implementación con Terraform
### 1️⃣ Inicializar el Proyecto
Ejecuta el siguiente comando para inicializar Terraform y descargar los proveedores necesarios:
```bash
terraform init
```

### 2️⃣ Planificar la Infraestructura
Antes de aplicar los cambios, verifica qué se va a crear:
```bash
terraform plan
```

### 3️⃣ Aplicar la Configuración
Para crear el bucket y configurar el hosting estático:
```bash
terraform apply -auto-approve
```

### 4️⃣ Subir el Archivo `index.html` al Bucket
Terraform no sube automáticamente los archivos, por lo que se debe hacer manualmente:
```bash
gsutil cp index.html gs://<bucket_name>/
```

### 5️⃣ Obtener la URL del Sitio
Terraform generará una salida con la URL del sitio web, que puedes consultar con:
```bash
terraform output website_url
```

## 🗑️ Eliminación de Recursos
Para eliminar toda la infraestructura creada:
```bash
terraform destroy -auto-approve
```

## 📌 Notas Finales
- `.terraform/` y archivos de estado (`terraform.tfstate`) deben ser excluidos del repositorio Git usando `.gitignore`.
- Asegúrate de que el bucket tenga permisos públicos si deseas que el sitio sea accesible desde cualquier lugar.

---
🔹 **Autor:** [Tu Nombre]  
🔹 **Fecha:** [Fecha de creación]  
🔹 **Repositorio:** [GitHub/GitLab URL]  

---
✅ **Proyecto Completado con Éxito 🚀**

