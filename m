Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E138434B400
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 04:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhC0DYX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 23:24:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14625 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhC0DYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 23:24:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6kfQ4khXz1BGrx;
        Sat, 27 Mar 2021 11:22:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 11:24:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 4/5] RDMA/hns: Reorganize process of setting HEM
Date:   Sat, 27 Mar 2021 11:21:33 +0800
Message-ID: <1616815294-13434-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
References: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Encapsulate configuring GMV base address and other type of HEM table into
two separate functions to make process of setting HEM clearer.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 77 +++++++++++++++++-------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d3a2045..5d499df 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1400,6 +1400,21 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
+			       dma_addr_t base_addr, u16 op)
+{
+	struct hns_roce_cmd_mailbox *mbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	int ret;
+
+	if (IS_ERR(mbox))
+		return PTR_ERR(mbox);
+
+	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, obj, 0, op,
+				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	hns_roce_free_cmd_mailbox(hr_dev, mbox);
+	return ret;
+}
+
 static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_query_version *resp;
@@ -3779,12 +3794,9 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 }
 
 static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
-			      int step_idx)
+			      int step_idx, u16 *mbox_op)
 {
-	int op;
-
-	if (type == HEM_TYPE_SCCC && step_idx)
-		return -EINVAL;
+	u16 op;
 
 	switch (type) {
 	case HEM_TYPE_QPC:
@@ -3809,51 +3821,50 @@ static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
 		op = HNS_ROCE_CMD_WRITE_CQC_TIMER_BT0;
 		break;
 	default:
-		dev_warn(hr_dev->dev,
-			 "table %u not to be written by mailbox!\n", type);
+		dev_warn(hr_dev->dev, "failed to check hem type %u.\n", type);
 		return -EINVAL;
 	}
 
-	return op + step_idx;
+	*mbox_op = op + step_idx;
+
+	return 0;
 }
 
-static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj, u64 bt_ba,
-			 u32 hem_type, int step_idx)
+static int config_gmv_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
+			       dma_addr_t base_addr)
 {
-	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_cfg_gmv_bt *gmv_bt =
 				(struct hns_roce_cfg_gmv_bt *)desc.data;
-	int ret;
-	int op;
+	u64 addr = to_hr_hw_page_addr(base_addr);
 
-	if (hem_type == HEM_TYPE_GMV) {
-		hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GMV_BT,
-					      false);
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GMV_BT, false);
 
-		gmv_bt->gmv_ba_l = cpu_to_le32(bt_ba >> HNS_HW_PAGE_SHIFT);
-		gmv_bt->gmv_ba_h = cpu_to_le32(bt_ba >> (HNS_HW_PAGE_SHIFT +
-							 32));
-		gmv_bt->gmv_bt_idx = cpu_to_le32(obj /
-			(HNS_HW_PAGE_SIZE / hr_dev->caps.gmv_entry_sz));
+	gmv_bt->gmv_ba_l = cpu_to_le32(lower_32_bits(addr));
+	gmv_bt->gmv_ba_h = cpu_to_le32(upper_32_bits(addr));
+	gmv_bt->gmv_bt_idx = cpu_to_le32(obj /
+		(HNS_HW_PAGE_SIZE / hr_dev->caps.gmv_entry_sz));
 
-		return hns_roce_cmq_send(hr_dev, &desc, 1);
-	}
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
 
-	op = get_op_for_set_hem(hr_dev, hem_type, step_idx);
-	if (op < 0)
-		return 0;
+static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj,
+			 dma_addr_t base_addr, u32 hem_type, int step_idx)
+{
+	int ret;
+	u16 op;
 
-	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
+	if (unlikely(hem_type == HEM_TYPE_GMV))
+		return config_gmv_ba_to_hw(hr_dev, obj, base_addr);
 
-	ret = hns_roce_cmd_mbox(hr_dev, bt_ba, mailbox->dma, obj,
-				0, op, HNS_ROCE_CMD_TIMEOUT_MSECS);
+	if (unlikely(hem_type == HEM_TYPE_SCCC && step_idx))
+		return 0;
 
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	ret = get_op_for_set_hem(hr_dev, hem_type, step_idx, &op);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return config_hem_ba_to_hw(hr_dev, obj, base_addr, op);
 }
 
 static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
-- 
2.8.1

