class ExamplesController < ApplicationController
    def index
        example = Example.last
        render plain: "Hello World #{example.name}"
    end
end
