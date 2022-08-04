# carlosafonso/cloud-logging-custom-lua

This sample repo shows how to use Fluent Bit with a Lua filter to perform custom manipulations of log messages.

In particular, the filter included in this repo parses all key value pairs in the form of `key=value` and adds them as attributes of the log payload. This is particularly useful for Google Cloud Logging, as it currently only accepts either plaintext or JSON-structured logs (even though arbitrary strings can be queries using regexes).

The configuration defined in this repository (in `fluent-bit.conf`) reads logs from a file located at `/tmp/my-logs-log`, runs them through the Lua filter and sends them to the standard output as well as to Cloud Logging (using the Stackdriver plugin, which is Google Cloud Operation's former name).

## How to use

Run Fluent Bit locally in one terminal:

```
/opt/fluent-bit/bin/fluent-bit -c fluent-bit.conf
```

Then in another terminal append logs to the file:

```
echo "foo=bar key=val arbitrary=attribute This is a message" >> /tmp/my-logs.log
```

If you check the logs in Cloud Logging you'll see a structure similar to the following:

```
{
  "insertId": "<REDACTED>",
  "jsonPayload": {
    "message": "foo=bar key=val arbitrary=attribute This is a message",
    "foo": "bar",
    "key": "val",
    "arbitrary": "attribute"
  },
  "resource": {
    "type": "global",
    "labels": {
      "project_id": "<REDACTED>"
    }
  },
  "timestamp": "2022-08-04T09:59:57.740623163Z",
  "logName": "projects/<REDACTED>/logs/tail.0",
  "receiveTimestamp": "2022-08-04T09:59:58.313602534Z"
}
```

## Next steps

The regex used in `custom_filter.lua` is very simple, but can be evolved into something more complex as needed.
