Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844253DAF82
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhG2Wup (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhG2Wup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D5C0613D5
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z26so10523032oih.10
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dADySybeBh700D9C3igRlWoyqesIxs9SLasmU2t384Y=;
        b=bpoz6H1W4+4YOpbX9kCsPr3IsmJMZOl/C/YqxDlej6ZlzzDX17uq7zsekZwil3ecer
         n6l+qJtR1/z+i6pEX+XXTUqOGU5Jt8hunePud72VA/CGa1chmxMLKAtOj9FLqovVrT6S
         PQQNZy21iaWWlIa1WL8m3RWkoz3WoQYNGMtoN3wvV+rQLzW2Xpeh2oF7P/Ne5GnK0G+B
         EBSKxqFLCjD8KQ2GCESRbFsQz9xbjD1Vs12YPVaaGY0Cxjj+qOsgP1nSK1cDFWziJJzG
         OaAzKVOZBenFeyEJOffIV6al3+EqFCFl8QqIIgc4WlWRQ/tAuTFLwKXy73080qOb+Sxm
         /7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dADySybeBh700D9C3igRlWoyqesIxs9SLasmU2t384Y=;
        b=l72nb++wYetHTrKQt4z04KFCy82D9oEMnWiWtLh01fjLHmQoKwopHSIUQx3KCjaTqu
         Hs2fxQAd5juoZ0kCGAVn1ZLaMzyaIMWxOO2JCCEGlGj2JYt1MACn47nK++LFaLyA+qyT
         2jYcg6oli91ZPWMV0fACI0iPf6WC3aTKZhSpSs3cY2Q/EJPt7jKFXyVYsUTmMYYOrvLo
         nC2n3B5dH/Fy8U5cyU223u2sDdrKTLB6/6UKUJ80pbTiw/4Rgs7jfNQWBvfHUvnXnZgO
         GqeesqeYN5vlGBZJqMhwVTwgyZOFahgprTtd/ekdMKDnTzFodtG+JBmR1SOM6v6tkgrF
         HH0Q==
X-Gm-Message-State: AOAM5328bvr4Ka5itdzon0hGIl5VyWJ7mxleqtpS7mQMd/vbBo+0AvKs
        NxZYoURi0+A80jSKFNZqYEM=
X-Google-Smtp-Source: ABdhPJwp7RdTLNpaDfpV/eejNnC2GtjsrOxd0PvVLhKgIkaoTypBqUoasAjdTlOCVAKJG2py3MU5uA==
X-Received: by 2002:a05:6808:ab1:: with SMTP id r17mr3035881oij.136.1627599039996;
        Thu, 29 Jul 2021 15:50:39 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c2sm696832ooo.28.2021.07.29.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 08/13] RDMA/rxe: Support alloc/dealloc xrcd
Date:   Thu, 29 Jul 2021 17:49:11 -0500
Message-Id: <20210729224915.38986-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement code to support ibv_alloc_xrcd and ibv_dealloc_xrcd verbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 39 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_param.h |  1 +
 drivers/infiniband/sw/rxe/rxe_pool.c  |  6 +++++
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 19 +++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h | 12 +++++++++
 6 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..fbbb3d6f172b 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -24,6 +24,7 @@ void rxe_dealloc(struct ib_device *ib_dev)
 
 	rxe_pool_cleanup(&rxe->uc_pool);
 	rxe_pool_cleanup(&rxe->pd_pool);
+	rxe_pool_cleanup(&rxe->xrcd_pool);
 	rxe_pool_cleanup(&rxe->ah_pool);
 	rxe_pool_cleanup(&rxe->srq_pool);
 	rxe_pool_cleanup(&rxe->qp_pool);
@@ -74,6 +75,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
+	rxe->max_xrcd				= RXE_MAX_XRCD;
 }
 
 /* initialize port attributes */
@@ -130,62 +132,69 @@ static int rxe_init_pools(struct rxe_dev *rxe)
 	if (err)
 		goto err2;
 
+	err = rxe_pool_init(rxe, &rxe->xrcd_pool, RXE_TYPE_XRCD,
+			    rxe->max_xrcd);
+	if (err)
+		goto err3;
+
 	err = rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH,
 			    rxe->attr.max_ah);
 	if (err)
-		goto err3;
+		goto err4;
 
 	err = rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ,
 			    rxe->attr.max_srq);
 	if (err)
-		goto err4;
+		goto err5;
 
 	err = rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP,
 			    rxe->attr.max_qp);
 	if (err)
-		goto err5;
+		goto err6;
 
 	err = rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ,
 			    rxe->attr.max_cq);
 	if (err)
-		goto err6;
+		goto err7;
 
 	err = rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR,
 			    rxe->attr.max_mr);
 	if (err)
-		goto err7;
+		goto err8;
 
 	err = rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW,
 			    rxe->attr.max_mw);
 	if (err)
-		goto err8;
+		goto err9;
 
 	err = rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
 			    rxe->attr.max_mcast_grp);
 	if (err)
-		goto err9;
+		goto err10;
 
 	err = rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
 			    rxe->attr.max_total_mcast_qp_attach);
 	if (err)
-		goto err10;
+		goto err11;
 
 	return 0;
 
-err10:
+err11:
 	rxe_pool_cleanup(&rxe->mc_grp_pool);
