Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8521DB5B1
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETNyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:54:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbgETNyA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:54:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FC35E7D4CEA759B9753;
        Wed, 20 May 2020 21:53:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Optimize the usage of MTR
Date:   Wed, 20 May 2020 21:53:19 +0800
Message-ID: <1589982799-28728-10-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Currently, the MTR region is configed before hns_roce_mtr_map() is invoked,
but in some scenarios, the region is configed at MTR creation, the caller
need to store this config and call hns_roce_mtr_map() later. So optimize
the usage by wrapping the MTR region config into MTR.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 54 +++++++++++++++--------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e6eb85c..e33ece5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -355,6 +355,8 @@ struct hns_roce_mtr {
 		unsigned int	ba_pg_shift; /* BA table page shift */
 		unsigned int	buf_pg_shift; /* buffer page shift */
 		int		buf_pg_count;  /* buffer page count */
+		struct hns_roce_buf_region region[HNS_ROCE_MAX_BT_REGION];
+		unsigned int	region_count;
 	} hem_cfg; /* config for hardware addressing */
 };
 
@@ -1138,7 +1140,6 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_mtr *mtr);
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     struct hns_roce_buf_region *regions, int region_cnt,
 		     dma_addr_t *pages, int page_cnt);
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index e0f5f55..a62da7a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -481,7 +481,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
-	struct hns_roce_buf_region region = {};
+	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
 	int ret = 0;
 
 	mr->npages = 0;
@@ -497,11 +497,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		goto err_page_list;
 	}
 
-	region.offset = 0;
-	region.count = mr->npages;
-	region.hopnum = mr->pbl_hop_num;
-	ret = hns_roce_mtr_map(hr_dev, &mr->pbl_mtr, &region, 1, mr->page_list,
-			       mr->npages);
+	mtr->hem_cfg.region[0].offset = 0;
+	mtr->hem_cfg.region[0].count = mr->npages;
+	mtr->hem_cfg.region[0].hopnum = mr->pbl_hop_num;
+	mtr->hem_cfg.region_count = 1;
+	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
 	if (ret) {
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
 		ret = 0;
@@ -861,7 +861,6 @@ static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     struct hns_roce_buf_region *regions, int region_cnt,
 		     dma_addr_t *pages, int page_cnt)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
@@ -869,8 +868,8 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	int err;
 	int i;
 
-	for (i = 0; i < region_cnt; i++) {
-		r = &regions[i];
+	for (i = 0; i < mtr->hem_cfg.region_count; i++) {
+		r = &mtr->hem_cfg.region[i];
 		if (r->offset + r->count > page_cnt) {
 			err = -EINVAL;
 			ibdev_err(ibdev,
@@ -943,15 +942,16 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 /* convert buffer size to page index and page count */
-static int mtr_init_region(struct hns_roce_buf_attr *attr, int page_cnt,
-			   struct hns_roce_buf_region *regions, int region_cnt,
-			   unsigned int page_shift)
+static unsigned int mtr_init_region(struct hns_roce_buf_attr *attr,
+				    int page_cnt,
+				    struct hns_roce_buf_region *regions,
+				    int region_cnt, unsigned int page_shift)
 {
 	unsigned int page_size = 1 << page_shift;
 	int max_region = attr->region_count;
 	struct hns_roce_buf_region *r;
+	unsigned int i = 0;
 	int page_idx = 0;
-	int i = 0;
 
 	for (; i < region_cnt && i < max_region && page_idx < page_cnt; i++) {
 		r = &regions[i];
@@ -980,7 +980,6 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			unsigned int page_shift, struct ib_udata *udata,
 			unsigned long user_addr)
 {
-	struct hns_roce_buf_region regions[HNS_ROCE_MAX_BT_REGION] = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	dma_addr_t *pages = NULL;
 	int region_cnt = 0;
@@ -1012,18 +1011,22 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	hns_roce_hem_list_init(&mtr->hem_list);
 	mtr->hem_cfg.is_direct = !has_mtt;
 	mtr->hem_cfg.ba_pg_shift = page_shift;
+	mtr->hem_cfg.region_count = 0;
+	region_cnt = mtr_init_region(buf_attr, all_pg_cnt,
+				     mtr->hem_cfg.region,
+				     ARRAY_SIZE(mtr->hem_cfg.region),
+				     mtr->hem_cfg.buf_pg_shift);
+	if (region_cnt < 1) {
+		err = -ENOBUFS;
+		ibdev_err(ibdev, "failed to init mtr region %d\n", region_cnt);
+		goto err_alloc_bufs;
+	}
+
+	mtr->hem_cfg.region_count = region_cnt;
+
 	if (has_mtt) {
-		region_cnt = mtr_init_region(buf_attr, all_pg_cnt,
-					     regions, ARRAY_SIZE(regions),
-					     mtr->hem_cfg.buf_pg_shift);
-		if (region_cnt < 1) {
-			err = -ENOBUFS;
-			ibdev_err(ibdev, "Failed to init mtr region %d\n",
-				  region_cnt);
-			goto err_alloc_bufs;
-		}
 		err = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
-						regions, region_cnt,
+						mtr->hem_cfg.region, region_cnt,
 						page_shift);
 		if (err) {
 			ibdev_err(ibdev, "Failed to request mtr hem, err %d\n",
@@ -1059,8 +1062,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtr->hem_cfg.root_ba = pages[0];
 	} else {
 		/* write buffer's dma address to BA table */
-		err = hns_roce_mtr_map(hr_dev, mtr, regions, region_cnt, pages,
-				       all_pg_cnt);
+		err = hns_roce_mtr_map(hr_dev, mtr, pages, all_pg_cnt);
 		if (err) {
 			ibdev_err(ibdev, "Failed to map mtr pages, err %d\n",
 				  err);
-- 
2.8.1

