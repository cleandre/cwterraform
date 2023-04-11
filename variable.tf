terraform {}

variable rgname {
 type = string
 description = "the name of resource group for containing resources"
}
variable rlocation {
 type = string
 default = "westus2"
 description = "azure location for hosting resources"
}
variable environment {
    type = string
    default = "test"
}

variable "sa" {
    type = string
    
}