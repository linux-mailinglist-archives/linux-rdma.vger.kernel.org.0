Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92BC8767A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406136AbfHIJpe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406120AbfHIJpd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9C25159F539E5631454;
        Fri,  9 Aug 2019 17:45:31 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:21 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 8/9] RDMA/hns: Kernel notify usr space to stop ring db
Date:   Fri, 9 Aug 2019 17:41:05 +0800
Message-ID: <1565343666-73193-9-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

In the reset scenario, if the kernel receives the reset signal,
it needs to notify the user space to stop ring doorbell.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 52 ++++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 +++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 22 ++++++------
 4 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 32465f5..be65fce 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -268,6 +268,8 @@ enum {
 
 #define PAGE_ADDR_SHIFT				12
 
+#define HNS_ROCE_IS_RESETTING			1
+
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
@@ -1043,6 +1045,8 @@ struct hns_roce_dev {
 	u32			odb_offset;
 	dma_addr_t		tptr_dma_addr;	/* only for hw v1 */
 	u32			tptr_size;	/* only for hw v1 */
+	struct page		*reset_page; /* store reset state */
+	void			*reset_kaddr; /* addr of reset page */
 	const struct hns_roce_hw *hw;
 	void			*priv;
 	struct workqueue_struct *irq_workq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d33341e..138e5a8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1867,17 +1867,49 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
 			  link_tbl->table.map);
 }
 
+static int hns_roce_v2_get_reset_page(struct hns_roce_dev *hr_dev)
+{
+	hr_dev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!hr_dev->reset_page)
+		return -ENOMEM;
+
+	hr_dev->reset_kaddr = vmap(&hr_dev->reset_page, 1, VM_MAP, PAGE_KERNEL);
+	if (!hr_dev->reset_kaddr)
+		goto err_with_vmap;
+
+	return 0;
+
+err_with_vmap:
+	put_page(hr_dev->reset_page);
+	return -ENOMEM;
+}
+
+static void hns_roce_v2_put_reset_page(struct hns_roce_dev *hr_dev)
+{
+	vunmap(hr_dev->reset_kaddr);
+	hr_dev->reset_kaddr = NULL;
+	put_page(hr_dev->reset_page);
+	hr_dev->reset_page = NULL;
+}
+
 static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int qpc_count, cqc_count;
 	int ret, i;
 
+	ret = hns_roce_v2_get_reset_page(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"reset state init failed, ret = %d.\n", ret);
+		return ret;
+	}
+
 	/* TSQ includes SQ doorbell and ack doorbell */
 	ret = hns_roce_init_link_table(hr_dev, TSQ_LINK_TABLE);
 	if (ret) {
 		dev_err(hr_dev->dev, "TSQ init failed, ret = %d.\n", ret);
-		return ret;
+		goto err_tsq_init_failed;
 	}
 
 	ret = hns_roce_init_link_table(hr_dev, TPQ_LINK_TABLE);
@@ -1923,6 +1955,9 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 err_tpq_init_failed:
 	hns_roce_free_link_table(hr_dev, &priv->tsq);
 
+err_tsq_init_failed:
+	hns_roce_v2_put_reset_page(hr_dev);
+
 	return ret;
 }
 
@@ -1935,6 +1970,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
 	hns_roce_free_link_table(hr_dev, &priv->tsq);
+	hns_roce_v2_put_reset_page(hr_dev);
 }
 
 static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
@@ -6434,6 +6470,19 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
 }
+
+static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_reset_state *state;
+
+	state = (struct hns_roce_v2_reset_state *) hr_dev->reset_kaddr;
+
+	state->reset_state = HNS_ROCE_IS_RESETTING;
+
+	/* Ensure reset state was flushed in memory */
+	wmb();
+}
+
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
@@ -6454,6 +6503,7 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 	hr_dev->is_reset = true;
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
+	hns_roce_v2_reset_notify_user(hr_dev);
 
 	event.event = IB_EVENT_DEVICE_FATAL;
 	event.device = &hr_dev->ib_dev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 58931b5..392bc03 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1622,6 +1622,10 @@ struct hns_roce_link_table_entry {
 #define HNS_ROCE_LINK_TABLE_NXT_PTR_S 20
 #define HNS_ROCE_LINK_TABLE_NXT_PTR_M GENMASK(31, 20)
 
+struct hns_roce_v2_reset_state {
+	u32 reset_state; /* stored to use in user space */
+};
+
 struct hns_roce_v2_priv {
 	struct hnae3_handle *handle;
 	struct hns_roce_v2_cmq cmq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1e4ba48..1bda7a5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -360,18 +360,18 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 					 PAGE_SIZE,
 					 pgprot_noncached(vma->vm_page_prot));
 
-	/* vm_pgoff: 1 -- TPTR */
+	/* vm_pgoff: 1 -- TPTR(hw v1), reset_page(hw v2) */
 	case 1:
-		if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
-			return -EINVAL;
-		/*
-		 * FIXME: using io_remap_pfn_range on the dma address returned
-		 * by dma_alloc_coherent is totally wrong.
-		 */
-		return rdma_user_mmap_io(context, vma,
-					 hr_dev->tptr_dma_addr >> PAGE_SHIFT,
-					 hr_dev->tptr_size,
-					 vma->vm_page_prot);
+		if (hr_dev->tptr_dma_addr && hr_dev->tptr_size)
+			return rdma_user_mmap_io(context, vma,
+					    hr_dev->tptr_dma_addr >> PAGE_SHIFT,
+					    hr_dev->tptr_size,
+					    vma->vm_page_prot);
+
+		if (hr_dev->reset_page)
+			return remap_pfn_range(vma, vma->vm_start,
+					  page_to_pfn(hr_dev->reset_page),
+					  PAGE_SIZE, vma->vm_page_prot);
 
 	default:
 		return -EINVAL;
-- 
1.9.1

