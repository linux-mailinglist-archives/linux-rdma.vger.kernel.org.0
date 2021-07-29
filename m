Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172823D9BBC
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhG2CXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 22:23:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16021 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhG2CXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 22:23:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZvP21SJHzZv7x;
        Thu, 29 Jul 2021 10:19:34 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:01 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:00 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <leon@kernel.org>, <liangwenpeng@huawei.com>,
        Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v4 for-next 11/12] RDMA/nldev: Add detailed CTX information support
Date:   Thu, 29 Jul 2021 10:19:22 +0800
Message-ID: <1627525163-1683-12-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Implement the RDMA nldev netlink interface for dumping detailed CTX
information.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/core/device.c | 1 +
 drivers/infiniband/core/nldev.c  | 8 +++++++-
 include/rdma/ib_verbs.h          | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 9056f48..195986f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2641,6 +2641,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, drain_rq);
 	SET_DEVICE_OP(dev_ops, drain_sq);
 	SET_DEVICE_OP(dev_ops, enable_driver);
+	SET_DEVICE_OP(dev_ops, fill_res_ctx_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_cm_id_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_cq_entry_raw);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e9b4b2c..e8c99b7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -716,6 +716,7 @@ static int fill_res_ctx_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			      struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_ucontext *ctx = container_of(res, struct ib_ucontext, res);
+	struct ib_device *dev = ctx->device;
 
 	if (rdma_is_kernel_res(res))
 		return 0;
@@ -723,7 +724,12 @@ static int fill_res_ctx_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN, ctx->res.id))
 		return -EMSGSIZE;
 
-	return fill_res_name_pid(msg, res);
+	if (fill_res_name_pid(msg, res))
+		return -EMSGSIZE;
+
+	return (dev->ops.fill_res_ctx_entry) ?
+		       dev->ops.fill_res_ctx_entry(msg, ctx) :
+		       0;
 }
 
 static int fill_res_range_qp_entry(struct sk_buff *msg, uint32_t min_range,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 371df1c..b0277c5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2568,6 +2568,7 @@ struct ib_device_ops {
 	/**
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
+	int (*fill_res_ctx_entry)(struct sk_buff *msg, struct ib_ucontext *ctx);
 	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
 	int (*fill_res_mr_entry_raw)(struct sk_buff *msg, struct ib_mr *ibmr);
 	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
-- 
2.8.1

