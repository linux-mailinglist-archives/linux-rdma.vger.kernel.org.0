Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6549AE6C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379524AbiAYItS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:49:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36081 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1379389AbiAYIq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:46:57 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AP2jLX6KEQiex65izFE+R3pQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDv1GgqhjYEnWRJC2iGMvmMajehft92boS08UxUvJ6Gz4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkjPvVHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/UWo+6cfyfXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irlfO00qO5ELE03uwsKcDqOMUUvXQI5TXYBPApXp3FW6jM6vdYw?=
 =?us-ascii?q?T4vi8EIFvHbD+IVYDwpblLfYhlLO14SE7o/mvulgj/0dDgwgE6SoKMs8S7c1gt?=
 =?us-ascii?q?02bT/M9v9e9qWSMETlUGdzkrC8mP/KhIXLtqSzXyC6H3ErubPlDn8XoY6EqO5+?=
 =?us-ascii?q?v9jxlaUwwQ7DRcSUlC7if+ni0K/UpRULEl80jYpqIAu/UizQ8i7VBq9yFaAvxg?=
 =?us-ascii?q?BS59THvc85QWl1KXZ+UCaC3ICQzoHb8Yp3OcyRDo3xhqTk9bgLSJgvafTSn+H8?=
 =?us-ascii?q?LqQ6zSoNkA9L2ANTT0FQBMIpdLqyLzfJDqnos1LSfbz14OqX2qrhW3ikcT3vJ1?=
 =?us-ascii?q?L5eZj6klx1Quvb+qQm6X0?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AM1mtBqBypkh6C0flHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839367"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:29 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 683244D146E6;
        Tue, 25 Jan 2022 16:44:27 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:26 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:24 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 1/9] RDMA: mr: Introduce is_pmem
Date:   Tue, 25 Jan 2022 16:50:33 +0800
Message-ID: <20220125085041.49175-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 683244D146E6.AC73F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We can use it to indicate whether the registering mr is associated with
a pmem/nvdimm or not.

Currently, we only update it in rxe driver, for other device/drivers,
they should implement it if needed.

CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: check 1st byte to avoid crossing page boundary
    new scheme to check is_pmem # Dan
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 25 +++++++++++++++++++++++++
 include/rdma/ib_verbs.h            |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 453ef3c9d535..0427baea8c06 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -161,6 +161,28 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 	mr->type = IB_MR_TYPE_DMA;
 }
 
+static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
+{
+	char *vaddr;
+	int is_pmem;
+
+	/* XXX: Shall me allow length == 0 */
+	if (length == 0) {
+		return false;
+	}
+	/* check the 1st byte only to avoid crossing page boundary */
+	vaddr = iova_to_vaddr(mr, iova, 1);
+	if (!vaddr) {
+		pr_warn("not a valid iova 0x%llx\n", iova);
+		return false;
+	}
+
+	is_pmem = region_intersects(virt_to_phys(vaddr), 1, IORESOURCE_MEM,
+				    IORES_DESC_PERSISTENT_MEMORY);
+
+	return is_pmem == REGION_INTERSECTS;
+}
+
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
@@ -235,6 +257,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	set->va = start;
 	set->offset = ib_umem_offset(umem);
 
+	// iova_in_pmem() must be called after set is updated
+	mr->ibmr.is_pmem = iova_in_pmem(mr, iova, length);
+
 	return 0;
 
 err_release_umem:
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..4fa07b123c8d 100644
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



