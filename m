Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343A5094B9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383666AbiDUBoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383669AbiDUBoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:01 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3ED167F7
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r8so4100958oib.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyyIfh3NCIynbX7dfkoYQNhnnyc2TlEMyYMFedoimmE=;
        b=gSiqmyITmI8nat/OREOzjvr0ix+G0Ga6cCouoVaBiZDyFlkJrrF8dEhSaJiFEDRnpK
         AdvCvnSyt6QE5q3kBWJYZxJaF0zkhX4ZybBJVKwvh+tLbHKLCDXastKcdM3bRgqXl2UV
         eMpVoB+ZN/3GjvrU6aqNXGzGR/rk8deoZp8uil8LeFo7Gl6/diqTwCgSjfDPen11bfvC
         FfDZynekBszbEf/KEXSFVPSgZyTTNTCm5XFrv4SGQC9xUs+5UawV8eSyaSwCoQKPsKuK
         cVMd66NUPs6Z4fUiIYkuZ31yAXcLwiMJ3EmISpgyY6fmd5XUWbUV7g4d7N1Ji32lOQaL
         SXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyyIfh3NCIynbX7dfkoYQNhnnyc2TlEMyYMFedoimmE=;
        b=1hdThx0p30VMgmySVS/sCr9yFFkGh+titCG1jV1sMPGAsFkpNbaaV6+7woABzoxMgD
         0L3fVORHnZQFYAjn0T1iaBksvzzKS4+nZqct27rLdS/0TFEtidRioYduw3iQ5iYLwm3S
         0aWH6gTvesxe3Pg0Auy6GwtqJ3T6Aq+F//Nf4vx+bKekf/9/QTOdzduzQOq/PlylHC+0
         ANaZMs/GB9XJVlsUE0uxskCqCzkXeyQ/ndEHRqYa9/DTsltgLqtznQYgEX7IlLPaVfvW
         WQ9SBTVod7b6HYYiTxI3szSMySQQc0QGzaCLrXeWFyMyIbjJifflW6yfLKve7DHmhX/P
         B+Xg==
X-Gm-Message-State: AOAM5313E84Wm9Ozck5PbZ+fBu2eMBvsOtCUnTZ9Lzrdv2RtWEdC3PzG
        IKrzwpjg3VEMzt+wEZ5R6cUrwhTKp50=
X-Google-Smtp-Source: ABdhPJwlI76ujjsGlG4RbXdhXHl7fTySvVZ64pW6Z+MI2W/8WUOCDtSoyKhewZfC1Fb7Izc58unNzQ==
X-Received: by 2002:a05:6808:1985:b0:2da:3515:9486 with SMTP id bj5-20020a056808198500b002da35159486mr3111126oib.205.1650505273043;
        Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 06/10] RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
Date:   Wed, 20 Apr 2022 20:40:39 -0500
Message-Id: <20220421014042.26985-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
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

Move code from rxe_dealloc_mw() to rxe_mw_cleanup() to allow
flows which hold a reference to mw to complete.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c   | 57 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.c |  1 +
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index f29829efd07d..2e1fa844fabf 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -36,40 +36,11 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	return 0;
 }
 
-static void rxe_do_dealloc_mw(struct rxe_mw *mw)
-{
-	if (mw->mr) {
-		struct rxe_mr *mr = mw->mr;
-
-		mw->mr = NULL;
-		atomic_dec(&mr->num_mw);
-		rxe_put(mr);
-	}
-
-	if (mw->qp) {
-		struct rxe_qp *qp = mw->qp;
-
-		mw->qp = NULL;
-		rxe_put(qp);
-	}
-
-	mw->access = 0;
-	mw->addr = 0;
-	mw->length = 0;
-	mw->state = RXE_MW_STATE_INVALID;
-}
-
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
-	struct rxe_pd *pd = to_rpd(ibmw->pd);
-
-	spin_lock_bh(&mw->lock);
-	rxe_do_dealloc_mw(mw);
-	spin_unlock_bh(&mw->lock);
 
 	rxe_put(mw);
-	rxe_put(pd);
 
 	return 0;
 }
@@ -336,3 +307,31 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 
 	return mw;
 }
+
+void rxe_mw_cleanup(struct rxe_pool_elem *elem)
+{
+	struct rxe_mw *mw = container_of(elem, typeof(*mw), elem);
+	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
+
+	rxe_put(pd);
+
+	if (mw->mr) {
+		struct rxe_mr *mr = mw->mr;
+
+		mw->mr = NULL;
+		atomic_dec(&mr->num_mw);
+		rxe_put(mr);
+	}
+
+	if (mw->qp) {
+		struct rxe_qp *qp = mw->qp;
+
+		mw->qp = NULL;
+		rxe_put(qp);
+	}
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_INVALID;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 5963b1429ad8..0fdde3d46949 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -83,6 +83,7 @@ static const struct rxe_type_info {
 		.name		= "mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
+		.cleanup	= rxe_mw_cleanup,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.max_elem	= RXE_MAX_MW_INDEX - RXE_MIN_MW_INDEX + 1,
-- 
2.32.0

