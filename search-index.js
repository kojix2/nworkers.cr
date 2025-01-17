crystal_doc_search_index_callback({"repository_name":"nworkers","body":"# nworkers.cr\n\n[![test](https://github.com/kojix2/nworkers.cr/actions/workflows/ci.yml/badge.svg)](https://github.com/kojix2/nworkers.cr/actions/workflows/ci.yml)\n\n`nworkers.cr` is an experimental library in Crystal programming language that allows you to change the number of worker threads at runtime.\n\nSee [Crystal Forum : How to add command line options to specify the number of threads?](https://forum.crystal-lang.org/t/how-to-add-command-line-options-to-specify-the-number-of-threads/)\n\n## Installation\n\n1. Add the dependency to your `shard.yml`:\n\n   ```yaml\n   dependencies:\n     nworkers:\n       github: kojix2/nworkers.cr\n   ```\n\n2. Run `shards install`\n\n## Usage\n\nThis is an experimental library. It is intended for use where the number of workers is changed immediately after startup and not changed afterwards. For example, in a command line tool, where the number of threads is set as an option.\n\n- `NWorkers.set_worker(n : Int)`: Sets the number of worker threads to `n`.\n- `NWorkers.add_worker(n : Int)`: Adds `n` worker threads.\n- `NWorkers.remove_worker(n : Int)`: Removes `n` worker threads.\n\nHere's an example:\n\n```cr\nrequire \"nworkers\"\n\n# set the number of workers to 4\nNWorkers.set_worker(4)\n\n# add 2 more workers\nNWorkers.add_worker(2)\n\n# remove 1 worker\nNWorkers.remove_worker\n```\n\n[Documentation](https://kojix2.github.io/nworkers.cr/)\n\n## Development\n\n- Crystal creates the number of workers specified by the environment variable ENV [“CRYSTAL_WORKERS”] only once at the beginning.\n  - See [scheduler.cr](https://github.com/crystal-lang/crystal/blob/master/src/crystal/scheduler.cr).\n- This library will add workers later in [the same manner](https://github.com/kojix2/nworkers.cr/blob/main/src/ext/crystal_scheduler.cr).\n- The author has used this library to create several small command line tools to verify that parallel processing with additional workers actually works.\n- However, that there is no guarantee that adding or removing workers after the fact will work correctly.\n- The author does not have sufficient knowledge or experience to examine whether this method will work well for long-running processes such as web applications.\n- Pull requests and comments are always welcome!\n\n## Contributing\n\n1. Fork it (<https://github.com/kojix2/nworkers.cr/fork>)\n2. Create your feature branch (`git checkout -b my-new-feature`)\n3. Commit your changes (`git commit -am 'Add some feature'`)\n4. Push to the branch (`git push origin my-new-feature`)\n5. Create a new Pull Request\n\nContributions are welcome! \nPlease feel free to submit a Pull Request if you find a bug or you want to propose a new feature.\n\n","program":{"html_id":"nworkers/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"locations":[],"repository_name":"nworkers","program":true,"enum":false,"alias":false,"const":false,"types":[{"html_id":"nworkers/NWorkers","path":"NWorkers.html","kind":"module","full_name":"NWorkers","name":"NWorkers","abstract":false,"locations":[{"filename":"src/nworkers.cr","line_number":4,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers.cr#L4"},{"filename":"src/nworkers/version.cr","line_number":1,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers/version.cr#L1"}],"repository_name":"nworkers","program":false,"enum":false,"alias":false,"const":false,"constants":[{"id":"VERSION","name":"VERSION","value":"{{ (`shards version /home/runner/work/nworkers.cr/nworkers.cr/src/nworkers`).chomp.stringify }}"}],"class_methods":[{"html_id":"add_worker(n=1)-class-method","name":"add_worker","abstract":false,"args":[{"name":"n","default_value":"1","external_name":"n","restriction":""}],"args_string":"(n = 1)","args_html":"(n = <span class=\"n\">1</span>)","location":{"filename":"src/nworkers.cr","line_number":29,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers.cr#L29"},"def":{"name":"add_worker","args":[{"name":"n","default_value":"1","external_name":"n","restriction":""}],"visibility":"Public","body":"{% if flag?(:preview_mt) %}\n      n.times { Crystal::Scheduler.add_worker }\n      ENV[\"CRYSTAL_WORKERS\"] = count.to_s\n      n\n    {% end %}"}},{"html_id":"count-class-method","name":"count","abstract":false,"location":{"filename":"src/nworkers.cr","line_number":61,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers.cr#L61"},"def":{"name":"count","visibility":"Public","body":"size"}},{"html_id":"remove_worker(n=1)-class-method","name":"remove_worker","abstract":false,"args":[{"name":"n","default_value":"1","external_name":"n","restriction":""}],"args_string":"(n = 1)","args_html":"(n = <span class=\"n\">1</span>)","location":{"filename":"src/nworkers.cr","line_number":41,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers.cr#L41"},"def":{"name":"remove_worker","args":[{"name":"n","default_value":"1","external_name":"n","restriction":""}],"visibility":"Public","body":"{% if flag?(:preview_mt) %}\n      n.times { Crystal::Scheduler.remove_worker }\n      ENV[\"CRYSTAL_WORKERS\"] = count.to_s\n      n\n    {% end %}"}},{"html_id":"set_worker(n:Int)-class-method","name":"set_worker","abstract":false,"args":[{"name":"n","external_name":"n","restriction":"Int"}],"args_string":"(n : Int)","args_html":"(n : Int)","location":{"filename":"src/nworkers.cr","line_number":8,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers.cr#L8"},"def":{"name":"set_worker","args":[{"name":"n","external_name":"n","restriction":"Int"}],"visibility":"Public","body":"{% if flag?(:preview_mt) %}\n      num_workers = count\n      case n\n      when 1...num_workers\n        remove_worker(num_workers - n)\n      when num_workers\n        ENV[\"CRYSTAL_WORKERS\"] = n.to_s # do nothing\n      when (num_workers + 1)..\n        add_worker(n - num_workers)\n      else\n        raise ArgumentError.new(\"Invalid number of workers: #{n}\")\n      end\n      n\n    {% end %}"}},{"html_id":"size-class-method","name":"size","abstract":false,"location":{"filename":"src/nworkers.cr","line_number":51,"url":"https://github.com/kojix2/nworkers.cr/blob/58659d4bc631301f83e9cf94413432dd654f232c/src/nworkers.cr#L51"},"def":{"name":"size","visibility":"Public","body":"{% if flag?(:preview_mt) %}\n      Crystal::Scheduler.number_of_workers\n    {% else %}\n      1\n    {% end %}"}}]}]}})