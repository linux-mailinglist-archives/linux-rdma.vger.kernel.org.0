Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59147EBCA
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 06:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351395AbhLXFkA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 00:40:00 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7360 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351385AbhLXFkA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 00:40:00 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ayq4OHKvKOkLEZn76+mmpValrJufnVKFcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3ymNKUGvXOv/YMGP1eI11bdy2oxwBvZWBz95mSQtspCBgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?eZngoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1JtI6wS?=
 =?us-ascii?q?AUoN6vklvkfUgVDDmd1OqguFLrveCHu7ZLOnxGaG5fr67A0ZK0sBqUK6+RlEGM?=
 =?us-ascii?q?UraRAAD8IZxGHwemxxdqTW+BqhNklatvrIasbu3d93XfVAOhOaZTCRbjaoNxVx?=
 =?us-ascii?q?jE9guhQEvvEIckUczxiaFLHeRInElMWDo8u2f2kg3DXbTJVshSWqLAx7myVyxZ?=
 =?us-ascii?q?+uJDvP9X9aN2HXcgTlU/wm45s1wwVGTlDbJrGl2XDqSnq24fycerAcNp6PNWFG?=
 =?us-ascii?q?jRC2TV/HlAuNSA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ari277a1rJ/fcVETdUkDe7gqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="119465844"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Dec 2021 13:39:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1BE094D146E8;
        Fri, 24 Dec 2021 13:39:54 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Dec 2021 13:39:55 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Dec 2021 13:39:51 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanjun.zhu@linux.dev>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] RDMA/rxe: Prevent from double freeing rxe_map_set
Date:   Fri, 24 Dec 2021 13:44:46 +0800
Message-ID: <20211224054446.958913-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1BE094D146E8.AAB9D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

a same rxe_map_set could be freed twice:
rxe_reg_user_mr()
  -> rxe_mr_init_user()
    -> rxe_mr_free_map_set() # 1st
  -> rxe_drop_ref()
   ...
    -> rxe_mr_cleanup()
      -> rxe_mr_free_map_set() # 2nd

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 53271df10e47..c02385a1be55 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -65,10 +65,12 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
-static void rxe_mr_free_map_set(int num_map, struct rxe_map_set *set)
+static void rxe_mr_free_map_set(int num_map, struct rxe_map_set **setp)
 {
 	int i;
+	struct rxe_map_set *set = *setp;
 
+	*setp = NULL;
 	for (i = 0; i < num_map; i++)
 		kfree(set->map[i]);
 
@@ -140,7 +142,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
 	if (both) {
 		ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
 		if (ret) {
-			rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+			rxe_mr_free_map_set(mr->num_map, &mr->cur_map_set);
 			goto err_out;
 		}
 	}
@@ -238,7 +240,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	return 0;
 
 err_cleanup_map:
-	rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+	rxe_mr_free_map_set(mr->num_map, &mr->cur_map_set);
 err_release_umem:
 	ib_umem_release(umem);
 err_out:
@@ -706,8 +708,8 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 	ib_umem_release(mr->umem);
 
 	if (mr->cur_map_set)
-		rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+		rxe_mr_free_map_set(mr->num_map, &mr->cur_map_set);
 
 	if (mr->next_map_set)
-		rxe_mr_free_map_set(mr->num_map, mr->next_map_set);
+		rxe_mr_free_map_set(mr->num_map, &mr->next_map_set);
 }
-- 
2.31.1



