=begin
Topological Inventory

Topological Inventory

OpenAPI spec version: 0.0.1
Contact: you@your-company.com
Generated by: https://github.com/swagger-api/swagger-codegen.git

=end


class Source < ApplicationRecord
  validates :name, :presence => true
end
