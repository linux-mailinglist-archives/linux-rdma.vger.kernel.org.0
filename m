Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184D639F398
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhFHKdh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 06:33:37 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:41762 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFHKdg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 06:33:36 -0400
Received: by mail-ed1-f43.google.com with SMTP id g18so21919185edq.8
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 03:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL+EN0zWidH6/P9/6QcLFHezjtyZ+PTsZ+hns4lgn3w=;
        b=EtEg8dZSa+zybjLvbQrndP+7+v27MGiY1+IUyrwnSgh4Vxp4x271eldMWn4uDosjvU
         hKeLkXTs8u8vtfoDUzaSU548Bn3MDxPwWhKsy6tHdtziw7Xlwc5x/uhKqEHJU0luctel
         +wpJeKzZz54Hw6VJHGywg82O2psK7uAFiKSkfHQdbpwRoDZn39KdeSHNffwvS94EFDGd
         srdftETfJto9kO0+9T/ZlN0Tqalr+4a42Zqq+6UXaYVyWQfBzE1xh9MY675BSRTuJInP
         rgGi1lhq5RYTsNjAqRdGU95PwYi5goEiPYzYkUQFdIoInn8ihNDXfeYUWlPey7Tk1tXX
         zp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL+EN0zWidH6/P9/6QcLFHezjtyZ+PTsZ+hns4lgn3w=;
        b=liAtbpIGGtigCQPwvBS5AmR2Yxhak3/AyMk7N18JkNhBHaDgLjd3i5E67OMFYPQ9rX
         nNnMi4CIGJKEcGxe0xvwGbQ3Gw7DCBWuYVjdrDf/2uV54tFQrjmEeTBjD5Lf9IxgJbCi
         TvyQJqnhlu172mb1NG0DOj2+pA/JKzDZx6n62DRm714EOeZK9QXNxA++n0rYLzrlaoWM
         cPjkiHaZuWzddgK76QhFzMzRahsV1YSy9GdvmeOYGg3ZPsm9+NuKc8K03XqMGu5m8Ncc
         os5sByc+ApdF23bBR0P8pMVUerV1QOIBo9chRLF8KV4DO7WjNIaI0l6M8u+OYk2e4KZ5
         D2Nw==
X-Gm-Message-State: AOAM533pKhZ5QDxS8CQGbPKm9i8ZHuY4cZGt3lc9g6AYpUWG4eLucoDH
        9K0U/P5rRUEE86+t8KTBYPQF76gqQKGqqA==
X-Google-Smtp-Source: ABdhPJytKLqmqQ4Xp37LPBhTR1iKJw4TDegBd2/1iTxkBUpAK+U1qAARWKpq+ope5XEM1Pmjrke++Q==
X-Received: by 2002:a05:6402:157:: with SMTP id s23mr25432295edu.282.1623148242874;
        Tue, 08 Jun 2021 03:30:42 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id dy19sm8634400edb.68.2021.06.08.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:30:42 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 2/4] RDMA/rtrs-clt: Use minimal max_send_sge when create qp
Date:   Tue,  8 Jun 2021 12:30:37 +0200
Message-Id: <20210608103039.39080-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608103039.39080-1-jinpu.wang@ionos.com>
References: <20210608103039.39080-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

We use device limit max_send_sge, which is suboptimal for memory usage.
We don't need that much for User Con, 1 is enough. And for IO con,
sess->max_segments + 1 is enough

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f1fd7ae9ac53..cd53edddfe1f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1417,7 +1417,6 @@ static void query_fast_reg_mode(struct rtrs_clt_sess *sess)
 	sess->max_pages_per_mr =
 		min3(sess->max_pages_per_mr, (u32)max_pages_per_mr,
 		     ib_dev->attrs.max_fast_reg_page_list_len);
-	sess->max_send_sge = ib_dev->attrs.max_send_sge;
 }
 
 static bool rtrs_clt_change_state_get_old(struct rtrs_clt_sess *sess,
@@ -1573,7 +1572,7 @@ static void destroy_con(struct rtrs_clt_con *con)
 static int create_con_cq_qp(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
-	u32 max_send_wr, max_recv_wr, cq_size;
+	u32 max_send_wr, max_recv_wr, cq_size, max_send_sge;
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
@@ -1587,6 +1586,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		 */
 		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
+		max_send_sge = 1;
 		/* We must be the first here */
 		if (WARN_ON(sess->s.dev))
 			return -EINVAL;
@@ -1625,25 +1625,27 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		max_recv_wr =
 			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
 			      sess->queue_depth * 3 + 1);
+		max_send_sge = sess->clt->max_segments + 1;
 	}
+	cq_size = max_send_wr + max_recv_wr;
 	/* alloc iu to recv new rkey reply when server reports flags set */
 	if (sess->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
-		con->rsp_ius = rtrs_iu_alloc(max_recv_wr, sizeof(*rsp),
+		con->rsp_ius = rtrs_iu_alloc(cq_size, sizeof(*rsp),
 					      GFP_KERNEL, sess->s.dev->ib_dev,
 					      DMA_FROM_DEVICE,
 					      rtrs_clt_rdma_done);
 		if (!con->rsp_ius)
 			return -ENOMEM;
-		con->queue_size = max_recv_wr;
+		con->queue_size = cq_size;
 	}
 	cq_size = max_send_wr + max_recv_wr;
 	cq_vector = con->cpu % sess->s.dev->ib_dev->num_comp_vectors;
 	if (con->c.cid >= sess->s.irq_con_num)
-		err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
+		err = rtrs_cq_qp_create(&sess->s, &con->c, max_send_sge,
 					cq_vector, cq_size, max_send_wr,
 					max_recv_wr, IB_POLL_DIRECT);
 	else
-		err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
+		err = rtrs_cq_qp_create(&sess->s, &con->c, max_send_sge,
 					cq_vector, cq_size, max_send_wr,
 					max_recv_wr, IB_POLL_SOFTIRQ);
 	/*
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 919c9f96f25b..822a820540d4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -141,7 +141,6 @@ struct rtrs_clt_sess {
 	u32			chunk_size;
 	size_t			queue_depth;
 	u32			max_pages_per_mr;
-	int			max_send_sge;
 	u32			flags;
 	struct kobject		kobj;
 	u8			for_new_clt;
-- 
2.25.1

