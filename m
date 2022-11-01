Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1087261532B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKAUX7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKAUXz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:55 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA361EC65
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:52 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13c569e5ff5so17714133fac.6
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr1kvXJvgw1UbM8mu0WDkZsP/Lg9tsuyirjps0ms1hY=;
        b=q5Zae9mV6+Wmh9P5lNTFDzydh6VS79sPRiXtpWqSqgAtdUrUKC0p5wKLLqLu9N8ha7
         bgZt9oq3ns7RxBk5PDLSeyG0YC/x4qPJXoqM08MGZ5XngSPzTg9C1jFZQHgYKVgCOuMq
         i4Mitklsr7T+24oqYc7RD/R2jvEEqtat5T6XMYeSZYlSjIB4Vm0R9UpWHBbVBlmW3djy
         3GQjyLVCVjNvg+jsVuH7p3ETYC27VLGOORqPJXGQQ7z/7Aw1mBj5t2YsNHFU1wmgjuzq
         Jq/3Rqrolpsm4+nEEjq0lU1dMHcAaut8j/lBaHT5p98D3+SzGkh68cR2WYRlSNnz4RNZ
         XYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr1kvXJvgw1UbM8mu0WDkZsP/Lg9tsuyirjps0ms1hY=;
        b=Nt9k6/7T7l699rd5g1EcZhRhN9s8i1i6UyadJC/qghPJn8YuN6Ta3TQ9A9ges05IY3
         pkLI6Vs9UyP6adSQqhF5Id6fExvGNyf6j9Yg2ut97UPR78T09qC2lT2YzdjUcWcj7sbU
         Eb1BpbwMGB2+hpWRyFjt/WaHY4rOXuyKoPyDedKXoaLrgOjgWHLRkpt+hymCuIOolqlV
         V5CLAAKyBq2p3xI/08q6ofuvRF41XqLyZOV7Kf1uVRpg1hWnkwfi6uPMq4c8ZItlKiRB
         CL2yjeiMMYpaKGougnq/ghIovIP9l2FEsRRSWV9yW858yo5eNL/nadgT9kPQM8XSqjss
         /Uqg==
X-Gm-Message-State: ACrzQf18I3OD2CEnbDimiugsi3j74htMI5mpI/SFS1sVgpFecRCym3kV
        /GumZUdvVowOMT9A46aTZcRzs7sDLOI=
X-Google-Smtp-Source: AMsMyM7uz76uIMYQEgSiGLN8YtSoLKLsouGkCuZ0ztidy87MiSZZsL/VPIDY0/Sbn5S2Ydblell1iQ==
X-Received: by 2002:a05:6870:4607:b0:127:fd93:4752 with SMTP id z7-20020a056870460700b00127fd934752mr21867085oao.64.1667334232249;
        Tue, 01 Nov 2022 13:23:52 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_mw in rxe_mw.c
Date:   Tue,  1 Nov 2022 15:22:30 -0500
Message-Id: <20221101202238.32836-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to rxe_err/warn() int rxe_mw.c with rxe_dbg_mw().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 8df1c9066ed8..afa5ce1a7116 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -52,14 +52,14 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 {
 	if (mw->ibmw.type == IB_MW_TYPE_1) {
 		if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
-			pr_err_once(
+			rxe_dbg_mw(mw,
 				"attempt to bind a type 1 MW not in the valid state\n");
 			return -EINVAL;
 		}
 
 		/* o10-36.2.2 */
 		if (unlikely((mw->access & IB_ZERO_BASED))) {
-			pr_err_once("attempt to bind a zero based type 1 MW\n");
+			rxe_dbg_mw(mw, "attempt to bind a zero based type 1 MW\n");
 			return -EINVAL;
 		}
 	}
@@ -67,21 +67,21 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	if (mw->ibmw.type == IB_MW_TYPE_2) {
 		/* o10-37.2.30 */
 		if (unlikely(mw->state != RXE_MW_STATE_FREE)) {
-			pr_err_once(
+			rxe_dbg_mw(mw,
 				"attempt to bind a type 2 MW not in the free state\n");
 			return -EINVAL;
 		}
 
 		/* C10-72 */
 		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
-			pr_err_once(
+			rxe_dbg_mw(mw,
 				"attempt to bind type 2 MW with qp with different PD\n");
 			return -EINVAL;
 		}
 
 		/* o10-37.2.40 */
 		if (unlikely(!mr || wqe->wr.wr.mw.length == 0)) {
-			pr_err_once(
+			rxe_dbg_mw(mw,
 				"attempt to invalidate type 2 MW by binding with NULL or zero length MR\n");
 			return -EINVAL;
 		}
@@ -92,13 +92,13 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		return 0;
 
 	if (unlikely(mr->access & IB_ZERO_BASED)) {
-		pr_err_once("attempt to bind MW to zero based MR\n");
+		rxe_dbg_mw(mw, "attempt to bind MW to zero based MR\n");
 		return -EINVAL;
 	}
 
 	/* C10-73 */
 	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
-		pr_err_once(
+		rxe_dbg_mw(mw,
 			"attempt to bind an MW to an MR without bind access\n");
 		return -EINVAL;
 	}
@@ -107,7 +107,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	if (unlikely((mw->access &
 		      (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
 		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
-		pr_err_once(
+		rxe_dbg_mw(mw,
 			"attempt to bind an Writable MW to an MR without local write access\n");
 		return -EINVAL;
 	}
@@ -115,7 +115,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	/* C10-75 */
 	if (mw->access & IB_ZERO_BASED) {
 		if (unlikely(wqe->wr.wr.mw.length > mr->ibmr.length)) {
-			pr_err_once(
+			rxe_dbg_mw(mw,
 				"attempt to bind a ZB MW outside of the MR\n");
 			return -EINVAL;
 		}
@@ -123,7 +123,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		if (unlikely((wqe->wr.wr.mw.addr < mr->ibmr.iova) ||
 			     ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
 			      (mr->ibmr.iova + mr->ibmr.length)))) {
-			pr_err_once(
+			rxe_dbg_mw(mw,
 				"attempt to bind a VA MW outside of the MR\n");
 			return -EINVAL;
 		}
-- 
2.34.1

