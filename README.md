# nworkers.cr

[![test](https://github.com/kojix2/nworkers.cr/actions/workflows/ci.yml/badge.svg)](https://github.com/kojix2/nworkers.cr/actions/workflows/ci.yml)

`nworkers.cr` is an experimental library in Crystal programming language that allows you to change the number of worker threads at runtime.

See [Crystal Forum : How to add command line options to specify the number of threads?](https://forum.crystal-lang.org/t/how-to-add-command-line-options-to-specify-the-number-of-threads/)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     nworkers:
       github: kojix2/nworkers.cr
   ```

2. Run `shards install`

## Usage

This is an experimental library. It is intended for use where the number of workers is changed immediately after startup and not changed afterwards. For example, in a command line tool, where the number of threads is set as an option.

- `NWorkers.set_worker(n : Int)`: Sets the number of worker threads to `n`.
- `NWorkers.add_worker(n : Int)`: Adds `n` worker threads.
- `NWorkers.remove_worker(n : Int)`: Removes `n` worker threads.

Here's an example:

```cr
require "nworkers"

# set the number of workers to 4
NWorkers.set_worker(4)

# add 2 more workers
NWorkers.add_worker(2)

# remove 1 worker
NWorkers.remove_worker
```

[Documentation](https://kojix2.github.io/nworkers.cr/)

## Development

To develop `nworkers.cr`, you can clone the repository and run `shards install` to fetch the dependencies. After making modifications, you can run `crystal spec` to ensure that the tests are passing.

## Contributing

1. Fork it (<https://github.com/kojix2/nworkers.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Contributions are welcome! Please feel free to submit a Pull Request if you find a bug or you want to propose a new feature.
