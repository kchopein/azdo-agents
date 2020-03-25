$repo="alexdegrootnl"
$imageName="azdo-agent-lin"
$stamp=$(get-date -f yyyyMMddHHmm)
$latestImage="${repo}/${imageName}:latest"
$latestImageWithStamp="${repo}/${imageName}:${stamp}"

docker build -t $latestImage -t $latestImageWithStamp .

docker push $latestImage
docker push $latestImageWithStamp