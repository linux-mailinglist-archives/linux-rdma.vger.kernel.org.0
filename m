Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321C1D0E9B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgEMKBS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 06:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387606AbgEMJvK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 05:51:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA06F23126;
        Wed, 13 May 2020 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363469;
        bh=CFAw9cSjFx6cENQyYfzjYVLFqpCNnTyZTbhN9RptVtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lnz89V+L0teFYqeAE60g+SBgggzlfO58DijWO97TsFyQTNBTEmsnFY/cOyIiIg/kf
         L8MD0FrC2uBcMAtROJYEi4tS7MhwwCvRNq/O2oEqayu19i4Q4F2LSyPHEFfJM3k1KX
         fbfrVxzC5NuwXhfZSZy1y92I5BDroRFMnSDlmyj0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH rdma-next 09/14] RDMA: Add a dedicated QP resource tracker function
Date:   Wed, 13 May 2020 12:50:29 +0300
Message-Id: <20200513095034.208385-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513095034.208385-1-leon@kernel.org>
References: <20200513095034.208385-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

In order to avoid double multiplexing of the resource when it's QP,
add a dedicated callback function.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c       | 1 +
 drivers/infiniband/core/nldev.c        | 2 +-
 drivers/infiniband/core/restrack.c     | 2 ++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 1 +
 drivers/infiniband/hw/cxgb4/restrack.c | 5 +----
 include/rdma/ib_verbs.h                | 1 +
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1f9f44e62e49..23af3cc27ee1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2619,6 +2619,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
+	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
 	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
 	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 6207b68453a1..8c748888bf28 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -499,7 +499,7 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	return dev->ops.fill_res_entry(msg, res);
+	return dev->ops.fill_res_qp_entry(msg, qp);
 
 err:	return -EMSGSIZE;
 }
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 031a4f94400e..33d7c0888753 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -29,11 +29,13 @@ static int fill_res_dummy(struct sk_buff *msg,
 
 FILL_DUMMY(mr);
 FILL_DUMMY(cq);
+FILL_DUMMY(qp);
 
 static const struct ib_device_ops restrack_dummy_ops = {
 	.fill_res_cq_entry = fill_res_cq,
 	.fill_res_entry = fill_res_dummy,
 	.fill_res_mr_entry = fill_res_mr,
+	.fill_res_qp_entry = fill_res_qp,
 	.fill_stat_mr_entry = fill_res_mr,
 };
 
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 18a2c1a44dcc..c84aa7c937f1 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1057,6 +1057,7 @@ typedef int c4iw_restrack_func(struct sk_buff *msg,
 			       struct rdma_restrack_entry *res);
 int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr);
 int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
+int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp);
 extern c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX];
 
 #endif
diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index ead2cd08793d..5144d3b67293 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -134,10 +134,8 @@ static int fill_swsqes(struct sk_buff *msg, struct t4_sq *sq,
 	return -EMSGSIZE;
 }
 
-static int fill_res_qp_entry(struct sk_buff *msg,
-			     struct rdma_restrack_entry *res)
+int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
 {
-	struct ib_qp *ibqp = container_of(res, struct ib_qp, res);
 	struct t4_swsqe *fsp = NULL, *lsp = NULL;
 	struct c4iw_qp *qhp = to_c4iw_qp(ibqp);
 	u16 first_sq_idx = 0, last_sq_idx = 0;
@@ -490,6 +488,5 @@ int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 }
 
 c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX] = {
-	[RDMA_RESTRACK_QP]	= fill_res_qp_entry,
 	[RDMA_RESTRACK_CM_ID]	= fill_res_ep_entry,
 };
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 61f27cacc120..194a15b71498 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2571,6 +2571,7 @@ struct ib_device_ops {
 			      struct rdma_restrack_entry *entry);
 	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
 	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
+	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);
 
 	/* Device lifecycle callbacks */
 	/*
-- 
2.26.2

