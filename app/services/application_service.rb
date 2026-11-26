class ApplicationService
  def self.call(*args, **kwargs, &block)
    init_params = instance_method(:initialize).parameters

    # CASE 1: No arguments passed at all.
    return new(&block).call if args.empty? && kwargs.empty?

    # CASE 2: Keyword arguments are provided.
    unless kwargs.empty?
      # Check if the initializer expects keyword arguments.
      arg_types = %i[key keyreq keyrest]

      if init_params.any? { |type, _| arg_types.include?(type) }
        # The initializer accepts keywords, so forward them.
        return new(*args, **kwargs, &block).call
      elsif args.empty?
        # The initializer does not expect keywords, assume a single hash.
        return new(kwargs, &block).call
      else
        # Mixed positional and keyword args: merge keywords into positional hash.
        return new(*args, kwargs, &block).call
      end
    end

    # CASE 3a: A single positional hash, but initialize expects keywords
    arg_types = %i[key keyreq keyrest]
    if kwargs.empty? && args.size == 1 && init_params.any? { |type, _| arg_types.include?(type) } &&
       args.first.is_a?(Hash)
      return new(**args.first, &block).call
    end

    # CASE 3b: Only positional arguments provided.
    new(*args, &block).call
  end
end
