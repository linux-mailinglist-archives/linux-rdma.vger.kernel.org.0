Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78C653E71B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiFFOjg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiFFOj3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:39:29 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2C150A29
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:39:28 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f16a3e0529so19400205fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U49BvOdGgMN5ce3QzHU9Q6ZMWiGBn/QthrIFJCZRmUE=;
        b=dRMakNC5RhVWlIKZkemu37NCzSVn1LyldZQwVcz1vxULcRYjHT7JUlRN0eTljh85DF
         RzN2uTwacKxTjYdzYsnhgViGcJ0WKIieOhH26U1aVqepysKGmmRsc4mwsQ0WJRXdMaAF
         FJWqREXieQmb/MiO4ojn6abmR7Se+JbzGgFx2u6bQDHWEdMayqdR9iBU6cHIcmRB2N/o
         mT8QB2BAdukJ52vf6LSW3bF3N7baPKld+9f7NE8he0aYSpPfJ3OY9cmjnCl2Tvz73JIC
         dfSK59s0d07UZoh+a3KG0FB0VpcyR7bsTJGw843wv5qIUBjiIRNzpspspM4vYfSztC4P
         NfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U49BvOdGgMN5ce3QzHU9Q6ZMWiGBn/QthrIFJCZRmUE=;
        b=aGTm50EEjy8NxHxKr7enL5Ry3U1yCMOTiFHhEnaPPwJ5OXfwvEY1uXkcxVGJ8FH8KP
         /EYy2c6on1EZ4w5AuSBTOUhGLsYudbMA5lwZy1jgNlA0ZWc9xtKgEBFIgb1i//75tZ5m
         H5rWORmies9r66gBQX+Q3qHohcSYYpDc0gl8DfVD11OU3KDboloxp8f1CRyDorBaZpp9
         hpl21XhVfFSKOmMfgL6eiaMzWYLy2gf8KEs1kIBAhZlani2BwzCND/PVTVhxbdS1n9hS
         SRvkclhf5lOEBfYavoMmN25kKoXvc1GtSaBVwYeEFz3XMG/bD+YTrFrBz0oeaiXgU+g5
         3Wmw==
X-Gm-Message-State: AOAM532qb1hh3IKdqlMYJ37D+TKiC4wOZ1lCNehXngFtQtQdgdEwr0K2
        KnCVMoYn3UUMa3l8yxRwT5k=
X-Google-Smtp-Source: ABdhPJzbu9xuDICYCVnIxYc1JtvzVaXjjmj8iq6R9oeQPgEtdtCGxHWalfyVFv8AZbcYKo+6p/6l6g==
X-Received: by 2002:a05:6870:eca1:b0:f6:dd:8d8 with SMTP id eo33-20020a056870eca100b000f600dd08d8mr12347047oab.23.1654526367472;
        Mon, 06 Jun 2022 07:39:27 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm658335otc.72.2022.06.06.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:39:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 5/5] RDMA/rxe: Merge normal and retry atomic flows
Date:   Mon,  6 Jun 2022 09:38:37 -0500
Message-Id: <20220606143836.3323-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606143836.3323-1-rpearsonhpe@gmail.com>
References: <20220606143836.3323-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make the execution of the atomic operation in rxe_atomic_reply()
conditional on res->replay and make duplicate_request() call into
rxe_atomic_reply() to merge the two flows. This is modeled on
the behavior of read reply. Delete the skb from the atomic
responder resource since it is no longer used. Adjust the reference
counting of the qp in send_atomic_ack() for this flow.

Fixes: 8700e3e7c485 ("The software RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 -
 drivers/infiniband/sw/rxe/rxe_resp.c  | 79 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 3 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 22e9b85344c3..8355a5b1cb60 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -129,8 +129,6 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
-	if (res->type == RXE_ATOMIC_MASK)
-		kfree_skb(res->atomic.skb);
 	res->type = 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 320ab7c717cb..6888bd9d0bfc 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -586,40 +586,43 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 		qp->resp.res = res;
 	}
 
