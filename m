Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A7181D5F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgCKQNI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46901 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgCKQNH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:13:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so3342972wrw.13
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D8nMx7fe6bx5qr2FHnRAwghCD1fll4dzRJe+G3pyv7U=;
        b=B3ir/pboWmG6GmjPiKKSosLhvQLc3H/G4DvuZ5ohMmSUAwJs7VWFgQJ7tg+gXsHTWv
         9J1Bi1WmgpQc5HfmHBAyBfPLhpknkAWCgvA3RDklsGvTBdSh7XW+DQ7qL4BdB9QD2dZu
         KpT3hV+jJU48xa/Wz7XXqRiFpCpubkbpjWoIxVjXQxm3/tlgcwbMRsa+knAEsUybBXrd
         4qY0thwFo3xWfmVFFJ+iNg6RGXXC7JYhj+dGSd6M7hHuhbcsl9U6d0sghJjtfTG6Th5F
         vxVqLDt60++jxvRrN8jITdGWZ71pcp2CDgfdIwNeUAsgQn9FXM2KTXkKqU/fnJEsFRlS
         fNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D8nMx7fe6bx5qr2FHnRAwghCD1fll4dzRJe+G3pyv7U=;
        b=N8AurnlLOH4oIYawL5YHwk1lmGyn6SCCrsunj3Cg4hehX2AhM1hTONmN4ABsE+NPCk
         CPAZrNiOhIRfFUqr6ahv02cwLWhJD+WznHWt6mdRaCaYeWWKOCCnb97Qc/s4LJzR0bk2
         OuQLGi8HouQprSVNIl214OD9kUotloUQvWgZR0URUcTAUgrwK1xEPWklDTOzHV1Z4CTd
         abvd+uFRSpX9Nh/z1pUGA+z9pZGs6Hfq5INTZ66Ni1CcO6GeXzni1+hnKRcb6H/+bV+A
         IPGylNIJ2Rx+jiXtGRg14Hm7j9SVegUJJdAoBJ6x+xWGxuvz0yXLiGZsVtLQF9Fd3Ptr
         987A==
X-Gm-Message-State: ANhLgQ0OUedLK1bNizqiqkJExNJ98EJUtDYmBRi/rtr4DZ1PCjtuDBKf
        h6eMDo+8liiN2zmL4pk/Kt2vzq04Jrk=
X-Google-Smtp-Source: ADFU+vsq/nVTY1XnzDP3nJYQHlueGgGBL7sT9B0Nl7Xeq7T0j0NEC5YKens7prOWY05m1WeD5BFS4g==
X-Received: by 2002:adf:f708:: with SMTP id r8mr5165982wrp.221.1583943184473;
        Wed, 11 Mar 2020 09:13:04 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:03 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com, linux-kernel@vger.kernel.org
Subject: [PATCH v10 14/26] RDMA/rtrs: a bit of documentation
Date:   Wed, 11 Mar 2020 17:12:28 +0100
Message-Id: <20200311161240.30190-15-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

README with description of major sysfs entries, sysfs documentation
has been moved to ABI dir as suggested by Bart.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: linux-kernel@vger.kernel.org
---
 .../ABI/testing/sysfs-class-rtrs-client       | 131 +++++++++++
 .../ABI/testing/sysfs-class-rtrs-server       |  53 +++++
 drivers/infiniband/ulp/rtrs/README            | 213 ++++++++++++++++++
 3 files changed, 397 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
 create mode 100644 drivers/infiniband/ulp/rtrs/README

diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
new file mode 100644
index 000000000000..e7e718db8941
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -0,0 +1,131 @@
+What:		/sys/class/rtrs-client
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	When a user of RTRS API creates a new session, a directory entry with
+		the name of that session is created under /sys/class/rtrs-client/<session-name>/
+
+What:		/sys/class/rtrs-client/<session-name>/add_path
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RW, adds a new path (connection) to an existing session. Expected format is the
+		following:
+
+		<[source addr,]destination addr>
+		*addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]
+
+What:		/sys/class/rtrs-client/<session-name>/max_reconnect_attempts
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Maximum number reconnect attempts the client should make before giving up
+		after connection breaks unexpectedly.
+
+What:		/sys/class/rtrs-client/<session-name>/mp_policy
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Multipath policy specifies which path should be selected on each IO:
+
+		round-robin (0):
+		select path in per CPU round-robin manner.
+
+		min-inflight (1):
+		select path with minimum inflights.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Each path belonging to a given session is listed here by its source and
+		destination address. When a new path is added to a session by writing to
+		the "add_path" entry, a directory <src@dst> is created.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/state
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains "connected" if the session is connected to the peer and fully
+		functional.  Otherwise the file contains "disconnected"
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/reconnect
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write "1" to the file in order to reconnect the path.
+		Operation is blocking and returns 0 if reconnect was successful.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/disconnect
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write "1" to the file in order to disconnect the path.
+		Operation blocks until RTRS path is disconnected.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/remove_path
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write "1" to the file in order to disconnected and remove the path
+		from the session.  Operation blocks until the path is disconnected
+		and removed from the session.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the the name of HCA the connection established on.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the port number of active port traffic is going through.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/src_addr
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the source address of the path
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/dst_addr
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the destination address of the path
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/reset_all
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RW, Read will return usage help, write 0 will clear all the statistics.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/cpu_migration
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RTRS expects that each HCA IRQ is pinned to a separate CPU. If it's
+		not the case, the processing of an I/O response could be processed on a
+		different CPU than where it was originally submitted.  This file shows
+		how many interrupts where generated on a non expected CPU.
+		"from:" is the CPU on which the IRQ was expected, but not generated.
+		"to:" is the CPU on which the IRQ was generated, but not expected.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/reconnects
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Contains 2 unsigned int values, the first one records number of successful
+		reconnects in the path lifetime, the second one records number of failed
+		reconnects in the path lifetime.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/rdma
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Contains statistics regarding rdma operations and inflight operations.
+		The output consists of 6 values:
+
+		<read-count> <read-total-size> <write-count> <write-total-size> \
+		<inflights> <failovered>
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
new file mode 100644
index 000000000000..3b6d5b067df0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -0,0 +1,53 @@
+What:		/sys/class/rtrs-server
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	When a user of RTRS API creates a new session on a client side, a
+		directory entry with the name of that session is created in here.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	When new path is created by writing to "add_path" entry on client side,
+		a directory entry named as <source address>@<destination address> is created
+		on server.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/disconnect
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	When "1" is written to the file, the RTRS session is being disconnected.
+		Operations is non-blocking and returns control immediately to the caller.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the the name of HCA the connection established on.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the port number of active port traffic is going through.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/src_addr
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the source address of the path
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/dst_addr
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the destination address of the path
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/stats/rdma
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Contains statistics regarding rdma operations and inflight operations.
+		The output consists of 5 values:
+		<read-count> <read-total-size> <write-count> <write-total-size> <inflights>
diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README
new file mode 100644
index 000000000000..5d9ea142e5dd
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/README
@@ -0,0 +1,213 @@
+****************************
+RDMA Transport (RTRS)
+****************************
+
+RTRS (RDMA Transport) is a reliable high speed transport library
+which provides support to establish optimal number of connections
+between client and server machines using RDMA (InfiniBand, RoCE, iWarp)
+transport. It is optimized to transfer (read/write) IO blocks.
+
+In its core interface it follows the BIO semantics of providing the
+possibility to either write data from an sg list to the remote side
+or to request ("read") data transfer from the remote side into a given
+sg list.
+
+RTRS provides I/O fail-over and load-balancing capabilities by using
+multipath I/O (see "add_path" and "mp_policy" configuration entries in
+Documentation/ABI/testing/sysfs-class-rtrs-client).
+
+RTRS is used by the RNBD (RDMA Network Block Device) modules.
+
+==================
+Transport protocol
+==================
+
+Overview
+--------
+An established connection between a client and a server is called rtrs
+session. A session is associated with a set of memory chunks reserved on the
+server side for a given client for rdma transfer. A session
+consists of multiple paths, each representing a separate physical link
+between client and server. Those are used for load balancing and failover.
+Each path consists of as many connections (QPs) as there are cpus on
+the client.
+
+When processing an incoming write or read request, rtrs client uses memory
+chunks reserved for him on the server side. Their number, size and addresses
+need to be exchanged between client and server during the connection
+establishment phase. Apart from the memory related information client needs to
+inform the server about the session name and identify each path and connection
+individually.
+
+On an established session client sends to server write or read messages.
+Server uses immediate field to tell the client which request is being
+acknowledged and for errno. Client uses immediate field to tell the server
+which of the memory chunks has been accessed and at which offset the message
+can be found.
+
+Module parameter always_invalidate is introduced for the security problem
+discussed in LPC RDMA MC 2019. When always_invalidate=Y, on the server side we
+invalidate each rdma buffer before we hand it over to RNBD server and
+then pass it to the block layer. A new rkey is generated and registered for the
+buffer after it returns back from the block layer and RNBD server.
+The new rkey is sent back to the client along with the IO result.
+The procedure is the default behaviour of the driver. This invalidation and
+registration on each IO causes performance drop of up to 20%. A user of the
+driver may choose to load the modules with this mechanism switched off
+(always_invalidate=N), if he understands and can take the risk of a malicious
+client being able to corrupt memory of a server it is connected to. This might
+be a reasonable option in a scenario where all the clients and all the servers
+are located within a secure datacenter.
+
+
+Connection establishment
+------------------------
+
+1. Client starts establishing connections belonging to a path of a session one
+by one via attaching RTRS_MSG_CON_REQ messages to the rdma_connect requests.
+Those include uuid of the session and uuid of the path to be
+established. They are used by the server to find a persisting session/path or
+to create a new one when necessary. The message also contains the protocol
+version and magic for compatibility, total number of connections per session
+(as many as cpus on the client), the id of the current connection and
+the reconnect counter, which is used to resolve the situations where
+client is trying to reconnect a path, while server is still destroying the old
+one.
+
+2. Server accepts the connection requests one by one and attaches
+RTRS_MSG_CONN_RSP messages to the rdma_accept. Apart from magic and
+protocol version, the messages include error code, queue depth supported by
+the server (number of memory chunks which are going to be allocated for that
+session) and the maximum size of one io, RTRS_MSG_NEW_RKEY_F flags is set
+when always_invalidate=Y.
+
+3. After all connections of a path are established client sends to server the
+RTRS_MSG_INFO_REQ message, containing the name of the session. This message
+requests the address information from the server.
+
+4. Server replies to the session info request message with RTRS_MSG_INFO_RSP,
+which contains the addresses and keys of the RDMA buffers allocated for that
+session.
+
+5. Session becomes connected after all paths to be established are connected
+(i.e. steps 1-4 finished for all paths requested for a session)
+
+6. Server and client exchange periodically heartbeat messages (empty rdma
+messages with an immediate field) which are used to detect a crash on remote
+side or network outage in an absence of IO.
+
+7. On any RDMA related error or in the case of a heartbeat timeout, the
+corresponding path is disconnected, all the inflight IO are failed over to a
+healthy path, if any, and the reconnect mechanism is triggered.
+
+CLT                                     SRV
+*for each connection belonging to a path and for each path:
+RTRS_MSG_CON_REQ  ------------------->
+                   <------------------- RTRS_MSG_CON_RSP
+...
+*after all connections are established:
+RTRS_MSG_INFO_REQ ------------------->
+                   <------------------- RTRS_MSG_INFO_RSP
+*heartbeat is started from both sides:
+                   -------------------> [RTRS_HB_MSG_IMM]
+[RTRS_HB_MSG_ACK] <-------------------
+[RTRS_HB_MSG_IMM] <-------------------
+                   -------------------> [RTRS_HB_MSG_ACK]
+
+IO path
+-------
+
+* Write (always_invalidate=N) *
+
+1. When processing a write request client selects one of the memory chunks
+on the server side and rdma writes there the user data, user header and the
+RTRS_MSG_RDMA_WRITE message. Apart from the type (write), the message only
+contains size of the user header. The client tells the server which chunk has
+been accessed and at what offset the RTRS_MSG_RDMA_WRITE can be found by
+using the IMM field.
+
+2. When confirming a write request server sends an "empty" rdma message with
+an immediate field. The 32 bit field is used to specify the outstanding
+inflight IO and for the error code.
+
+CLT                                                          SRV
+usr_data + usr_hdr + rtrs_msg_rdma_write -----------------> [RTRS_IO_REQ_IMM]
+[RTRS_IO_RSP_IMM]                        <----------------- (id + errno)
+
+* Write (always_invalidate=Y) *
+
+1. When processing a write request client selects one of the memory chunks
+on the server side and rdma writes there the user data, user header and the
+RTRS_MSG_RDMA_WRITE message. Apart from the type (write), the message only
+contains size of the user header. The client tells the server which chunk has
+been accessed and at what offset the RTRS_MSG_RDMA_WRITE can be found by
+using the IMM field, Server invalidate rkey associated to the memory chunks
+first, when it finishes, pass the IO to RNBD server module.
+
+2. When confirming a write request server sends an "empty" rdma message with
+an immediate field. The 32 bit field is used to specify the outstanding
+inflight IO and for the error code. The new rkey is sent back using
+SEND_WITH_IMM WR, client When it recived new rkey message, it validates
+the message and finished IO after update rkey for the rbuffer, then post
+back the recv buffer for later use.
+
+CLT                                                          SRV
+usr_data + usr_hdr + rtrs_msg_rdma_write -----------------> [RTRS_IO_REQ_IMM]
+[RTRS_MSG_RKEY_RSP]                     <----------------- (RTRS_MSG_RKEY_RSP)
+[RTRS_IO_RSP_IMM]                        <----------------- (id + errno)
+
+
+* Read (always_invalidate=N)*
+
+1. When processing a read request client selects one of the memory chunks
+on the server side and rdma writes there the user header and the
+RTRS_MSG_RDMA_READ message. This message contains the type (read), size of
+the user header, flags (specifying if memory invalidation is necessary) and the
+list of addresses along with keys for the data to be read into.
+
+2. When confirming a read request server transfers the requested data first,
+attaches an invalidation message if requested and finally an "empty" rdma
+message with an immediate field. The 32 bit field is used to specify the
+outstanding inflight IO and the error code.
+
+CLT                                           SRV
+usr_hdr + rtrs_msg_rdma_read --------------> [RTRS_IO_REQ_IMM]
+[RTRS_IO_RSP_IMM]            <-------------- usr_data + (id + errno)
+or in case client requested invalidation:
+[RTRS_IO_RSP_IMM_W_INV]      <-------------- usr_data + (INV) + (id + errno)
+
+* Read (always_invalidate=Y)*
+
+1. When processing a read request client selects one of the memory chunks
+on the server side and rdma writes there the user header and the
+RTRS_MSG_RDMA_READ message. This message contains the type (read), size of
+the user header, flags (specifying if memory invalidation is necessary) and the
+list of addresses along with keys for the data to be read into.
+Server invalidate rkey associated to the memory chunks first, when it finishes,
+passes the IO to RNBD server module.
+
+2. When confirming a read request server transfers the requested data first,
+attaches an invalidation message if requested and finally an "empty" rdma
+message with an immediate field. The 32 bit field is used to specify the
+outstanding inflight IO and the error code. The new rkey is sent back using
+SEND_WITH_IMM WR, client When it recived new rkey message, it validates
+the message and finished IO after update rkey for the rbuffer, then post
+back the recv buffer for later use.
+
+CLT                                           SRV
+usr_hdr + rtrs_msg_rdma_read --------------> [RTRS_IO_REQ_IMM]
+[RTRS_IO_RSP_IMM]            <-------------- usr_data + (id + errno)
+[RTRS_MSG_RKEY_RSP]	     <----------------- (RTRS_MSG_RKEY_RSP)
+or in case client requested invalidation:
+[RTRS_IO_RSP_IMM_W_INV]      <-------------- usr_data + (INV) + (id + errno)
+=========================================
+Contributors List(in alphabetical order)
+=========================================
+Danil Kipnis <danil.kipnis@profitbricks.com>
+Fabian Holler <mail@fholler.de>
+Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Jack Wang <jinpu.wang@profitbricks.com>
+Kleber Souza <kleber.souza@profitbricks.com>
+Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
+Milind Dumbare <Milind.dumbare@gmail.com>
+Roman Penyaev <roman.penyaev@profitbricks.com>
-- 
2.17.1

