require "database_type_table/version"

module DatabaseTypeTable

                  # references on using self.included: 
                  #   http://pragprog.com/screencasts/v-dtrubyom/the-ruby-object-model-and-metaprogramming
                  #     episode 2, last 10 minutes or so.
                  #   http://railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
                  #   http://chrislloyd.github.com/gravtastic
  def self.included base
    base.extend StageOne
  end

  module StageOne
    def database_type_table(*args, &blk)
      extend ClassMethods
      include InstanceMethods
      DatabaseTypeTable.configure(self, *args, &blk)
      load_types
      self
    end
  end

  def self.configure(model, *args, &blk)
    options = args.last.is_a?(Hash) ? args.pop : {}

    model.defaults = {
      id_column:   :id,
      name_column: :name
    }.merge(options)
  end


  module ClassMethods
    attr_accessor :defaults
    attr_accessor :db_types

    def load_types
      @db_types= {}

      all.each do |a|
        myid    = a.send( self.defaults[:id_column])
        myname  = a.send( self.defaults[:name_column])
        if (myid && myname && myname.is_a?(String))
          def_name = myname.strip
          def_name.gsub!(/  +/, ' ')
          def_name.gsub!(/ /, '_')
          def_name.gsub!(/\//, '_')
          def_name.gsub!(/[^a-zA-Z0-9_]/, '')

          upcase_name = def_name.upcase
          url_name    = def_name.downcase
          self.const_set("#{upcase_name}_ID", myid)
          self.const_set("#{upcase_name}_NAME", myname)
          self.const_set("#{upcase_name}_URL", url_name.gsub(/_/, '-'))

          @db_types[myid] = myname
        end
      end
    end

    def each_id
      @db_types.each_key
    end

    def each_name
      @db_types.each_value
    end

    def get_id_from_name(n)
      result = nil
      if n.is_a?(String)
        @db_types.each do |key, value|
          result = key if value.casecmp(n) == 0
        end
      end
      result
    end

    def [](n)
      @db_types[n]
    end
  end


  module InstanceMethods
    def to_s
      "#{cache_key} -- #{send( self.defaults[:name_column])}"
    end
  end

end

