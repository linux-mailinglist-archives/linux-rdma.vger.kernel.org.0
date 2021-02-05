Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF06B31083D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBEJrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:47:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12852 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBEJpR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:45:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9QB1b2bz7hVk;
        Fri,  5 Feb 2021 17:40:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 03/12] RDMA/hns: Add mapped page count checking for MTR
Date:   Fri, 5 Feb 2021 17:39:25 +0800
Message-ID: <1612517974-31867-4-git-send-email-liweihang@huawei.com>
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

From: Xi Wang <wangxi11@huawei.com>

Add the mapped page count checking flow to avoid invalid page size when
creating MTR.

Fixes: 38389eaa4db1 ("RDMA/hns: Add mtr support for mixed multihop addressing")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c |  9 +++--
 drivers/infiniband/hw/hns/hns_roce_mr.c  | 56 +++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index edc9d6b..cfd2e1b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1075,9 +1075,8 @@ static struct roce_hem_item *hem_list_alloc_item(struct hns_roce_dev *hr_dev,
 		return NULL;
 
 	if (exist_bt) {
-		hem->addr = dma_alloc_coherent(hr_dev->dev,
-						   count * BA_BYTE_LEN,
-						   &hem->dma_addr, GFP_KERNEL);
+		hem->addr = dma_alloc_coherent(hr_dev->dev, count * BA_BYTE_LEN,
+					       &hem->dma_addr, GFP_KERNEL);
 		if (!hem->addr) {
 			kfree(hem);
 			return NULL;
@@ -1336,6 +1335,10 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	if (ba_num < 1)
 		return -ENOMEM;
 
+	if (ba_num > unit)
+		return -ENOBUFS;
+
+	ba_num = min_t(int, ba_num, unit);
 	INIT_LIST_HEAD(&temp_root);
 	offset = r->offset;
 	/* indicate to last region */
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 5a2a557..79b3c30 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -596,30 +596,26 @@ int hns_roce_dealloc_mw(struct ib_mw *ibmw)
 }
 
 static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			  dma_addr_t *pages, struct hns_roce_buf_region *region)
+			  struct hns_roce_buf_region *region, dma_addr_t *pages,
+			  int max_count)
 {
+	int count, npage;
+	int offset, end;
 	__le64 *mtts;
-	int offset;
-	int count;
-	int npage;
 	u64 addr;
-	int end;
 	int i;
 
-	/* if hopnum is 0, buffer cannot store BAs, so skip write mtt */
-	if (!region->hopnum)
-		return 0;
-
 	offset = region->offset;
 	end = offset + region->count;
 	npage = 0;
-	while (offset < end) {
+	while (offset < end && npage < max_count) {
+		count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  offset, &count, NULL);
 		if (!mtts)
 			return -ENOBUFS;
 
-		for (i = 0; i < count; i++) {
+		for (i = 0; i < count && npage < max_count; i++) {
 			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
 				addr = to_hr_hw_page_addr(pages[npage]);
 			else
@@ -631,7 +627,7 @@ static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		offset += count;
 	}
 
-	return 0;
+	return npage;
 }
 
 static inline bool mtr_has_mtt(struct hns_roce_buf_attr *attr)
@@ -779,8 +775,8 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_region *r;
-	unsigned int i;
-	int err;
+	unsigned int i, mapped_cnt;
+	int ret;
 
 	/*
 	 * Only use the first page address as root ba when hopnum is 0, this
@@ -791,26 +787,42 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		return 0;
 	}
 
-	for (i = 0; i < mtr->hem_cfg.region_count; i++) {
+	for (i = 0, mapped_cnt = 0; i < mtr->hem_cfg.region_count &&
+	     mapped_cnt < page_cnt; i++) {
 		r = &mtr->hem_cfg.region[i];
+		/* if hopnum is 0, no need to map pages in this region */
+		if (!r->hopnum) {
+			mapped_cnt += r->count;
+			continue;
+		}
+
 		if (r->offset + r->count > page_cnt) {
-			err = -EINVAL;
+			ret = -EINVAL;
 			ibdev_err(ibdev,
 				  "failed to check mtr%u end %u + %u, max %u.\n",
 				  i, r->offset, r->count, page_cnt);
-			return err;
+			return ret;
 		}
 
-		err = mtr_map_region(hr_dev, mtr, &pages[r->offset], r);
-		if (err) {
+		ret = mtr_map_region(hr_dev, mtr, r, &pages[r->offset],
+				     page_cnt - mapped_cnt);
+		if (ret < 0) {
 			ibdev_err(ibdev,
 				  "failed to map mtr%u offset %u, ret = %d.\n",
-				  i, r->offset, err);
-			return err;
+				  i, r->offset, ret);
+			return ret;
 		}
+		mapped_cnt += ret;
+		ret = 0;
 	}
 
-	return 0;
+	if (mapped_cnt < page_cnt) {
+		ret = -ENOBUFS;
+		ibdev_err(ibdev, "failed to map mtr pages count: %u < %u.\n",
+			  mapped_cnt, page_cnt);
+	}
+
+	return ret;
 }
 
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-- 
2.8.1

