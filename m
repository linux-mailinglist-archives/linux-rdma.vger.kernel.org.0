Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C84ED933
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiCaMEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiCaMEl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 08:04:41 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF75AE0E1
        for <linux-rdma@vger.kernel.org>; Thu, 31 Mar 2022 05:02:51 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A/dRm46mcLhPv7zQJKemph2bo5gy+JERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2dTyjAcXmvTPayCZGShftgiao62/E5XuZKHn9IxT1Y5+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2dxLuoz2S?=
 =?us-ascii?q?xYBMLDOmfgGTl9TFCQW0ahuoeWceCLu65bJp6HBWz62qxl0N2kyMIoe0uV6G2d?=
 =?us-ascii?q?D8bofMj9lRhKMiMqw3rO3S+AqjcMmROHvPYUCqjR6wTTQJegpTIqFQKjQ49Jcm?=
 =?us-ascii?q?jAqiahz8Vz2DyYCQWM3Kk2ePFsUYRFKYK/SVdyA3hHXGwC0YnrMzUbv31Xu8Q?=
 =?us-ascii?q?=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AENaH+anP5nekcFPH+KlhxDNMDbvpDfMpimdD?=
 =?us-ascii?q?5ihNYBxZY6WkfpiV7YEmPR+dskdtZJhSo6H1BEDgewKXyXcb2/hhAV7PZnichI?=
 =?us-ascii?q?LsFvAR0WKA+UysJ8SdzJ8s6U4IScEXY6yVfCEK9foSojPIYOrIq+P3jJxA8N2u?=
 =?us-ascii?q?sUuFOjsaFJ2IgT0JcDpzWXcGMzWuTaBJYqa01456nRKGVUlSQPqAXT0+U+LevN?=
 =?us-ascii?q?3XhPvdEHs7Li9i1DOnqh+UrJDFKUPd5BsETDNEzd4Zngal8zDR1+Geidmd5iKZ?=
 =?us-ascii?q?+VHotNBqkNXgx7J4da6xo/lQFg/FrSqUIKpeYebHgTwzqOazgWxa8+XkklMdBe?=
 =?us-ascii?q?xVx06UWnu6gRaF4XiH7B8er0PZ4Xi1vD/Zrcb0RC03BqN6775xQ1/k0WIGkOw5?=
 =?us-ascii?q?66RWwm6V3qA7YS/orWDA3fDueywvrEypunAv+NRj6EB3QM8Uc7lUrZAauEdOHp?=
 =?us-ascii?q?cMdRiKobzOBoFVfYnhDdhtABinU0w=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123129222"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Mar 2022 20:02:48 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 790724D16FF7;
        Thu, 31 Mar 2022 20:02:47 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 31 Mar 2022 20:02:47 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 31 Mar 2022 20:02:47 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3] RDMA/rxe: Generate a completion on error after getting a wqe
Date:   Thu, 31 Mar 2022 20:02:45 +0800
Message-ID: <20220331120245.314614-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 790724D16FF7.A8EDB
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
getting a wqe. Fix the issue by calling rxe_completer() on error.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..01ae400e5481 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -648,26 +648,24 @@ int rxe_requester(void *arg)
 		psn_compare(qp->req.psn, (qp->comp.psn +
 				RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
-		goto exit;
+		goto qp_op_err;
 	}
 
 	/* Limit the number of inflight SKBs per QP */
 	if (unlikely(atomic_read(&qp->skb_out) >
 		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
 		qp->need_req_skb = 1;
-		goto exit;
+		goto qp_op_err;
 	}
 
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
-	if (unlikely(opcode < 0)) {
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto exit;
-	}
+	if (unlikely(opcode < 0))
+		goto qp_op_err;
 
 	mask = rxe_opcode[opcode].mask;
 	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
 		if (check_init_depth(qp, wqe))
-			goto exit;
+			goto qp_op_err;
 	}
 
 	mtu = get_mtu(qp);
@@ -706,26 +704,26 @@ int rxe_requester(void *arg)
 	av = rxe_get_av(&pkt, &ah);
 	if (unlikely(!av)) {
 		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err_drop_ah;
 	}
 
 	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err_drop_ah;
 	}
 
 	ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
 	if (unlikely(ret)) {
 		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
+		if (ah)
+			rxe_put(ah);
 		if (ret == -EFAULT)
 			wqe->status = IB_WC_LOC_PROT_ERR;
 		else
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		kfree_skb(skb);
-		goto err_drop_ah;
+		goto err;
 	}
 
 	if (ah)
@@ -751,8 +749,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err;
+		goto qp_op_err;
 	}
 
 	update_state(qp, wqe, &pkt);
@@ -762,6 +759,9 @@ int rxe_requester(void *arg)
 err_drop_ah:
 	if (ah)
 		rxe_put(ah);
+
+qp_op_err:
+	wqe->status = IB_WC_LOC_QP_OP_ERR;
 err:
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
-- 
2.25.4



