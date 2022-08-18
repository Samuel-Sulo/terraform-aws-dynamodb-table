provider "aws" {
  region = "eu-west-1"
}

module "books_db" {
  source = "../../module"

  name                = "Books"
  hash_key            = "author"
  range_key           = "title"
  billing_mode        = "PROVISIONED"
  read_capacity       = 4
  write_capacity      = 4
  autoscaling_enabled = true

  global_secondary_indexes = [
    {
      name            = "Genre"
      hash_key        = "genre"
      range_key       = "release"
      projection_type = "KEYS_ONLY"
      read_capacity   = 4
      write_capacity  = 4
    }
  ]

  attributes = {
    author  = "S"
    title   = "S"
    genre   = "S"
    release = "S"
  }

  autoscaling_table_read = {
    min_capacity = 1
    max_capacity = 10
  }

  autoscaling_table_write = {
    min_capacity = 1
    max_capacity = 10
  }

  autoscaling_indexes_read = {
    Genre = {
      min_capacity = 1
      max_capacity = 5
    }
  }

  autoscaling_indexes_write = {
    Genre = {
      min_capacity = 1
      max_capacity = 5
    }
  }
}
