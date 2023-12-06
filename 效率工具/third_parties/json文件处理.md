### cpp
- jsoncpp
[github](https://github.com/open-source-parsers/jsoncpp)
```cpp
std::string default_map_name;
Json::Reader reader;
Json::Value root;
bool has_default_map = false;
if (reader.parse(file, root))
{
	if(root["map_list"].size() == 0)
    {
	    LOG(WARNING)<<"No map within map_list!";
	    return false;
    }

    for (unsigned int i = 0; i < root["map_list"].size(); i++)
    {
	    has_default_map = root["map_list"][i]["default"].asBool();
	    if(has_default_map)
        {
	        default_map_name = root["map_list"][i]["name"].asString();
	        break;
	    }
    }
}
```