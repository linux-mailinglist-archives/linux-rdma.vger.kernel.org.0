Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9194D987A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiCOKOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiCOKOR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:17 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79F946173;
        Tue, 15 Mar 2022 03:13:04 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AtRSjFqkBDuL/XMJ+DwpEVxjo5gyOJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzdUzTQbD2uEOvyOZTOkLd5+Ptvk90IB6pDUm9QyTQBr+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZzNRftZ2yS?=
 =?us-ascii?q?A4vFqPRmuUBSAQeGCZ7VUFD0Oadeybj4ZXLkyUqdFOpmZ2CFnoeJ5UV8/xsBmd?=
 =?us-ascii?q?O7fEwJzUEbxTFjOWzqJqpW+t+l8Z5dJGzFIwas3BkizreCJ4ORZHKRarV6NlA0?=
 =?us-ascii?q?TE/rsBTFOnTZowSbj8HRBjJZVtNfEgWDJY/leKzrnj5bzBc7lmSoMIf/2/WxRd?=
 =?us-ascii?q?jlrf3N9/cds6JRO1UmFqVoiTN+GGRKhUXM9q3yjef9H+owOjVkkvTUYIbDrq+8?=
 =?us-ascii?q?tZsnlyfx2VVAxoTPXO+q/2+gU6WXcxeJ00dvCEpqMAa6EuuZsX0WwW1sTiPuRt?=
 =?us-ascii?q?0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC/luImc75QCZjtbS9V32Q7?=
 =?us-ascii?q?PGXoCm0NCxTKnUNDQcGQgQt8djuuIx1hRunczrJOMZZlfWsQXepnW/M93N42t0?=
 =?us-ascii?q?uYQcw//3T1Tj6b/iE//AlljII2zg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ad/6iVq/MPezAO+fXgz5uk+C2I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY1TiX2rayTdZggviMc6wx+ZJhDo7+90cC7KBvhHPVOjLX5U43JYDXb?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648104"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:03 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 6930B4D16FD8;
        Tue, 15 Mar 2022 18:13:02 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:02 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:04 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:13:00 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 2/7] RDMA/rxe: Allow registering persistent flag for pmem MR only
Date:   Tue, 15 Mar 2022 18:18:40 +0800
Message-ID: <20220315101845.4166983-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6930B4D16FD8.AFDAF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Memory region could at most support 2 placement types:
IB_ACCESS_FLUSH_PERSISTENT and IB_ACCESS_FLUSH_GLOBAL_VISIBILITY

But we only allow user to register persistence flush to non-pmem MR.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: combine [RFC PATCH v2 1/9] RDMA: mr: Introduce is_pmem
V2: update commit message, get rid of confusing ib_check_flush_access_flags() # Tom
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 453ef3c9d535..4f5c4af19fe0 100644
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
@@ -235,6 +257,16 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	set->va = start;
 	set->offset = ib_umem_offset(umem);
 
+	// iova_in_pmem() must be called after set is updated
+	if (!iova_in_pmem(mr, iova, length) &&
+	    access & IB_ACCESS_FLUSH_PERSISTENT) {
+		pr_warn("Cannot register IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
+		mr->state = RXE_MR_STATE_INVALID;
+		mr->umem = NULL;
+		err = -EINVAL;
+		goto err_release_umem;
+	}
+
 	return 0;
 
 err_release_umem:
-- 
2.31.1



