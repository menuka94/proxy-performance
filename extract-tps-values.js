const fs = require('fs');

const proxy = "netty";
const resultsDir = "results/" + proxy;

const payloads = ["500", "1024", "5120", "10240", "102400", "512000"];
const users = ["100", "200", "500", "1000"];

payloads.forEach((payload) => {
    users.forEach((users) => {
        let summaryFileCommon = proxy + "-payload" + payload + "-users" + users;
        let summaryFilePath = resultsDir + "/" + summaryFileCommon + "/" + summaryFileCommon + "-measurement-summary.json";
        console.log(summaryFilePath);
        let summaryJson = JSON.parse(fs.readFileSync(summaryFilePath, 'utf-8'));
        console.log(summaryJson);
    });
});

