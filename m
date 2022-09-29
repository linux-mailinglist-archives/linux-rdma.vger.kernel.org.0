Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD455EFB9F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiI2RJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiI2RJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:12 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1C1CEDF5
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:09 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131886d366cso2535183fac.10
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FS69ZhqHhf8a+VG0KKc2dMHFF+UrTR+gxCYXxxxws8A=;
        b=Oif+/QzPl6V5U9AbpnAFyVTg2JetTGFZ+Aq8Hxbk/h6JiDxMj5Pvdofni3c/DuDtZy
         LJB1gZaMn1ue+EgtT3RlqEmGlNLrOSV+GgwFmGKgiGxPrFaoOItvwIel4VqJaZACgw5z
         7Z8pZPX+6bPOj6bGQxyWCo6t4Ymv1TXkwpL6ozJFitcTXz+l4hS/39UJhQD3ibj5Ov07
         nbTfn/mfmGv7tnX939dXa5+CWsZOd6kxyYlOKq1wsiFpZxqIs78TBI3Dk8sv1ddzTnH+
         9mmeNJpY8BTjTjIxfWns8XsVslsX3XqqC1w0QcthdPZX/012VeUtiSod36noz4CN4bR1
         d8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FS69ZhqHhf8a+VG0KKc2dMHFF+UrTR+gxCYXxxxws8A=;
        b=oB4y/h9edgKDveWEQZPZ4qo7EWq1jvYXmbjgjHS2L03wqASQOtnKEbE66pcAdklfjW
         9+Y9mrGmSLPLW3CrsJz9OhUW/YJ7ozRhmfLsrU6wb3anj3BFkfshhp0abuAMsFZxNDmH
         xtWOr8aCGLAsiiQUEY90iMTxS8/hlX+ZXeIqotNLHQfInN5dmUzsdabilwnzT7yHMZZT
         RHvK2VF5ET+2km8V5i2DWSqgd143jR2u1cprXOao4HDbX5sKzkmRft8sGI+bg2PeE38z
         eZJkb7E//DghbEabXdfgUlBSlVQTOobuaDeWNjf+TMTDSwkfDjivW2njuWTkPIm9JzD8
         JpdA==
X-Gm-Message-State: ACrzQf1pYG568tH/kP6t9/GqLTI9ikr9hH1g1TPDX0qPpmtDn/b//xij
        Io5E2Nw98bclqwrpVVvsvTc=
X-Google-Smtp-Source: AMsMyM7ib/vyranZHO7RtgSr5HL21JxN5F2YoWB/E00OUvIi/4Tfy1HXe2kdsDHhnfHtpmfaAZYwJg==
X-Received: by 2002:a05:6870:fbaa:b0:131:a07e:c93c with SMTP id kv42-20020a056870fbaa00b00131a07ec93cmr5913933oab.131.1664471348383;
        Thu, 29 Sep 2022 10:09:08 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 02/13] RDMA/rxe: Move next_opcode() to rxe_opcode.c
Date:   Thu, 29 Sep 2022 12:08:26 -0500
Message-Id: <20220929170836.17838-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move next_opcode() from rxe_req.c to rxe_opcode.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h    |   3 +
 drivers/infiniband/sw/rxe/rxe_opcode.c | 156 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 156 -------------------------
 3 files changed, 157 insertions(+), 158 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..a806737168d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -99,6 +99,9 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 
+/* opcode.c */
+int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe, u32 opcode);
+
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 0ea587c15931..6b1a1f197c4d 100644
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
@@ -919,3 +919,155 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	},
 
 };
+
+static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
+{
+	switch (opcode) {
+	case IB_WR_RDMA_WRITE:
+		if (qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_LAST :
+				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_ONLY :
+				IB_OPCODE_RC_RDMA_WRITE_FIRST;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_RC_RDMA_WRITE_FIRST;
+
+	case IB_WR_SEND:
+		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY :
+				IB_OPCODE_RC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_RC_SEND_FIRST;
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
+	case IB_WR_SEND_WITH_INV:
+		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ? IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ? IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE :
+				IB_OPCODE_RC_SEND_FIRST;
+	case IB_WR_REG_MR:
+	case IB_WR_LOCAL_INV:
+		return opcode;
+	}
+
+	return -EINVAL;
+}
+
+static int next_opcode_uc(struct rxe_qp *qp, u32 opcode, int fits)
+{
+	switch (opcode) {
+	case IB_WR_RDMA_WRITE:
+		if (qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_LAST :
+				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_ONLY :
+				IB_OPCODE_UC_RDMA_WRITE_FIRST;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_UC_RDMA_WRITE_FIRST;
+
+	case IB_WR_SEND:
+		if (qp->req.opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_SEND_LAST :
+				IB_OPCODE_UC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_SEND_ONLY :
+				IB_OPCODE_UC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_SEND_MIDDLE)
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
+int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe, u32 opcode)
+{
+	int fits = (wqe->dma.resid <= qp->mtu);
+
+	switch (qp_type(qp)) {
+	case IB_QPT_RC:
+		return next_opcode_rc(qp, opcode, fits);
+
+	case IB_QPT_UC:
+		return next_opcode_uc(qp, opcode, fits);
+
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		switch (opcode) {
+		case IB_WR_SEND:
+			return IB_OPCODE_UD_SEND_ONLY;
+
+		case IB_WR_SEND_WITH_IMM:
+			return IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e136abc802af..d2a9abfed596 100644
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
@@ -194,159 +191,6 @@ static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
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
-- 
2.34.1

