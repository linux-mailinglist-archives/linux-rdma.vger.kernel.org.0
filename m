Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80934765C24
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjG0T3j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjG0T3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:35 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD23585
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:30 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55e1ae72dceso945581eaf.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486169; x=1691090969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaJEk5vt2+/wifPhSnLjuk98YQwix/8lRPzZb8SRjVY=;
        b=Q1A0A9K9xG1/+A9wggaii/E9IA5os8hi0QIfYtSF01BQJGV38uVPT79sg1piGLN7jk
         btxbiel1+TD40nEXHoaPP0yAiiSCg6eIiCEwti8Ni1QZDnoWP4iEpcur2xjt0QWJwqnm
         gPFk0MeSkjoS6y3yu17nI6yuuk5LUNSrfWpAhybyWRuV1RKCNqBF3cCxkEQEkaiUG8FW
         /WTbEGVxmen+JmoaCb3WQeKTH0DvKtGZy9N4HL3oA9N/OAh+wCxfvETov8zfLZHRr7aW
         S8iwOjcEyMXG4MAXVlDyZ5kq/WCosz3g3Mnr9nGmUhgj/27D4Y0k7TA+uN0NuvA0Hzoi
         PptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486169; x=1691090969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaJEk5vt2+/wifPhSnLjuk98YQwix/8lRPzZb8SRjVY=;
        b=RlNRiFK7XUTvTIy3SQgCt80oqMyKrEJnyn7UnDOmk7qvefWFNCToUyu7onP6/cLhry
         jaMB5BBX1iNJgtzwXYEMNNhHHIDBVPtZatpzEMdfk4Ru7OwRV67x2vjzyWbCgNGShUhh
         G9VSIttjC/STi+0KPKmnYu5f2gb9WOfiBo5EfqftbMaGF7mBNn3suOFK0ij1+A60drfu
         d682tvHeGOmzVmMUj130LIzXQRC5BByjTAsK1gSqDW2ZfxeP7WzuD+nJQvaqa/3su/bv
         Ayhcanr92MnODp30QsxqR/94EGLpRKGSdkDAYkBw9gOPE/56RxqlOUqYnAB5qS6U32cK
         C9Ww==
X-Gm-Message-State: ABy/qLatSwEGjfxXZI7vqdTFpn/nDBl6m+v0NFilxfYe9nngbshZsNST
        wfpCVzRm4imypd66Tyqp4xA=
X-Google-Smtp-Source: APBJJlF7tv3GLRfRKkTz246OamsaFfya1ER8X0oGthWqCjVRU7HKEm07KZCa7Me+AgpZkCEd7Ed8Cg==
X-Received: by 2002:a4a:8201:0:b0:566:f8ee:fa67 with SMTP id d1-20020a4a8201000000b00566f8eefa67mr455270oog.0.1690486169156;
        Thu, 27 Jul 2023 12:29:29 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 8/8] RDMA/rxe: Move next_opcode to rxe_opcode.c
Date:   Thu, 27 Jul 2023 14:28:32 -0500
Message-Id: <20230727192831.65495-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Localize opcode specific code to rxe_opcode.c by moving next_opcode()
to rxe_next_req_opcode() in rxe_opcode.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 176 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   4 +
 drivers/infiniband/sw/rxe/rxe_req.c    | 173 +-----------------------
 3 files changed, 183 insertions(+), 170 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 5c0d5c6ffda4..f358b732a751 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -5,8 +5,8 @@
  */
 
 #include <rdma/ib_pack.h>
