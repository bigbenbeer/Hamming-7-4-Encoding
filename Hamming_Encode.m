
function [bitstream] = Hamming_Encode(input_from_foto)
%========================================================================
%Hamming encode
%========================================================================
%This function makes use of the Hamming(7,4) encoding to encode 4 data bits
%with 3 parity bits. This function was authored by Benjamin Beer. For the
%detailed break down of what the hamming algorithm is and how it is
%implemented please refer to the Hamming section of the practical report in
%part B.
%This algorithm accepts a bitstream input

input=input_from_foto;
k=numel(input);
k=k./4;
z=logical(zeros(k,4));

z=reshape(input,[4,k]);
z=z.';
%The functions above reshape the input bitstream into a n-by-4 array . This
%n-by-4 array will be used to create the three even parity bits p0,p1 & p2.
%These parity bits are then inserted into an n-by-7 array with the data
%bits. These parity btis will be used to error check the data on the client
%side.

k=length(z); 

hamming=logical(zeros(k,7)); %Init of the array
tracker=1;

for a=1:k %This for loop has an O(n) complexity of n however when working
    %with large data arrays it takes quite some time to complete a full
    %encoding sequence

    if(mod(z(a,1)+z(a,2)+z(a,4),2)==0)
       
       p1=0; 
    else
       p1=1;
    end


    if(mod(z(a,1)+z(a,3)+z(a,4),2)==0)
       
       p2=0; 
    else
       p2=1;
    end
      
    if(mod(z(a,2)+z(a,3)+z(a,4),2)==0)
       
       p3=0; 
    else
       p3=1;
    end
   
   hamming(a,:)=[p1 p2 z(a,1) p3 z(a,2) z(a,3) z(a,4)]; %here the n-by-4 
   %array is reshaped and the 3 parity bits are inserted to for a n-by-7
   %array .
    
end


%the n-by-7 array is then reshaped into a n-by-1 bitstream
bitstream=reshape(hamming.',[],1);

end