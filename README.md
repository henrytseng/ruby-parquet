# Ruby Parquet

[Red Arrow](https://github.com/apache/arrow/tree/master/ruby/red-arrow) installation on Alpine.

Reading Parquet in Ruby can be done with using the Red Arrow gem.  On Alpine a number of dependencies are required.  Alpine runs musl and Apache Red Arrow uses dependencies built with glib.

Pull and run container

```
  docker pull henrytseng/ruby_parquet:latest
  docker run -it --rm henrytseng/ruby_parquet /bin/sh
```

With these dependencies you install the red-arrow gem which requires arrow and arrow_glib for the Ruby C extension

```
  gem install red-arrow
```
