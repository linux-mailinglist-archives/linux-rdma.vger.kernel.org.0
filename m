Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7A3A5EC6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhFNJFq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhFNJFq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 05:05:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5455C061574
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:03:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k25so15411006eja.9
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90FBh6s/mqzvv1B+rS9VcbJNoJHBal7ZdcOzcZj/cf8=;
        b=LHSnOYjzvoOkQ8Ci3bFOHl0rotCxsvq+zdaZG3aQkVR1921mklXDlxx7m9lps29fh2
         LipSqRVofC/rc4z2YT27RtNajiadrF2j7mDkArh1eG2dV7Z/W6dbkNKAvVnbS/o/SupD
         TIS+vrlHMYiklbBgf02oxXh/y4vAR1kldW5eiipmRrbMK2swW8cKcqpMfB99ZPutjejh
         6C5ewmp6QH2HuxYNpt3d8Wnq+wg7yAm9FFO6Qx1tjYRVNumW0GXRWxt16ogtgivlpOKl
         qVD7ttQQeJGH2wRuoGVYINZgSxcsb0mJj3NiYOtYHyHqWBjX7s0SUERyzmX2qvUIM1ki
         FULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90FBh6s/mqzvv1B+rS9VcbJNoJHBal7ZdcOzcZj/cf8=;
        b=oMh7GR3jZiOYMinYwgJrMkV3D/fcJjhyxrhV7+uRAet9f4E6nnRd6fo4Xug4EhKK40
         A7NEB82gpUv0sGi65qHNXnwbTltIphjj1tBBd7JOi5zEaoOat+8s+g3tKVjexeIG3c8P
         dpw7aLQAhzkxJCtVnzUX0hxSO1TXqD6BIRlsArts1tER53EP6mM6OgoaAkGV4yHO9fCl
         sa6Bc2OgWDFNPCdrZBmsZdFTGp4la23S7E1tSZ5Nu4xNrOfAni+zH1ryHkzf+zGFIGQR
         +IA7Ak0w+xUmqHz8TT61qzZfG/i5sTPPdkVnOQMYsA24xjBKQHOYFkncZGfwkwgBO+cw
         bR6Q==
X-Gm-Message-State: AOAM532IICKtWT4Jmfr70FH9I8BdOs1bshMRXa7HFdLOBQtl+1mAgvdt
        Q66HzQpBcZwjmqJdrM2owDUMmO4r6vIUhw==
X-Google-Smtp-Source: ABdhPJyL/o5+jfD8t2V89nXMnfuKfcYN3CvzAFACHJ3kT+J40xLmsakaZdbxLKHl5JtA4kzoonAkBw==
X-Received: by 2002:a17:906:8688:: with SMTP id g8mr13987465ejx.470.1623661420451;
        Mon, 14 Jun 2021 02:03:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4960:8600:dc5e:964f:b034:cb7d])
        by smtp.gmail.com with ESMTPSA id qq26sm6764355ejb.6.2021.06.14.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:03:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv3 for-next 2/5] RDMA/rtrs-clt: Use minimal max_send_sge when create qp
Date:   Mon, 14 Jun 2021 11:03:34 +0200
Message-Id: <20210614090337.29557-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614090337.29557-1-jinpu.wang@ionos.com>
References: <20210614090337.29557-1-jinpu.wang@ionos.com>
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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

