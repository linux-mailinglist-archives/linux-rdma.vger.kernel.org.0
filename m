Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABA1E449E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbgE0Nyd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 09:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388807AbgE0Nya (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 09:54:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9162078C;
        Wed, 27 May 2020 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590587669;
        bh=21UaX92a0aIinfwZhNfzX6E3orajkBxjbmro6d+SrIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPAgknSM88M5D1FY76hfxf562oNEeweFc62qVgilRQeLl4acDHMCOvJlPeup8brG5
         kY/8jpgysSS1c8ORGtKlbVtMh8JX9hwbzB9vw8fxmOUw8JTq6KoY9cvOAj5mqJM1GX
         cWgQdgQAMG0nkGuNOX3c1CBHOpkNECoI9qxXAN+Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, Lijun Ou <oulijun@huawei.com>,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>
Subject: [PATCH rdma-next v1 05/11] RDMA: Add dedicated CQ resource tracker function
Date:   Wed, 27 May 2020 16:54:02 +0300
Message-Id: <20200527135408.480878-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527135408.480878-1-leon@kernel.org>
References: <20200527135408.480878-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

In order to avoid double multiplexing of the resource when it's CQ,
add a dedicated callback function.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/nldev.c               |  5 ++---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  1 +
 drivers/infiniband/hw/cxgb4/provider.c        |  1 +
 drivers/infiniband/hw/cxgb4/restrack.c        |  5 +----
 drivers/infiniband/hw/hns/hns_roce_device.h   |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 14 ++------------
 include/rdma/ib_verbs.h                       |  1 +
 9 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e76875d8c101..4ea2789360e0 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2617,6 +2617,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, drain_rq);
 	SET_DEVICE_OP(dev_ops, drain_sq);
 	SET_DEVICE_OP(dev_ops, enable_driver);
+	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
 	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index a4f3f838d6fe..707f724db1dd 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -598,9 +598,8 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	if (fill_res_entry(dev, msg, res))
-		goto err;
-
+	if (dev->ops.fill_res_cq_entry)
+		return dev->ops.fill_res_cq_entry(msg, cq);
 	return 0;
 
 err:	return -EMSGSIZE;
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 5b9884ca2f5e..18a2c1a44dcc 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1056,6 +1056,7 @@ struct c4iw_wr_wait *c4iw_alloc_wr_wait(gfp_t gfp);
 typedef int c4iw_restrack_func(struct sk_buff *msg,
 			       struct rdma_restrack_entry *res);
 int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr);
+int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
 extern c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX];
 
 #endif
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 36eeb595d41c..d6b20aa314a0 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -485,6 +485,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.destroy_cq = c4iw_destroy_cq,
 	.destroy_qp = c4iw_destroy_qp,
 	.destroy_srq = c4iw_destroy_srq,
+	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
 	.fill_res_entry = fill_res_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index 9a5ca9192c1c..ead2cd08793d 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -372,10 +372,8 @@ static int fill_swcqes(struct sk_buff *msg, struct t4_cq *cq,
 	return -EMSGSIZE;
 }
 
-static int fill_res_cq_entry(struct sk_buff *msg,
-			     struct rdma_restrack_entry *res)
+int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
 {
-	struct ib_cq *ibcq = container_of(res, struct ib_cq, res);
 	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
 	struct nlattr *table_attr;
 	struct t4_cqe hwcqes[2];
@@ -494,5 +492,4 @@ int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX] = {
 	[RDMA_RESTRACK_QP]	= fill_res_qp_entry,
 	[RDMA_RESTRACK_CM_ID]	= fill_res_ep_entry,
-	[RDMA_RESTRACK_CQ]	= fill_res_cq_entry,
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a77fa6730b2d..a61f0c4d4dbb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1266,6 +1266,6 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 
-int hns_roce_fill_res_entry(struct sk_buff *msg,
-			    struct rdma_restrack_entry *res);
+int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
+			       struct ib_cq *ib_cq);
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 50763cf4fa3d..5907cfd878a6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -428,7 +428,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.destroy_ah = hns_roce_destroy_ah,
 	.destroy_cq = hns_roce_destroy_cq,
 	.disassociate_ucontext = hns_roce_disassociate_ucontext,
-	.fill_res_entry = hns_roce_fill_res_entry,
+	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
 	.get_dma_mr = hns_roce_get_dma_mr,
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 06871731ac43..259444c0a630 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -76,10 +76,9 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-static int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-				      struct rdma_restrack_entry *res)
+int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
+			       struct ib_cq *ib_cq)
 {
-	struct ib_cq *ib_cq = container_of(res, struct ib_cq, res);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct hns_roce_v2_cq_context *context;
@@ -119,12 +118,3 @@ static int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 	kfree(context);
 	return ret;
 }
-
-int hns_roce_fill_res_entry(struct sk_buff *msg,
-			    struct rdma_restrack_entry *res)
-{
-	if (res->type == RDMA_RESTRACK_CQ)
-		return hns_roce_fill_res_cq_entry(msg, res);
-
-	return 0;
-}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5f2397c62f63..fc354b49b9e3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2599,6 +2599,7 @@ struct ib_device_ops {
 	int (*fill_res_entry)(struct sk_buff *msg,
 			      struct rdma_restrack_entry *entry);
 	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
+	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
 
 	/* Device lifecycle callbacks */
 	/*
-- 
2.26.2