-	if (mr->state != RXE_MR_STATE_VALID) {
-		ret = RESPST_ERR_RKEY_VIOLATION;
-		goto out;
-	}
+	if (!res->replay) {
+		if (mr->state != RXE_MR_STATE_VALID) {
+			ret = RESPST_ERR_RKEY_VIOLATION;
+			goto out;
+		}
 
-	vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
+		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
+					sizeof(u64));
 
-	/* check vaddr is 8 bytes aligned. */
-	if (!vaddr || (uintptr_t)vaddr & 7) {
-		ret = RESPST_ERR_MISALIGNED_ATOMIC;
-		goto out;
-	}
+		/* check vaddr is 8 bytes aligned. */
+		if (!vaddr || (uintptr_t)vaddr & 7) {
+			ret = RESPST_ERR_MISALIGNED_ATOMIC;
+			goto out;
+		}
 
-	spin_lock_bh(&atomic_ops_lock);
-	res->atomic.orig_val = value = *vaddr;
+		spin_lock_bh(&atomic_ops_lock);
+		res->atomic.orig_val = value = *vaddr;
 
-	if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
-		if (value == atmeth_comp(pkt))
-			value = atmeth_swap_add(pkt);
-	} else {
-		value += atmeth_swap_add(pkt);
-	}
+		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+			if (value == atmeth_comp(pkt))
+				value = atmeth_swap_add(pkt);
+		} else {
+			value += atmeth_swap_add(pkt);
+		}
 
-	*vaddr = value;
-	spin_unlock_bh(&atomic_ops_lock);
+		*vaddr = value;
+		spin_unlock_bh(&atomic_ops_lock);
 
-	qp->resp.msn++;
+		qp->resp.msn++;
 
-	/* next expected psn, read handles this separately */
-	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
-	qp->resp.ack_psn = qp->resp.psn;
+		/* next expected psn, read handles this separately */
+		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+		qp->resp.ack_psn = qp->resp.psn;
 
-	qp->resp.opcode = pkt->opcode;
-	qp->resp.status = IB_WC_SUCCESS;
+		qp->resp.opcode = pkt->opcode;
+		qp->resp.status = IB_WC_SUCCESS;
+	}
 
 	ret = RESPST_ACKNOWLEDGE;
 out:
@@ -1059,7 +1062,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
-	struct resp_res *res = qp->resp.res;
 
 	skb = prepare_ack_packet(qp, pkt, &ack_pkt,
 				 IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, 0, pkt->psn,
@@ -1069,15 +1071,9 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto out;
 	}
 
-	skb_get(skb);
-
-	res->atomic.skb = skb;
-
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err) {
-		pr_err_ratelimited("Failed sending ack\n");
-		rxe_put(qp);
-	}
+	if (err)
+		pr_err_ratelimited("Failed sending atomic ack\n");
 
 	/* have to clear this since it is used to trigger
 	 * long read replies
@@ -1205,14 +1201,11 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* Find the operation in our list of responder resources. */
 		res = find_resource(qp, pkt->psn);
 		if (res) {
-			skb_get(res->atomic.skb);
-			/* Resend the result. */
-			rc = rxe_xmit_packet(qp, pkt, res->atomic.skb);
-			if (rc) {
-				pr_err("Failed resending result. This flow is not handled - skb ignored\n");
-				rc = RESPST_CLEANUP;
-				goto out;
-			}
+			res->replay = 1;
+			res->cur_psn = pkt->psn;
+			qp->resp.res = res;
+			rc = RESPST_ATOMIC_REPLY;
+			goto out;
 		}
 
 		/* Resource not found. Class D error. Drop the request. */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5ee0f2599896..0c01c7f58d43 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -155,7 +155,6 @@ struct resp_res {
 
 	union {
 		struct {
-			struct sk_buff	*skb;
 			u64		orig_val;
 		} atomic;
 		struct {
-- 
2.34.1

