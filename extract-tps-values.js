const fs = require('fs');
const {convertArrayToCSV} = require('convert-array-to-csv');

const proxy = "netty";
const resultsDir = "results/" + proxy;

const payloads = ["500", "1024", "5120", "10240", "102400", "512000"];
const users = ["100", "200", "500", "1000"];

let records = [];

payloads.forEach((payload) => {
    console.log("Payload:", payload);
    console.log('================');
    users.forEach((users) => {
        let summaryFileCommon = proxy + "-payload" + payload + "-users" + users;
        let summaryFilePath = resultsDir + "/" + summaryFileCommon + "/" + summaryFileCommon + "-measurement-summary.json";
        console.log(summaryFileCommon);
        let summaryJson = JSON.parse(fs.readFileSync(summaryFilePath, 'utf-8'));
        let throughput = summaryJson["HTTP Request"].throughput;
        let errorPercentage = summaryJson["HTTP Request"].errorPercentage;

        console.log("Throughput:", throughput);
        console.log("ErrorPercentage:", errorPercentage);

        records.push({
            payload: payload,
            users: users,
            errorPercentage: errorPercentage,
            throughput: throughput
        });
        console.log();
    });
    console.log();
});

const csvs = convertArrayToCSV(records);
console.log(csvs);


fs.writeFile('csvs/netty.csv', csvs, function (err) {
    if(err) {
        return console.log(err);
    }
    console.log('...Done');
});