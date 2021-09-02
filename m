Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2D3FEA7A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbhIBIQI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 04:16:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53032 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243655AbhIBIQH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 04:16:07 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2GKdHq2H6o2r9pWSsWReyQqjBFokLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb3qynIpoV+6faUskd3ZJhOo7C90cW7LU80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HAROoJgLcKqAeAJ8SRzIFgPN9bAspD4cPLfCNHpPe/8A+lCMwh3dXC1KipgN3V?=
 =?us-ascii?q?x3BrQRoCUdAY0y5JThacDlZtRBRLQb4wFJ+n7MJBoDa6PVsNaMDTPAh8Y8Hz48?=
 =?us-ascii?q?3MiIn9YQMLQzou6Ay1hzuu77LgVzi0ty1uNQ9y/Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,371,1620662400"; 
   d="scan'208";a="113894813"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Sep 2021 16:15:08 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 482C14D0D9D8;
        Thu,  2 Sep 2021 16:15:07 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Sep 2021 16:14:57 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Sep 2021 16:14:54 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 4/5] RDMA/rxe: Set partial attributes when completion status != IBV_WC_SUCCESS
Date:   Thu, 2 Sep 2021 16:46:39 +0800
Message-ID: <20210902084640.679744-5-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902084640.679744-1-yangx.jy@fujitsu.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 482C14D0D9D8.A6904
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
index fb7741ec5cd3..1bbce4af1414 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -383,30 +383,35 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  struct rxe_cqe *cqe)
 {
+	struct ib_wc *wc = &cqe->ibwc;
+	struct ib_uverbs_wc *uwc = &cqe->uibwc;
+
 	memset(cqe, 0, sizeof(*cqe));
 
 	if (!qp->sq.is_user) {
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
+		if (!qp->sq.is_user) {
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
2.23.0



