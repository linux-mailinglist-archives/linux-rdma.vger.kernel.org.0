Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD681FAE66
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFPKqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKqU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:46:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5CD20734;
        Tue, 16 Jun 2020 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592304379;
        bh=GMV3bzjWfnfb5orBKDsggtm3NjwRlVDKMIEw1Ab8Lbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yq4CdKUNuQ1g1kJMhtlRqVSTeKUaH0OmhI7PeUWKGqIpjwt0A8D/KYwhC8O/i+tA2
         h6uao0s0Qtb1kd+FXWnsHDRqdKEBi53meWQqmPd+wqKX5hzvIIo13Be2CFpIYNAjJr
         8JiCL8utAapqb6E2k6/rWPthoqtnHpG7bIpZwQyQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH rdma-next v2 07/11] RDMA: Add dedicated CM_ID resource tracker function
Date:   Tue, 16 Jun 2020 13:40:02 +0300
Message-Id: <20200616104006.2425549-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616104006.2425549-1-leon@kernel.org>
References: <20200616104006.2425549-1-leon@kernel.org>
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
 drivers/infiniband/core/device.c       |  2 +-
 drivers/infiniband/core/nldev.c        | 13 ++-----------
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  4 +---
 drivers/infiniband/hw/cxgb4/provider.c |  9 +--------
 drivers/infiniband/hw/cxgb4/restrack.c |  9 ++-------
 include/rdma/ib_verbs.h                |  4 ++--
 6 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index f94989274df5..cbe95e729cf1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2617,8 +2617,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
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
index 79d0980a75e0..394e307c342c 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -446,14 +446,6 @@ static int fill_res_name_pid(struct sk_buff *msg,
 	return err ? -EMSGSIZE : 0;
 }
 
-static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
-			   struct rdma_restrack_entry *res)
-{
-	if (!dev->ops.fill_res_entry)
-		return false;
-	return dev->ops.fill_res_entry(msg, res);
-}
-
 static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			     struct rdma_restrack_entry *res, uint32_t port)
 {
@@ -559,9 +551,8 @@ static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	if (fill_res_entry(dev, msg, res))
-		goto err;
-
+	if (dev->ops.fill_res_cm_id_entry)
+		return dev->ops.fill_res_cm_id_entry(msg, cm_id);
 	return 0;
 
 err: return -EMSGSIZE;
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
index bba4ae7287f9..5146a472511f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -75,6 +75,7 @@ struct ib_umem_odp;
 struct ib_uqp_object;
 struct ib_usrq_object;
 struct ib_uwq_object;
+struct rdma_cm_id;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2582,11 +2583,10 @@ struct ib_device_ops {
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

