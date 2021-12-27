function use(f, resource, close = close)
    try
        f(resource)
    finally
        close(resource)
    end
end
