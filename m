Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615153E7F9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiFFOja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiFFOj1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:39:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CC153535
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:39:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m82so19886962oif.13
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/QYRwqsPC9QQxGxg7qWciRwy16PvFOKYnmFeB9KJKo=;
        b=LTxu10YPPd7ycHGk2ftF4kfCskcPPnJ9kaP0gq7HzB50NL1Le9D3uiInryTzrMKLD5
         qXVrE+F4KVE5OIaCUf42ovh8HX+PXtBH1K1V7wEhCGVH4JZgqkSJG3cD7IMR90Bn6Uql
         O6WnaRz1cTylPkpDp+Ne70qyNJxcCWvTScShRXpz80vWCDvm52greyaxOZMOje3IWg2y
         OCEwhkT2WYrbG6olnQQ/Wlh+ZeTBtHOtmZlHPszW+uqOj7C91OzSWpuMbzSYl41dOgLj
         AJZjafWTYmOxOZmfNTOj9l7A5skcibfFbdpzCA4o5jKlI01Z6KuKs/MEp8w8s4qhXxnW
         KGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/QYRwqsPC9QQxGxg7qWciRwy16PvFOKYnmFeB9KJKo=;
        b=KHtfCXg0httdBIvsDTRLYB+URrYI3alcyXWZx8JkTM8Q1evQH/xBPuXgdJO31txaxC
         ODDLShfw7XAtoPzpWeFGNWReSnOUy50aDdtsWPgdbx4uBHXp0gUY4qTcLKQwbwYNdPwI
         NCmX1SNj+2nr9gEo84S7PHfjdRoLuSNfTLbDIGjI9G7wvOclVyuSQH/U/Pp3dU+M4UAh
         2kw0HxIMHqTUz0K4qWfLh2LGO6Aki2bZ04iPR2xDXA5AKW2XnlYW3ATa4miQWPvUVot4
         1yNX54I0CcTKKa0mv8eEokZ0EKmChtHX8fmOJ0v8H4WigvkkbRLWU4hN6S8mtyM8wjJ9
         0KkA==
X-Gm-Message-State: AOAM532xQJNeRU/6cgajB2noUaRC1e2nW9aD+WXRESCmUWjVrCGdaO7O
        iY77CInAt3iTIDalN4lkO7M=
X-Google-Smtp-Source: ABdhPJwJNVjvnDLYiXA9nZQtUGDDNlhNaXSIZnLiw6pYjcoYqsvoDjaDeeSDJbB/EKKEI19v/unK4Q==
X-Received: by 2002:a05:6808:17a8:b0:327:9efa:cf1a with SMTP id bg40-20020a05680817a800b003279efacf1amr28642920oib.81.1654526365614;
        Mon, 06 Jun 2022 07:39:25 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm658335otc.72.2022.06.06.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:39:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/5] RDMA/rxe: Add a responder state for atomic reply
Date:   Mon,  6 Jun 2022 09:38:34 -0500
Message-Id: <20220606143836.3323-3-rpearsonhpe@gmail.com>
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

Add a responder state for atomic reply similar to read reply and
rename process_atomic() rxe_atomic_reply(). In preparation for
merging the normal and retry atomic responder flows.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 69723bc1a071..4babd6fbfefe 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -21,6 +21,7 @@ enum resp_states {
 	RESPST_CHK_RKEY,
 	RESPST_EXECUTE,
 	RESPST_READ_REPLY,
+	RESPST_ATOMIC_REPLY,
 	RESPST_COMPLETE,
 	RESPST_ACKNOWLEDGE,
 	RESPST_CLEANUP,
@@ -55,6 +56,7 @@ static char *resp_state_name[] = {
 	[RESPST_CHK_RKEY]			= "CHK_RKEY",
 	[RESPST_EXECUTE]			= "EXECUTE",
 	[RESPST_READ_REPLY]			= "READ_REPLY",
+	[RESPST_ATOMIC_REPLY]			= "ATOMIC_REPLY",
 	[RESPST_COMPLETE]			= "COMPLETE",
 	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
 	[RESPST_CLEANUP]			= "CLEANUP",
@@ -552,8 +554,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
-static enum resp_states process_atomic(struct rxe_qp *qp,
-				       struct rxe_pkt_info *pkt)
+static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
+					 struct rxe_pkt_info *pkt)
 {
 	u64 *vaddr;
 	enum resp_states ret;
@@ -585,7 +587,16 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 
 	spin_unlock_bh(&atomic_ops_lock);
 
-	ret = RESPST_NONE;
+	qp->resp.msn++;
+
+	/* next expected psn, read handles this separately */
+	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
+
+	qp->resp.opcode = pkt->opcode;
+	qp->resp.status = IB_WC_SUCCESS;
+
+	ret = RESPST_ACKNOWLEDGE;
 out:
 	return ret;
 }
@@ -858,9 +869,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		qp->resp.msn++;
 		return RESPST_READ_REPLY;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
-		err = process_atomic(qp, pkt);
-		if (err)
-			return err;
+		return RESPST_ATOMIC_REPLY;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1327,6 +1336,9 @@ int rxe_responder(void *arg)
 		case RESPST_READ_REPLY:
 			state = read_reply(qp, pkt);
 			break;
+		case RESPST_ATOMIC_REPLY:
+			state = rxe_atomic_reply(qp, pkt);
+			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
 			break;
-- 
2.34.1

