Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870C5BB5BE
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIQDKt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQDKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:10:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559EF4DF25
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x23-20020a056830409700b00655c6dace73so13827190ott.11
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dZydl9VOtrbPxiFnDDs3otuazpDHAJBf6IwhOk9Dnjk=;
        b=DH1E/t4Odsxrl3hdAcN3MAydOyE7894VjQs7/lXXEo2gW0/ro8yt4rRXrOHDKUHsqQ
         HY1baXqqmtw92iImn9W/k5lq9Jhcn6CUpmlm986mo9z9eertYnQvlKVdmcUVdS2B7Yyj
         YeG4sGh2Q/9aykRiawVU2VA7qVehUUvbU2n0LMKTUfVaMUEn0+04GUDV/2fw9VB28RUm
         2QL1m38Z89FY3ov/rebFfLz8kaN25WBo96Hl7GIJsCouYE9dYRVqX4j0TVvzJfcJNdJw
         jwQD4yUm+RLYHuRddE9DbTKYItMwDyFbC6YoIBO1tChqYywP1vcIfRPoZSEsELJ9Jj+g
         BbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dZydl9VOtrbPxiFnDDs3otuazpDHAJBf6IwhOk9Dnjk=;
        b=xKbMGpiwJ5iCfM7D7z53p/DpcFojg13wnmhVpRH6J2ipcOYe45+MT3byuHSbmlwEZL
         GMQg+UDmZmbrFQBDUz70wH8K8+Pp66QCLVqdT5zUeqFRap6I7itxMqZvt7Jirq4ZSVPp
         8mtdadSo2jss72tSHEAXuti3uUs/hvhqUpKNEzrbKbRG2vS4EXda2HxUn/LFvatOPF1u
         jW8ZDcDSRz8vokvmyD7a7TwT13FDd6Jt7IRRX0MgXvAfmu/0hy9iWGqKZBCGQ9/LlLFi
         7/WUBwwlvLcdvqhl+DFKicuDUZTvFQ5lNe/P59HrRmDWOWKzvivz+JpUXAss+9Ds97im
         6FTg==
X-Gm-Message-State: ACrzQf2GkA5z104vXwyUBllTrTvcqGpTyBsVgHvEvp3FrrG2XQCTJOJH
        x9TGJ+f+qhYq0sB/smnQBxGvWrEBaaQ=
X-Google-Smtp-Source: AMsMyM55kHkoKdvG7iwps8sdedeBuofO5kGEl2StMDVFjmoCIPb65ScRrcQBjwOGzN84YQVWpoIbFQ==
X-Received: by 2002:a05:6830:4422:b0:658:7273:1955 with SMTP id q34-20020a056830442200b0065872731955mr3576232otv.60.1663384244529;
        Fri, 16 Sep 2022 20:10:44 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm4464800oab.3.2022.09.16.20.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:10:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 02/13] RDMA/rxe: Move next_opcode() to rxe_opcode.c
Date:   Fri, 16 Sep 2022 22:10:21 -0500
Message-Id: <20220917031028.21187-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031028.21187-1-rpearsonhpe@gmail.com>
References: <20220917031028.21187-1-rpearsonhpe@gmail.com>
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
index 22f6cc31d1d6..5526d83697c7 100644
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

