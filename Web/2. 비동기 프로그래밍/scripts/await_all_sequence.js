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

async function test(){
	const async_fun_list = []
	for(item of array){	
		const async_fun = request(item.sub_path)
		async_fun_list.push(async_fun)
	}
		
	for(async_fun of async_fun_list){
		const resolve = await async_fun	
		console.log(resolve)
	}		
}

	
test()
