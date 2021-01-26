DEBEZIUM_VERSION=1.4

.PHONY: up
up:
	docker-compose up -d

.PHONY: down
down:
	docker-compose down

.PHONY: down clean volumes
down-v:
	docker-compose down -v

.PHONY: kafka list topics
kafka-topics:
	docker-compose exec kafka bin/kafka-topics.sh --list --zookeeper zookeeper:2181

.PHONY: kafka consume topic 
kafka-consume:
	docker-compose exec kafka bin/kafka-console-consumer.sh \
	--bootstrap-server kafka:9092 \
	--from-beginning \
	--property print.key=true \
	--topic kitchen.public.items

.PHONY: register debezium connector
register-connector:
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-postgres.json

.PHONY: delete debezium connector
delete-connector:
	curl -i -X DELETE -H "Accept:application/json" localhost:8083/connectors/kitchen-connector

.PHONY: test $(XPTO)
test1: $(XPTO)
	echo $(XPTO)