Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643E1480729
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhL1ICW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47591 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235478AbhL1ICT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:19 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AhCRgkqJPaLKhLizxFE+Rj5QlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCxgjMh0DRSzWEdDWmOOK2DYDSnf4h+a4y0oB9SusLXx4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yAlj/vYHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPwYpeCbeSfXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irlfO00qO5ELE03uwsKcDqOMUUvXQI5TXYBPApXp3FW6jM6vdYw?=
 =?us-ascii?q?T4vi8EIFvHbD+IdaCVibRTJZRJnOkoeF58/2uyvgxHXdzBfrnqWqLAx7myVyxZ?=
 =?us-ascii?q?+uJDkMNPPfdqObcNLn0qZryTN+GGRKhQQMNuUyRKD7HOgh+aJliT+MKoWFbul5?=
 =?us-ascii?q?rtpjUeVy2g7FhIbTx24rOO/h0r4XMhQQ2QQ+ywzve0o+EmiZsfyUgf+o3OeuBM?=
 =?us-ascii?q?YHd1KHIUS6g6C4rjV7h6UQGMNJgOtwvROWNQeHGRsjwHW2YiyQ2EHjVFcclrFn?=
 =?us-ascii?q?p/8kN94EXFORYPaWRI5cA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACvgY86xaWGnT48rM8r8SKrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZImPH7P+U8ssR4b+exoVJPtfZqYz+8R3WBzB8bEYOCFgh?=
 =?us-ascii?q?rKEGgK1+KLqFeMJ8S9zJ846U4KSclD4bPLYmSS9fyKgjVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657407"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 70B9C4D15A26;
        Tue, 28 Dec 2021 16:01:50 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:51 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:47 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering persistent flag for pmem MR only
Date:   Tue, 28 Dec 2021 16:07:12 +0800
Message-ID: <20211228080717.10666-6-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 70B9C4D15A26.AF226
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Memory region should support 2 placement types: IB_ACCESS_FLUSH_PERSISTENT
and IB_ACCESS_FLUSH_GLOBAL_VISIBILITY, and only pmem/nvdimm has ability to
persist data(IB_ACCESS_FLUSH_PERSISTENT).

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bcd5e7afa475..21616d058f29 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -206,6 +206,11 @@ static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
 	return page_in_dev_pagemap(page);
 }
 
+static bool ib_check_flush_access_flags(struct ib_mr *mr, u32 flags)
+{
+	return mr->is_pmem || !(flags & IB_ACCESS_FLUSH_PERSISTENT);
+}
+
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
@@ -282,6 +287,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	// iova_in_pmem must be called after set is updated
 	mr->ibmr.is_pmem = iova_in_pmem(mr, iova, length);
+	if (!ib_check_flush_access_flags(&mr->ibmr, access)) {
+		pr_err("Cannot set IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
+		mr->state = RXE_MR_STATE_INVALID;
+		mr->umem = NULL;
+		err = -EINVAL;
+		goto err_release_umem;
+	}
 
 	return 0;
 
-- 
2.31.1



