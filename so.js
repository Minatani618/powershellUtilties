const { exec } = require("child_process");

async function pingIPAddresses(start, end) {
  const results = [];

  for (let i = start; i <= end; i++) {
    const ipAddress = `192.168.11.${i}`;

    await new Promise((resolve, reject) => {
      exec(`ping ${ipAddress}`, (error, stdout, stderr) => {
        if (error) {
          results.push({ ipAddress, status: "Error", message: error.message });
        } else {
          results.push({ ipAddress, status: "Success", message: stdout });
        }
        resolve();
      });
    });
  }

  return results;
}

async function main() {
  const startIP = 100;
  const endIP = 200;

  try {
    const results = await pingIPAddresses(startIP, endIP);
    console.log(results);
  } catch (error) {
    console.error(error);
  }
  console.log("result");
}

main();
