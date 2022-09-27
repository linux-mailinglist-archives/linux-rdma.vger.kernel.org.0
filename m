Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8A5EB9A4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiI0F0q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiI0F0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:26:45 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 22:26:43 PDT
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2436476755;
        Mon, 26 Sep 2022 22:26:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="90090448"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="90090448"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:25:37 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 441F3D4323;
        Tue, 27 Sep 2022 14:25:36 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D77DBF3E3;
        Tue, 27 Sep 2022 14:25:35 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EF2B11403D7;
        Tue, 27 Sep 2022 14:25:34 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH jgg-for-next] RDMA/rxe: Fix pd refcount_t: underflow; use-after-free
Date:   Tue, 27 Sep 2022 13:25:30 +0800
Message-Id: <20220927052530.21397-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10-0.495300-10.000000
X-TMASE-MatchedRID: Qgrh8rFiqFSlTHNxJDwdpM36paW7ZnFoUdPVQTIo4RLfUY2boz4kpOgU
        rKBxousFHeLURnkZ9/50fjyPLAxbIArdexLvyJVkOjf3A4DTYuFN8rmPQRlvK/XGsfmQor+uP0E
        ECAycyB4i+t+0AiFaYvL3NxFKQpq18gFf6MN9caueAiCmPx4NwJuJ+Pb8n/VxSnQ4MjwaO9cqtq
        5d3cxkNZKQ2nSmoAeRxuKRNK6+2Pw/kRCYiDjRDeiecGk1ifHvKQeLuRDovJbv4XJedG181T7Wz
        GfzeXJkt1UGZw1E8niazv5f7A5SCRiKAP5Y7TkhFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
        HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the error path, both rxe_put(pd) and rxe_cleanup(mr) will
drop pd's ref_cont.
rxe_cleanup(mr)
 -> __rxe_cleanup
   -> rxe_put(mr->elem)
   -> rxe_mr_cleanup(mr)
     -> rxe_put(mr_pd(mr))

[342431.583189] ------------[ cut here ]------------
[342431.585051] refcount_t: underflow; use-after-free.
[342431.586677] WARNING: CPU: 0 PID: 660500 at lib/refcount.c:28 refcount_warn_saturate+0xcd/0x120
[342431.605247] RIP: 0010:refcount_warn_saturate+0xcd/0x120
[342431.661981]  __rxe_cleanup+0x1c3/0x1e0 [rdma_rxe]
[342431.663260]  rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
[342431.664883]  ib_dealloc_pd_user+0x95/0xd0 [ib_core]
[342431.666803]  destroy_hw_idr_uobject+0x46/0x90 [ib_uverbs]
[342431.668514]  uverbs_destroy_uobject+0xc8/0x360 [ib_uverbs]
[342431.670232]  __uverbs_cleanup_ufile+0x157/0x210 [ib_uverbs]
[342431.671920]  ? uverbs_destroy_uobject+0x360/0x360 [ib_uverbs]

CC: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 0d0e4b528c3b ("RDMA/rxe: Set pd early in mr alloc routines")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
I have to say i made a mistake in previous review, I missed this WARN_ONCE messages.
And the V6 patch that i had applied fix this problem in another way.
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 933277d67b7c..88825edc7dce 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -939,7 +939,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
-	rxe_put(pd);
 	rxe_cleanup(mr);
 err2:
 	return ERR_PTR(err);
@@ -974,7 +973,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_put(pd);
 	rxe_cleanup(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.31.1

