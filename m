Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045E6630DA5
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKSJCQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Nov 2022 04:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKSJCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Nov 2022 04:02:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57880999
        for <linux-rdma@vger.kernel.org>; Sat, 19 Nov 2022 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668848535; x=1700384535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VthC0u1TdpVjTwgEBLSpZMpSyWc0rij8qGfQTsNmZAk=;
  b=SilVO4hEIHWz2xphm2UNUGeVN+qxn8ZildHUl8GdFkGUKH1SXb7DDkAi
   Df6ujKoiN4/IiWpH/QBSZbIB46zK69b616HkF2Ov26aI/3lZ/Fk042E18
   LvPW0Ih6XqZ9chyUlubyD2LyFSQzTRxjP5NC7U3TztxLrKnbso7gU3cWC
   ohlACn1HaDZLDWueKzw9CEoBtS38ZriNJbOUHqdATF+wk31urm2skfcgm
   p9lDFzB2fcRvVljh2EBgljP+0VjntzM6UF/+ggTIuN+KrHLba9grVY0Kb
   yhHzIdXB6ghU2cY0DhsE5wb46PXPfmHruBWtuB8v7ETWTmKR6Zo37Pnl3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313333135"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="313333135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 01:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746288995"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="746288995"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2022 01:02:13 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     yanjun.zhu@intel.com, zyjzyj2000@gmail.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is not highmem
Date:   Sat, 19 Nov 2022 20:29:38 -0500
Message-Id: <20221120012939.539953-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In ib_umem_get, sgt_append is allocated from the function
sg_alloc_append_table_from_pages. And it is not from highmem.

As such, the return value of page_address will not be NULL.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b1423000e4bc..3f33a4cdef24 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -119,7 +119,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	struct ib_umem		*umem;
 	struct sg_page_iter	sg_iter;
 	int			num_buf;
-	void			*vaddr;
 	int err;
 
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
@@ -149,6 +148,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		buf = map[0]->buf;
 
 		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
+			void *vaddr;
+
 			if (num_buf >= RXE_BUF_PER_MAP) {
 				map++;
 				buf = map[0]->buf;
@@ -156,16 +157,10 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 			}
 
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
-			if (!vaddr) {
-				rxe_dbg_mr(mr, "Unable to get virtual address\n");
-				err = -ENOMEM;
-				goto err_release_umem;
-			}
 			buf->addr = (uintptr_t)vaddr;
 			buf->size = PAGE_SIZE;
 			num_buf++;
 			buf++;
-
 		}
 	}
 
-- 
2.27.0

