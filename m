Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27305EBA1B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiI0FyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiI0FyF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:05 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9796FF9;
        Mon, 26 Sep 2022 22:54:03 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="90094095"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="90094095"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:02 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id AF558D4F60;
        Tue, 27 Sep 2022 14:54:00 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D6918F0FB6;
        Tue, 27 Sep 2022 14:53:59 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 96E9911416F0;
        Tue, 27 Sep 2022 14:53:58 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 01/11] RDMA/rxe: make sure requested access is a subset of {mr,mw}->access
Date:   Tue, 27 Sep 2022 13:53:27 +0800
Message-Id: <20220927055337.22630-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10-0.410700-10.000000
X-TMASE-MatchedRID: PQKBKUUweS8q/mR31mzCQEXBhxFdFgcQYnjb54Q6bnBD0XHWdCmZPJgU
        Ly4zAbFBjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRSCtgxgcsrMoqIDKj/B/pqZsoi2XrUn/Jn6K
        dMrRsL14qtq5d3cxkNXXgXsQkv1483utzuttQ/10s7SSaWe3OQyo0r00SEySLSM2MLO925gqfkq
        MAQK0wp6mp9yep8KrUR4ywKJOlCUlstuyAPeJTWNGQez76nGiBFcUQf3Yp/ridO0/GUi4gFb0fO
        PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should reject the requests with access flags that is not registered
by MR/MW. For example, lookup_mr() should return NULL when requested access
is 0x03 and mr->access is 0x01.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 502e9ada99b3..74a38d06332f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -511,7 +511,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
 		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
-		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
+		     mr_pd(mr) != pd || ((access & mr->access) != access) ||
 		     mr->state != RXE_MR_STATE_VALID)) {
 		rxe_put(mr);
 		mr = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 902b7df7aaed..8df1c9066ed8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -293,8 +293,7 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 
 	if (unlikely((mw->rkey != rkey) || rxe_mw_pd(mw) != pd ||
 		     (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
-		     (mw->length == 0) ||
-		     (access && !(access & mw->access)) ||
+		     (mw->length == 0) || ((access & mw->access) != access) ||
 		     mw->state != RXE_MW_STATE_VALID)) {
 		rxe_put(mw);
 		return NULL;
-- 
2.31.1

