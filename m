Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B5480732
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhL1IC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:29 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235528AbhL1ICZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:25 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AWxc+CqrtKQLbHi8b6Xft34jZtSxeBmJGZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmQdWGiEOKzYYmakLt91bNyx9UtVupGDzNZlQVRl+3s9QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUbe?=
 =?us-ascii?q?eYHApHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlsZ2iS?=
 =?us-ascii?q?QYrP6TKsOoAURhECDw4NqpDkFPCCSHm4JLOkBGfKhMAxN0rVinaJ7Yw4P56CHt?=
 =?us-ascii?q?V8voYMD0lYRWKhubwy7W+IsF+l8YxPcuxZNtHkn5lxDDdS/0hRPjrR6TD49BH0?=
 =?us-ascii?q?TEoi8ZBNfbDbtUUaHxkaxGoSxlOJVoWCJs4k8+om3Dgfjweo1WQzYIz7m/V5A9?=
 =?us-ascii?q?8yr7gNJzSYNPibcxVl1yfoGbu+Xr4DhATcteYzFKt93iogeTPtSXlWY4THfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTR4bT122pdGnhUOkHdFSMUoZ/mwpt6da3EiqSMTtGge0pXesoBE?=
 =?us-ascii?q?RQZxTHvc85QXLzbDbiy6bCWcsXD9McNFgv8ZeeNCA/jdlhPuwXXo27uLTEinbq?=
 =?us-ascii?q?9+pQfqJEXB9BQc/ieUsFFBtDwHfnbwO?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Addz9L65rcqxeHRTzVwPXwCzXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiX+rbHJoB17726MtN9/YhEdcLy7VJVoBEmskKKdgrNhWotKPjOW21?=
 =?us-ascii?q?dARbsKheCJrgEIWReOktK1vp0AT0ERMrLN5CBB/KTHCReDYqsd6ejC4Ka1nv3f?=
 =?us-ascii?q?0nsoaQlrbptr5wB/Bh3zKDwMeCB2QYo+CIGH5tdK4x6peXEsZMy9AXUfG8fZod?=
 =?us-ascii?q?mjruOdXTc2Qw4g9BKVjS6lrJrzEx2j1B8YVD9VhZcOmFK16zDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657411"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 193974D15A21;
        Tue, 28 Dec 2021 16:01:47 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:48 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:44 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Date:   Tue, 28 Dec 2021 16:07:08 +0800
Message-ID: <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 193974D15A21.AE5CF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We can use it to indicate whether the registering mr is associated with
a pmem/nvdimm or not.

Currently, we only assign it in rxe driver, for other device/drivers,
they should implement it if needed.

RDMA FLUSH will support the persistence feature for a pmem/nvdimm.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 47 ++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h            |  1 +
 2 files changed, 48 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 7c4cd19a9db2..bcd5e7afa475 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -162,6 +162,50 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 	mr->type = IB_MR_TYPE_DMA;
 }
 
+// XXX: the logic is similar with mm/memory-failure.c
+static bool page_in_dev_pagemap(struct page *page)
+{
+	unsigned long pfn;
+	struct page *p;
+	struct dev_pagemap *pgmap = NULL;
+
+	pfn = page_to_pfn(page);
+	if (!pfn) {
+		pr_err("no such pfn for page %p\n", page);
+		return false;
+	}
+
+	p = pfn_to_online_page(pfn);
+	if (!p) {
+		if (pfn_valid(pfn)) {
+			pgmap = get_dev_pagemap(pfn, NULL);
+			if (pgmap)
+				put_dev_pagemap(pgmap);
+		}
+	}
+
+	return !!pgmap;
+}
+
+static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
+{
+	struct page *page = NULL;
+	char *vaddr = iova_to_vaddr(mr, iova, length);
+
+	if (!vaddr) {
+		pr_err("not a valid iova %llu\n", iova);
+		return false;
+	}
+
+	page = virt_to_page(vaddr);
+	if (!page) {
+		pr_err("no such page for vaddr %p\n", vaddr);
+		return false;
+	}
+
+	return page_in_dev_pagemap(page);
+}
+
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
@@ -236,6 +280,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	set->va = start;
 	set->offset = ib_umem_offset(umem);
 
+	// iova_in_pmem must be called after set is updated
+	mr->ibmr.is_pmem = iova_in_pmem(mr, iova, length);
+
 	return 0;
 
 err_release_umem:
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6e9ad656ecb7..822ebb3425dc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1807,6 +1807,7 @@ struct ib_mr {
 	unsigned int	   page_size;
 	enum ib_mr_type	   type;
 	bool		   need_inval;
+	bool		   is_pmem;
 	union {
 		struct ib_uobject	*uobject;	/* user */
 		struct list_head	qp_entry;	/* FR */
-- 
2.31.1



