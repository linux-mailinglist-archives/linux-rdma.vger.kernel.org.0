Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFA3A41C5
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFKMNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 08:13:37 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33581 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFKMNg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 08:13:36 -0400
Received: by mail-ed1-f45.google.com with SMTP id f5so31833782eds.0
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL+EN0zWidH6/P9/6QcLFHezjtyZ+PTsZ+hns4lgn3w=;
        b=KeMuNPrRgYKVQKs80mICPP7/D37u2GiJEUAMufD9943ekORkZq1lOQ/VH57mUGzz9w
         S34lP1bM34TiKktJm72uBqEmzcg9mHkRDiQwn/Bu7NO3EhVBSbOKlPZgBou4vhE+EU8f
         39t5ifUaMu+2jkZSZXD9Y9N6PBLWKmoT6NVZktVtl94EDEDoJCZmMFI5//mIdGvc89te
         Iq7zp4GgWwtkjuhu5tcalkRTGX4IZL1bGNBgHPdAozwG+ICsory73Wo99NNnq9w/fXiV
         rduqumsd3sSAB62QbSOJrMkj/gP8S7OwHW+a3d30QO/H0kmVOtB+917eWw37D3K1nWxE
         26mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL+EN0zWidH6/P9/6QcLFHezjtyZ+PTsZ+hns4lgn3w=;
        b=Z38CSalh0OWf5GXg9FSIkwI2s1o+x3hhsxb0cqdSYE7mZobKqcmzFZPmb1NALLmOjm
         a9PIWI9xyQ6gRP68xYZE3TXN5Q4dsjh//l0BWOf7a0Kp/pjvQnBPCn3J9vX/S7aMr9Lm
         +g2gt6BAdt9s6ep0kslz2KxIkGwwltjk9Vdq7E4G5R8odwU3x7E72Exk/kUhDVLNEere
         09KlI62bwYzVI9J5evLdv2E75ckTHgG0r7+vQ7GQNV647U9lwSHoWn9bpguV6RDoFtLh
         zpl/kunCWHMmiJyoB8zV/qgV9OvuG4MaLC71czqxjzGoOO1Sj4aVupHRMD9v+L1LoL08
         LHuQ==
X-Gm-Message-State: AOAM530kNODGQgQVVKk4RT61FRG5zD8TMM2Nn4jBt0d5s93Nvng/r3tb
        ng/D9E02zl80bjVlvhnex8NneFw4wim+Uw==
X-Google-Smtp-Source: ABdhPJzbf/Hf5qCJBEknMMOIKIgCwCKhSfHytRhDjLyMeD7qwKSxjqt7SxzT247HsrLT6N/t27Q6KA==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr3313970edd.111.1623413437628;
        Fri, 11 Jun 2021 05:10:37 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4954:2e00:fd6f:fc71:2689:4a7a])
        by smtp.gmail.com with ESMTPSA id n11sm2084116ejg.43.2021.06.11.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:10:37 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 2/5] RDMA/rtrs-clt: Use minimal max_send_sge when create qp
Date:   Fri, 11 Jun 2021 14:10:31 +0200
Message-Id: <20210611121034.48837-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611121034.48837-1-jinpu.wang@ionos.com>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
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

