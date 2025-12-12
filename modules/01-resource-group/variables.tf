variable "var_child_resource_group" {
  type = map(object(
    {
      resource_group_name     = string
      location = string
      tags     = optional(map(string))
    }
  ))
}