-err9:
+err10:
 	rxe_pool_cleanup(&rxe->mw_pool);
-err8:
+err9:
 	rxe_pool_cleanup(&rxe->mr_pool);
-err7:
+err8:
 	rxe_pool_cleanup(&rxe->cq_pool);
-err6:
+err7:
 	rxe_pool_cleanup(&rxe->qp_pool);
-err5:
+err6:
 	rxe_pool_cleanup(&rxe->srq_pool);
-err4:
+err5:
 	rxe_pool_cleanup(&rxe->ah_pool);
+err4:
+	rxe_pool_cleanup(&rxe->xrcd_pool);
 err3:
 	rxe_pool_cleanup(&rxe->pd_pool);
 err2:
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index ec5c6331bee8..b843be4cc25a 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -79,6 +79,7 @@ enum rxe_device_param {
 	RXE_LOCAL_CA_ACK_DELAY		= 15,
 
 	RXE_MAX_UCONTEXT		= 512,
+	RXE_MAX_XRCD			= 512,
 
 	RXE_NUM_PORT			= 1,
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 342f090152d1..76caef5790b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -22,6 +22,12 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.elem_offset	= offsetof(struct rxe_pd, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
+	[RXE_TYPE_XRCD] = {
+		.name		= "rxe-xrcd",
+		.size		= sizeof(struct rxe_xrcd),
+		.elem_offset	= offsetof(struct rxe_xrcd, pelem),
+		.flags		= RXE_POOL_NO_ALLOC,
+	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 1feca1bffced..1475b9374315 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -19,6 +19,7 @@ enum rxe_pool_flags {
 enum rxe_elem_type {
 	RXE_TYPE_UC,
 	RXE_TYPE_PD,
+	RXE_TYPE_XRCD,
 	RXE_TYPE_AH,
 	RXE_TYPE_SRQ,
 	RXE_TYPE_QP,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7ff98a60ddcd..b4b993f1ce92 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -156,6 +156,22 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }
 
+static int rxe_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
+{
+	struct rxe_dev *rxe = to_rdev(ibxrcd->device);
+	struct rxe_xrcd *xrcd = to_rxrcd(ibxrcd);
+
+	return rxe_add_to_pool(&rxe->xrcd_pool, xrcd);
+}
+
+static int rxe_dealloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
+{
+	struct rxe_xrcd *xrcd = to_rxrcd(ibxrcd);
+
+	rxe_drop_ref(xrcd);
+	return 0;
+}
+
 static int rxe_create_ah(struct ib_ah *ibah,
 			 struct rdma_ah_init_attr *init_attr,
 			 struct ib_udata *udata)
@@ -1078,6 +1094,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.alloc_mw = rxe_alloc_mw,
 	.alloc_pd = rxe_alloc_pd,
 	.alloc_ucontext = rxe_alloc_ucontext,
+	.alloc_xrcd = rxe_alloc_xrcd,
 	.attach_mcast = rxe_attach_mcast,
 	.create_ah = rxe_create_ah,
 	.create_cq = rxe_create_cq,
@@ -1088,6 +1105,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.dealloc_mw = rxe_dealloc_mw,
 	.dealloc_pd = rxe_dealloc_pd,
 	.dealloc_ucontext = rxe_dealloc_ucontext,
+	.dealloc_xrcd = rxe_dealloc_xrcd,
 	.dereg_mr = rxe_dereg_mr,
 	.destroy_ah = rxe_destroy_ah,
 	.destroy_cq = rxe_destroy_cq,
@@ -1128,6 +1146,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
 	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
+	INIT_RDMA_OBJ_SIZE(ib_xrcd, rxe_xrcd, ibxrcd),
 };
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 0a433f4c0222..5b75de74a992 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -43,6 +43,11 @@ struct rxe_pd {
 	struct rxe_pool_entry	pelem;
 };
 
+struct rxe_xrcd {
+	struct ib_xrcd		ibxrcd;
+	struct rxe_pool_entry	pelem;
+};
+
 struct rxe_ah {
 	struct ib_ah		ibah;
 	struct rxe_pool_entry	pelem;
@@ -384,6 +389,7 @@ struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
 	int			max_ucontext;
+	int			max_xrcd;
 	int			max_inline_data;
 	struct mutex	usdev_lock;
 
@@ -393,6 +399,7 @@ struct rxe_dev {
 
 	struct rxe_pool		uc_pool;
 	struct rxe_pool		pd_pool;
+	struct rxe_pool		xrcd_pool;
 	struct rxe_pool		ah_pool;
 	struct rxe_pool		srq_pool;
 	struct rxe_pool		qp_pool;
@@ -434,6 +441,11 @@ static inline struct rxe_pd *to_rpd(struct ib_pd *pd)
 	return pd ? container_of(pd, struct rxe_pd, ibpd) : NULL;
 }
 
+static inline struct rxe_xrcd *to_rxrcd(struct ib_xrcd *xrcd)
+{
+	return xrcd ? container_of(xrcd, struct rxe_xrcd, ibxrcd) : NULL;
+}
+
 static inline struct rxe_ah *to_rah(struct ib_ah *ah)
 {
 	return ah ? container_of(ah, struct rxe_ah, ibah) : NULL;
-- 
2.30.2

