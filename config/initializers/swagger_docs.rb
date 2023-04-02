Swagger::Blocks.build do
  swagger_root do
    key :swagger, "2.0"
    info do
      key :version, "1.0.0"
      key :title, "HrTech API"
      key :description, "This is the API for HrTech API"
    end

    tag do
      key :name, "users"
      key :description, "Operations related to user management"
    end
    # ... add more tags, definitions, paths, etc. as needed
  end
end
