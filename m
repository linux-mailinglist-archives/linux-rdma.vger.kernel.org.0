Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFF3941D0
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhE1LcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhE1LcL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E9C06138B
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id df21so4478111edb.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyDSwVDxaz/2g5qVIzlNJqfchWdo5hv8O+V3TRK4MSo=;
        b=bOR/KGXCJg5e//wyv6Z0me4gDtvi36mKP6wdrHE+HLg6QfeqAyuinzyYUIgJ9h5f7n
         Cz87kaqQYvSgW0ccf6FD2OIETl4wDnBLGsIVwGmdAJz1UX+Hbe8QZEM6syh5Oxoc/XAs
         YBKskIroHOXC/Tbog8rFZ3N4BiQrd9wRGhE+E65YTfXsqFZlBJzLLnHwFTKvYMF427GU
         oU6XdXls6yyI/CWF2AmJ+dhO0gqDnDqhjSuvwumUILYyFk3FwE+EebqXVLVbYlDD4arU
         CNiGCOz9coFU22s9Cw/BEIkJ0fe/Pc+FxQmg4OQ2nZEhtqYKGBnWY8VlZ/3RzY/FsKCe
         WvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyDSwVDxaz/2g5qVIzlNJqfchWdo5hv8O+V3TRK4MSo=;
        b=L6s7Q5ZjAQ1NxQhPlAICr13z50PuP/CMpZUej6hHT2mjsVzQcckY45WebNFnR98lnU
         BgTuh5WB1v425sLq6KGQ7CqnZJbUbVrgdmg4FCrirE1dMgWadFKs86mF7Tfq7DYsK6ou
         J+lkiS1/AVsuSukJSMNIv6Jd32swL78TLzSxwreAClju01OeIeTTrKdRI8m8o2sL1buJ
         pmz2CJgjG6JAXNYoGNd9TobxakCozE36cwKflFt4tyxnJ4QFW+ofSYtKDNN8CAY0K/ae
         mTYYBMYwvD9FAaSmMyvv8YoxDWNSwWtEEYrWoWlqrpnc9ORdLGhJRQGf8jWBayw1ZH/b
         kC4w==
X-Gm-Message-State: AOAM532J0njKNv5zU7aiELHWn6BtfiKlXKP4+gdz/BXVW+kbVFHn9VvN
        /etouKmTQgmptNn0gYTXCjhwnZuE27NTxQ==
X-Google-Smtp-Source: ABdhPJzNQI5Lo3miaOBEIwUvmixjxYPiS6hiNiTYGHai1OHEBLxv6EJcTqRRb8JqltLodmjNcJTPOw==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr9644741edd.140.1622201434336;
        Fri, 28 May 2021 04:30:34 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 17/20] RDMA/rtrs-srv: Fix memory leak of unfreed rtrs_srv_stats object
Date:   Fri, 28 May 2021 13:30:15 +0200
Message-Id: <20210528113018.52290-18-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When closing a session, currently the rtrs_srv_stats object in the
closing session is freed by kobject release. But if it failed
to create a session by various reasons, it must free the rtrs_srv_stats
object directly because kobject is not created yet.

This problem is found by kmemleak as below:

1. One client machine maps /dev/nullb0 with session name 'bla':
root@test1:~# echo "sessname=bla path=ip:192.168.122.190 \
device_path=/dev/nullb0" > /sys/devices/virtual/rnbd-client/ctl/map_device

2. Another machine failed to create a session with the same name 'bla':
root@test2:~# echo "sessname=bla path=ip:192.168.122.190 \
device_path=/dev/nullb1" > /sys/devices/virtual/rnbd-client/ctl/map_device
-bash: echo: write error: Connection reset by peer

3. The kmemleak on server machine reported an error:
unreferenced object 0xffff888033cdc800 (size 128):
  comm "kworker/2:1", pid 83, jiffies 4295086585 (age 2508.680s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000a72903b2>] __alloc_sess+0x1d4/0x1250 [rtrs_server]
    [<00000000d1e5321e>] rtrs_srv_rdma_cm_handler+0xc31/0xde0 [rtrs_server]
    [<00000000bb2f6e7e>] cma_ib_req_handler+0xdc5/0x2b50 [rdma_cm]
    [<00000000e896235d>] cm_process_work+0x2d/0x100 [ib_cm]
    [<00000000b6866c5f>] cm_req_handler+0x11bc/0x1c40 [ib_cm]
    [<000000005f5dd9aa>] cm_work_handler+0xe65/0x3cf2 [ib_cm]
    [<00000000610151e7>] process_one_work+0x4bc/0x980
    [<00000000541e0f77>] worker_thread+0x78/0x5c0
    [<00000000423898ca>] kthread+0x191/0x1e0
    [<000000005a24b239>] ret_from_fork+0x3a/0x50

Fixes: 39c2d639ca183 ("RDMA/rtrs-srv: Set .release function for rtrs srv device during device init")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 78a861843705..5639b29b8b02 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1503,6 +1503,7 @@ static void free_sess(struct rtrs_srv_sess *sess)
 		kobject_del(&sess->kobj);
 		kobject_put(&sess->kobj);
 	} else {
+		kfree(sess->stats);
 		kfree(sess);
 	}
 }
-- 
2.25.1

