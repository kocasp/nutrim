class ExamplesController < ApplicationController
    def index
        example = Example.last
        Example.create(name: "Example 2")
        Example.destroy_all
        render plain: "Hello World #{example.name}"
    end
end
