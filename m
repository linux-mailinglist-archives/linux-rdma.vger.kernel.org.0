Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65B92A47D
	for <lists+linux-rdma@lfdr.de>; Sat, 25 May 2019 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfEYM6I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 May 2019 08:58:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfEYM6I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 May 2019 08:58:08 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 529723CA67E16F11BCB1;
        Sat, 25 May 2019 20:58:01 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:57:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mike.marciniszyn@intel.com>, <dennis.dalessandro@intel.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] IB/hfi1: remove set but not used variables 'offset' and 'fspsn'
Date:   Sat, 25 May 2019 20:57:37 +0800
Message-ID: <20190525125737.15648-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/hw/hfi1/tid_rdma.c: In function tid_rdma_rcv_error:
drivers/infiniband/hw/hfi1/tid_rdma.c:2029:7: warning: variable offset set but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/hfi1/tid_rdma.c: In function hfi1_rc_rcv_tid_rdma_ack:
drivers/infiniband/hw/hfi1/tid_rdma.c:4555:35: warning: variable fspsn set but not used [-Wunused-but-set-variable]

'offset' is never used since introduction in
commit d0d564a1caac ("IB/hfi1: Add functions to receive TID RDMA READ request")

'fspsn' is never used since introduciotn in
commit 9e93e967f7b4 ("IB/hfi1: Add a function to receive TID RDMA ACK packet")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 6fb93032fbef..bdf1c313e13f 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2026,7 +2026,6 @@ static int tid_rdma_rcv_error(struct hfi1_packet *packet,
 	trace_hfi1_tid_req_rcv_err(qp, 0, e->opcode, e->psn, e->lpsn, req);
 	if (e->opcode == TID_OP(READ_REQ)) {
 		struct ib_reth *reth;
-		u32 offset;
 		u32 len;
 		u32 rkey;
 		u64 vaddr;
@@ -2038,7 +2037,6 @@ static int tid_rdma_rcv_error(struct hfi1_packet *packet,
 		 * The requester always restarts from the start of the original
 		 * request.
 		 */
-		offset = delta_psn(psn, e->psn) * qp->pmtu;
 		len = be32_to_cpu(reth->length);
 		if (psn != e->psn || len != req->total_len)
 			goto unlock;
@@ -4552,7 +4550,7 @@ void hfi1_rc_rcv_tid_rdma_ack(struct hfi1_packet *packet)
 	struct rvt_swqe *wqe;
 	struct tid_rdma_request *req;
 	struct tid_rdma_flow *flow;
-	u32 aeth, psn, req_psn, ack_psn, fspsn, resync_psn, ack_kpsn;
+	u32 aeth, psn, req_psn, ack_psn, resync_psn, ack_kpsn;
 	unsigned long flags;
 	u16 fidx;
 
@@ -4756,7 +4754,6 @@ void hfi1_rc_rcv_tid_rdma_ack(struct hfi1_packet *packet)
 			IB_AETH_CREDIT_MASK) {
 		case 0: /* PSN sequence error */
 			flow = &req->flows[req->acked_tail];
-			fspsn = full_flow_psn(flow, flow->flow_state.spsn);
 			trace_hfi1_tid_flow_rcv_tid_ack(qp, req->acked_tail,
 							flow);
 			req->r_ack_psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
-- 
2.17.1


