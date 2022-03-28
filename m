Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90EF4E9AD0
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiC1PTe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiC1PTe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 11:19:34 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B43606EB
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 08:17:53 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AZ0bmYKMC5T+zuaDvrR1JlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQm50Glw12MAzWMXCmHQO/beZjbyLdx2aoXlox4Bu8ODm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/mjyPkMA3ysRlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnslZfYapeScSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgGKgeCrxvSpSvREgsUlMdmtMI4B0lliwj7xC+gnTZHKBa7N4Ldw2?=
 =?us-ascii?q?Do3gNpJNfDAZsYYYHxkaxGoSxlOPEoHTYgyme6AmHbyaXtbpUiTqK5x5HLcpDG?=
 =?us-ascii?q?depCF3MH9I4TMHJsK2B3D4D+uwogwOTlCXPT39NZP2ivEajfzoB7G?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcNcv4aqtPfXx0sjm0/4jYsoaV5rDeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj+fxG+85rsSMc6QxhP03I9urhBEDtex/hHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKlbbehEWmNQz6U4ZSdkdNDTvNykAse/KpBm/D807wMSKtIShheLl?=
 =?us-ascii?q?xX9rSg1wApsQljtRO0KKFFFsXglaCd4cHJqY3MBOoD2tYjA5dcK+b0N1J9Trlp?=
 =?us-ascii?q?nako78ex4aC1oC4AmKtzmh77n3CFy5834lIlVy/Ys=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123034533"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Mar 2022 23:17:52 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 6ABB64D169FF;
        Mon, 28 Mar 2022 23:17:51 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 28 Mar 2022 23:17:53 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 28 Mar 2022 23:17:52 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <leonro@nvidia.com>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2] RDMA/rxe: Generate a completion on error after getting a wqe
Date:   Mon, 28 Mar 2022 23:17:48 +0800
Message-ID: <20220328151748.304551-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6ABB64D169FF.AA879
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current rxe_requester() doesn't generate a completion on error after
getting a wqe. Fix the issue by calling "goto err;" instead.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..e69fe409fbcb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -648,26 +648,30 @@ int rxe_requester(void *arg)
 		psn_compare(qp->req.psn, (qp->comp.psn +
 				RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
-		goto exit;
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		goto err;
 	}
 
 	/* Limit the number of inflight SKBs per QP */
 	if (unlikely(atomic_read(&qp->skb_out) >
 		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
 		qp->need_req_skb = 1;
-		goto exit;
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		goto err;
 	}
 
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto exit;
+		goto err;
 	}
 
 	mask = rxe_opcode[opcode].mask;
 	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
-		if (check_init_depth(qp, wqe))
-			goto exit;
+		if (check_init_depth(qp, wqe)) {
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
+			goto err;
+		}
 	}
 
 	mtu = get_mtu(qp);
-- 
2.25.4



