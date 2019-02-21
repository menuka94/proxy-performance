const fs = require('fs');
const {convertArrayToCSV} = require('convert-array-to-csv');

const proxy = "esb";
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
        if (fs.existsSync(summaryFilePath)) {
            console.log(summaryFileCommon);
            let summaryJson = JSON.parse(fs.readFileSync(summaryFilePath, 'utf-8'));

            let jsonHttpRequest = summaryJson["HTTP Request"];
            console.log(jsonHttpRequest);
            if (jsonHttpRequest) {
                let throughput = jsonHttpRequest.throughput;
                let errorPercentage = jsonHttpRequest.errorPercentage;

                console.log("Throughput:", throughput);
                console.log("ErrorPercentage:", errorPercentage);

                records.push({
                    payload: payload,
                    users: users,
                    errorPercentage: errorPercentage,
                    throughput: throughput
                });
            }
        }
        console.log();
    });
    console.log();
});

const csvs = convertArrayToCSV(records);
console.log(csvs);


fs.writeFile('csvs/' + proxy + '.csv', csvs, function (err) {
    if (err) {
        return console.log(err);
    }
    console.log('...Done');
});