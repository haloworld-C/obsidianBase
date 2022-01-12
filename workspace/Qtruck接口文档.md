## general module interfaces document
### inputs

|message name | message type | source module | description |
|:------------|:-------------|:--------------|:------------|
|/task\_info  | TaskInfo.msg | FMS           | routing destination and other info|
|/stop\_dis   | std\_msgs::Float32 | FMS     | 轮胎吊上的激光雷达偏移量，用以调整停止位置| 