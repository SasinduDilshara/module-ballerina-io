// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

@test:Config {}
function testWriteXml() {
    string filePath = TEMP_DIR + "xmlCharsFile1.xml";
    createDirectoryExtern(TEMP_DIR);
    xml content = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var byteChannel = openWritableFile(filePath);
    if (byteChannel is WritableByteChannel) {
        WritableCharacterChannel characterChannel = new WritableCharacterChannel(byteChannel, DEFAULT_ENCODING);
        var result = characterChannel.writeXml(content);
        if (result is Error) {
            test:assertFail(msg = result.message());
        }

        var closeResult = characterChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {dependsOn: [testWriteXml]}
function testReadXml() {
    string filePath = TEMP_DIR + "xmlCharsFile1.xml";
    xml expectedXml = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var byteChannel = openReadableFile(filePath);
    if (byteChannel is ReadableByteChannel) {
        ReadableCharacterChannel characterChannel = new ReadableCharacterChannel(byteChannel, DEFAULT_ENCODING);
        var result = characterChannel.readXml();
        if (result is xml) {
            test:assertEquals(result, expectedXml, msg = "Found unexpected output");
        } else {
            test:assertFail(msg = result.message());
        }

        var closeResult = characterChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {}
function testFileWriteXml() {
    string filePath = TEMP_DIR + "xmlCharsFile2.xml";
    xml content = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var result = fileWriteXml(filePath, content);
    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileWriteXml]}
function testFileReadXml() {
    string filePath = TEMP_DIR + "xmlCharsFile2.xml";
    xml expectedXml = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var result = fileReadXml(filePath);
    if (result is xml) {
        test:assertEquals(result, expectedXml, msg = "Found unexpected output");
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileWriteXmlWithOverwrite() {
    string filePath = TEMP_DIR + "xmlCharsFile3.xml";
    xml content1 = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    xml content2 = xml `<USER><NAME>Mary Jane</NAME><AGE>33</AGE></USER>`;
    // Check content 01
    var result1 = fileWriteXml(filePath, content1);
    if (result1 is Error) {
        test:assertFail(msg = result1.message());
    }
    var result2 = fileReadXml(filePath);
    if (result2 is xml) {
        test:assertEquals(result2, content1);
    } else {
        test:assertFail(msg = result2.message());
    }

    // Check content 02
    var result3 = fileWriteXml(filePath, content2);
    if (result3 is Error) {
        test:assertFail(msg = result3.message());
    }
    var result4 = fileReadXml(filePath);
    if (result4 is xml) {
        test:assertEquals(result4, content2);
    } else {
        test:assertFail(msg = result4.message());
    }
}

@test:Config {}
function testFileWriteDocTypedXml() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    xml content = xml `<note>
    <to>Tove</to>
    <from>Jani</from>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
    </note>`;
    string docTypeValue = "<!DOCTYPE note SYSTEM \"Note.dtd\">";

    var writeResult = fileWriteXml(filePath, content, docType=docTypeValue);
    if (writeResult is Error) {
        test:assertFail(msg = writeResult.message());
    }
    var readResult = fileReadString(filePath);
    if (readResult is string) {
        test:assertEquals(readResult, (xml:concat(docTypeValue, NEW_LINE, content)).toString());
    } else {
        test:assertFail(msg = readResult.message());
    }

}

@test:Config {}
function testFileWriteDocTypedWithMultiRoots() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    xml content = xml `<note>
    <to>Tove</to>
    <from>Jani</from>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
    </note>`;
    string docTypeValue = "<!DOCTYPE note SYSTEM \"Note.dtd\">";
    xml x1 = xml `<body>Don't forget me this weekend!</body>`;

    var writeResult = fileWriteXml(filePath, xml:concat(content, x1), docType=docTypeValue);
    if (writeResult is Error) {
        test:assertEquals(writeResult.message(), "The DOCUMENT XML can only contains single root");
    }
}

@test:Config {}
function testFileWriteDocTypedWithAppend() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    xml content = xml `<note>
    <to>Tove</to>
    <from>Jani</from>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
    </note>`;
    string docTypeValue = "<!DOCTYPE note SYSTEM \"Note.dtd\">";

    var writeResult = fileWriteXml(filePath, content,
                        docType=docTypeValue, fileWriteOption=APPEND);
    if (writeResult is Error) {
        test:assertEquals(writeResult.message(), "The APPEND operation not allowed with DOCUMENT");
    }
}

@test:Config {dependsOn: [testFileWriteDocTypedXml]}
function testFileAppendDocTypedXml() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    xml existingContent = xml `<note>
    <to>Tove</to>
    <from>Jani</from>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
    </note>`;
    string docTypeValue = "<!DOCTYPE note SYSTEM \"Note.dtd\">";
    xml content = xml `<body>Don't forget me this weekend!</body>`;
    var appendResult = fileWriteXml(filePath, content, fileWriteOption=APPEND, xmlContentType=EXTERNAL_PARSED_ENTITY);
    if (appendResult is Error) {
        test:assertFail(msg = appendResult.message());
    }
    var readResult = fileReadString(filePath);
    if (readResult is string) {
        test:assertEquals(readResult,
            (xml:concat(docTypeValue, NEW_LINE, existingContent, content)).toString());
    } else {
        test:assertFail(msg = readResult.message());
    }
}
