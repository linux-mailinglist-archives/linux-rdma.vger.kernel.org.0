Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B89305620
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhA0IuJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 03:50:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8597 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232422AbhA0IsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 03:48:03 -0500
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; 
   d="scan'208";a="103892255"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2021 16:46:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id F01944CE6014;
        Wed, 27 Jan 2021 16:46:07 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 27 Jan 2021 16:46:07 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 27 Jan 2021 16:46:07 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@nvidia.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR with imm_data finished on SQ
Date:   Wed, 27 Jan 2021 16:24:31 +0800
Message-ID: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F01944CE6014.A96A3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
module cannot set imm_data in WC when the related WR with imm_data
finished on SQ.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---

Current rxe module and other rdma modules(e.g. mlx5) only set
imm_data in WC when the related WR with imm_data finished on RQ.
I am not sure if it is a expected behavior.

 drivers/infiniband/sw/rxe/rxe_comp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 0a1e6393250b..e380ff63ab2d 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -384,8 +384,10 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		wc->status		= wqe->status;
 		wc->opcode		= wr_to_wc_opcode(wqe->wr.opcode);
 		if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
-		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
+		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM) {
 			wc->wc_flags = IB_WC_WITH_IMM;
+			wc->ex.imm_data = wqe->wr.ex.imm_data;
+		}
 		wc->byte_len		= wqe->dma.length;
 		wc->qp			= &qp->ibqp;
 	} else {
@@ -395,8 +397,10 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		uwc->status		= wqe->status;
 		uwc->opcode		= wr_to_wc_opcode(wqe->wr.opcode);
 		if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
-		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
+		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM) {
 			uwc->wc_flags = IB_WC_WITH_IMM;
+			uwc->ex.imm_data = wqe->wr.ex.imm_data;
+		}
 		uwc->byte_len		= wqe->dma.length;
 		uwc->qp_num		= qp->ibqp.qp_num;
 	}
-- 
2.23.0



