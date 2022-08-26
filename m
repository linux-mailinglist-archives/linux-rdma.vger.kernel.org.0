Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F05A2492
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbiHZJgz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiHZJgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 05:36:47 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 02:36:44 PDT
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463AE8E9A5
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:36:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="74217555"
X-IronPort-AV: E=Sophos;i="5.93,264,1654527600"; 
   d="scan'208";a="74217555"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 26 Aug 2022 18:35:37 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2751ACC147
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 18:35:36 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 51B62D765C
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 18:35:35 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 1EEB3200B3B8;
        Fri, 26 Aug 2022 18:35:35 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove an unused member from struct rxe_mr
Date:   Fri, 26 Aug 2022 18:34:53 +0900
Message-Id: <20220826093453.854991-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 1e75550648da ("Revert "RDMA/rxe: Create duplicate mapping tables for
FMRs"") brought back the member 'va' to struct rxe_mr. However, it is
actually used by nobody and thus can be removed.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 850b80f5ad8b..814116ec4778 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -180,7 +180,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->access = access;
 	mr->length = length;
 	mr->iova = iova;
-	mr->va = start;
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_USER;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e264cf69bf55..9ebe9decad34 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1007,7 +1007,6 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 
 	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
 
-	mr->va = ibmr->iova;
 	mr->iova = ibmr->iova;
 	mr->length = ibmr->length;
 	mr->page_shift = ilog2(ibmr->page_size);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 96af3e054f4d..a51819d0c345 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -305,7 +305,6 @@ struct rxe_mr {
 	u32			rkey;
 	enum rxe_mr_state	state;
 	enum ib_mr_type		type;
-	u64			va;
 	u64			iova;
 	size_t			length;
 	u32			offset;
-- 
2.31.1

