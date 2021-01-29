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

import ballerina/test;

type Employee record {
    string id;
    string name;
    float salary;
};

type PerDiem record {
    int id;
    string name;
    int age;
    int? beverageAllowance;
    float? total;
    string? department;
};

type CommonApp record {
    string appId;
    string createdDt;
    string exportDt;
    string firstName;
    string middleName;
    string lastName;
    string gender;
    string birthDate;
    string address1;
    string address2;
    string city;
    string state;
    string zip;
    string country;
    string email;
    string phoneNumber;
    string hispLatino;
    string citizenship;
    string schoolLookup;
};

@test:Config {}
function testReadCsv() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sample.csv";
    int expectedRecordLength = 3;

    var byteChannel = openReadableFile(filePath);
    if (byteChannel is ReadableByteChannel) {
        ReadableCharacterChannel characterChannel = new ReadableCharacterChannel(byteChannel, DEFAULT_ENCODING);
        ReadableCSVChannel csvChannel = new ReadableCSVChannel(characterChannel, COMMA);

        test:assertTrue(csvChannel.hasNext());
        var recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertFalse(csvChannel.hasNext());
        var endResult = csvChannel.getNext();
        if (endResult is error) {
            test:assertEquals(endResult.message(), "EoF when reading from the channel", msg = "Found unexpected output");
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {}
function testOpenAndReadCsv() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sample.csv";
    int expectedRecordLength = 3;

    var csvChannel = openReadableCsvFile(filePath);
    if (csvChannel is ReadableCSVChannel) {
        test:assertTrue(csvChannel.hasNext());
        var recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertFalse(csvChannel.hasNext());
        var endResult = csvChannel.getNext();
        if (endResult is error) {
            test:assertEquals(endResult.message(), "EoF when reading from the channel", msg = "Found unexpected output");
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testOpenAndReadColonDelimitedFile() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sampleWithColon.txt";
    int expectedRecordLength = 3;

    var byteChannel = openReadableFile(filePath);
    if (byteChannel is ReadableByteChannel) {
        ReadableCharacterChannel characterChannel = new ReadableCharacterChannel(byteChannel, DEFAULT_ENCODING);
        ReadableCSVChannel csvChannel = new ReadableCSVChannel(characterChannel, COLON);

        test:assertTrue(csvChannel.hasNext());
        var recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertFalse(csvChannel.hasNext());
        var endResult = csvChannel.getNext();
        if (endResult is error) {
            test:assertEquals(endResult.message(), "EoF when reading from the channel", msg = "Found unexpected output");
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {dependsOn: [testOpenAndReadColonDelimitedFile]}
function testOpenAndReadCsvWithHeaders() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sampleWithHeader.csv";
    int expectedRecordLength = 3;

    var csvChannel = openReadableCsvFile(filePath, COMMA, DEFAULT_ENCODING, 1);
    if (csvChannel is ReadableCSVChannel) {
        test:assertTrue(csvChannel.hasNext());
        var recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testReadRfc() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sampleRfc.csv";
    int expectedRecordLength = 3;

    var csvChannel = openReadableCsvFile(filePath);
    if (csvChannel is ReadableCSVChannel) {
        test:assertTrue(csvChannel.hasNext());
        var recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
            test:assertEquals(recordResult[0], "User1,12", msg = "Found unexpected output");
            test:assertEquals(recordResult[1], "WSO2", msg = "Found unexpected output");
            test:assertEquals(recordResult[2], "07xxxxxx", msg = "Found unexpected output");
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testReadTdf() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sampleTdf.tsv";
    int expectedRecordLength = 3;

    var csvChannel = openReadableCsvFile(filePath, TAB);
    if (csvChannel is ReadableCSVChannel) {
        test:assertTrue(csvChannel.hasNext());
        var recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(csvChannel.hasNext());
        recordResult = csvChannel.getNext();
        if (recordResult is string[]) {
            test:assertEquals(recordResult.length(), expectedRecordLength);
        } else if (recordResult is Error) {
            test:assertFail(msg = recordResult.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertFalse(csvChannel.hasNext());
        var endResult = csvChannel.getNext();
        if (endResult is error) {
            test:assertEquals(endResult.message(), "EoF when reading from the channel", msg = "Found unexpected output");
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testWriteDefaultCsv() {
    string filePath = TEMP_DIR + "recordsDefault.csv";
    string[] content1 = ["Name", "Email", "Telephone"];
    string[] content2 = ["Foo,12", "foo@ballerina/io", "332424242"];
    int expectedRecordLength = 3;

    var writeCsvChannel = openWritableCsvFile(filePath);
    if (writeCsvChannel is WritableCSVChannel) {
        var writeResult = writeCsvChannel.write(content1);
        if (writeResult is Error) {
            test:assertFail(msg = writeResult.message());
        }
        writeResult = writeCsvChannel.write(content2);
        if (writeResult is Error) {
            test:assertFail(msg = writeResult.message());
        }
    } else {
        test:assertFail(msg = writeCsvChannel.message());
    }

    var readCsvChannel = openReadableCsvFile(filePath);
    if (readCsvChannel is ReadableCSVChannel) {
        test:assertTrue(readCsvChannel.hasNext());
        var recordResult1 = readCsvChannel.getNext();
        if (recordResult1 is string[]) {
            test:assertEquals(recordResult1.length(), expectedRecordLength);
            test:assertEquals(recordResult1[0], content1[0]);
            test:assertEquals(recordResult1[1], content1[1]);
            test:assertEquals(recordResult1[2], content1[2]);
        } else if (recordResult1 is Error) {
            test:assertFail(msg = recordResult1.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertTrue(readCsvChannel.hasNext());
        var recordResult2 = readCsvChannel.getNext();
        if (recordResult2 is string[]) {
            test:assertEquals(recordResult2.length(), expectedRecordLength);
            test:assertEquals(recordResult2[0], content2[0]);
            test:assertEquals(recordResult2[1], content2[1]);
            test:assertEquals(recordResult2[2], content2[2]);
        } else if (recordResult2 is Error) {
            test:assertFail(msg = recordResult2.message());
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        test:assertFalse(readCsvChannel.hasNext());
        var endResult = readCsvChannel.getNext();
        if (endResult is error) {
            test:assertEquals(endResult.message(), "EoF when reading from the channel", msg = "Found unexpected output");
        } else {
            test:assertFail(msg = "Unexpected result");
        }

        var closeResult = readCsvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }

    } else {
        test:assertFail(msg = readCsvChannel.message());
    }
}

@test:Config {}
function testReadWriteCustomSeparator() {
    string filePath = TEMP_DIR + "recordsUserDefine.csv";
    string[][] data = [["1", "James", "10000"], ["2", "Nathan", "150000"], ["3", "Ronald", "120000"], ["4", "Roy", 
    "6000"], ["5", "Oliver", "1100000"]];
    int expectedRecordLength = 3;

    var writeCsvChannel = openWritableCsvFile(filePath);
    if (writeCsvChannel is WritableCSVChannel) {
        foreach string[] entry in data {
            var writeResult = writeCsvChannel.write(entry);
            if (writeResult is Error) {
                test:assertFail(msg = writeResult.message());
            }
        }
        var closeResult = writeCsvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = writeCsvChannel.message());
    }

    var readCsvChannel = openReadableCsvFile(filePath);
    if (readCsvChannel is ReadableCSVChannel) {
        int i = 0;
        foreach string[] entry in data {
            test:assertTrue(readCsvChannel.hasNext());
            var recordResult = readCsvChannel.getNext();
            if (recordResult is string[]) {
                test:assertEquals(recordResult.length(), expectedRecordLength);
                test:assertEquals(recordResult[0], data[i][0]);
                test:assertEquals(recordResult[1], data[i][1]);
                test:assertEquals(recordResult[2], data[i][2]);
            } else if (recordResult is Error) {
                test:assertFail(msg = recordResult.message());
            } else {
                test:assertFail(msg = "Unexpected result");
            }
            i += 1;
        }
        var closeResult = readCsvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = readCsvChannel.message());
    }
}

@test:Config {}
function testWriteTdf() {
    string filePath = TEMP_DIR + "recordsTdf.csv";
    string[] content = ["Name", "Email", "Telephone"];

    var csvChannel = openWritableCsvFile(filePath, TAB);
    if (csvChannel is WritableCSVChannel) {
        var result = csvChannel.write(content);
        if (result is Error) {
            test:assertFail(msg = result.message());
        }
        var closeResult = csvChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testTableContent() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sample5.csv";
    float expectedValue = 60001.00;
    float total = 0.0;

    var csvChannel = openReadableCsvFile(filePath);
    if (csvChannel is ReadableCSVChannel) {
        var tableResult = csvChannel.getTable(Employee);
        if (tableResult is table<record { }>) {
            table<Employee> tb = <table<Employee>>tableResult;
            foreach var x in tb {
                total = total + x.salary;
            }
            test:assertEquals(total, expectedValue);
            var closeResult = csvChannel.close();
            if (closeResult is Error) {
                test:assertFail(msg = closeResult.message());
            }
        } else {
            test:assertFail(msg = tableResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testTableWithNull() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sample6.csv";
    string name = "";
    string dep = "";

    var csvChannel = openReadableCsvFile(filePath, skipHeaders = 1);
    if (csvChannel is ReadableCSVChannel) {
        var tblResult = csvChannel.getTable(PerDiem);
        if (tblResult is table<record { }>) {
            table<PerDiem> tb = <table<PerDiem>>tblResult;
            foreach var rec in tb {
                name = name + rec.name;
                dep = dep + (rec.department ?: "-1");
            }
            test:assertEquals(name, "Person1Person2Person3", msg = "Found unexpected output");
            test:assertEquals(dep, "EngMrk-1", msg = "Found unexpected output");

            var closeResult = csvChannel.close();
            if (closeResult is Error) {
                test:assertFail(msg = closeResult.message());
            }
        } else {
            test:assertFail(msg = tblResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testTableWithHeader() {
    string filePath = RESOURCES_BASE_PATH + "datafiles/io/records/sample7.csv";
    string[] expectedOutput = ["Common App ID", "11111111", "22222222", "33333333", "44444444", "55555555", "55555556"];
    string[] keys = [];

    var csvChannel = openReadableCsvFile(filePath);
    if (csvChannel is ReadableCSVChannel) {
        var tblResult = csvChannel.getTable(CommonApp);
        if (tblResult is table<record { }>) {
            table<CommonApp> tb = <table<CommonApp>>tblResult;
            foreach var rec in tb {
                keys.push(rec.appId);
            }

            int i = 0;
            foreach string s in expectedOutput {
                test:assertEquals(keys[i], s, msg = "Found unexpected output");
                i += 1;
            }

            var closeResult = csvChannel.close();
            if (closeResult is Error) {
                test:assertFail(msg = closeResult.message());
            }
        } else {
            test:assertFail(msg = tblResult.message());
        }
    } else {
        test:assertFail(msg = csvChannel.message());
    }
}

@test:Config {}
function testFileCsvWrite() {
    string[][] content = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], ["John Thomson", 
    "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "Sampath Bank", "30 years", 
    "Colombo"]];
    string filePath = TEMP_DIR + "workers1.csv";
    var result = fileWriteCsv(filePath, content);
    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileCsvWrite]}
function testFileCsvRead() {
    string[][] expectedContent = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], [
    "John Thomson", "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "Sampath Bank", 
    "30 years", "Colombo"]];
    string filePath = TEMP_DIR + "workers1.csv";
    var result = fileReadCsv(filePath);
    if (result is string[][]) {
        int i = 0;
        foreach string[] r in expectedContent {
            int j = 0;
            foreach string s in r {
                test:assertEquals(s, expectedContent[i][j]);
                j += 1;
            }
            i += 1;
        }
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileCsvWriteWithSkipHeaders() {
    string[][] content = [["Name", "Occupation", "Company", "Age", "Hometown"], ["Ross Meton", "Civil Engineer", 
    "ABC Construction", "26 years", "Sydney"], ["Matt Jason", "Architect", "Typer", "38 years", "Colombo"]];
    string filePath = TEMP_DIR + "workers2.csv";
    var result = fileWriteCsv(filePath, content);
    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileCsvWriteWithSkipHeaders]}
function testFileCsvReadWithSkipHeaders() {
    string[][] expectedContent = [["Name", "Occupation", "Company", "Age", "Hometown"], ["Ross Meton", "Civil Engineer", 
    "ABC Construction", "26 years", "Sydney"], ["Matt Jason", "Architect", "Typer", "38 years", "Colombo"]];
    string filePath = TEMP_DIR + "workers2.csv";
    var result = fileReadCsv(filePath, 1);
    if (result is string[][]) {
        int i = 0;
        foreach string[] r in expectedContent {
            int j = 0;
            foreach string s in r {
                test:assertEquals(s, expectedContent[i][j]);
                j += 1;
            }
            i += 1;
        }
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileWriteCsvFromStream() {
    string filePath = TEMP_DIR + "workers4.csv";
    string[][] content = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], ["John Thomson", 
    "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "Sampath Bank", "30 years", 
    "Colombo"]];
    var result = fileWriteCsvFromStream(filePath, content.toStream());
    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileWriteCsvFromStream]}
function testFileReadCsvAsStream() {
    string filePath = TEMP_DIR + "workers4.csv";
    string[][] expectedContent = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], [
    "John Thomson", "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "Sampath Bank", 
    "30 years", "Colombo"]];
    var result = fileReadCsvAsStream(filePath);
    if (result is stream<string[], Error>) {
        int i = 0;
        error? e = result.forEach(function(string[] val) {
                               int j = 0;
                               foreach string s in val {
                                   test:assertEquals(s, expectedContent[i][j]);
                                   j += 1;
                               }
                               i += 1;
                           });
        if (e is error) {
            test:assertFail(msg = e.message());
        }
        test:assertEquals(i, 3);
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileCsvWriteWithTruncate() {
    string filePath = TEMP_DIR + "workers2.csv";
    string[][] content1 = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], ["John Thomson",
    "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "Sampath Bank", "30 years",
    "Colombo"]];
    string[][] content2 = [["Distributed Computing", "A001", "Prof. Jack"], ["Quantum Computing", "A002", "Dr. Sam"],
    ["Artificail Intelligence", "A003", "Prof. Angelina"]];

    // Check content 01
    var result1 = fileWriteCsv(filePath, content1);
    if (result1 is Error) {
        test:assertFail(msg = result1.message());
    }
    var result2 = fileReadCsv(filePath);
    if (result2 is string[][]) {
        int i = 0;
        foreach string[] r in content1 {
            int j = 0;
            foreach string s in r {
                test:assertEquals(s, content1[i][j]);
                j += 1;
            }
            i += 1;
        }
    } else {
        test:assertFail(msg = result2.message());
    }

    // Check content 02
    var result3 = fileWriteCsv(filePath, content2);
    if (result3 is Error) {
        test:assertFail(msg = result3.message());
    }
    var result4 = fileReadCsv(filePath);
    if (result4 is string[][]) {
        int i = 0;
        foreach string[] r in content2 {
            int j = 0;
            foreach string s in r {
                test:assertEquals(s, content2[i][j]);
                j += 1;
            }
            i += 1;
        }
    } else {
        test:assertFail(msg = result4.message());
    }

}
