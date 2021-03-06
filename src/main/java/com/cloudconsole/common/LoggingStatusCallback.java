package com.cloudconsole.common;

import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cloudfoundry.client.lib.UploadStatusCallback;

public class LoggingStatusCallback implements UploadStatusCallback{

	private static final Log log = LogFactory.getLog(LoggingStatusCallback.class);

    private final Timer timer;

    public LoggingStatusCallback(Timer timer2) {
        this.timer = timer2;
    }
	
	@Override
	public void onCheckResources() {
		log.info("Preparing to upload to CloudFoundry - comparing resources...");		
	}

	@Override
	public void onMatchedFileNames(Set<String> matchedFileNames) {
		log.info(matchedFileNames.size() + " files already cached...");	
	}

	@Override
	public void onProcessMatchedResources(int length) {
		log.info("Uploading " + length + " bytes...");
        this.timer.start();		
	}

	@Override
	public boolean onProgress(String status) {
		// TODO Auto-generated method stub
		return false;
	}
	
	public static final class Timer {

        private long startTime;

        public void start() {
            this.startTime = System.currentTimeMillis();
        }

        public long stop() {
            return System.currentTimeMillis() - this.startTime;
        }
    }

}
