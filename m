Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59417B4A4
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2020 03:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCFCsn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 21:48:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbgCFCsn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 21:48:43 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E20E3C1897AC1FA2CD2;
        Fri,  6 Mar 2020 10:48:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 10:48:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 4/5] RDMA/hns: Optimize base address table config flow for qp buffer
Date:   Fri, 6 Mar 2020 10:44:53 +0800
Message-ID: <1583462694-43908-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583462694-43908-1-git-send-email-liweihang@huawei.com>
References: <1583462694-43908-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Currently, before the qp is created, a page size needs to be calculated for
the base address table to store all base addresses in the mtr. As a result,
the parameter configuration of the mtr is complex. So integrate the process
of calculating the base table page size into the hem related interface to
simplify the process of using mtr.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ---
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 16 +++++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 42 +++++++----------------------
 3 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b6ae12d..f6b3cf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -669,10 +669,6 @@ struct hns_roce_qp {
 	struct ib_umem		*umem;
 	struct hns_roce_mtt	mtt;
 	struct hns_roce_mtr	mtr;
-
-	/* this define must less than HNS_ROCE_MAX_BT_REGION */
-#define HNS_ROCE_WQE_REGION_MAX	 3
-	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX];
 	int                     wqe_bt_pg_shift;
 
 	u32			buff_size;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index e822157..8380d71 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1383,6 +1383,7 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	void *cpu_base;
 	u64 phy_base;
 	int ret = 0;
+	int ba_num;
 	int offset;
 	int total;
 	int step;
@@ -1393,12 +1394,16 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	if (root_hem)
 		return 0;
 
+	ba_num = hns_roce_hem_list_calc_root_ba(regions, region_cnt, unit);
+	if (ba_num < 1)
+		return -ENOMEM;
+
 	INIT_LIST_HEAD(&temp_root);
-	total = r->offset;
+	offset = r->offset;
 	/* indicate to last region */
 	r = &regions[region_cnt - 1];
-	root_hem = hem_list_alloc_item(hr_dev, total, r->offset + r->count - 1,
-				       unit, true, 0);
+	root_hem = hem_list_alloc_item(hr_dev, offset, r->offset + r->count - 1,
+				       ba_num, true, 0);
 	if (!root_hem)
 		return -ENOMEM;
 	list_add(&root_hem->list, &temp_root);
@@ -1410,7 +1415,7 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 		INIT_LIST_HEAD(&temp_list[i]);
 
 	total = 0;
-	for (i = 0; i < region_cnt && total < unit; i++) {
+	for (i = 0; i < region_cnt && total < ba_num; i++) {
 		r = &regions[i];
 		if (!r->count)
 			continue;
@@ -1443,7 +1448,8 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 			/* if exist mid bt, link L1 to L0 */
 			list_for_each_entry_safe(hem, temp_hem,
 					  &hem_list->mid_bt[i][1], list) {
-				offset = hem->start / step * BA_BYTE_LEN;
+				offset = (hem->start - r->offset) / step *
+					  BA_BYTE_LEN;
 				hem_list_link_bt(hr_dev, cpu_base + offset,
 						 hem->dma_addr);
 				total++;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c2ea489..1c5de2b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -579,30 +579,6 @@ static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
 	return region_cnt;
 }
 
-static int calc_wqe_bt_page_shift(struct hns_roce_dev *hr_dev,
-				  struct hns_roce_buf_region *regions,
-				  int region_cnt)
-{
-	int bt_pg_shift;
-	int ba_num;
-	int ret;
-
-	bt_pg_shift = PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz;
-
-	/* all root ba entries must in one bt page */
-	do {
-		ba_num = (1 << bt_pg_shift) / BA_BYTE_LEN;
-		ret = hns_roce_hem_list_calc_root_ba(regions, region_cnt,
-						     ba_num);
-		if (ret <= ba_num)
-			break;
-
-		bt_pg_shift++;
-	} while (ret > ba_num);
-
-	return bt_pg_shift - PAGE_SHIFT;
-}
-
 static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
 				struct hns_roce_qp *hr_qp)
 {
@@ -768,7 +744,10 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		       u32 page_shift, bool is_user)
 {
-	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
+/* WQE buffer include 3 parts: SQ, extend SGE and RQ. */
+#define HNS_ROCE_WQE_REGION_MAX	 3
+	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX] = {};
+	dma_addr_t *buf_list[HNS_ROCE_WQE_REGION_MAX] = { NULL };
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_region *r;
 	int region_count;
@@ -776,18 +755,18 @@ static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	int ret;
 	int i;
 
-	region_count = split_wqe_buf_region(hr_dev, hr_qp, hr_qp->regions,
-					ARRAY_SIZE(hr_qp->regions), page_shift);
+	region_count = split_wqe_buf_region(hr_dev, hr_qp, regions,
+					    ARRAY_SIZE(regions), page_shift);
 
 	/* alloc a tmp list to store WQE buffers address */
-	ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list, region_count);
+	ret = hns_roce_alloc_buf_list(regions, buf_list, region_count);
 	if (ret) {
 		ibdev_err(ibdev, "Failed to alloc WQE buffer list\n");
 		return ret;
 	}
 
 	for (i = 0; i < region_count; i++) {
-		r = &hr_qp->regions[i];
+		r = &regions[i];
 		if (is_user)
 			buf_count = hns_roce_get_umem_bufs(hr_dev, buf_list[i],
 					r->count, r->offset, hr_qp->umem,
@@ -805,11 +784,10 @@ static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		}
 	}
 
-	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
-							region_count);
+	hr_qp->wqe_bt_pg_shift = hr_dev->caps.mtt_ba_pg_sz;
 	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
 			  page_shift);
-	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list, hr_qp->regions,
+	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list, regions,
 				  region_count);
 	if (ret)
 		ibdev_err(ibdev, "Failed to attach WQE's mtr\n");
-- 
2.8.1

