# System Metrics-Backend

contains 3 api:
1. post: api/vitals : save log status
2. get: api/vitals : returns history list
3. get: api/vitals/analytics : returns analytics data

## Tools and technologies:

1. SDK: .NET: 8.0.411

## Installation:
- To setup .NET: [follow the official link](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
- [vs code download link](https://code.visualstudio.com/) (opitonal, but rerecommended) with extension: C# Dev Kit

To run this project locally, follow these steps:

1. **Clone the repository**:

  ```bash
  git clone https://github.com/Neloy-SWE/660778ee0cf2.git
  ```

2. **Navigate to the project directory(root folder)**:

  ```bash
  cd 660778ee0cf2/backend/system_metrics
```

3. **Prepare the project:**
  ```bash
  dotnet build
```

4. **Navigate to the web api project**:
  ```bash
  cd system_metrics.API
```

5. **Run the project**:
  ```bash
  dotnet run
```

you will find the swagger: http://0.0.0.0:5005/swagger/index.html

## For developmnet purpose:
run (for mac)
```bash
ipconfig getifaddr en0
```

or (window)
```bash
ipconfig | findstr IPv4
```
if ```ipconfig | findstr IPv4``` not work for window, try only ```ipconfig``` and collect ipv4 address.


Now 
```bsah
http://your-collected-ip-address-from-terminal-or-cmd:5005/
```
you can use this link as your base url for front end develoopment. and you will find swagger also:
```bsah
http://your-collected-ip-address-from-terminal-or-cmd:5005/swagger/index.html
```

## Test:

from root (system_metrics):
```bash
cd system_metrics.Tests
dotnet test
```