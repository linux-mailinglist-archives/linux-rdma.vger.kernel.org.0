Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3C46B152
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 04:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhLGDUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 22:20:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:4230 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233751AbhLGDUN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 22:20:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224353443"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224353443"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 19:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="679269141"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2021 19:16:42 -0800
From:   yanjun.zhu@linux.dev
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 1/1] RDMA/rxe: Remove the unnecessary variable
Date:   Tue,  7 Dec 2021 14:40:57 -0500
Message-Id: <20211207194057.713289-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The variable pkey is assigned to a macro. Then this variable is passed
to a function bth_init directly. And pkey is not used again. So remove
it and use the macro directly.

Fixes: 76251e15ea73 ("RDMA/rxe: Remove pkey table")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0c9d2af15f3d..350c47174aca 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -372,7 +372,6 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	int			pad = (-payload) & 0x3;
 	int			paylen;
 	int			solicited;
-	u16			pkey;
 	u32			qp_num;
 	int			ack_req;
 
@@ -404,8 +403,6 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
 			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
 
-	pkey = IB_DEFAULT_PKEY_FULL;
-
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
 
@@ -414,7 +411,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
-	bth_init(pkt, pkt->opcode, solicited, 0, pad, pkey, qp_num,
+	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL, qp_num,
 		 ack_req, pkt->psn);
 
 	/* init optional headers */
-- 
2.27.0

