package com.java.philly.jud.mininote.repository;

import com.azure.spring.data.cosmos.repository.CosmosRepository;
import com.java.philly.jud.mininote.model.MiniNote;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MiniNoteRepository extends CosmosRepository<MiniNote, String> {

    List<MiniNote> findAll();
}
