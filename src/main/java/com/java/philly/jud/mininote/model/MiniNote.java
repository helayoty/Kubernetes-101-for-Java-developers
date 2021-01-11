package com.java.philly.jud.mininote.model;

import com.azure.spring.data.cosmos.core.mapping.PartitionKey;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.stereotype.Component;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Component
@Document(collection = "MiniNote")
public
class MiniNote {

    @Id
    @PartitionKey
    private String id;
    private String description;

    @Override
    public String toString() {
        return description;
    }
}