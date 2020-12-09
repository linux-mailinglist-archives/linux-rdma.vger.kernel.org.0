Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730D42D470A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgLIQrH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLIQrH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:07 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54107C0617A6
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:52 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id x16so3058243ejj.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JaxSIHKTI1X89HEA600DvBOFqz5T5wMPCHd0uiQJW0=;
        b=is2QrUHd9hLN8dQB2NANTGusJx4uoUyo3Z7i0M6SvA2mvYkWh4BMgyF7WqwFhtL0I2
         qoFn6kROfQWDKEtCiyC3SRBiDpmrFDFSpjTULCQRVUK73WZ7r5TeIjX4fyoeYnsAcNPV
         feEZIRKKTbVyYYg1xzPi6qEqQK3FqAmgl1/vIkpXeMr+3s1BDSGRSY2Ceij4wQj3KD2r
         pLxMk7Ow1G5nYx7DOZ0O+u3ksjlzv8uh9g3dxEzNuaApTcqH6shPyb9x1BsK41/1D09K
         hB6K1Nnzu7Oanm0Mi93lkqDph0K2wSO8Uu4q2aNo4rNxSe867/QpPFOYYPNrhUcADY34
         1OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JaxSIHKTI1X89HEA600DvBOFqz5T5wMPCHd0uiQJW0=;
        b=BMRPnZf6pwPHHjt6ycbUiFsYPfKi6UIV+HyU0qAIbN8Y1mjetix53PQerluqksI2q2
         1CA7JBsbKFnf2+LdykqU3DSDbZ7EpE5bzNm/LuF75Y/MtAa5z+vn66KhZRNnV5e7FvmQ
         x54IVEMcQsEyZzICtZ0V7tiqFupKNtALAIPn14Cm8LU1m52vGU4ikIB9QML1qf1I3z5Q
         od/PcGrE7pDzbpw0rQu5V9rUznYsCtH46EiUspi2RCC96L/G8SStxkrDTnZWgr5tbrqL
         hXznQGjz57ofRkE8zpUrvt7uYzRgCL9I8mu/lMVribNcKdsTWUfXJA5Pq5pGBxI64jtZ
         KiBA==
X-Gm-Message-State: AOAM533PJXoGpuTqC2SqGpUFOfnVSKgy8e9IV3qID/8HuG+bf7BN0ybo
        DhwS7BnU7wQPWuvLBAy344sHZCJitgZ4fQ==
X-Google-Smtp-Source: ABdhPJz0lAOSm/Q+hs6L0HjTRlDjmidHpoEhRaopbLJ4X9Ft74OVlocF0A3fVDhHU3uYiHCZDwvvwQ==
X-Received: by 2002:a17:906:1a01:: with SMTP id i1mr2812491ejf.315.1607532350833;
        Wed, 09 Dec 2020 08:45:50 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:50 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 05/18] RDMA/rtrs-clt: Set mininum limit when create QP
Date:   Wed,  9 Dec 2020 17:45:29 +0100
Message-Id: <20201209164542.61387-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
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

