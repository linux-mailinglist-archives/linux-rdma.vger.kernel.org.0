Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DCE3D9BB5
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhG2CXG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 22:23:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12277 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhG2CXF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 22:23:05 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZvL84bCYz1CNPX;
        Thu, 29 Jul 2021 10:17:04 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:01 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:01 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <leon@kernel.org>, <liangwenpeng@huawei.com>,
        Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v4 for-next 12/12] RDMA/hns: Dump detailed driver-specific UCTX
Date:   Thu, 29 Jul 2021 10:19:23 +0800
Message-ID: <1627525163-1683-13-git-send-email-liangwenpeng@huawei.com>
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

Dump DCA mem pool status in UCTX restrack.

Sample output:
$ rdma res show ctx dev hns_0 -dd
 dev hns_0 ctxn 7 pid 1410 comm python3 drv_dca-total 65536 drv_dca-free 40960
 dev hns_0 ctxn 8 pid 1410 comm python3 drv_dca-total 0 drv_dca-free 0

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 ++
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 50 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index bef418d..0dfaca4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1304,4 +1304,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 			       struct ib_cq *ib_cq);
+int hns_roce_fill_res_ctx_entry(struct sk_buff *msg, struct ib_ucontext *ctx);
+
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index e37ece8..4f30c29 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -546,6 +546,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.destroy_cq = hns_roce_destroy_cq,
 	.disassociate_ucontext = hns_roce_disassociate_ucontext,
 	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
+	.fill_res_ctx_entry = hns_roce_fill_res_ctx_entry,
 	.get_dma_mr = hns_roce_get_dma_mr,
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 259444c..18521a4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -118,3 +118,53 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 	kfree(context);
 	return ret;
 }
+
+static int hns_roce_fill_dca_uctx(struct hns_roce_dca_ctx *ctx,
+				  struct sk_buff *msg)
+{
+	unsigned long flags;
+	u64 total, free;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	total = ctx->total_size;
+	free = ctx->free_size;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+	if (rdma_nl_put_driver_u64(msg, "dca-total", total))
+		goto err;
+
+	if (rdma_nl_put_driver_u64(msg, "dca-free", free))
+		goto err;
+
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+int hns_roce_fill_res_ctx_entry(struct sk_buff *msg, struct ib_ucontext *ctx)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ctx->device);
+	struct hns_roce_ucontext *uctx = to_hr_ucontext(ctx);
+	struct nlattr *table_attr;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		goto err;
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE) {
+		if (hns_roce_fill_dca_uctx(&uctx->dca_ctx, msg))
+			goto err_cancel_table;
+	}
+
+	nla_nest_end(msg, table_attr);
+
+	return 0;
+
+err_cancel_table:
+	nla_nest_cancel(msg, table_attr);
+err:
+	return -EMSGSIZE;
+
+	return 0;
+}
-- 
2.8.1

