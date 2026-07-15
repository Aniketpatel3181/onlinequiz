async function deleteQuiz(id){

if(!confirm("Delete Quiz?")) return;

await fetch(API+"/quiz/"+id,{

method:"DELETE",

headers:{

Authorization:"Bearer "+token

}

});

alert("Deleted Successfully");

location.reload();

}