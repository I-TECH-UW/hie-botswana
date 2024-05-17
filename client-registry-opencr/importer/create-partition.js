import got from 'got';

const partition = process.env.PARTITION || 'opencr';

(async () => {
  const createPartition = async () => {
    //Check db exists before creating
    got.post('http://hapi-fhir:8080/fhir/default/$partition-management-create-partition', {
      json: {
        'resourceType': 'Parameters',
        'parameter': [
          {
            'name': 'id',
            'valueInteger': 1
          },
          {
            'name': 'name',
            'valueString': partition
          },
          {
            'name': 'description',
            'valueString': 'OpenCR Partition'
          }
        ]
      }
    }).then(response => {
      console.log(response.body);
    }).catch(error => {
      console.error('Error creating database:', error.message)
    });
  }
})();
