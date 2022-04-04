Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D244F1F24
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiDDWaH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349395AbiDDW2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468A451E43
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso8118730otf.12
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOY+T0iyFXtdgsKlS557JSXDm6hKgYpjdNQTGul5DK4=;
        b=VMZHm21GlYPmQYf+qgDJxpxr2uIzAL7ahDIQ021N3PZ5CekBH5UeDs7C+G3Co6hY1O
         0W6H44/2hQhoUriUcXnOo9DHOllYSSKBKwhKt+5joTQcyalJO/kAp/BFHrrQAwdCduG/
         dpucsechG0FNGzdYR8NqIk1qWUJk39pCucQ5i4P9r2CyEc4aYmALfJBghVaY7TL+k65D
         IgIsOczGrf9LVp8nQZinuz0/GQJL5Law0zdOG+IvnVFdOvHow050kScK+qt02tO3L1u5
         rGHrsmVCmdG6qkOCwvPcc2TujbxcwNwtOK+SBLR3+LAO4VaMwAoTjRepCaAR8FU/pp4q
         BFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOY+T0iyFXtdgsKlS557JSXDm6hKgYpjdNQTGul5DK4=;
        b=idNOwetVpo7JSl3rnTTtD/4Y5+wElD7iyMGlt3bO0tgy202tu2iM2lEBQwRU5QkMeJ
         5je8oXBtCbYFuIPZiMgHRdVq2iPt+nqLRgKINKzzqB5FMojeshJ8fIfdktugMBq0bB17
         fqR1TCQDnvYbbXUnSXIRljjF+VJ5/Zamyxd7npzW4FTD9N98wu7QqEn3HHuO06AtYMEf
         kteqZUVOwmE8rPL1V5s0HZ+6nnWhfV/U4K1dsAVDVzKby54QvJsijc94TOI8Qd7qgNQ/
         HMbB0nGKMZkSQx53AQLk7LGxJUEETG8JTO0k4PojGJbNLTTbPphirXoFhqfnUBcWYxtc
         PBUQ==
X-Gm-Message-State: AOAM530AYvArwRONUM7aNCx/LlBJWHuMuks3Vo3eLrjbQjUCGIFwuEmo
        VTxeSiutCYm5UuRJxaOugP5YK2cAeMc=
X-Google-Smtp-Source: ABdhPJw6PBhk/zBYcvumrowTDAnpJiGNnCF8Df6PXadwDU9xuqgPU2QLCgfU410QXUEOOQW0orjMGg==
X-Received: by 2002:a9d:5913:0:b0:5cd:a050:8f55 with SMTP id t19-20020a9d5913000000b005cda0508f55mr134717oth.44.1649109088581;
        Mon, 04 Apr 2022 14:51:28 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 06/10] RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
Date:   Mon,  4 Apr 2022 16:50:56 -0500
Message-Id: <20220404215059.39819-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
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

