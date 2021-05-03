Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9CD37148B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhECLtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhECLt2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855EC06138B
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so7362281ejb.11
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCdsmGACtZCjM/sBpdLDmbQOwefgt5f/hCoszKdbNFs=;
        b=J3cCTwoLTvkkHZni2CDtISYoX/1z8qyJfaDhjjXuX/ll2084UeISEC6KV5Bv+hxuQM
         Qb81CtY9RvxJywKRCASK96gUNdEeQvqztMy8EmaV+nCNtvqD8DDj2LrG1pQgqAzf4yoe
         YXkJyre3C1dEAspMthXgxAAE3p9uZ2jRYmmtw9Triofc7ypvvXmE2PWSkYqojnhbyiYb
         JAaIvbW5WUo1quUqirJmWkYIcTVGVSIHDHyo1oZQoNZYUHHYlqdpuOS/FI4hwb6XXTQY
         QLDiwaDhhumcpswoUEMJZzFB8HP6c8pMvJB4GL9oxqxVyR+UA8MG2OIEAxGcWh7NfOEj
         oMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCdsmGACtZCjM/sBpdLDmbQOwefgt5f/hCoszKdbNFs=;
        b=C8drgyC/0kKeKZyspo8qbCdQCDs8Yp52f3q5CJdBM7pU92LO8N7r7T38AaOoIQjaCL
         dnOmCHsV3pz/nYaHZxe2ve2RJI58vXenerUc/u3O6OeiXGuFDwO+yWO1S/VGIkAgBSTx
         qHdMq3u/LskVETcpUZvWinYQSYX4KtIjW7I2rDrb76A+CZb3nZnBEIV0WmzsjkIUvgyT
         umZol7H3cQPCbEgc0BcRa8I08lb0jea9GVzmFHb2nGnEO0ot52ZNi24MGZgIqxTpY+Q5
         f4yWridC5cRWdZ9E/a/y5MchLWQeFtVHX4xwD1aATiOQyKifQvXIJ0nQ+VXEqTCMYe92
         SC+w==
X-Gm-Message-State: AOAM5339rDXJwK/VmF3UEDqN/JRNt8T6HY524qiVZPCTkRDTCCviFm18
        Hox/uBtdeuZDoKL4wpduS2fUJjTZWZ3laA==
X-Google-Smtp-Source: ABdhPJzsrpNpfyEBetdA9xRi9lXcq+AZ0htCeXvK4yzrtSosibnsjBBFaAsgVTcJrUJmWgPdBfOZPQ==
X-Received: by 2002:a17:906:1dd3:: with SMTP id v19mr15922147ejh.4.1620042513331;
        Mon, 03 May 2021 04:48:33 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:33 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 17/20] RDMA/rtrs-srv: Fix memory leak of unfreed rtrs_srv_stats object
Date:   Mon,  3 May 2021 13:48:15 +0200
Message-Id: <20210503114818.288896-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0e1e303dcbee..879e6dbca86d 100644
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

