document
.getElementById("quizForm")
.addEventListener("submit",async(e)=>{

e.preventDefault();

const title=document.getElementById("title").value;

const duration=document.getElementById("duration").value;

await fetch(API+"/quiz",{

method:"POST",

headers:{

"Content-Type":"application/json",

Authorization:"Bearer "+token

},

body:JSON.stringify({

title,
duration

})

});

alert("Quiz Created");

location.reload();

});