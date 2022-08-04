function do_filter(tag, timestamp, record)
    -- Split key=value pairs in the original message and add them as key-value
    -- attributes. These will appear as structured attributes in Cloud Logging.
    for k, v in string.gmatch(record["message"], "(%w+)=(%w+)") do
            record[k] = v
    end

    -- Returning "2" means that the record has changed, but not the timestamp.
    return 2, timestamp, record
end
