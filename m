Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1A3552B8
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbhDFLvL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbhDFLvK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:51:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F314C061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:51:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ap14so21491550ejc.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzGzDb6sOnF8N0SPvMe9bIQjSerHc8BoxV7MjmHw1gQ=;
        b=IL+lXi7Fck9ycEgSFxeRCwY7mk/0gG/lD8v/DGs+ApV4x0yjzBOGKSSj4zh4rsr5L0
         MTHLdDmCOjeYjooVIIrGBjR7WfByvqIKcZWlDvz7aQ3MhkhCGUhXu7MRcLkmhfbhe4iY
         qRVGt0qEHm9oSh1cU7lpnPkPqhTr6iA60X8esrx7G0NVOEbGVauQsedlJ9aAJhFS2oPC
         Geq64csMdLDqXYqQXVb3ZC6SfvDRzYt8sh+IgrTW4r0OifhpVaJ7MsaATNETdPQA6/9M
         rgCwWphz1yCC9btuEOy1fZlo61OKvRRdhHn1FhYotLMo56rePhwdO6bLRFvKGj/0WTuJ
         DJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzGzDb6sOnF8N0SPvMe9bIQjSerHc8BoxV7MjmHw1gQ=;
        b=qibMlkXDn7oMZ7ri3CMXF9UbjmRmxW4AkQI5mpJKnRGdOlSCkx4XdveQQv9H2eidDm
         sSCvZR8TIvK55eDEpp2+CXuvhvFk4VDn8J71/CJ65tP+SniT1T/5gTER46ONCAxxmA5v
         SBaGDCbKDSilQUIL6l8ABKLp2OM5ppwi47cLdcrdKIFaA+u5H/V9Umczzsz8ub3t2p0/
         TPoraxzlkG6yWjxJw9mgkxYiuaBKlBhghQwB47CzSyyfNcHQapYArsYIbRUAFwC28/ZZ
         b9t2X9sGdJSvBQS9pJgusxbmle1UJ/7nGDw3ot+gm6e4JxPKSx6H2Ia+azKau8bsRSMJ
         /m/A==
X-Gm-Message-State: AOAM531dZ8aLJRm7Ggq2V1mZqAKbirL2dpshhzYELlWoI1m5GpBV/28e
        9CIyuyeC+7y1vldN0lA3tHuIyK5yFSPkHNGF
X-Google-Smtp-Source: ABdhPJxVIkWAfkyagvnr/hajx6i0wdgR6FCHCK48yFCzBoqf60AQFNZf+XxE5V+k5AXr5mNEEcz5lA==
X-Received: by 2002:a17:906:6c4:: with SMTP id v4mr32866953ejb.198.1617709861716;
        Tue, 06 Apr 2021 04:51:01 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id t1sm855964eds.53.2021.04.06.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:51:01 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        akinobu.mita@gmail.com, corbet@lwn.net,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH 4/4] docs: fault-injection: Add fault-injection manual of RTRS
Date:   Tue,  6 Apr 2021 13:50:49 +0200
Message-Id: <20210406115049.196527-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406115049.196527-1-gi-oh.kim@ionos.com>
References: <20210406115049.196527-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

It describes how to use the fault-injection of RTRS.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 .../fault-injection/rtrs-fault-injection.rst  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/fault-injection/rtrs-fault-injection.rst

diff --git a/Documentation/fault-injection/rtrs-fault-injection.rst b/Documentation/fault-injection/rtrs-fault-injection.rst
new file mode 100644
index 000000000000..463869877a85
--- /dev/null
+++ b/Documentation/fault-injection/rtrs-fault-injection.rst
@@ -0,0 +1,83 @@
+RTRS (RDMA Transport) Fault Injection
+=====================================
+This document introduces how to enable and use the error injection of RTRS
+via debugfs in the /sys/kernel/debug directory. When enabled, users can
+enable specific error injection point and change the default status code
+via the debugfs.
+
+Following examples show how to inject an error into the RTRS.
+
+First, enable CONFIG_FAULT_INJECTION_DEBUG_FS kernel config,
+recompile the kernel. After booting up the kernel, map a target device.
+
+After mapping, /sys/kernel/debug/<session-name> directory is created
+on both of the client and the server.
+
+Example 1: Inject an error into request processing of rtrs-client
+-----------------------------------------------------------------
+
+Generate an error on one session of rtrs-client::
+
+  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability
+  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times
+  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request
+  dd if=/dev/rnbd0 of=./dd bs=1k count=10
+
+Expected Result::
+
+  dd succeeds but generates an IO error
+
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 0 PID: 799 Comm: dd Tainted: G           O      5.4.77-pserver+ #169
+  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
+  Call Trace:
+    dump_stack+0x97/0xe0
+    should_fail.cold+0x5/0x11
+    rtrs_clt_should_fail_request+0x2f/0x50 [rtrs_client]
+    rtrs_clt_request+0x223/0x540 [rtrs_client]
+    rnbd_queue_rq+0x347/0x800 [rnbd_client]
+    __blk_mq_try_issue_directly+0x268/0x380
+    blk_mq_request_issue_directly+0x9a/0xe0
+    blk_mq_try_issue_list_directly+0xa3/0x170
+    blk_mq_sched_insert_requests+0x1de/0x340
+    blk_mq_flush_plug_list+0x488/0x620
+    blk_flush_plug_list+0x20f/0x250
+    blk_finish_plug+0x3c/0x54
+    read_pages+0x104/0x2b0
+    __do_page_cache_readahead+0x28b/0x2b0
+    ondemand_readahead+0x2cc/0x610
+    generic_file_read_iter+0xde0/0x11f0
+    new_sync_read+0x246/0x360
+    vfs_read+0xc1/0x1b0
+    ksys_read+0xc3/0x160
+    do_syscall_64+0x68/0x260
+    entry_SYSCALL_64_after_hwframe+0x49/0xbe
+  RIP: 0033:0x7f7ff4296461
+  Code: fe ff ff 50 48 8d 3d fe d0 09 00 e8 e9 03 02 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 99 62 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
+  RSP: 002b:00007fffdceca5b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
+  RAX: ffffffffffffffda RBX: 000055c5eab6e3e0 RCX: 00007f7ff4296461
+  RDX: 0000000000000400 RSI: 000055c5ead27000 RDI: 0000000000000000
+  RBP: 0000000000000400 R08: 0000000000000003 R09: 00007f7ff4368260
+  R10: ffffffffffffff3b R11: 0000000000000246 R12: 000055c5ead27000
+  R13: 0000000000000000 R14: 0000000000000000 R15: 000055c5ead27000
+
+Example 2: rtrs-server does not send ACK to the heart-beat of rtrs-client
+-------------------------------------------------------------------------
+
+::
+
+  echo 100 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/probability
+  echo 5 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/times
+  echo 1 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/fail-hb-ack
+
+Expected Result::
+
+  If rtrs-server does not send ACK more than 5 times, rtrs-client tries reconnection.
+
+Check how many times rtrs-client did reconnection::
+
+  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects
+  1 0
-- 
2.25.1

