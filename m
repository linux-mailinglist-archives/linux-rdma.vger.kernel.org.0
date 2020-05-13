Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C41D0E8D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgEMJvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 05:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbgEMJvR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 05:51:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E63920575;
        Wed, 13 May 2020 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363476;
        bh=MToyYdFDuHjdqk+Rgum/hbau5DtCaQ/ZU3Wik55ut/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBEyP7S4+lNCIKSX/nx4Nd2Z0h5NsJ9ja10Dltq+TaDEpqtI0vlTJdXhjET94Ps/8
         VSto4f/zBPRyPuG9m52R57uaKwVJPDPlpc8W+vUQmRfG09lx2GBz6XJjL3h4FhZjaq
         bJc/1RzA9AnMz6PD1q12OgUw5eJNjbEAY6dvjfMM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH rdma-next 10/14] RDMA: Add dedicated cm id resource tracker function
Date:   Wed, 13 May 2020 12:50:30 +0300
Message-Id: <20200513095034.208385-11-leon@kernel.org>
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

In order to avoid double multiplexing of the resource when it's
cm id, add a dedicated callback function.
In addition remove fill_res_entry which is not used anymore.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c       | 2 +-
 drivers/infiniband/core/nldev.c        | 2 +-
 drivers/infiniband/core/restrack.c     | 5 ++---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 4 +---
 drivers/infiniband/hw/cxgb4/provider.c | 9 +--------
 drivers/infiniband/hw/cxgb4/restrack.c | 9 ++-------
 include/rdma/ib_verbs.h                | 4 ++--
 7 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 23af3cc27ee1..49637a3cd068 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2616,8 +2616,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, drain_rq);
 	SET_DEVICE_OP(dev_ops, drain_sq);
 	SET_DEVICE_OP(dev_ops, enable_driver);
+	SET_DEVICE_OP(dev_ops, fill_res_cm_id_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
-	SET_DEVICE_OP(dev_ops, fill_res_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
 	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 8c748888bf28..02a1f50b23be 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -549,7 +549,7 @@ static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	return dev->ops.fill_res_entry(msg, res);
+	return dev->ops.fill_res_cm_id_entry(msg, cm_id);
 
 err: return -EMSGSIZE;
 }
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 33d7c0888753..bad96ab58fc9 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -21,8 +21,7 @@
 		return 0;					\
 	}
 
-static int fill_res_dummy(struct sk_buff *msg,
-			  struct rdma_restrack_entry *entry)
+static int fill_res_cm_id(struct sk_buff *msg, struct rdma_cm_id *id)
 {
 	return 0;
 }
@@ -32,8 +31,8 @@ FILL_DUMMY(cq);
 FILL_DUMMY(qp);
 
 static const struct ib_device_ops restrack_dummy_ops = {
+	.fill_res_cm_id_entry = fill_res_cm_id,
 	.fill_res_cq_entry = fill_res_cq,
-	.fill_res_entry = fill_res_dummy,
 	.fill_res_mr_entry = fill_res_mr,
 	.fill_res_qp_entry = fill_res_qp,
 	.fill_stat_mr_entry = fill_res_mr,
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index c84aa7c937f1..27da0705c88a 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1053,11 +1053,9 @@ int c4iw_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		       const struct ib_recv_wr **bad_wr);
 struct c4iw_wr_wait *c4iw_alloc_wr_wait(gfp_t gfp);
 
-typedef int c4iw_restrack_func(struct sk_buff *msg,
-			       struct rdma_restrack_entry *res);
 int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr);
 int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
 int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp);
-extern c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX];
+int c4iw_fill_res_cm_id_entry(struct sk_buff *msg, struct rdma_cm_id *cm_id);
 
 #endif
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index d6b20aa314a0..1d3ff59e4060 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -458,13 +458,6 @@ static void get_dev_fw_str(struct ib_device *dev, char *str)
 		 FW_HDR_FW_VER_BUILD_G(c4iw_dev->rdev.lldi.fw_vers));
 }
 
-static int fill_res_entry(struct sk_buff *msg, struct rdma_restrack_entry *res)
-{
-	return (res->type < ARRAY_SIZE(c4iw_restrack_funcs) &&
-		c4iw_restrack_funcs[res->type]) ?
-		c4iw_restrack_funcs[res->type](msg, res) : 0;
-}
-
 static const struct ib_device_ops c4iw_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_CXGB4,
@@ -486,7 +479,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.destroy_qp = c4iw_destroy_qp,
 	.destroy_srq = c4iw_destroy_srq,
 	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
-	.fill_res_entry = fill_res_entry,
+	.fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = c4iw_get_dma_mr,
diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index 5144d3b67293..b32e6516d65f 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -193,10 +193,9 @@ union union_ep {
 	struct c4iw_ep ep;
 };
 
-static int fill_res_ep_entry(struct sk_buff *msg,
-			     struct rdma_restrack_entry *res)
+int c4iw_fill_res_cm_id_entry(struct sk_buff *msg,
+			      struct rdma_cm_id *cm_id)
 {
-	struct rdma_cm_id *cm_id = rdma_res_to_id(res);
 	struct nlattr *table_attr;
 	struct c4iw_ep_common *epcp;
 	struct c4iw_listen_ep *listen_ep = NULL;
@@ -486,7 +485,3 @@ int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 err:
 	return -EMSGSIZE;
 }
-
-c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX] = {
-	[RDMA_RESTRACK_CM_ID]	= fill_res_ep_entry,
-};
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 194a15b71498..4b7812340167 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -75,6 +75,7 @@ struct ib_umem_odp;
 struct ib_uqp_object;
 struct ib_usrq_object;
 struct ib_uwq_object;
+struct rdma_cm_id;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2567,11 +2568,10 @@ struct ib_device_ops {
 	/**
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
-	int (*fill_res_entry)(struct sk_buff *msg,
-			      struct rdma_restrack_entry *entry);
 	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
 	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
 	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);
+	int (*fill_res_cm_id_entry)(struct sk_buff *msg, struct rdma_cm_id *id);
 
 	/* Device lifecycle callbacks */
 	/*
-- 
2.26.2

