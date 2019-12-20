Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C63127FEF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLTPve (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34189 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLTPvd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so9894828wrr.1;
        Fri, 20 Dec 2019 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/OyeGAc6zhNCz8fTc2ihZh+DZMzm3e/bmzFW4dwAJ4=;
        b=KV+1v27MLhaaVcU247GJR+5fJSHvcSp2N7FOGBZLLY98PgCCwjHZKyQr9NJDn2wy/o
         wXo7UId80e5R2ySY9kkzoSa50hSEFgWd3F6kPlenssZlg9yknc+72ofAVFnw7V1p6k6e
         3VHUZdoJPj0SDVO4HJj07nweJsiCuLjbDH5zI7cvHWt13FWpi7KFbZ8EyO30nJyrIv+U
         TwQ3VvICJeq4DGXE8GIrmyf7BL48BkEFeNcrdRzJ5KJuwWcS1fD9vICob5siTrAgEACH
         P/a/zhBCpth14aupvO3iMZVOPy2HQrxcAYaV6a04DOG298mXg/WSmOlnCxTNacCGdIhP
         y0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/OyeGAc6zhNCz8fTc2ihZh+DZMzm3e/bmzFW4dwAJ4=;
        b=NJTUJzTAcDoWj3vfrk+0K8fU0m/hADwTHbBhwr/EPClvgHtuqSg5ayvDuFB+46mwXX
         qnxdr5a+Qn/5D3AyZxhBoQukoYiIjJJkPHavs10RtpVbDEn+CNdqB74XlCVeIAHZOvD2
         KPL+ASumcsQAQPOBZ9fuWS9AW3a4arFKH8pMbHTFEMiVvjwZr+7vyOlE+TN+H7Z2f65A
         Th6KqG/5ZU1UzaBVOFwdLXSVuzVGY2W6cAvK8dVjdNWaSmkV6b7eTnJPzqEys7fyRQ5F
         jSoVhDAGc6gL6pNCGipjGkDXN+5jfF8vAkb0Yw41B1vC6ynkC9pYUvyxoK8rkcMfSUve
         YLMQ==
X-Gm-Message-State: APjAAAU3x2CZx5V3yyxLlKrrSmUsrCAoigboFNyXcJEhX08rQUDwfQQP
        ndoogPyws+GRuiFHI2y5DQQ9x0y/oLY=
X-Google-Smtp-Source: APXvYqx7vBlZQP3fEL7anJRrIMvlNxb6euNl87x9J7sydBU8tq+cu1X2M3AQCZ6p6DkMvrpncjeGFQ==
X-Received: by 2002:adf:a109:: with SMTP id o9mr17126800wro.189.1576857090715;
        Fri, 20 Dec 2019 07:51:30 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:30 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/25] rtrs: a bit of documentation
Date:   Fri, 20 Dec 2019 16:50:58 +0100
Message-Id: <20191220155109.8959-15-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

README with description of major sysfs entries, sysfs documentation
has been moved to ABI dir as suggested by Bart.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: linux-kernel@vger.kernel.org
---
 .../ABI/testing/sysfs-class-rtrs-client       | 190 ++++++++++++++++++
 .../ABI/testing/sysfs-class-rtrs-server       |  81 ++++++++
 drivers/infiniband/ulp/rtrs/README            | 137 +++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
 create mode 100644 drivers/infiniband/ulp/rtrs/README

diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
new file mode 100644
index 000000000000..8b219cf6c5c4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -0,0 +1,190 @@
+What:		/sys/class/rtrs-client
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+When a user of RTRS API creates a new session, a directory entry with
+the name of that session is created under /sys/class/rtrs-client/<session-name>/
+
+What:		/sys/class/rtrs-client/<session-name>/add_path
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RW, adds a new path (connection) to an existing session. Expected format is the
+following:
+
+  <[source addr,]destination addr>
+
+  *addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]
+
+What:		/sys/class/rtrs-client/<session-name>/max_reconnect_attempts
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Maximum number reconnect attempts the client should make before giving up
+after connection breaks unexpectedly.
+
+What:		/sys/class/rtrs-client/<session-name>/mp_policy
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Multipath policy specifies which path should be selected on each IO:
+
+   round-robin (0):
+       select path in per CPU round-robin manner.
+
+   min-inflight (1):
+       select path with minimum inflights.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Each path belonging to a given session is listed here by its source and
+destination address. When a new path is added to a session by writing to
+the "add_path" entry, a directory <src@dst> is created.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/state
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains "connected" if the session is connected to the peer and fully
+functional.  Otherwise the file contains "disconnected"
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/reconnect
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Write "1" to the file in order to reconnect the path.
+Operation is blocking and returns 0 if reconnect was successful.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/disconnect
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Write "1" to the file in order to disconnect the path.
+Operation blocks until RTRS path is disconnected.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/remove_path
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Write "1" to the file in order to disconnected and remove the path
+from the session.  Operation blocks until the path is disconnected
+and removed from the session.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the the name of HCA the connection established on.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the port number of active port traffic is going through.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/src_addr
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the source address of the path
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/dst_addr
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the destination address of the path
+
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/reset_all
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RW, Read will return usage help, write 0 will clear all the statistics.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/sg_entries
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Data to be transferred via RDMA is passed to RTRS as scatter-gather
+list. A scatter-gather list can contain multiple entries.
+Scatter-gather list with less entries require less processing power
+and can therefore transferred faster. The file sg_entries outputs a
+per-CPU distribution table for the number of entries in the
+scatter-gather lists, that were passed to the RTRS API function
+rtrs_clt_request (READ or WRITE).
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/cpu_migration
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RTRS expects that each HCA IRQ is pinned to a separate CPU. If it's
+not the case, the processing of an I/O response could be processed on a
+different CPU than where it was originally submitted.  This file shows
+how many interrupts where generated on a non expected CPU.
+"from:" is the CPU on which the IRQ was expected, but not generated.
+"to:" is the CPU on which the IRQ was generated, but not expected.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/reconnects
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains 2 unsigned int values, the first one records number of successful
+reconnects in the path lifetime, the second one records number of failed
+reconnects in the path lifetime.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/rdma_lat
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Latency distribution of RTRS requests.
+The format is:
+   1 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+   2 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+   4 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+   8 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  16 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  ...
+  65536 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  >= 65536 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  maximum ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/wc_completion
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains 2 unsigned int values, the first one records max number of work
+requests processed in work_completion in session lifetime, the second
+one records average number of work requests processed in work_completion
+in session lifetime.
+
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/rdma
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains statistics regarding rdma operations and inflight operations.
+The output consists of 6 values:
+
+<read-count> <read-total-size> <write-count> <write-total-size> \
+<inflights> <failovered>
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
new file mode 100644
index 000000000000..cac2a093d56f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -0,0 +1,81 @@
+What:		/sys/class/rtrs-server
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+When a user of RTRS API creates a new session on a client side, a
+directory entry with the name of that session is created in here.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+When new path is created by writing to "add_path" entry on client side,
+a directory entry named as <source address>@<destination address> is created
+on server.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/disconnect
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+When "1" is written to the file, the RTRS session is being disconnected.
+Operations is non-blocking and returns control immediately to the caller.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the the name of HCA the connection established on.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the port number of active port traffic is going through.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/src_addr
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the source address of the path
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/dst_addr
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RO, Contains the destination address of the path
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/stats/reset_all
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RW, Read will return usage help, write 0 will clear all the statistics.
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/stats/rdma
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains statistics regarding rdma operations and inflight operations.
+The output consists of 5 values:
+<read-count> <read-total-size> <write-count> <write-total-size> <inflights>
+
+What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/stats/wc_completion
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains 3 values, the first one is int, records max number of work
+requests processed in work_completion in session lifetime, the second
+one long int records total number of work requests processed in
+work_completion in session lifetime and the 3rd one long int records
+total number of calls to the cq completion handler. Division of 2nd
+number through 3rd gives the average number of completions processed
+in completion handler.
diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README
new file mode 100644
index 000000000000..e4985070e3c0
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/README
@@ -0,0 +1,137 @@
+****************************
+InfiniBand Transport (RTRS)
+****************************
+
+RTRS (InfiniBand Transport) is a reliable high speed transport library
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
+multipath I/O (see "add_path" and "mp_policy" configuration entries).
+
+RTRS is used by the RNBD (Infiniband Network Block Device) modules.
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
+When processing an incoming rdma write or read request rtrs client uses memory
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
+session) and the maximum size of one io.
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
+* Write *
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
+* Read *
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
-- 
2.17.1

