name "base"
description "Base role applied to all nodes."

run_list(
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[sudo]",
  "recipe[vim]",
  "recipe[nginx]",
  "recipe[ohai]",
  "recipe[rbenv]",
  "recipe[ruby_build]",
  "recipe[runit]",
  "recipe[unicorn]",           
  "recipe[rails-lastmile]"
)

override_attributes(
  :authorization => {
    :sudo => {
      :users => ["ubuntu", "vagrant"],
      :passwordless => true
    }
  },
  :'rails-lastmile' => {
      :'app_dir' => "/home/vagrant/proj-name",
      :'ruby_version' => "1.9.3-p385"
  }
)
