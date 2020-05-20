Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF831DB5AF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgETNxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbgETNxw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 799A9B5C8FD6D5A0034B;
        Wed, 20 May 2020 21:53:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/9] RDMA/hns: Change all page_shift to unsigned
Date:   Wed, 20 May 2020 21:53:16 +0800
Message-ID: <1589982799-28728-7-git-send-email-liweihang@huawei.com>
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

page_shift is used to calculate the page size, it's always non-negative,
and should be in type of unsigned.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h | 25 +++++++++++++------------
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 20 +++++++++++---------
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 365e7db..9bb3f30 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -254,7 +254,7 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 
 int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, int start, struct ib_umem *umem,
-			   int page_shift)
+			   unsigned int page_shift)
 {
 	struct ib_block_iter biter;
 	int total = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 06bafa1..e7622bf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -338,7 +338,7 @@ struct hns_roce_buf_attr {
 		int	hopnum; /* multi-hop addressing hop num */
 	} region[HNS_ROCE_MAX_BT_REGION];
 	int region_count; /* valid region count */
-	int page_shift;  /* buffer page shift */
+	unsigned int page_shift;  /* buffer page shift */
 	bool fixed_page; /* decide page shift is fixed-size or maximum size */
 	int user_access; /* umem access flag */
 	bool mtt_only; /* only alloc buffer-required MTT memory */
@@ -347,14 +347,14 @@ struct hns_roce_buf_attr {
 /* memory translate region */
 struct hns_roce_mtr {
 	struct hns_roce_hem_list hem_list; /* multi-hop addressing resource */
-	struct ib_umem		 *umem; /* user space buffer */
-	struct hns_roce_buf	 *kmem; /* kernel space buffer */
+	struct ib_umem		*umem; /* user space buffer */
+	struct hns_roce_buf	*kmem; /* kernel space buffer */
 	struct {
-		dma_addr_t	 root_ba; /* root BA table's address */
-		bool		 is_direct; /* addressing without BA table */
-		int		 ba_pg_shift; /* BA table page shift */
-		int		 buf_pg_shift; /* buffer page shift */
-		int		 buf_pg_count;  /* buffer page count */
+		dma_addr_t	root_ba; /* root BA table's address */
+		bool		is_direct; /* addressing without BA table */
+		unsigned int	ba_pg_shift; /* BA table page shift */
+		unsigned int	buf_pg_shift; /* buffer page shift */
+		int		buf_pg_count;  /* buffer page count */
 	} hem_cfg; /* config for hardware addressing */
 };
 
@@ -419,7 +419,7 @@ struct hns_roce_buf {
 	struct hns_roce_buf_list	*page_list;
 	u32				npages;
 	u32				size;
-	int				page_shift;
+	unsigned int			page_shift;
 };
 
 struct hns_roce_db_pgdir {
@@ -1132,8 +1132,9 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev);
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
 int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			struct hns_roce_buf_attr *buf_attr, int page_shift,
-			struct ib_udata *udata, unsigned long user_addr);
+			struct hns_roce_buf_attr *buf_attr,
+			unsigned int page_shift, struct ib_udata *udata,
+			unsigned long user_addr);
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_mtr *mtr);
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
@@ -1203,7 +1204,7 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, int start, struct hns_roce_buf *buf);
 int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, int start, struct ib_umem *umem,
-			   int page_shift);
+			   unsigned int page_shift);
 
 int hns_roce_create_srq(struct ib_srq *srq,
 			struct ib_srq_init_attr *srq_init_attr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 37d101e..c8db6f8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1400,7 +1400,7 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
 			      const struct hns_roce_buf_region *regions,
-			      int region_cnt, int bt_pg_shift)
+			      int region_cnt, unsigned int bt_pg_shift)
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 1fa0bdc..b34c940 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -133,7 +133,7 @@ int hns_roce_hem_list_calc_root_ba(const struct hns_roce_buf_region *regions,
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
 			      const struct hns_roce_buf_region *regions,
-			      int region_cnt, int bt_pg_shift);
+			      int region_cnt, unsigned int bt_pg_shift);
 void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_list *hem_list);
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index ecd7675..e0f5f55 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -704,7 +704,8 @@ static inline size_t mtr_bufs_size(struct hns_roce_buf_attr *attr)
 	return size;
 }
 
-static inline int mtr_umem_page_count(struct ib_umem *umem, int page_shift)
+static inline int mtr_umem_page_count(struct ib_umem *umem,
+				      unsigned int page_shift)
 {
 	int count = ib_umem_page_count(umem);
 
@@ -717,7 +718,7 @@ static inline int mtr_umem_page_count(struct ib_umem *umem, int page_shift)
 }
 
 static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_size,
-					  int page_shift)
+					  unsigned int page_shift)
 {
 	if (is_direct)
 		return ALIGN(alloc_size, 1 << page_shift);
@@ -730,7 +731,7 @@ static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_size,
  * Returns 0 on success, or the error page num.
  */
 static inline int mtr_check_direct_pages(dma_addr_t *pages, int page_count,
-					 int page_shift)
+					 unsigned int page_shift)
 {
 	size_t page_size = 1 << page_shift;
 	int i;
@@ -763,8 +764,8 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			  struct ib_udata *udata, unsigned long user_addr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	int max_pg_shift = buf_attr->page_shift;
-	int best_pg_shift = 0;
+	unsigned int max_pg_shift = buf_attr->page_shift;
+	unsigned int best_pg_shift = 0;
 	int all_pg_count = 0;
 	size_t direct_size;
 	size_t total_size;
@@ -834,7 +835,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			 dma_addr_t *pages, int count, int page_shift)
+			 dma_addr_t *pages, int count, unsigned int page_shift)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int npage;
@@ -944,7 +945,7 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 /* convert buffer size to page index and page count */
 static int mtr_init_region(struct hns_roce_buf_attr *attr, int page_cnt,
 			   struct hns_roce_buf_region *regions, int region_cnt,
-			   int page_shift)
+			   unsigned int page_shift)
 {
 	unsigned int page_size = 1 << page_shift;
 	int max_region = attr->region_count;
@@ -975,8 +976,9 @@ static int mtr_init_region(struct hns_roce_buf_attr *attr, int page_cnt,
  * @buf_alloced: mtr has private buffer, true means need to alloc
  */
 int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			struct hns_roce_buf_attr *buf_attr, int page_shift,
-			struct ib_udata *udata, unsigned long user_addr)
+			struct hns_roce_buf_attr *buf_attr,
+			unsigned int page_shift, struct ib_udata *udata,
+			unsigned long user_addr)
 {
 	struct hns_roce_buf_region regions[HNS_ROCE_MAX_BT_REGION] = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-- 
2.8.1

