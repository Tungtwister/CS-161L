#include <iostream>
#include <vector>
#include <stdio.h> //for printf
#include <math.h> //log function
#include <algorithm>
#include <climits>

#define  BLOCK_SIZE     16
//#define  CACHE_SIZE     16384

using namespace std;

struct set 
{
  vector<unsigned long long> time;
  vector<unsigned long long> tag;
};

unsigned long long offset_calc(int a) //calculates offset
{
  unsigned long long b = 1;
  for (int i = 1; i < a; ++i)
  {
    b = (b << 1) + 1;
  }
  return b;
}

int lru (vector<unsigned long long> time) //for LRU replacement
{
  unsigned long long min = ULLONG_MAX;
  int tmp = 0;
  for (unsigned int i = 0; i < time.size(); ++i)
    if (min > time[i])
    {
      tmp = i;
      min = time[i];
    }
  return tmp;
}
unsigned long long lines[10000000];
unsigned long long inputs = 0;

double miss_rate (int policy, int CACHE_SIZE, unsigned int ASS) //inputs policy, cache size, associativity
{
    unsigned long long curr_time = 1;
    int number_of_blocks = CACHE_SIZE / BLOCK_SIZE / ASS; 
    set cache[number_of_blocks]; //build cache
    int offsetSize = (int)log2(BLOCK_SIZE); 
    int indexSize = (int)log2(number_of_blocks);
    unsigned long long read_line;
    int total = 0, miss = 0;
    int line_index = 0;
    
    while (line_index <= inputs) 
    {
      read_line = lines[line_index++];
      ++total;
      unsigned long long tag   = read_line >> (indexSize + offsetSize); //get tag
      unsigned long long index = read_line >> offsetSize; //get index
      index = index & offset_calc(indexSize);
      vector<unsigned long long>::const_iterator it;
      it = find(cache[index].tag.begin(), cache[index].tag.end(), tag);
      if (it == cache[index].tag.end()) //check for miss
      {
        ++miss;
        cache[index].tag.push_back(tag);
        cache[index].time.push_back(curr_time++);
        if  (cache[index].tag.size() > ASS) 
        {
          if (policy) //LRU if policy is 1
          { 
            int lru_ = lru(cache[index].time);
            cache[index].tag.erase(cache[index].tag.begin() + lru_);
            cache[index].time.erase(cache[index].time.begin() + lru_);
          }
          else //FIFO if policy is 0
          { 
            cache[index].tag.erase(cache[index].tag.begin());
            cache[index].time.erase(cache[index].time.begin());
          }
        }
      }
      else
      {
        int time_index = it - cache[index].tag.begin();
        cache[index].time[time_index] = curr_time++;
      }
   }
   double miss_rate_tmp = (double)miss / (double)(total);
   return miss_rate_tmp;
}

int main()
{
  while(std::cin >> std::hex >> lines[inputs++]); //pulls values from trace
   printf("  LRU Replacement Policy\n  "); //this builds the LRU replacement policy grid
   for (int i = 1024; i <= 16384; i=i*2)
   {
      printf("%d  ",i);
   }
   for (int i = 1; i <= 8; i=i*2)
   {
     printf("\n%d ",i);
     for (int j = 1024; j <= 16384; j=j*2)
     {
       printf("%0.2lf ", miss_rate(1,j,i) * 100.0);
     }
   }
   
    cout << endl << endl;
   printf("  FIFO Replacement Policy\n  "); //this builds the FIFO replacement policy grid
   for (int i = 1024; i <= 16384; i=i*2)
   {
      printf("%d  ",i);
   }
   for (int i = 1; i <= 8; i=i*2)
   {
     printf("\n%d ",i);
     for (int j = 1024; j <= 16384; j=j*2)
     {
       printf("%0.2lf ", miss_rate(0,j,i) * 100.0);
     }
   }
   cout << endl;
   
   return 0;
}

//given sample simulation program
// int main () {
//   // build cache
//   int number_of_blocks = CACHE_SIZE / BLOCK_SIZE;
//   std::vector<unsigned long long> cache;

//   for (int i = 0; i < number_of_blocks; ++i)
//       cache.push_back(0);

//   // read memory accesses from standard input
//   unsigned long long read_line;
//   int total = 0, miss = 0;
//   while (std::cin >> std::hex >> read_line) {
//       total++;
//       unsigned long long tag   = read_line >> (10 + 4); // get tag
//       unsigned long long index = read_line >> 4;        // get index
//       index = index & 0x00000000000003FF;

//       // check for miss
//       if (cache[index] != tag) {
//          cache[index] = tag;
//          miss++;
//       }
//   }
//   double miss_rate = (double)miss / (double)(total);

//   printf("total accesses: %d\n", total);
//   printf("miss rate:      %0.2lf\n", miss_rate * 100.0);

//   return 0;
// }