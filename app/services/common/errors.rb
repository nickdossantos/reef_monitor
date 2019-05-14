module Common
    class Errors < Hash
      def add(key, value, _opts = {})
        self[key] ||= []
        self[key] << value
        self[key].uniq!
      end

      def add_multiple_errors(errors_hash)
        errors_hash.each do |key, values|
          errors_hash[key].each { |value| add key, value }
        end
      end

      def full_messages
        messages = []
        self.each do |field, list_errors|
            messages += list_errors
        end
        messages
      end
    end
end
