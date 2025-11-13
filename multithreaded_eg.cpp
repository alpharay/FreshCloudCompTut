#include <iostream>
#include <thread>
#include <vector>
#include <chrono>

void print_message(const std::string& message, int thread_id)
{
  for(int i=0; i< 5; i++){
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout<<"Thread" << thread_id << ": " << message << std::endl;
  }
}


int main()
{
  const int num_threads = 3; //the number of threads
  std::vector<std::thread> threads; // setting the vector container to receive the threads

  //create and start threads
  for(int i = 0; i < num_threads; i++){
    threads.emplace_back(print_message,"Message from thread", i);
  }

  //join all the threads to ensure that the main thread waits for all other threads to finish
  for(auto& th : threads) th.join();

  std::cout<< "All threads have finished execution." << std::endl;
  return 0;
}
