Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A892369FF9F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjBVXfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBVXfl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:41 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639E474EF
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:38 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bm20so9056380oib.7
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb1A4fQFC5zuaBljUu2EFf10hcNUwhzBrinSvotfBis=;
        b=o6q1Qpt1Z4A58O34cwewGqCcrfyrokN6imy2lnlp4gj5SHkwKjAwbCj8bvC0All+dr
         W7DVJK3Plo5cLuTPCmxhD2sAoYdgu/6QlEz6vjCxMQ05MLrebLdaf8cdj1cEv7nOqiBz
         Xl5Ti6iIsf/oixNs2qSr/niQHZEeklV7cPfhSMMzfs3cIaA6vxg8AVRVQ/SVvMUwN5OE
         svh17hJm03k7q1oGP9V+RZiBGH9/xONmt1vi83Oxa4pt1iYKwAkCxnyLh+QTxE865lQz
         Huh7HfkqcfA3DwoVfAuD4DwvBWVbyL13uo731SLXCchyqYoKXw382rdDCQQd+KKTuz7Z
         DUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb1A4fQFC5zuaBljUu2EFf10hcNUwhzBrinSvotfBis=;
        b=el3RUTeTdKWpU6pAYVy2kFn2gx1gkvu8YIX7l+gqbRkyDY8R8hBTRktuMu2SOo44ZR
         4W6mNnW83mNlgnTgqETgUdlcmuSigUOFwiD/gvJUlzbvz3CntYIGPvWpMtAlq9Hv5fKe
         ZQCyTu0qkW3f9S5msHDRq6olFZ9umrOa4gRjmw4Ko0aXcVMnlKp7WWqQ9z2z19xJSeU+
         XoMh4U0JILik0fLhzHvhoc6l23g5pjhEjvkZUTxk8l7mxWAhCePSrkusP+v3Gg9Jd9NG
         m5tKpQNa1AnLWjLPEzAnChdqEkTCdvWSR6z59a8LtYd9NCig19mcEeGiyPGdFCmTIJK1
         cGtw==
X-Gm-Message-State: AO0yUKXdKYfiJcBruS/X0UPp4vSXdfrZZA4FZ6W5h1nDfSJ9C5QU7oaJ
        SJ8xLwON4sDJre3Y1/4vvymOyTS8alQ=
X-Google-Smtp-Source: AK7set/sEIh+bNKXE3n/CJOwnEwGa58j0gcBKkos9l4gnKoNgobMuGZDK+DVwOwjuhjLlnea9z1McA==
X-Received: by 2002:a05:6808:6248:b0:383:b9da:328e with SMTP id dt8-20020a056808624800b00383b9da328emr2834185oib.48.1677108937103;
        Wed, 22 Feb 2023 15:35:37 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 7/9] RDMA/rxe: Check for unsupported wr opcodes
Date:   Wed, 22 Feb 2023 17:32:36 -0600
Message-Id: <20230222233237.48940-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver does not check for unsupported work
request opcodes in posted send work requests. This patch adds
code to do this and immediately return an error if an
unsupported opocode is used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 37 ++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8dfed5f8b6b7..b70403df20ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -695,7 +695,7 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	return -EINVAL;
 }
 
-static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
+static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			 const struct ib_send_wr *ibwr)
 {
 	wr->wr_id = ibwr->wr_id;
@@ -746,11 +746,22 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			wr->wr.reg.key = reg_wr(ibwr)->key;
 			wr->wr.reg.access = reg_wr(ibwr)->access;
 			break;
+		case IB_WR_SEND:
+		case IB_WR_BIND_MW:
+		case IB_WR_RDMA_READ_WITH_INV:
+		case IB_WR_FLUSH:
+		case IB_WR_ATOMIC_WRITE:
+			/* nothing to do here */
+			break;
 		default:
-			WARN_ON(1);
+			rxe_err_qp(qp, "unsupported send wr opcode = %d",
+				   wr->opcode);
+			return -EOPNOTSUPP;
 			break;
 		}
 	}
+
+	return 0;
 }
 
 static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
@@ -766,19 +777,22 @@ static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
 	}
 }
 
-static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
+static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 			 unsigned int mask, unsigned int length,
 			 struct rxe_send_wqe *wqe)
 {
 	int num_sge = ibwr->num_sge;
+	int err;
 
-	init_send_wr(qp, &wqe->wr, ibwr);
+	err = init_send_wr(qp, &wqe->wr, ibwr);
+	if (err)
+		return err;
 
 	/* local operation */
 	if (unlikely(mask & WR_LOCAL_OP_MASK)) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
-		return;
+		return 0;
 	}
 
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
@@ -797,6 +811,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	wqe->dma.sge_offset	= 0;
 	wqe->state		= wqe_state_posted;
 	wqe->ssn		= atomic_add_return(1, &qp->ssn);
+
+	return 0;
 }
 
 static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
@@ -809,8 +825,10 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	int full;
 
 	err = validate_send_wr(qp, ibwr, mask, length);
-	if (err)
+	if (err) {
+		rxe_dbg_qp(qp, "malformed wr");
 		return err;
+	}
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
@@ -822,7 +840,12 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	}
 
 	send_wqe = queue_producer_addr(sq->queue, QUEUE_TYPE_FROM_ULP);
-	init_send_wqe(qp, ibwr, mask, length, send_wqe);
+
+	err = init_send_wqe(qp, ibwr, mask, length, send_wqe);
+	if (err) {
+		rxe_err_qp(qp, "failed to init send wqe");
+		return err;
+	}
 
 	queue_advance_producer(sq->queue, QUEUE_TYPE_FROM_ULP);
 
-- 
2.37.2