-#include "rxe_opcode.h"
-#include "rxe_hdr.h"
+
+#include "rxe.h"
 
 /* useful information about work request opcodes and pkt opcodes in
  * table form
@@ -973,3 +973,175 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	},
 
 };
+
+static int next_opcode_rc(int last_opcode, u32 wr_opcode, bool fits)
+{
+	switch (wr_opcode) {
+	case IB_WR_RDMA_WRITE:
+		if (last_opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
+		    last_opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_LAST :
+				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_ONLY :
+				IB_OPCODE_RC_RDMA_WRITE_FIRST;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (last_opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
+		    last_opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_RC_RDMA_WRITE_FIRST;
+
+	case IB_WR_SEND:
+		if (last_opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    last_opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY :
+				IB_OPCODE_RC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_IMM:
+		if (last_opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    last_opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_RC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_INV:
+		if (last_opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    last_opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE :
+				IB_OPCODE_RC_SEND_FIRST;
+
+	case IB_WR_FLUSH:
+		return IB_OPCODE_RC_FLUSH;
+
+	case IB_WR_RDMA_READ:
+		return IB_OPCODE_RC_RDMA_READ_REQUEST;
+
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+		return IB_OPCODE_RC_COMPARE_SWAP;
+
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		return IB_OPCODE_RC_FETCH_ADD;
+
+	case IB_WR_ATOMIC_WRITE:
+		return IB_OPCODE_RC_ATOMIC_WRITE;
+
+	case IB_WR_REG_MR:
+	case IB_WR_LOCAL_INV:
+		return OPCODE_NONE;	/* not used */
+	}
+
+	return -EINVAL;
+}
+
+static int next_opcode_uc(int last_opcode, u32 wr_opcode, bool fits)
+{
+	switch (wr_opcode) {
+	case IB_WR_RDMA_WRITE:
+		if (last_opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    last_opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_LAST :
+				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_ONLY :
+				IB_OPCODE_UC_RDMA_WRITE_FIRST;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (last_opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    last_opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_UC_RDMA_WRITE_FIRST;
+
+	case IB_WR_SEND:
+		if (last_opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    last_opcode == IB_OPCODE_UC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_SEND_LAST :
+				IB_OPCODE_UC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_SEND_ONLY :
+				IB_OPCODE_UC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_IMM:
+		if (last_opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    last_opcode == IB_OPCODE_UC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_UC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_UC_SEND_FIRST;
+	}
+
+	return -EINVAL;
+}
+
+/* compute next requester packet opcode
+ * assumes caller is following the sequence rules
+ */
+int next_req_opcode(struct rxe_qp *qp, int resid, u32 wr_opcode)
+{
+	int fits = resid <= qp->mtu;
+	int last_opcode = qp->req.opcode;
+	int ret;
+
+	switch (qp_type(qp)) {
+	case IB_QPT_RC:
+		ret = next_opcode_rc(last_opcode, wr_opcode, fits);
+		break;
+	case IB_QPT_UC:
+		ret = next_opcode_uc(last_opcode, wr_opcode, fits);
+		break;
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		switch (wr_opcode) {
+		case IB_WR_SEND:
+			ret = IB_OPCODE_UD_SEND_ONLY;
+			break;
+		case IB_WR_SEND_WITH_IMM:
+			ret = IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret == -EINVAL)
+		rxe_err_qp(qp, "unable to compute next opcode");
+	return ret;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 5686b691d6b8..61030d9c299f 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -7,6 +7,8 @@
 #ifndef RXE_OPCODE_H
 #define RXE_OPCODE_H
 
+struct rxe_qp;
+
 /*
  * contains header bit mask definitions and header lengths
  * declaration of the rxe_opcode_info struct and
@@ -108,4 +110,6 @@ struct rxe_opcode_info {
 
 extern struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE];
 
+int next_req_opcode(struct rxe_qp *qp, int resid, u32 wr_opcode);
+
 #endif /* RXE_OPCODE_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 4db1bacdfdb8..51b781ac2844 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -11,9 +11,6 @@
 #include "rxe_loc.h"
 #include "rxe_queue.h"
 
-static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-		       u32 opcode);
-
 static inline void retry_first_write_send(struct rxe_qp *qp,
 					  struct rxe_send_wqe *wqe, int npsn)
 {
@@ -23,8 +20,8 @@ static inline void retry_first_write_send(struct rxe_qp *qp,
 		int to_send = (wqe->dma.resid > qp->mtu) ?
 				qp->mtu : wqe->dma.resid;
 
-		qp->req.opcode = next_opcode(qp, wqe,
-					     wqe->wr.opcode);
+		qp->req.opcode = next_req_opcode(qp, wqe->dma.resid,
+						 wqe->wr.opcode);
 
 		if (wqe->wr.send_flags & IB_SEND_INLINE) {
 			wqe->dma.resid -= to_send;
@@ -51,7 +48,7 @@ static void req_retry(struct rxe_qp *qp)
 
 	qp->req.wqe_index	= cons;
 	qp->req.psn		= qp->comp.psn;
-	qp->req.opcode		= -1;
+	qp->req.opcode		= OPCODE_NONE;
 
 	for (wqe_index = cons; wqe_index != prod;
 			wqe_index = queue_next_index(q, wqe_index)) {
@@ -221,166 +218,6 @@ static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
 }
 
-static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
-{
-	switch (opcode) {
-	case IB_WR_RDMA_WRITE:
-		if (qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
-		    qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
-			return fits ?
-				IB_OPCODE_RC_RDMA_WRITE_LAST :
-				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_RC_RDMA_WRITE_ONLY :
-				IB_OPCODE_RC_RDMA_WRITE_FIRST;
-
-	case IB_WR_RDMA_WRITE_WITH_IMM:
-		if (qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
-		    qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
-			return fits ?
-				IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
-				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
-				IB_OPCODE_RC_RDMA_WRITE_FIRST;
-
-	case IB_WR_SEND:
-		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
-		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
-			return fits ?
-				IB_OPCODE_RC_SEND_LAST :
-				IB_OPCODE_RC_SEND_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_RC_SEND_ONLY :
-				IB_OPCODE_RC_SEND_FIRST;
-
-	case IB_WR_SEND_WITH_IMM:
-		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
-		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
-			return fits ?
-				IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE :
-				IB_OPCODE_RC_SEND_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
-				IB_OPCODE_RC_SEND_FIRST;
-
-	case IB_WR_FLUSH:
-		return IB_OPCODE_RC_FLUSH;
-
-	case IB_WR_RDMA_READ:
-		return IB_OPCODE_RC_RDMA_READ_REQUEST;
-
-	case IB_WR_ATOMIC_CMP_AND_SWP:
-		return IB_OPCODE_RC_COMPARE_SWAP;
-
-	case IB_WR_ATOMIC_FETCH_AND_ADD:
-		return IB_OPCODE_RC_FETCH_ADD;
-
-	case IB_WR_SEND_WITH_INV:
-		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
-		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
-			return fits ? IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE :
-				IB_OPCODE_RC_SEND_MIDDLE;
-		else
-			return fits ? IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE :
-				IB_OPCODE_RC_SEND_FIRST;
-
-	case IB_WR_ATOMIC_WRITE:
-		return IB_OPCODE_RC_ATOMIC_WRITE;
-
-	case IB_WR_REG_MR:
-	case IB_WR_LOCAL_INV:
-		return opcode;
-	}
-
-	return -EINVAL;
-}
-
-static int next_opcode_uc(struct rxe_qp *qp, u32 opcode, int fits)
-{
-	switch (opcode) {
-	case IB_WR_RDMA_WRITE:
-		if (qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
-		    qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
-			return fits ?
-				IB_OPCODE_UC_RDMA_WRITE_LAST :
-				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_UC_RDMA_WRITE_ONLY :
-				IB_OPCODE_UC_RDMA_WRITE_FIRST;
-
-	case IB_WR_RDMA_WRITE_WITH_IMM:
-		if (qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
-		    qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
-			return fits ?
-				IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
-				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
-				IB_OPCODE_UC_RDMA_WRITE_FIRST;
-
-	case IB_WR_SEND:
-		if (qp->req.opcode == IB_OPCODE_UC_SEND_FIRST ||
-		    qp->req.opcode == IB_OPCODE_UC_SEND_MIDDLE)
-			return fits ?
-				IB_OPCODE_UC_SEND_LAST :
-				IB_OPCODE_UC_SEND_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_UC_SEND_ONLY :
-				IB_OPCODE_UC_SEND_FIRST;
-
-	case IB_WR_SEND_WITH_IMM:
-		if (qp->req.opcode == IB_OPCODE_UC_SEND_FIRST ||
-		    qp->req.opcode == IB_OPCODE_UC_SEND_MIDDLE)
-			return fits ?
-				IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE :
-				IB_OPCODE_UC_SEND_MIDDLE;
-		else
-			return fits ?
-				IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE :
-				IB_OPCODE_UC_SEND_FIRST;
-	}
-
-	return -EINVAL;
-}
-
-static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-		       u32 opcode)
-{
-	int fits = (wqe->dma.resid <= qp->mtu);
-
-	switch (qp_type(qp)) {
-	case IB_QPT_RC:
-		return next_opcode_rc(qp, opcode, fits);
-
-	case IB_QPT_UC:
-		return next_opcode_uc(qp, opcode, fits);
-
-	case IB_QPT_UD:
-	case IB_QPT_GSI:
-		switch (opcode) {
-		case IB_WR_SEND:
-			return IB_OPCODE_UD_SEND_ONLY;
-
-		case IB_WR_SEND_WITH_IMM:
-			return IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE;
-		}
-		break;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static inline int check_init_depth(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	int depth;
@@ -761,7 +598,7 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(qp_state(qp) == IB_QPS_RESET)) {
 		qp->req.wqe_index = queue_get_consumer(q,
 						QUEUE_TYPE_FROM_CLIENT);
-		qp->req.opcode = -1;
+		qp->req.opcode = OPCODE_NONE;
 		qp->req.need_rd_atomic = 0;
 		qp->req.wait_psn = 0;
 		qp->req.need_retry = 0;
@@ -813,7 +650,7 @@ int rxe_requester(struct rxe_qp *qp)
 		goto exit;
 	}
 
-	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
+	opcode = next_req_opcode(qp, wqe->dma.resid, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err;
-- 
2.39.2

