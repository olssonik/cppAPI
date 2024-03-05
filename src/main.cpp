#include <iostream>
#include <string>
#include <curl/curl.h>


size_t writeCallback(void *contents, size_t size, size_t nmemb, std::string *output) {
    size_t totalSize = size * nmemb;
    output->append((char*)contents, totalSize);
    return totalSize;
}

int main() {
    CURL *curl;
    CURLcode res;
    std::string response;

    std::cout << "Enter the URL: ";
    std::string url;
    std::getline(std::cin, url);

    curl = curl_easy_init();
    if (curl) {

        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());


        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);


        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);


        res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            std::cerr << "curl_easy_perform() failed: " << curl_easy_strerror(res) << std::endl;
        }

        // Clean up
        curl_easy_cleanup(curl);
    }

    std::cout << "Response: " << response << std::endl;

    return 0;
}
