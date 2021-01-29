// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/jballerina.java;
import ballerina/test;
import ballerina/lang.'string as langstring;

@test:Config {}
function testReadBytes() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/text/charfile.txt";
    string expectedString = "123";
    int numberOfBytes = 3;

    var byteChannel = openReadableFile(filePath);
    if (byteChannel is ReadableByteChannel) {
        var result = byteChannel.read(numberOfBytes);
        if (result is byte[]) {
            test:assertEquals(result, expectedString.toBytes(), msg = "Found unexpected output");
        } else {
            test:assertFail(msg = result.message());
        }

        result = byteChannel.read(numberOfBytes);
        expectedString = "456";
        if (result is byte[]) {
            test:assertEquals(result, expectedString.toBytes(), msg = "Found unexpected output");
        } else {
            test:assertFail(msg = result.message());
        }

        result = byteChannel.read(numberOfBytes);
        expectedString = "";
        if (result is byte[]) {
            test:assertEquals(result, expectedString.toBytes(), msg = "Found unexpected output");
        } else {
            test:assertFail(msg = result.message());
        }

        var closeResult = byteChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {}
function testWriteBytes() {
    string filePath = TEMP_DIR + "bytesFile1.txt";
    byte[] content = [1, 46, 77, 90, 38];
    var byteChannel = openWritableFile(filePath);

    if (byteChannel is WritableByteChannel) {
        var result = byteChannel.write(content, 0);
        if (result is Error) {
            test:assertFail(msg = result.message());
        }

        var closeResult = byteChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {}
function testFileWriteBytes() {
    string filePath = TEMP_DIR + "bytesFile2.txt";
    createDirectoryExtern(TEMP_DIR);
    string content = "Sheldon Cooper";
    var result = fileWriteBytes(filePath, content.toBytes());

    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileWriteBytes]}
function testFileReadBytes() {
    string filePath = TEMP_DIR + "bytesFile2.txt";
    var result = fileReadBytes(filePath);
    string expectedString = "Sheldon Cooper";

    if (result is (readonly & byte[])) {
        test:assertEquals(result, expectedString.toBytes(), msg = "Found unexpected output");
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileWriteBytesFromStream() {
    string filePath = TEMP_DIR + "bytesFile3.txt";
    string[] stringContent = ["Sheldon", " ", "Cooper"];
    byte[][] byteContent = [];
    int i = 0;
    foreach string s in stringContent {
        byteContent[i] = s.toBytes();
        i += 1;
    }
    var result = fileWriteBlocksFromStream(filePath, byteContent.toStream());
    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileWriteBytesFromStream]}
function testFileReadBytesAsStream() {
    string filePath = TEMP_DIR + "bytesFile3.txt";
    var result = fileReadBlocksAsStream(filePath, 2);
    string expectedString = "Sheldon Cooper";
    byte[] byteArr = [];
    if (result is stream<Block, Error>) {
        error? e = result.forEach(function(Block val) {
            foreach byte b in val {
                byteArr.push(b);
            }
        });
        string|error returnedString = langstring:fromBytes(byteArr);
        if (returnedString is string) {
            test:assertEquals(returnedString, expectedString);
        } else {
            test:assertFail(msg = returnedString.message());
        }
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileChannelWriteBytes() {
    string filePath = TEMP_DIR + "bytesFile4.txt";
    createDirectoryExtern(TEMP_DIR);
    string content = "Sheldon Cooper";

    var fileOpenResult = openWritableFile(filePath);
    if (fileOpenResult is WritableByteChannel) {
        var result = channelWriteBytes(fileOpenResult, content.toBytes());
        if (result is Error) {
            test:assertFail(msg = result.message());
        }
    } else {
        test:assertFail(msg = fileOpenResult.message());
    }
}

@test:Config {dependsOn: [testFileChannelWriteBytes]}
function testFileChannelReadBytes() {
    string filePath = TEMP_DIR + "bytesFile4.txt";
    string expectedString = "Sheldon Cooper";

    var fileOpenResult = openReadableFile(filePath);
    if (fileOpenResult is ReadableByteChannel) {
        var result = channelReadBytes(fileOpenResult);
        if (result is byte[]) {
            test:assertEquals(result, expectedString.toBytes(), msg = "Found unexpected output");
        } else {
            test:assertFail(msg = result.message());
        }
    } else {
        test:assertFail(msg = fileOpenResult.message());
    }
}

@test:Config {}
function testFileChannelWriteBytesFromStream() {
    string filePath = TEMP_DIR + "bytesFile5.txt";
    string[] stringContent = ["Sheldon", " ", "Cooper"];
    byte[][] byteContent = [];
    int i = 0;
    foreach string s in stringContent {
        byteContent[i] = s.toBytes();
        i += 1;
    }
    var fileOpenResult = openWritableFile(filePath);
    if (fileOpenResult is WritableByteChannel) {
        var result = channelWriteBlocksFromStream(fileOpenResult, byteContent.toStream());
        if (result is Error) {
            test:assertFail(msg = result.message());
        }
    } else {
        test:assertFail(msg = fileOpenResult.message());
    }
}

@test:Config {dependsOn: [testFileChannelWriteBytesFromStream]}
function testFileChannelReadBytesAsStream() {
    string filePath = TEMP_DIR + "bytesFile5.txt";
    string expectedString = "Sheldon Cooper";
    byte[] byteArr = [];

    var fileOpenResult = openReadableFile(filePath);
    if (fileOpenResult is ReadableByteChannel) {
        var result = channelReadBlocksAsStream(fileOpenResult, 2);
        if (result is stream<Block, Error>) {
            error? e = result.forEach(function(Block val) {
                                   foreach byte b in val {
                                       byteArr.push(b);
                                   }
                               });
            string|error returnedString = langstring:fromBytes(byteArr);
            if (returnedString is string) {
                test:assertEquals(returnedString, expectedString);
            } else {
                test:assertFail(msg = returnedString.message());
            }
        } else {
            test:assertFail(msg = result.message());
        }
    } else {
        test:assertFail(msg = fileOpenResult.message());
    }
}

@test:Config {}
function testFileCopy() {
    string readFilePath = RESOURCES_BASE_PATH + "datafiles/io/images/ballerina.png";
    string writeFilePath = TEMP_DIR + "ballerina.png";
    var readResult = fileReadBytes(readFilePath);

    if (readResult is (readonly & byte[])) {
        var writeResult = fileWriteBytes(writeFilePath, <@untainted>readResult);
        if (writeResult is Error) {
            test:assertFail(msg = writeResult.message());
        }
    } else {
        test:assertFail(msg = readResult.message());
    }
}

@test:Config {}
function testFileWriteBytesWithTruncate() {
    string filePath = TEMP_DIR + "bytesFile6.txt";
    createDirectoryExtern(TEMP_DIR);
    string content1 = "Ballerina is an open source programming language and " +
    "platform for cloud-era application programmers to easily write software that just works.";
    string content2 = "Ann Johnson is a banker.";

    // Check content 01
    var result1 = fileWriteBytes(filePath, content1.toBytes());
    if (result1 is Error) {
        test:assertFail(msg = result1.message());
    }
    var result2 = fileReadBytes(filePath);
    if (result2 is (readonly & byte[])) {
        test:assertEquals(result2, content1.toBytes());
    } else {
        test:assertFail(msg = result2.message());
    }

    // Check content 02
    var result3 = fileWriteBytes(filePath, content2.toBytes());
    if (result3 is Error) {
        test:assertFail(msg = result3.message());
    }
    var result4 = fileReadBytes(filePath);
    if (result4 is (readonly & byte[])) {
        test:assertEquals(result4, content2.toBytes());
    } else {
        test:assertFail(msg = result4.message());
    }
}

function createDirectoryExtern(string path) = @java:Method {
    name: "createDirectory",
    'class: "org.ballerinalang.stdlib.io.testutils.FileTestUtils"
} external;
