Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40340D99F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhIPMRG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 08:17:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65178 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239292AbhIPMRG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 08:17:06 -0400
IronPort-Data: =?us-ascii?q?A9a23=3Axgv2samXVYOiELu01JGhb8vo5gxjJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzIEzjQdD2CBMq7ZajDzLY1zPIS09U9SsZXWydBrTAI9+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuWJQUVUj/nSH+KtUbC?=
 =?us-ascii?q?cYEideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2dxLuoz2S?=
 =?us-ascii?q?xYBMLDOmfgGTl9TFCQW0ahuoeabfCfl6ZPOp6HBWz62qxl0N2ksJYAR4P1wB2F?=
 =?us-ascii?q?W+NQXLTkMalaIgOfe6KCqSPt9hJ57dJHDM4YWu3UmxjbcZd4iTJfFa6bH/9lV2?=
 =?us-ascii?q?HE3nM8mNfTRaOIfdztjbR2GaBpKUn8TCZQjjKKyinz2WyNXpUjTpqct5WXXigt?=
 =?us-ascii?q?r39DQ3HD9EjCRbZwN2B/G+SSdpCKkaiz2/ee3kVKtmk9ATMeV9c8jZL8vKQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8jfVbK1vXFXAImpFrV8awwqjBNckLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SKylfq+V8cjzuSWftN9zYhAdcLK7V5VoKEm0nfVICOEqTNSftWLd1F?=
 =?us-ascii?q?dAQrsN0bff?=
X-IronPort-AV: E=Sophos;i="5.85,298,1624291200"; 
   d="scan'208";a="114572075"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 20:15:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 45D244D0DC6E;
        Thu, 16 Sep 2021 20:15:41 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 20:15:31 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 20:15:29 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v3 4/5] RDMA/rxe: Set partial attributes when completion status != IBV_WC_SUCCESS
Date:   Thu, 16 Sep 2021 20:46:51 +0800
Message-ID: <20210916124652.1304649-5-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
References: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 45D244D0DC6E.AA178
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
index 148fe3dd3b32..6b71e020009b 100644
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
2.25.1



