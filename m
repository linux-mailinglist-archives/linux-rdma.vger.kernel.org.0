Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673C661FB3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfGHNox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728124AbfGHNox (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9396370015FFBED8023E;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:40 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Package for hns_roce_rereg_user_mr function
Date:   Mon, 8 Jul 2019 21:41:23 +0800
Message-ID: <1562593285-8037-8-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here moves some codes of hns_roce_rereg_user_mr functioon into
an independent function in oder to optimize complexity.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 153 +++++++++++++++++++-------------
 1 file changed, 89 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index c4b758c..0cfa946 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1206,6 +1206,83 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(ret);
 }
 
+static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
+			  u64 start, u64 length,
+			  u64 virt_addr, int mr_access_flags,
+			  struct hns_roce_cmd_mailbox *mailbox,
+			  u32 pdn, struct ib_udata *udata)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
+	struct hns_roce_mr *mr = to_hr_mr(ibmr);
+	struct device *dev = hr_dev->dev;
+	int npages;
+	int ret;
+
+	if (mr->size != ~0ULL) {
+		npages = ib_umem_page_count(mr->umem);
+
+		if (hr_dev->caps.pbl_hop_num)
+			hns_roce_mhop_free(hr_dev, mr);
+		else
+			dma_free_coherent(dev, npages * 8,
+					  mr->pbl_buf, mr->pbl_dma_addr);
+	}
+	ib_umem_release(mr->umem);
+
+	mr->umem = ib_umem_get(udata, start, length, mr_access_flags, 0);
+	if (IS_ERR(mr->umem)) {
+		ret = PTR_ERR(mr->umem);
+		mr->umem = NULL;
+		return -ENOMEM;
+	}
+	npages = ib_umem_page_count(mr->umem);
+
+	if (hr_dev->caps.pbl_hop_num) {
+		ret = hns_roce_mhop_alloc(hr_dev, npages, mr);
+		if (ret)
+			goto release_umem;
+	} else {
+		mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
+						 &(mr->pbl_dma_addr),
+						 GFP_KERNEL);
+		if (!mr->pbl_buf) {
+			ret = -ENOMEM;
+			goto release_umem;
+		}
+	}
+
+	ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, pdn,
+					   mr_access_flags, virt_addr,
+					   length, mailbox->buf);
+	if (ret)
+		goto release_umem;
+
+
+	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->umem);
+	if (ret) {
+		if (mr->size != ~0ULL) {
+			npages = ib_umem_page_count(mr->umem);
+
+			if (hr_dev->caps.pbl_hop_num)
+				hns_roce_mhop_free(hr_dev, mr);
+			else
+				dma_free_coherent(dev, npages * 8,
+						  mr->pbl_buf,
+						  mr->pbl_dma_addr);
+		}
+
+		goto release_umem;
+	}
+
+	return 0;
+
+release_umem:
+	ib_umem_release(mr->umem);
+	return ret;
+
+}
+
+
 int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 			   u64 virt_addr, int mr_access_flags, struct ib_pd *pd,
 			   struct ib_udata *udata)
@@ -1216,7 +1293,6 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 	struct device *dev = hr_dev->dev;
 	unsigned long mtpt_idx;
 	u32 pdn = 0;
-	int npages;
 	int ret;
 
 	if (!mr->enabled)
@@ -1243,73 +1319,25 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 		pdn = to_hr_pd(pd)->pdn;
 
 	if (flags & IB_MR_REREG_TRANS) {
-		if (mr->size != ~0ULL) {
-			npages = ib_umem_page_count(mr->umem);
-
-			if (hr_dev->caps.pbl_hop_num)
-				hns_roce_mhop_free(hr_dev, mr);
-			else
-				dma_free_coherent(dev, npages * 8, mr->pbl_buf,
-						  mr->pbl_dma_addr);
-		}
-		ib_umem_release(mr->umem);
-
-		mr->umem =
-			ib_umem_get(udata, start, length, mr_access_flags, 0);
-		if (IS_ERR(mr->umem)) {
-			ret = PTR_ERR(mr->umem);
-			mr->umem = NULL;
+		ret = rereg_mr_trans(ibmr, flags,
+				     start, length,
+				     virt_addr, mr_access_flags,
+				     mailbox, pdn, udata);
+		if (ret)
 			goto free_cmd_mbox;
-		}
-		npages = ib_umem_page_count(mr->umem);
-
-		if (hr_dev->caps.pbl_hop_num) {
-			ret = hns_roce_mhop_alloc(hr_dev, npages, mr);
-			if (ret)
-				goto release_umem;
-		} else {
-			mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
-							 &(mr->pbl_dma_addr),
-							 GFP_KERNEL);
-			if (!mr->pbl_buf) {
-				ret = -ENOMEM;
-				goto release_umem;
-			}
-		}
-	}
-
-	ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, pdn,
-					   mr_access_flags, virt_addr,
-					   length, mailbox->buf);
-	if (ret) {
-		if (flags & IB_MR_REREG_TRANS)
-			goto release_umem;
-		else
+	} else {
+		ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, pdn,
+						   mr_access_flags, virt_addr,
+						   length, mailbox->buf);
+		if (ret)
 			goto free_cmd_mbox;
 	}
 
-	if (flags & IB_MR_REREG_TRANS) {
-		ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->umem);
-		if (ret) {
-			if (mr->size != ~0ULL) {
-				npages = ib_umem_page_count(mr->umem);
-
-				if (hr_dev->caps.pbl_hop_num)
-					hns_roce_mhop_free(hr_dev, mr);
-				else
-					dma_free_coherent(dev, npages * 8,
-							  mr->pbl_buf,
-							  mr->pbl_dma_addr);
-			}
-
-			goto release_umem;
-		}
-	}
-
 	ret = hns_roce_sw2hw_mpt(hr_dev, mailbox, mtpt_idx);
 	if (ret) {
 		dev_err(dev, "SW2HW_MPT failed (%d)\n", ret);
-		goto release_umem;
+		ib_umem_release(mr->umem);
+		goto free_cmd_mbox;
 	}
 
 	mr->enabled = 1;
@@ -1320,9 +1348,6 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 
 	return 0;
 
-release_umem:
-	ib_umem_release(mr->umem);
-
 free_cmd_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
-- 
1.9.1

