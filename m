Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3C31081F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbhBEJo3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:44:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12844 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhBEJmh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:42:37 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q95zKVz7hVV;
        Fri,  5 Feb 2021 17:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:52 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 12/12] RDMA/hns: Delete redundant judgment when preparing descriptors
Date:   Fri, 5 Feb 2021 17:39:34 +0800
Message-ID: <1612517974-31867-13-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

There is no need to use a for loop to assign values for an array of cmd
descriptors which has only two elements.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 40 +++++++++++-------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9c6fe32..1071b3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1611,17 +1611,13 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 	struct hns_roce_pf_res_a *req_a;
 	struct hns_roce_pf_res_b *req_b;
 	int ret;
-	int i;
 
-	for (i = 0; i < 2; i++) {
-		hns_roce_cmq_setup_basic_desc(&desc[i],
-					      HNS_ROCE_OPC_QUERY_PF_RES, true);
+	hns_roce_cmq_setup_basic_desc(&desc[0], HNS_ROCE_OPC_QUERY_PF_RES,
+				      true);
+	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 
-		if (i == 0)
-			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-		else
-			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-	}
+	hns_roce_cmq_setup_basic_desc(&desc[1], HNS_ROCE_OPC_QUERY_PF_RES,
+				      true);
 
 	ret = hns_roce_cmq_send(hr_dev, desc, 2);
 	if (ret)
@@ -1714,19 +1710,16 @@ static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmq_desc desc[2];
 	struct hns_roce_vf_res_a *req_a;
 	struct hns_roce_vf_res_b *req_b;
-	int i;
 
 	req_a = (struct hns_roce_vf_res_a *)desc[0].data;
 	req_b = (struct hns_roce_vf_res_b *)desc[1].data;
-	for (i = 0; i < 2; i++) {
-		hns_roce_cmq_setup_basic_desc(&desc[i],
-					      HNS_ROCE_OPC_ALLOC_VF_RES, false);
 
-		if (i == 0)
-			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-		else
-			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-	}
+	hns_roce_cmq_setup_basic_desc(&desc[0], HNS_ROCE_OPC_ALLOC_VF_RES,
+				      false);
+	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+
+	hns_roce_cmq_setup_basic_desc(&desc[1], HNS_ROCE_OPC_ALLOC_VF_RES,
+				      false);
 
 	roce_set_field(req_a->vf_qpc_bt_idx_num,
 		       VF_RES_A_DATA_1_VF_QPC_BT_IDX_M,
@@ -2407,7 +2400,6 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 	struct hns_roce_link_table_entry *entry;
 	enum hns_roce_opcode_type opcode;
 	u32 page_num;
-	int i;
 
 	switch (type) {
 	case TSQ_LINK_TABLE:
@@ -2425,14 +2417,10 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 	page_num = link_tbl->npages;
 	entry = link_tbl->table.buf;
 
-	for (i = 0; i < 2; i++) {
-		hns_roce_cmq_setup_basic_desc(&desc[i], opcode, false);
+	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
+	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 
-		if (i == 0)
-			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-		else
-			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-	}
+	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 
 	req_a->base_addr_l = cpu_to_le32(link_tbl->table.map & 0xffffffff);
 	req_a->base_addr_h = cpu_to_le32(link_tbl->table.map >> 32);
-- 
2.8.1

