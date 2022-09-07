Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C25AFA19
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIGCop (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIGCon (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:44:43 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B2DF73
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 19:44:37 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="75355904"
X-IronPort-AV: E=Sophos;i="5.93,295,1654527600"; 
   d="scan'208";a="75355904"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Sep 2022 11:44:34 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E3819DA694;
        Wed,  7 Sep 2022 11:44:33 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 071FCD9471;
        Wed,  7 Sep 2022 11:44:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id B5A1D200B3AC;
        Wed,  7 Sep 2022 11:44:32 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH 3/7] RDMA/rxe: Cleanup code for responder Atomic operations
Date:   Wed,  7 Sep 2022 11:43:01 +0900
Message-Id: <861f3f8f8a07ce066a05cc5a2210bde76740f870.1662461897.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, rxe_responder() directly calls the function to execute Atomic
operations. This need to be modified to insert some conditional branches
for the new RDMA Write operation and the ODP feature.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 102 +++++++++++++++++----------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e97c55b292f0..cadc8fa64dd0 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -591,60 +591,86 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
-static enum resp_states atomic_reply(struct rxe_qp *qp,
-					 struct rxe_pkt_info *pkt)
+enum resp_states rxe_process_atomic(struct rxe_qp *qp,
+				    struct rxe_pkt_info *pkt, u64 *vaddr)
 {
-	u64 *vaddr;
 	enum resp_states ret;
-	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
 	u64 value;
 
-	if (!res) {
-		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
-		qp->resp.res = res;
+	/* check vaddr is 8 bytes aligned. */
+	if (!vaddr || (uintptr_t)vaddr & 7) {
+		ret = RESPST_ERR_MISALIGNED_ATOMIC;
+		goto out;
 	}
 
-	if (!res->replay) {
-		if (mr->state != RXE_MR_STATE_VALID) {
-			ret = RESPST_ERR_RKEY_VIOLATION;
-			goto out;
-		}
+	spin_lock(&atomic_ops_lock);
+	res->atomic.orig_val = value = *vaddr;
 
-		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
-					sizeof(u64));
+	if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+		if (value == atmeth_comp(pkt))
+			value = atmeth_swap_add(pkt);
+	} else {
+		value += atmeth_swap_add(pkt);
+	}
 
-		/* check vaddr is 8 bytes aligned. */
-		if (!vaddr || (uintptr_t)vaddr & 7) {
-			ret = RESPST_ERR_MISALIGNED_ATOMIC;
-			goto out;
-		}
+	*vaddr = value;
+	spin_unlock(&atomic_ops_lock);
 
-		spin_lock_bh(&atomic_ops_lock);
-		res->atomic.orig_val = value = *vaddr;
+	qp->resp.msn++;
 
-		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
-			if (value == atmeth_comp(pkt))
-				value = atmeth_swap_add(pkt);
-		} else {
-			value += atmeth_swap_add(pkt);
-		}
+	/* next expected psn, read handles this separately */
+	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
 
-		*vaddr = value;
-		spin_unlock_bh(&atomic_ops_lock);
+	qp->resp.opcode = pkt->opcode;
+	qp->resp.status = IB_WC_SUCCESS;
 
-		qp->resp.msn++;
+	ret = RESPST_ACKNOWLEDGE;
+out:
+	return ret;
+}
 
-		/* next expected psn, read handles this separately */
-		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
-		qp->resp.ack_psn = qp->resp.psn;
+static  enum resp_states rxe_atomic_ops(struct rxe_qp *qp,
+					struct rxe_pkt_info *pkt,
+					struct rxe_mr *mr)
+{
+	u64 *vaddr;
+	int ret;
 
-		qp->resp.opcode = pkt->opcode;
-		qp->resp.status = IB_WC_SUCCESS;
+	vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
+			      sizeof(u64));
+
+	if (pkt->mask & RXE_ATOMIC_MASK) {
+		ret = rxe_process_atomic(qp, pkt, vaddr);
+	} else {
+		/*ATOMIC WRITE operation will come here. */
+		ret = RESPST_ERR_UNSUPPORTED_OPCODE;
 	}
 
-	ret = RESPST_ACKNOWLEDGE;
-out:
+	return ret;
+}
+
+static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
+					 struct rxe_pkt_info *pkt)
+{
+	struct rxe_mr *mr = qp->resp.mr;
+	struct resp_res *res = qp->resp.res;
+	int ret;
+
+	if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
+		qp->resp.res = res;
+	}
+
+	if (!res->replay) {
+		if (mr->state != RXE_MR_STATE_VALID)
+			return RESPST_ERR_RKEY_VIOLATION;
+
+		ret = rxe_atomic_ops(qp, pkt, mr);
+	} else
+		ret = RESPST_ACKNOWLEDGE;
+
 	return ret;
 }
 
@@ -1327,7 +1353,7 @@ int rxe_responder(void *arg)
 			state = read_reply(qp, pkt);
 			break;
 		case RESPST_ATOMIC_REPLY:
-			state = atomic_reply(qp, pkt);
+			state = rxe_atomic_reply(qp, pkt);
 			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
-- 
2.31.1

