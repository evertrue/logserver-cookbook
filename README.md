# logserver [![Build Status](https://travis-ci.org/evertrue/logserver-cookbook.svg)](https://travis-ci.org/evertrue/logserver-cookbook)

Just a wrapper cookbook so that we can constrain the version of `et_elk`

# Usage

Include this recipe in a wrapper cookbook:

```
# metadata.rb
depends 'logserver', '~> 2.0'
```

```
# recipes/default.rb
include_recipe 'logserver::default'
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests with `kitchen test`, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Author:: The Authors (devops@evertrue.com)
