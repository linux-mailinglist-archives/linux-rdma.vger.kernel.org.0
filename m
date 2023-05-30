Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5771707F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjE3WN4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjE3WNy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:54 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF18EC
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af93a6166fso3890635a34.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484832; x=1688076832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd+papdTmBQcLij6aQA1Ym+/2ejsB/pepvaXOrJzmTI=;
        b=FZFKfq67+UGMA15Dd6nlbxYsN1dRORDV1AtYitUbO7+P2ODLM32na/h5VCwhwJ3QQo
         3WwWMan2kSnHw+VCkL9o+nDwhLQfGM5Ryf4DHA54yIGFBwSxXCbfoSqRt19bNSDlmJ/p
         GsGJRU4hINj8HNdyRr4pn8kX+FMAf1mE2Ap2av+OWi7IMfoAzFDGB6AtGhHpxO2iIf3o
         nzsuyqO+ifZg2LdW6IdvWR9iHDUMZV89OrfAJvjHRhi2+Z46/dErJI7C74c0/JHTX2FS
         2cG8EbXbzPaDP4WE0TJPT+xMfPUK3PMq+sXzt/sF7UNOvITeJm1+8zTaUv7X7dTuWeV9
         9JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484832; x=1688076832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd+papdTmBQcLij6aQA1Ym+/2ejsB/pepvaXOrJzmTI=;
        b=F9jxeraa3cVLUMY8Xj+B/7vgb+GkEB28MDdW9EKXloOKZnXFAyO4t48XykldnJzsva
         SsWfqlR6mJkMJmgRGW1aekgJJ2zkC+H4+LE3wCgwxvR+0j+cs81UJXZ3qEKC/mar/yaV
         3VHwyxh2cnbOsi/Sakxdyy1d4lMlT2jJ8arlWmZhGIpMUv96pmoZxm75s2CKdmrbvnEe
         vqy30rwa83XyJAvz1xR/K7+IBe4hzCawjOya03SspLWYzpzzCaiEEWjRMTO2KiDmEHGV
         sqnWcc2jOfXDpRyraDZp7dzcgc1Er5XnZB3gze2KBN06dfJxmkn7R5EjhfyLmQhWseHY
         IjCg==
X-Gm-Message-State: AC+VfDxwpzeGjST825tOBdGLl1ur7SgOcuuRRUvLfBTdtyAoKshpUC9m
        j41gL4Ybs/Q/tmJopz9bx0wczAGbPv8=
X-Google-Smtp-Source: ACHHUZ7OEYE0MN0AJ49LwmQpl6hbrdWdHpoq8M/Y/A7Uqgj6oDxtKMfGGXqQtebUvEBdc2pcLUZJYw==
X-Received: by 2002:a05:6808:291a:b0:394:39dc:a4b0 with SMTP id ev26-20020a056808291a00b0039439dca4b0mr1567324oib.52.1685484832542;
        Tue, 30 May 2023 15:13:52 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/6] RDMA/rxe: Introduce rxe access supported flags
Date:   Tue, 30 May 2023 17:13:33 -0500
Message-Id: <20230530221334.89432-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530221334.89432-1-rpearsonhpe@gmail.com>
References: <20230530221334.89432-1-rpearsonhpe@gmail.com>
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

Introduce supported bit masks for setting the access attributes
of MWs, MRs, and QPs. Check these when attributes are set.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c    |  5 +++++
 drivers/infiniband/sw/rxe/rxe_qp.c    |  7 +++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  6 ++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h | 15 ++++++++++++---
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index a7ec57ab8fad..d8a43d87de93 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -197,6 +197,11 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr = NULL;
 	}
 
+	if (access & ~RXE_ACCESS_SUPPORTED_MW) {
+		rxe_err_mw(mw, "access %#x not supported", access);
+		return -EOPNOTSUPP;
+	}
+
 	spin_lock_bh(&mw->lock);
 
 	ret = rxe_check_bind_mw(qp, wqe, mw, mr, access);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c5451a4488ca..95d4a6760c33 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -392,6 +392,13 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 	if (mask & IB_QP_CAP && rxe_qp_chk_cap(rxe, &attr->cap, !!qp->srq))
 		goto err1;
 
+	if (mask & IB_QP_ACCESS_FLAGS) {
+		if (!(qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_UC))
+			goto err1;
+		if (attr->qp_access_flags & ~RXE_ACCESS_SUPPORTED_QP)
+			goto err1;
+	}
+
 	if (mask & IB_QP_AV && rxe_av_chk_attr(qp, &attr->ah_attr))
 		goto err1;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index dea605b7f683..bb2b9d40e242 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1260,6 +1260,12 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	struct rxe_mr *mr;
 	int err, cleanup_err;
 
+	if (access & ~RXE_ACCESS_SUPPORTED_MR) {
+		rxe_err_pd(pd, "access = %#x not supported (%#x)", access,
+				RXE_ACCESS_SUPPORTED_MR);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 0a2b7343e38f..2f2dc67f03dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -253,10 +253,19 @@ struct rxe_qp {
 	struct execute_work	cleanup_work;
 };
 
-enum rxe_access {
-	RXE_ACCESS_REMOTE	= (IB_ACCESS_REMOTE_READ
+enum {
+	RXE_ACCESS_REMOTE	= IB_ACCESS_REMOTE_READ
 				| IB_ACCESS_REMOTE_WRITE
-				| IB_ACCESS_REMOTE_ATOMIC),
+				| IB_ACCESS_REMOTE_ATOMIC,
+	RXE_ACCESS_SUPPORTED_MR	= RXE_ACCESS_REMOTE
+				| IB_ACCESS_LOCAL_WRITE
+				| IB_ACCESS_MW_BIND
+				| IB_ACCESS_ON_DEMAND
+				| IB_ACCESS_FLUSH_GLOBAL
+				| IB_ACCESS_FLUSH_PERSISTENT,
+	RXE_ACCESS_SUPPORTED_QP	= RXE_ACCESS_SUPPORTED_MR,
+	RXE_ACCESS_SUPPORTED_MW	= RXE_ACCESS_SUPPORTED_MR
+				| IB_ZERO_BASED,
 };
 
 enum rxe_mr_state {
-- 
2.39.2

