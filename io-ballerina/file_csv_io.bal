// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Read file content as a CSV.
# ```ballerina
# string[][]|io:Error content = io:fileReadCsv("./resources/myfile.csv");
# ```
# + path - The CSV file path
# + skipHeaders - Number of headers, which should be skipped prior to reading records
# + return - The entire CSV content in the channel as an array of string arrays or an `io:Error`
public function fileReadCsv(@untainted string path, int skipHeaders = 0) returns @tainted string[][]|Error {

    var csvChannel = openReadableCsvFile(path, COMMA, DEFAULT_ENCODING, skipHeaders);
    if (csvChannel is ReadableCSVChannel) {
        return channelReadCsv(csvChannel);
    } else {
        return csvChannel;
    }
}

# Read file content as a CSV.
# ```ballerina
# stream<string[], io:Error>|io:Error content = io:fileReadCsvAsStream("./resources/myfile.csv");
# ```
# + path - The CSV file path
# + return - The entire CSV content in the channel a stream of string arrays or an `io:Error`
public function fileReadCsvAsStream(@untainted string path) returns @tainted stream<string[], Error>|Error {
    var csvChannel = openReadableCsvFile(path);
    if (csvChannel is ReadableCSVChannel) {
        return csvChannel.csvStream();
    } else {
        return csvChannel;
    }
}

# Write CSV content to a file.
# ```ballerina
# string[][] content = [["Anne", "Johnson", "SE"], ["John", "Cameron", "QA"]];
# io:Error? result = io:fileWriteCsv("./resources/myfile.csv", content);
# ```
# + path - The CSV file path
# + content - CSV content as an array of string arrays
# + return - Either an `io:Error` or the null `()` value when the writing was successful
public function fileWriteCsv(@untainted string path, string[][] content) returns Error? {
    var csvChannel = openWritableCsvFile(path);
    if (csvChannel is WritableCSVChannel) {
        return channelWriteCsv(csvChannel, content);
    } else {
        return csvChannel;
    }
}

# Write CSV record stream to a file.
# ```ballerina
# string[][] content = [["Anne", "Johnson", "SE"], ["John", "Cameron", "QA"]];
# stream<string[], io:Error> recordStream = content.toStream();
# io:Error? result = io:fileWriteCsv("./resources/myfile.csv", recordStream);
# ```
# + path - The CSV file path
# + content - A CSV record stream to be written
# + return - Either an `io:Error` or the null `()` value when the writing was successful
public function fileWriteCsvFromStream(@untainted string path, stream<string[], Error> content) returns Error? {
    var csvChannel = openWritableCsvFile(path);
    if (csvChannel is WritableCSVChannel) {
        return channelWriteCsvFromStream(csvChannel, content);
    } else {
        return csvChannel;
    }
}
