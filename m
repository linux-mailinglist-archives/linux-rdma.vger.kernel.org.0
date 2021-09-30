Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C496641D61D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349267AbhI3JTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 05:19:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31245 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349293AbhI3JTK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 05:19:10 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AChMkUaj3b6d6Kjs7V6a27RDiX161ghIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUOy2UfCzzQaamMYmSnL9ByPt6/pk5UuZLQyYNjGgpl+Hw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi8xZVA/fvQHOOkWbW?=
 =?us-ascii?q?cYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14MREs5OgD?=
 =?us-ascii?q?wU4FqPRmuUBSAQeGCZ7VUFD0OaefCLl75HCnyUqdFOpmZ2CFnoeJ5UV8/xsBmd?=
 =?us-ascii?q?O7fEwJzUEbxTFjOWzqJqpW+t+l8Z5dJGzFIwas3BkizreCJ4ORZ3ERY3J6MVe0?=
 =?us-ascii?q?TN2gdpBdd7caMUxbyRuYBXJJRZIPz8/DJM4gfftnHX6ehVGp1+P46k6+W7eyEp?=
 =?us-ascii?q?2yreFDTZ/UrRmXu0MxgDB+D2ApD+/X3kn2BWk4WLt2hqRaiXnx0sXgL4vKYA?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/S0U2KErwGetTVsrpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.85,335,1624291200"; 
   d="scan'208";a="115226598"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2021 17:17:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5963B4D0DC7C;
        Thu, 30 Sep 2021 17:17:21 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:21 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Sep 2021 17:17:19 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v4 3/4] RDMA/rxe: Set partial attributes when completion status != IBV_WC_SUCCESS
Date:   Thu, 30 Sep 2021 17:48:12 +0800
Message-ID: <20210930094813.226888-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930094813.226888-1-yangx.jy@fujitsu.com>
References: <20210930094813.226888-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5963B4D0DC7C.A9216
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As ibv_poll_cq()'s manual said, only partial attributes are valid
when completion status != IBV_WC_SUCCESS.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 45 +++++++++++++++-------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 48a3864ada29..d771ba8449a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -380,30 +380,35 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  struct rxe_cqe *cqe)
 {
+	struct ib_wc *wc = &cqe->ibwc;
+	struct ib_uverbs_wc *uwc = &cqe->uibwc;
+
 	memset(cqe, 0, sizeof(*cqe));
 
 	if (!qp->is_user) {
-		struct ib_wc		*wc	= &cqe->ibwc;
-
-		wc->wr_id		= wqe->wr.wr_id;
-		wc->status		= wqe->status;
-		wc->opcode		= wr_to_wc_opcode(wqe->wr.opcode);
-		if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
-		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
-			wc->wc_flags = IB_WC_WITH_IMM;
-		wc->byte_len		= wqe->dma.length;
-		wc->qp			= &qp->ibqp;
+		wc->wr_id = wqe->wr.wr_id;
+		wc->status = wqe->status;
+		wc->qp = &qp->ibqp;
 	} else {
-		struct ib_uverbs_wc	*uwc	= &cqe->uibwc;
-
-		uwc->wr_id		= wqe->wr.wr_id;
-		uwc->status		= wqe->status;
-		uwc->opcode		= wr_to_wc_opcode(wqe->wr.opcode);
-		if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
-		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
-			uwc->wc_flags = IB_WC_WITH_IMM;
-		uwc->byte_len		= wqe->dma.length;
-		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id = wqe->wr.wr_id;
+		uwc->status = wqe->status;
+		uwc->qp_num = qp->ibqp.qp_num;
+	}
+
+	if (wqe->status == IB_WC_SUCCESS) {
+		if (!qp->is_user) {
+			wc->opcode = wr_to_wc_opcode(wqe->wr.opcode);
+			if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
+			    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
+				wc->wc_flags = IB_WC_WITH_IMM;
+			wc->byte_len = wqe->dma.length;
+		} else {
+			uwc->opcode = wr_to_wc_opcode(wqe->wr.opcode);
+			if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
+			    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
+				uwc->wc_flags = IB_WC_WITH_IMM;
+			uwc->byte_len = wqe->dma.length;
+		}
 	}
 }
 
-- 
2.25.1



