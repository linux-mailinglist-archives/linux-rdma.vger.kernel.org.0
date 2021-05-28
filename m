Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C403941D2
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhE1LcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbhE1LcL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D9C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jt22so4837611ejb.7
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGxecfoeO7J0ch1dgSDW11rX626ORhUGBzNvZWcGShA=;
        b=Cgcv/98UiIRqhhuZqF7FD8/HEFCm8pszLlT52XBFR7W8n8Yu2lKkRZBn2kU7KTnnzk
         edV7AwhSpAJTHvEN9pD2ZCo4Xg0QeouhjpYjDTLCH3t01psZMAZuyn0fW+78Z89RjO8B
         ZZSIOmrUUzt7WZl8GPm18g6Ys42MRdES/yg/SZnLUflXssZR3zLg8gSXHhQ5xpv3oyyl
         48CnWuk/bnVchWpfPWwA3986pUd7N+Q3cM3eyse8lsRYij+JwGLzlBmnt4sTJ2E6RPIY
         7vZ0Kken8tnIAVivbnKOVQhsA6haZTp8qdNlgsGkOP9j6tz96nd3m+vZKghyy67r0gU9
         +liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGxecfoeO7J0ch1dgSDW11rX626ORhUGBzNvZWcGShA=;
        b=QVU/1Ifqqgqtak+lDWJqvKViODZCch7X+nthr2c/gLT4iHR58C1+nKGWgbpKGEq1CT
         A+chh7n4fJjWjiyJZf6evOKXRp+85mHoMKb1NMGAl5Ve546MVfISmja8G4BN9JMRzZ1o
         CWERlwTSWgQh06CAiOsoGgy+4HCXTw42d+koPxJj6m7britFz4YNeryeaUk+SqAEp7QZ
         avMZu6xdL2g1MsDYoZVsVr2o45UoRIO+CbIFWI8lfj6zhAVbPga3YSg+ZcfdWQg6cOlg
         xPcL3+WOTXgoKY0MbPUxSvMx38t7i28ULoRQjz/ZAE+rwraMYxa0fEY+FCaLxAIhDngJ
         EACQ==
X-Gm-Message-State: AOAM532tYxw7Hq3rDiHHhRMibmjPOhJO4dtKoh3mT538VkIaep/WaLwR
        TGz3vFtxaiFI1e6rDg7DakxbXK6/k3bDAA==
X-Google-Smtp-Source: ABdhPJzFQIXSI8iIRuTbcfW/bvqTKl99mfRENFqzmlh2hfHBBbD1sYZThWuJ4d/j2cFCB7wzTNLXRQ==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr8669591eju.295.1622201435216;
        Fri, 28 May 2021 04:30:35 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 18/20] RDMA/rtrs-srv: Fix memory leak when having multiple sessions
Date:   Fri, 28 May 2021 13:30:16 +0200
Message-Id: <20210528113018.52290-19-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Gioh notice memory leak below
unreferenced object 0xffff8880acda2000 (size 2048):
  comm "kworker/4:1", pid 77, jiffies 4295062871 (age 1270.730s)
  hex dump (first 32 bytes):
    00 20 da ac 80 88 ff ff 00 20 da ac 80 88 ff ff  . ....... ......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e85d85b5>] rtrs_srv_rdma_cm_handler+0x8e5/0xa90 [rtrs_server]
    [<00000000e31a988a>] cma_ib_req_handler+0xdc5/0x2b50 [rdma_cm]
    [<000000000eb02c5b>] cm_process_work+0x2d/0x100 [ib_cm]
    [<00000000e1650ca9>] cm_req_handler+0x11bc/0x1c40 [ib_cm]
    [<000000009c28818b>] cm_work_handler+0xe65/0x3cf2 [ib_cm]
    [<000000002b53eaa1>] process_one_work+0x4bc/0x980
    [<00000000da3499fb>] worker_thread+0x78/0x5c0
    [<00000000167127a4>] kthread+0x191/0x1e0
    [<0000000060802104>] ret_from_fork+0x3a/0x50
unreferenced object 0xffff88806d595d90 (size 8):
  comm "kworker/4:1H", pid 131, jiffies 4295062972 (age 1269.720s)
  hex dump (first 8 bytes):
    62 6c 61 00 6b 6b 6b a5                          bla.kkk.
  backtrace:
    [<000000004447d253>] kstrdup+0x2e/0x60
    [<0000000047259793>] kobject_set_name_vargs+0x2f/0xb0
    [<00000000c2ee3bc8>] dev_set_name+0xab/0xe0
    [<000000002b6bdfb1>] rtrs_srv_create_sess_files+0x260/0x290 [rtrs_server]
    [<0000000075d87bd7>] rtrs_srv_info_req_done+0x71b/0x960 [rtrs_server]
    [<00000000ccdf1bb5>] __ib_process_cq+0x94/0x100 [ib_core]
    [<00000000cbcb60cb>] ib_cq_poll_work+0x32/0xc0 [ib_core]
    [<000000002b53eaa1>] process_one_work+0x4bc/0x980
    [<00000000da3499fb>] worker_thread+0x78/0x5c0
    [<00000000167127a4>] kthread+0x191/0x1e0
    [<0000000060802104>] ret_from_fork+0x3a/0x50
unreferenced object 0xffff88806d6bb100 (size 256):
  comm "kworker/4:1H", pid 131, jiffies 4295062972 (age 1269.720s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 00 59 4d 86 ff ff ff ff  .........YM.....
  backtrace:
    [<00000000a18a11e4>] device_add+0x74d/0xa00
    [<00000000a915b95f>] rtrs_srv_create_sess_files.cold+0x49/0x1fe [rtrs_server]
    [<0000000075d87bd7>] rtrs_srv_info_req_done+0x71b/0x960 [rtrs_server]
    [<00000000ccdf1bb5>] __ib_process_cq+0x94/0x100 [ib_core]
    [<00000000cbcb60cb>] ib_cq_poll_work+0x32/0xc0 [ib_core]
    [<000000002b53eaa1>] process_one_work+0x4bc/0x980
    [<00000000da3499fb>] worker_thread+0x78/0x5c0
    [<00000000167127a4>] kthread+0x191/0x1e0
    [<0000000060802104>] ret_from_fork+0x3a/0x50

The problem is we increase device refcount by get_device in process_info_req
for each path, but only does put_deice for last path, which lead to
memory leak.

To fix it, it also calls put_device when dev_ref is not 0.

Fixes: e2853c49477d1 ("RDMA/rtrs-srv-sysfs: fix missing put_device")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index a9288175fbb5..20efd44297fb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -208,6 +208,7 @@ rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 		device_del(&srv->dev);
 		put_device(&srv->dev);
 	} else {
+		put_device(&srv->dev);
 		mutex_unlock(&srv->paths_mutex);
 	}
 }
-- 
2.25.1

