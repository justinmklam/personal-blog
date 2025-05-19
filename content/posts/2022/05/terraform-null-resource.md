+++
layout =    "single"
type =      "blog"

date =      2022-05-17T20:21:37-08:00
draft =     false

title =     "Tips and Tricks with Terraform's null_resource"
tagline =   ""
image =     ""
tags =      ["today-i-learned", "programming"]

aliases =   []
+++

Terraform's `null_resource` resource can be useful when there aren't any existing modules to satisfy your needs (with some caveats). [Hashicorp's documentation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) for it is a bit lacking, but fortunately there's more information about the provisioners in their other docs [here](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax). After using these resources in a handful of places across our infrastructure deployments, I've developed a small collection of tips I picked up over the past few months that I thought I'd share.

Use `timestamp()` as a trigger when you need the resource to run on every deployment:

```hcl
resource "null_resource" "always-run" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "echo foobar"
  }
}
```

You can also supply multiple `provisioner` blocks, where one of them can be configured with `when = destroy` to specify the action to take when the resource will be destroyed. Dynamic values need to be accessed using `self.triggers.*` since Terraform isn't able to resolve the values at runtime during resource destruction.

```hcl
resource "null_resource" "include-cleanup" {
  triggers = {
    name   = var.name
    region = var.region
  }

  # Executes on resource creation {
    command = join(" ", [
      "echo",
      "create:",
      "${self.triggers.name}",
      "${self.triggers.region}",
    ])
  }

  # Executes on resource destruction
  provisioner "local-exec" {
    when = destroy
    command = join(" ", [
      "echo",
      "destroy:",
      "${self.triggers.name}",
      "${self.triggers.region}",
    ])
  }
}
```

The `local-exec` provisioner also allows for an [environment](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html#environment) field, which can be used to easily pass values into commands or scripts:

```hcl
resource "null_resource" "environment-values" {
  provisioner "local-exec" {
    command = "./some-script.sh"
    environment = {
      ENVIRONMENT = var.environment
      JSON_DATA = jsonencode({
          "var1" = var.name,
          "var2" = var.region,
          ...
      })
    }
  }
}
```

Aside from provisioning resources, `null_resource` can also be used for debugging values (which I stumbled upon from [nexxai.dev](https://nexxai.dev/how-to-debug-terraform-variable-content-using-this-custom-module/)):

```hcl
resource "null_resource" "terraform-debug" {
  provisioner "local-exec" {
    command = "echo $VARIABLE1 >> debug.txt; echo $VARIABLE2 >> debug.txt"

    environment = {
      VARIABLE1 = jsonencode(var.your_variable_name)
      VARIABLE2 = jsonencode(local.piece_of_data)
    }
  }
}
```
