Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C634959F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhCYPdt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCYPdT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9705C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dm8so2912241edb.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d991e8iGkmSbc80CAxze9Aq15f9APezEhQ05eQ+W1tY=;
        b=gy5LsodZ5GchADzVf0lzMd7rsB5z5UcTx6STky+qE/ge/IHcGJJXP90aBXVHEGdqUc
         K04fexBcSbz23OFiuVvpHzpOVgUd3Oz9Dwg6Ho9Sb0wGhoeDee7XLhse4GURQPmdYuNk
         /8U71ZtI3dVnjl7TPwuzVEqHIma2+lfegZgGpQMjIItyI9BchURrD05gij/S792ssh6R
         2m+Te81xDbzhnLWAhetWGwUOkI24IxqvmLJG7SRkA9RZ6cp9fnqFftHlgvkhXwQvfVr1
         4Mux1OWWh3KTy0BTsV+O1Cj/zwpmKsNIFEX0PxeepQnzPfUfNKAfR1AVrLlFBicfMqBZ
         LDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d991e8iGkmSbc80CAxze9Aq15f9APezEhQ05eQ+W1tY=;
        b=N9u1wmMkNltroGf+SFDfFx2HWbIXq+oH/3Z1n/0mUrLzOSJaHz86pDc7nlFMb1Dfnn
         TOeY7KlLTj9kNygwbfB7wTheh+wJxOckpNCja+7adMHeTIF0rs00JRYob8NcJ6oUQeW8
         jiSDIbZlDA0CEyqHQfhMh30o/2ZRKq9k+MAbdCgXQ+e+hEI2lYJr4w/ydAvXTajqaAcB
         /pc6O25+CSyLOtoVvrGKIehyHsGP4wUC1dY3GGJN5KMewhD5BubGKL2fOdriyOkYgH7l
         K1IQChQmh/9BVo8cIVCsNi9jQE5PWyvIBtnjhE0iCsvBlO36JGv0N4dePeXcGfIYaH93
         r7AA==
X-Gm-Message-State: AOAM53320MeWkvwzeOu1y+/XqqkqOZw5upeS0O4rCqsmBKKCjfdxWKM/
        juXJ+PDt0JWS19L1CSTGAuHufzRj9dfebcSq
X-Google-Smtp-Source: ABdhPJz+VmEp6Afg97cs+S4BN0Wkt77KayYWJsFSGFpBEzaq1r94SMWl6p4YlODM2okh4jAiNOFivQ==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr9468442eds.81.1616686397097;
        Thu, 25 Mar 2021 08:33:17 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:16 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 05/22] docs: fault-injection: Add fault-injection manual of RTRS
Date:   Thu, 25 Mar 2021 16:32:51 +0100
Message-Id: <20210325153308.1214057-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
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
index 000000000000..775a223fef09
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

