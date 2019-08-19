Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CF92201
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfHSLRm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfHSLRm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:42 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930C92085A;
        Mon, 19 Aug 2019 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213461;
        bh=vUSq7At/buDxBEhtzuI23PB4aCcxeJoTvKnZcb92QZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZi5j25CKr/i2QuRTpv+pHkW3c7f1CTpzb9uHa1QDWgZ82QWWNCRbQDv9F7ZVvG1Y
         rRDT37v5Ad/bgjMFlpA0uIbQQMKb4lHBOL2KYpqW8Jil5ULWY5wFkUJSqenTf8u+GP
         Lj9h3UjUodiuB0Jz388/oNzScanSivF4nvbzu1wY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 08/12] RDMA/odp: Check for overflow when computing the umem_odp end
Date:   Mon, 19 Aug 2019 14:17:06 +0300
Message-Id: <20190819111710.18440-9-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Since the page size can be extended in the ODP case by IB_ACCESS_HUGETLB
the existing overflow checks done by ib_umem_get() are not
sufficient. Check for overflow again.

Further, remove the unchecked math from the inlines and just use the
precomputed value stored in the interval_tree_node.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 25 +++++++++++++++++++------
 include/rdma/ib_umem_odp.h         |  5 ++---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2575dd783196..46ae9962fae3 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -294,19 +294,32 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 	umem_odp->umem.is_odp = 1;
 	if (!umem_odp->is_implicit_odp) {
-		size_t pages = ib_umem_odp_num_pages(umem_odp);
-
+		size_t page_size = 1UL << umem_odp->page_shift;
+		size_t pages;
+
+		umem_odp->interval_tree.start =
+			ALIGN_DOWN(umem_odp->umem.address, page_size);
+		if (check_add_overflow(umem_odp->umem.address,
+				       umem_odp->umem.length,
+				       &umem_odp->interval_tree.last))
+			return -EOVERFLOW;
+		umem_odp->interval_tree.last =
+			ALIGN(umem_odp->interval_tree.last, page_size);
+		if (unlikely(umem_odp->interval_tree.last < page_size))
+			return -EOVERFLOW;
+
+		pages = (umem_odp->interval_tree.last -
+			 umem_odp->interval_tree.start) >>
+			umem_odp->page_shift;
 		if (!pages)
 			return -EINVAL;
 
 		/*
 		 * Note that the representation of the intervals in the
 		 * interval tree considers the ending point as contained in
-		 * the interval, while the function ib_umem_end returns the
-		 * first address which is not contained in the umem.
+		 * the interval.
 		 */
-		umem_odp->interval_tree.start = ib_umem_start(umem_odp);
-		umem_odp->interval_tree.last = ib_umem_end(umem_odp) - 1;
+		umem_odp->interval_tree.last--;
 
 		umem_odp->page_list = vzalloc(
 			array_size(sizeof(*umem_odp->page_list), pages));
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 5efb67f97b0a..b37c674b7fe6 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -91,14 +91,13 @@ static inline struct ib_umem_odp *to_ib_umem_odp(struct ib_umem *umem)
 /* Returns the first page of an ODP umem. */
 static inline unsigned long ib_umem_start(struct ib_umem_odp *umem_odp)
 {
-	return ALIGN_DOWN(umem_odp->umem.address, 1UL << umem_odp->page_shift);
+	return umem_odp->interval_tree.start;
 }
 
 /* Returns the address of the page after the last one of an ODP umem. */
 static inline unsigned long ib_umem_end(struct ib_umem_odp *umem_odp)
 {
-	return ALIGN(umem_odp->umem.address + umem_odp->umem.length,
-		     1UL << umem_odp->page_shift);
+	return umem_odp->interval_tree.last + 1;
 }
 
 static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
-- 
2.20.1

