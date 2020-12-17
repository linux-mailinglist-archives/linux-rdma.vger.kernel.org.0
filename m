Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB82DD2D5
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgLQOUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQOUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03FC061285
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b2so28834796edm.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cwr31r9xVs6HYLbvddJ5+hEwG5tfmVS3LWgeJk4fqjQ=;
        b=PpqAfLHCAvlmnS5JjNrMY/6s1cf+6ltv3fGoq8NU8VYYSBt+qlaNCUdhWk+S4C2yRb
         rDomAG0aYMvBxDrvWXNO6um+Dn+DKJ0KJeNLeI5IWpLl8smlP7syl3WC6KVunw0ll38s
         06dj3uMqSVBJJ9AuNqsJztPB/U1kIE52XGC9YciAQ4SBW92X476AJJvL44NaDN552HE5
         lUk6Bw2GbgJ0KYr8oISf4a+4B2WyqC+mMeltvkblSYkHbIWqQBW//MGcbUusVTbbMBBn
         062lvUwus/b+PUsr1/voCcrtEEGqpz14yEypuXoDXEvASz7sHga/6zaS9KP9GV11B+Tz
         elMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cwr31r9xVs6HYLbvddJ5+hEwG5tfmVS3LWgeJk4fqjQ=;
        b=ZFYGqbpcXnG787h3vz55+sMGGwpZfbHRoEEFNU9kra8dIhhJ+ianjj2eJZ9sSDcqVM
         PW+ivMpm7K1OP7iEKpfFJmbAG2tqgVj1204iOQlubKKIGPm11PSADQHivqIalgETm/PB
         lmK4rM1NqSDKdhEgQnKwjY28R/maAZ+gGr6GqivaWJvQL78EBaR9ekUNvSHdiV7RdZXJ
         XvfYDASuiewy+jusuypStQywgCZR4jb+pDuwNFTtJe8HkBzV6CLYbGgJy1qus0EsKSHh
         U7FBAG+xzB4P+HyE6L33VkTFvYoSSt2f6Fzz6ifsbRsASS/38O4N/zD0RAFgihaoQuBd
         PSrA==
X-Gm-Message-State: AOAM533DWXDjtUvgCLg/4QAHKpGJYdTA12jkyU4A+Nt5xXR+0mdIAtF8
        L5/7yKKA0upgj3aLbKFbOFZjctUuOZYKew==
X-Google-Smtp-Source: ABdhPJyWbYuBdybVbpivKLPJgmTHWoZHfiN6PovzqZ7VSL4Jn93Q74ng9H/xD/b+7jdbax7g5E4S4Q==
X-Received: by 2002:a50:fc13:: with SMTP id i19mr39777345edr.281.1608214761816;
        Thu, 17 Dec 2020 06:19:21 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:21 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCHv2 for-next 05/19] RDMA/rtrs-clt: Set mininum limit when create QP
Date:   Thu, 17 Dec 2020 15:19:01 +0100
Message-Id: <20201217141915.56989-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rtrs when create_qp use a coarse numbers (bigger in general),
which leads to hardware create more resources which only waste memory
with no benefits.

- SERVICE con,
For max_send_wr/max_recv_wr, it's 2 times SERVICE_CON_QUEUE_DEPTH + 2

- IO con
For max_send_wr/max_recv_wr, it's sess->queue_depth * 3 + 1

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 719254fc83a1..b3fb5fb93815 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1511,7 +1511,7 @@ static void destroy_con(struct rtrs_clt_con *con)
 static int create_con_cq_qp(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
-	u32 wr_queue_size;
+	u32 max_send_wr, max_recv_wr, cq_size;
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
@@ -1523,7 +1523,8 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		 * + 2 for drain and heartbeat
 		 * in case qp gets into error state
 		 */
-		wr_queue_size = SERVICE_CON_QUEUE_DEPTH * 3 + 2;
+		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
+		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		/* We must be the first here */
 		if (WARN_ON(sess->s.dev))
 			return -EINVAL;
@@ -1555,25 +1556,29 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 
 		/* Shared between connections */
 		sess->s.dev_ref++;
-		wr_queue_size =
+		max_send_wr =
 			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
 			      sess->queue_depth * 3 + 1);
+		max_recv_wr =
+			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
+			      sess->queue_depth * 3 + 1);
 	}
 	/* alloc iu to recv new rkey reply when server reports flags set */
 	if (sess->flags == RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
-		con->rsp_ius = rtrs_iu_alloc(wr_queue_size, sizeof(*rsp),
+		con->rsp_ius = rtrs_iu_alloc(max_recv_wr, sizeof(*rsp),
 					      GFP_KERNEL, sess->s.dev->ib_dev,
 					      DMA_FROM_DEVICE,
 					      rtrs_clt_rdma_done);
 		if (!con->rsp_ius)
 			return -ENOMEM;
-		con->queue_size = wr_queue_size;
+		con->queue_size = max_recv_wr;
 	}
+	cq_size = max_send_wr + max_recv_wr;
 	cq_vector = con->cpu % sess->s.dev->ib_dev->num_comp_vectors;
 	err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
-				 cq_vector, wr_queue_size, wr_queue_size,
-				 wr_queue_size, IB_POLL_SOFTIRQ);
+				 cq_vector, cq_size, max_send_wr,
+				 max_recv_wr, IB_POLL_SOFTIRQ);
 	/*
 	 * In case of error we do not bother to clean previous allocations,
 	 * since destroy_con_cq_qp() must be called.
-- 
2.25.1

