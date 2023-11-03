Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07D7E0119
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbjKCJ41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347655AbjKCJ4S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:56:18 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6D10C4;
        Fri,  3 Nov 2023 02:56:04 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="138283629"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="138283629"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:02 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C0533D6186;
        Fri,  3 Nov 2023 18:55:59 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C0FEC4A00;
        Fri,  3 Nov 2023 18:55:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8905F2005019A;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id E97941A0072;
        Fri,  3 Nov 2023 17:55:57 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 5/6] RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
Date:   Fri,  3 Nov 2023 17:55:48 +0800
Message-ID: <20231103095549.490744-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--2.085100-10.000000
X-TMASE-MatchedRID: 4vuDYoAhWgkEAXVIFoPmpMfIK2dgWYWGCZa9cSpBObnAuQ0xDMaXkH4q
        tYI9sRE/lTJXKqh1ne2XNWQa4uM6kJcFdomgH0lnFEUknJ/kEl5lVdRvgpNpe/oLR4+zsDTtuVf
        c976pNypHlescvaZnOWnt3jHkT+4bhPISvaLQ542U/6gnt9otdY9p61D8mgeNW27Gp3VFEiCpMY
        9k1M7dHstkdSYjBYPP5H+vESxOZUGGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This 2 elements were believed to be designed for extracting address
from the page_list before. But now we use PAGE_SIZE and PAGE_SHIFT
directly, so we can drop it.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 4 ----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d39c02f0c51e..a038133e1322 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -59,8 +59,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 
 	mr->access = access;
 	mr->ibmr.page_size = PAGE_SIZE;
-	mr->page_mask = PAGE_MASK;
-	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
 }
 
@@ -230,8 +228,6 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	}
 
 	mr->nbuf = 0;
-	mr->page_shift = PAGE_SHIFT;
-	mr->page_mask = PAGE_MASK;
 
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccc75f8c0985..ef813560b0ab 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -309,9 +309,6 @@ struct rxe_mr {
 	int			access;
 	atomic_t		num_mw;
 
-	unsigned int		page_shift;
-	u64			page_mask;
-
 	u32			num_buf;
 	u32			nbuf;
 
-- 
2.41.0

