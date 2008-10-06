package com.kazak.comeet.server.comunications;

import java.nio.channels.SocketChannel;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;
import com.kazak.comeet.server.comunications.SocketServer.SocketInfo;

public class PDASocketsHash {
    private static Hashtable <SocketChannel,SocketInfo> PDAhash;
    
    public PDASocketsHash() {
    	PDAhash = new Hashtable<SocketChannel,SocketInfo>();
    }
    
    public void addSocket(SocketChannel channel, SocketInfo socket) {
    	PDAhash.put(channel, socket);
    }
    
    public void removeSocket(SocketChannel channel) {
    	PDAhash.remove(channel);
    }
    
    public int size() {
    	return PDAhash.size();    	
    }
    
    public Hashtable getHash() {
    	return PDAhash;
    }
    
    public Collection<SocketInfo> getHashValues() {
    	return PDAhash.values();
    }
    
    public Enumeration<SocketChannel> getKeys() {
    	return PDAhash.keys();
    }   
}
