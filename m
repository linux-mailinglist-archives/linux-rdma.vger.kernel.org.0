Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C06D735E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Apr 2023 06:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjDEE1M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Apr 2023 00:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEE1J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Apr 2023 00:27:09 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93B3599
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 21:27:08 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so2078592ooo.13
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 21:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680668828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8+SKO55qGGMajqsSuK/gkh4B4t1XPBiRdlnbt9yI2k=;
        b=h4FNdmRj5J0ZYhANlkJPZQVUS4A0S6sJG3xtY9wXxIqJirfnvvtl0RqwmkOpcFkmqS
         Rk1wLeBY0czEQ390aTC4X5HirW7ovxdIqZAjUWRAQ6i0jNMM9Hoy2A4k1PTO5wbsEPt3
         0O5xCmhEyKq4GD+ZBuSsYOoS+t0Bct4+XtZWIzU1VJChQqkyhe5MA5JfyzxRN0wl7MGX
         Qii4K5iSjHSsPgMvAFIGmIm3oUSGiCz84Wh1qGAZxeX3i49c4YikhWEn2HMwYexy39QB
         LGnXtS6Lg4UjWSzWJH3bB1HQfEQfRSOV7g9J0l3LlJtPJO9pE4uNJrtAsei8qEw1kio5
         EYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8+SKO55qGGMajqsSuK/gkh4B4t1XPBiRdlnbt9yI2k=;
        b=1OnSx2MA4nBZ2azXmEa+xLaSXVH9bK5kXsg9B8szSvSVeozIpiDqkgn3VOWS68EYGM
         KMskRhyLOoBiykxA9lfmlLg21UZlT7fRFvqPPUqdIlvdkgJfLLt+sDxoY1WG3PQk5wjS
         UCxetl8k0pC3IgJ6D/FuxXybwYHMoyNkU1KT6/3tabPSTIW/cArZcUc2/DOEjKHLBaz2
         cPltpPXUjV89WMXK8WycgDiQBPwjKoYWzLiBfUnOBPDFXGrLJcffR8jKw3UNYKzO/Ls2
         2TR0ECNcVrNrSbDnT5tEbZgqXdSmGd8LIK6UTEu/sBDLIQOcBhDPtw4U8QGR7+P8V6so
         DX1Q==
X-Gm-Message-State: AAQBX9esMfdoJR8OeMEkWISQUmlHfdZ2oxFNy1GLcjU6gtFhElIAr94G
        XqPgxPjOMXXfbGcis3u9m7U=
X-Google-Smtp-Source: AKy350YYHJAYQBnACIDcGUm+HQs0ttd94jLGw21+auMBSYyUVOP30eJgxRslXMzd+II6beV2ZMjsnQ==
X-Received: by 2002:a4a:5241:0:b0:537:b1ad:1c7c with SMTP id d62-20020a4a5241000000b00537b1ad1c7cmr2460277oob.0.1680668828083;
        Tue, 04 Apr 2023 21:27:08 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm6321326ooa.19.2023.04.04.21.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 21:27:05 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/5] RDMA/rxe: Move code to check if drained  to subroutine
Date:   Tue,  4 Apr 2023 23:26:10 -0500
Message-Id: <20230405042611.6467-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405042611.6467-1-rpearsonhpe@gmail.com>
References: <20230405042611.6467-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move two blocks of code in rxe_comp.c and rxe_req.c to
subroutines that check if draining is complete in the SQD
state and, if so, generate a SQ_DRAINED event.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 35 ++++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_req.c  | 32 ++++++++++++++-----------
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 979990734e0c..1ccae8cff359 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -477,20 +477,8 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	}
 }
 
-static inline enum comp_state complete_ack(struct rxe_qp *qp,
-					   struct rxe_pkt_info *pkt,
-					   struct rxe_send_wqe *wqe)
+static void comp_check_sq_drain_done(struct rxe_qp *qp)
 {
-	if (wqe->has_rd_atomic) {
-		wqe->has_rd_atomic = 0;
-		atomic_inc(&qp->req.rd_atomic);
-		if (qp->req.need_rd_atomic) {
-			qp->comp.timeout_retry = 0;
-			qp->req.need_rd_atomic = 0;
-			rxe_sched_task(&qp->req.task);
-		}
-	}
-
 	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
 		/* state_lock used by requester & completer */
 		spin_lock_bh(&qp->state_lock);
@@ -507,10 +495,27 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 				qp->ibqp.event_handler(&ev,
 					qp->ibqp.qp_context);
 			}
-		} else {
-			spin_unlock_bh(&qp->state_lock);
+			return;
 		}
+		spin_unlock_bh(&qp->state_lock);
 	}
+}
+
+static inline enum comp_state complete_ack(struct rxe_qp *qp,
+					   struct rxe_pkt_info *pkt,
+					   struct rxe_send_wqe *wqe)
+{
+	if (wqe->has_rd_atomic) {
+		wqe->has_rd_atomic = 0;
+		atomic_inc(&qp->req.rd_atomic);
+		if (qp->req.need_rd_atomic) {
+			qp->comp.timeout_retry = 0;
+			qp->req.need_rd_atomic = 0;
+			rxe_sched_task(&qp->req.task);
+		}
+	}
+
+	comp_check_sq_drain_done(qp);
 
 	do_complete(qp, wqe);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8a8242512f2a..f329038efbc8 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -108,17 +108,12 @@ void rnr_nak_timer(struct timer_list *t)
 	rxe_sched_task(&qp->req.task);
 }
 
-static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
+static void req_check_sq_drain_done(struct rxe_qp *qp)
 {
-	struct rxe_send_wqe *wqe;
 	struct rxe_queue *q = qp->sq.queue;
 	unsigned int index = qp->req.wqe_index;
-	unsigned int cons;
-	unsigned int prod;
-
-	wqe = queue_head(q, QUEUE_TYPE_FROM_CLIENT);
-	cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
-	prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
+	unsigned int cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
+	struct rxe_send_wqe *wqe = queue_addr_from_index(q, cons);
 
 	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
 		/* check to see if we are drained;
@@ -126,18 +121,14 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		 */
 		spin_lock_bh(&qp->state_lock);
 		do {
-			if (!qp->attr.sq_draining) {
+			if (!qp->attr.sq_draining)
 				/* comp just finished */
-				spin_unlock_bh(&qp->state_lock);
 				break;
-			}
 
 			if (wqe && ((index != cons) ||
-				(wqe->state != wqe_state_posted))) {
+				(wqe->state != wqe_state_posted)))
 				/* comp not done yet */
-				spin_unlock_bh(&qp->state_lock);
 				break;
-			}
 
 			qp->attr.sq_draining = 0;
 			spin_unlock_bh(&qp->state_lock);
@@ -151,9 +142,22 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 				qp->ibqp.event_handler(&ev,
 					qp->ibqp.qp_context);
 			}
+			return;
 		} while (0);
+		spin_unlock_bh(&qp->state_lock);
 	}
+}
 
+static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
+{
+	struct rxe_send_wqe *wqe;
+	struct rxe_queue *q = qp->sq.queue;
+	unsigned int index = qp->req.wqe_index;
+	unsigned int prod;
+
+	req_check_sq_drain_done(qp);
+
+	prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
 	if (index == prod)
 		return NULL;
 
-- 
2.37.2

