Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10C96185DD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiKCRLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238426EA
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:39 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso2852089fac.13
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAhrhygiKpzQWMvqyQHcGjEEPmdXIk28dvB9t+mYowY=;
        b=C23sEtwNRi/Mz9qqOmLkEd20+DeguoXxMWtfG2QVdZphsaaj1oKwmSnOe9G/CuC5U5
         Pp6vdgL4q9lOdX6TT3nTFqVySkNg+IEcsCT/NCxbXMY42zGVD2TiNnU447Sb9J9Q/8Fn
         dnzOlGz+gKiGSAAPW5IiqE2SeCFCs7XPlUu2FK98/jL0zWIQLpLQXkCTw7baw/Ru+jTw
         2ZtgHpul+VzoF46HUMuAq5M07JLkONxTfMmxoWJm9QqjR0CBL3bhX/8afrVEm0avJSIy
         fAp2BaGvygt0uMZY9JaLRRMylD16ZJQe97eGQIkuCN7BvCwnl0xPOfE/8mNrooY5XY8Y
         y3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAhrhygiKpzQWMvqyQHcGjEEPmdXIk28dvB9t+mYowY=;
        b=eUaS3vmxIdQS/s09Wpg4/lSUushqnGrV4h6812Nr17+GJZ2Bq5ne48/cKK4I9uGQIE
         KMqgcKmltyFk9tK3QOx4QeUNbvi76B/OlbOBjAgGBAGpLEz11Ir5cY6NvaMH6IuQtryv
         wmXmFD+xLYKuDGL9ra35HLOHgETARvXN9IkwSavRke9hyO0K2JTqmkJrtOWp/4deioIw
         2CbdHdZVocoZlNvdD75KTlnLxE//po1I09kcO/XmOeuYKhMx3jvuZDeJdz1g3Mmd3JJc
         QT/66c5jC7XL6d1jB/G+5G9FxNT4Ph3cqzq4SiLLYJr9CXwUvMlmhohf9BnB2QAfxH+m
         qyvA==
X-Gm-Message-State: ACrzQf0xeYp2RSZdpYQVjUfmTOeZq1ucJwNdseW3WV76Nfow2kwqdG7l
        4F5czj3cOO2kqZpIwFWP/n4=
X-Google-Smtp-Source: AMsMyM4KSX1qwdHXhpUYwb7MoFWxtAYJbSCWFDwfhgAyhP1RkNef9doJLR3Jec19Sa5TtlMA33eL9A==
X-Received: by 2002:a05:6870:9193:b0:13c:f48b:505b with SMTP id b19-20020a056870919300b0013cf48b505bmr14858798oaf.122.1667495438794;
        Thu, 03 Nov 2022 10:10:38 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 05/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
Date:   Thu,  3 Nov 2022 12:10:03 -0500
Message-Id: <20221103171013.20659-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() int rxe_mw.c with rxe_dbg_xxx().

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

