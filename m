Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB24DD29E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiCRB5A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C18F242216
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e4so4467484oif.2
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOY+T0iyFXtdgsKlS557JSXDm6hKgYpjdNQTGul5DK4=;
        b=YEcIC5b4iyA3p9uTCGPLHsYHaBDha98XOEx+HsdczdRN10h5TnkKQHBAzNDDdgigDj
         9m9eHfKYhtzwTyiQ5j03WCwCQVD5ZcpCon8ajtwOVzQO3TBe+Au++B1+nMLqimiHRFSr
         WxjJjIDJXkfs6j+x5soWVsLsR3s2wCcsZW4cp43jEpEasYShR2gysl1iuMEMZSjfhJsj
         sAJ+D7O7tb7jJzNt7qsJJJvM/H6XSdCXQ+zTr/pqybjUs/q33MygQNpQLik5SnUJoiO8
         lIZVFf5j8xxdPaeh+77whZnGcjXfMDBpcaMqPRoxBKb1O8QPbnUb32iR0f8VKjJL7FcD
         vB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOY+T0iyFXtdgsKlS557JSXDm6hKgYpjdNQTGul5DK4=;
        b=3IW+WvH3LbF3DEpT8j3wRtN9Q/TSQtr8fIRQCz6dZS1z39ffTk8T9962Dj5iUS1e8h
         4JOjK5a82rqelg42PIj8O4Uq76YwzEwY5C+W6J8ES7dEkJ0EuVCSftEfTOzZ47XbLcVe
         5O4Eay4553zlaiikSRt5jvniKVD9PgAbHo4Lzj9hZzTWim6IjCxnnS1BggyRIDPIi8iu
         dVqYFz0kiQ+jzcZctjil0rKYIqqkbZT3WefNabxeKDXRkZ0bQgZzfI+X6yGR1j709YZh
         b89fjmteVde4GKplKacQ+MPPnXApU//9cRjqCkXWr2B6/gXuPMKMHDkW5WTI+e6uk7Gl
         bUsA==
X-Gm-Message-State: AOAM532gQckjRxRaHhhzLGcJ/R0sbdBOXjMGrLbmUFKQURo9g3q1Sv7C
        z0x9zlmPDwkR08Tz0hHQdKfpP3dRuww=
X-Google-Smtp-Source: ABdhPJxcDhstYLHNZWEkBmUYfkDiO2cfmezBpmkVY4UWP78jLo+c+fowmDnIDHRhHLt5qKD7YMjQaA==
X-Received: by 2002:a54:4e81:0:b0:2ec:ae99:e02d with SMTP id c1-20020a544e81000000b002ecae99e02dmr7728292oiy.261.1647568533572;
        Thu, 17 Mar 2022 18:55:33 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 06/11] RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
Date:   Thu, 17 Mar 2022 20:55:09 -0500
Message-Id: <20220318015514.231621-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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

Move code from rxe_dealloc_mw() to rxe_mw_cleanup() to allow
flows which hold a reference to mw to complete.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c   | 57 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.c |  1 +
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c86b2efd58f2..ba3f94c69171 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -28,40 +28,11 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
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
@@ -328,3 +299,31 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 
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

