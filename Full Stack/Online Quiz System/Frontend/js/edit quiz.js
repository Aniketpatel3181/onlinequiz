async function editQuiz(id){

const title=prompt("New Quiz Title");

const duration=prompt("Duration");

await fetch(API+"/quiz/"+id,{

method:"PUT",

headers:{

"Content-Type":"application/json",

Authorization:"Bearer "+token

},

body:JSON.stringify({

title,
duration

})

});

alert("Updated Successfully");

location.reload();

}