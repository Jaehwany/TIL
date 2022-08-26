const axios = require('axios');

async function request(sub_path){
	const url = 'http://13.124.193.201:8844/' + sub_path
	try{
		const response = await axios.get(url);								
		return response.data
	}
	catch(e){

		console.log(e)
	}
}


const array = [{sub_path:'a'}, {sub_path:'b'},{sub_path:'c'},{sub_path:'d'},{sub_path:'e'}]

array.reduce((prev, item) => {

	return prev.then(() =>
		request(item.sub_path).then((promise) => {console.log(promise)}))

}, Promise.resolve())