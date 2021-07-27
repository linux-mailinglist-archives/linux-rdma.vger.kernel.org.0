Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24D3D6CC1
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhG0Cu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12311 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhG0Cuz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:55 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYhzN0hDkz7yY5;
        Tue, 27 Jul 2021 11:26:40 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:08 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v3 for-next 12/12] RDMA/hns: Dump detailed driver-specific UCTX
Date:   Tue, 27 Jul 2021 11:27:32 +0800
Message-ID: <1627356452-30564-13-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
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
 dev hns_0 ctxn 7 pid 1410 comm python3 drv_dca-loading 37.50 drv_dca-total 65536 drv_dca-free 40960
 dev hns_0 ctxn 8 pid 1410 comm python3 drv_dca-loading 0.00 drv_dca-total 0 drv_dca-free 0

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 85 +++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

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
index 259444c..4e2e2c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -118,3 +118,88 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 	kfree(context);
 	return ret;
 }
+
+#define LOADING_PERCENT_SCALE 100
+#define LOADING_PERCENT_SHIFT 2
+#define LOADING_PERCENT_CHARS 10
+
+static u64 calc_dca_loading_percent(u64 total, u64 free, u32 *out_rem)
+{
+	u32 all_pages, used_pages, free_pages, scale;
+	u64 percent = 0;
+	u32 rem = 0;
+
+	all_pages = total >> HNS_HW_PAGE_SHIFT;
+	free_pages = free >> HNS_HW_PAGE_SHIFT;
+	if (all_pages >= free_pages) {
+		used_pages = all_pages - free_pages;
+		scale = LOADING_PERCENT_SCALE * LOADING_PERCENT_SCALE;
+		percent = (used_pages * scale) / all_pages;
+		percent = div_u64_rem(percent, LOADING_PERCENT_SCALE, &rem);
+	}
+
+	if (out_rem)
+		*out_rem = rem;
+
+	return percent;
+}
+
+static int hns_roce_fill_dca_uctx(struct hns_roce_dca_ctx *ctx,
+				  struct sk_buff *msg)
+{
+	char tmp_str[LOADING_PERCENT_CHARS];
+	unsigned long flags;
+	u64 total, free;
+	u64 percent;
+	u32 rem = 0;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	total = ctx->total_size;
+	free = ctx->free_size;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+	percent = calc_dca_loading_percent(total, free, &rem);
+	scnprintf(tmp_str, sizeof(tmp_str), "%llu.%0*u\n", percent,
+		  LOADING_PERCENT_SHIFT, rem);
+
+	if (rdma_nl_put_driver_string(msg, "dca-loading", tmp_str))
+		goto err;
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

