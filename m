Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1C4CCA8C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiCDAJf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCDAJd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:33 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415113FBFD
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:47 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso7663465ooc.7
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9q1/Uj0uD+ZwTi5CIpoO1p47G+exO0yd4IBMXRE/Big=;
        b=mWlj7kGPtmIVjkQ1E2fesF5cOZD4Ya4HDIFSH3vUHEhaSnEbaBF5P4+RxPTIBrt3XO
         3bco/PvSKYywaqTwdbX4i9sXoXWOoRZAF1AjYaXOZH3laX9mP5h4+U5lp9cB/jcqGfKt
         qtIIpKOi6U9chYfxQjKPhr0IuVdlOC0FPD3f9KyWHIr6vKWVXoywfEkykwxY5TW/4WU+
         kTTaXnaDMbsq7oCXD0xZtPx3OglmbLGAnbDvW0CBMYQTdd77IJ5agRuj4bXgBK/B5mmg
         4WxIdnPbPydHZe/qnvvImC0x84pHDqgIe/EOxCXs5ELWXjxpJ74fl0+u/B5UKa1BZmSA
         Oi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9q1/Uj0uD+ZwTi5CIpoO1p47G+exO0yd4IBMXRE/Big=;
        b=5LD/1JN/1wTwIsr+ZI6tkWXKW2aALxb9MSptrNhdO02oM91DIqd4LmqczQ8yew/5zM
         wM9V8FL6nwOaaPcv1rf+Ctd/otGuU80s+cVxV4K0kutNR44Ec7sU0h1EBVPF4YZWC6Cp
         7nJ/kuZUmHkgGRvfpubBsMq34oB2VK6y8r/Lx6TpG62Kqk52QVb9++Dmgwf76IRXkSGw
         BRdbxxiqSpjTZdVFPGy+O8TxiSxHHKe3uVh7UEE8zS6cQQC2cDttse5ILRgkDoxtt1K4
         PU7KGO1x4IPVqgijk+K14ZOouz2W/R7rxOsDZSzsF+TFM8iQFvt3Jkdy3+uDrxBC2slC
         T8HQ==
X-Gm-Message-State: AOAM532jZTx62uDkiRmOLmhay/VXUovCs3vHGpKzBppYQkNHQapQ3vFK
        oZy0Gslh9rDeDJjTZN7N4YM=
X-Google-Smtp-Source: ABdhPJwbJ/i5uFHzbS1N3EYndBJFqOaoKuA7DMxTG5YDuFneTzVNbCfJdTMAEhVPqCMMr5dEepn66Q==
X-Received: by 2002:a05:6870:45aa:b0:d4:5d51:b0ac with SMTP id y42-20020a05687045aa00b000d45d51b0acmr6102739oao.59.1646352526537;
        Thu, 03 Mar 2022 16:08:46 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:46 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 07/13] RDMA/rxe: Shorten pool names in rxe_pool.c
Date:   Thu,  3 Mar 2022 18:08:03 -0600
Message-Id: <20220304000808.225811-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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

Replace pool names like "rxe-xx" with "xx". Just reduces clutter.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index bc3ae64adba8..c50baeb10bd2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -19,19 +19,19 @@ static const struct rxe_type_info {
 	u32 max_elem;
 } rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
-		.name		= "rxe-uc",
+		.name		= "uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_PD] = {
-		.name		= "rxe-pd",
+		.name		= "pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_AH] = {
-		.name		= "rxe-ah",
+		.name		= "ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
 		.flags		= RXE_POOL_INDEX,
@@ -40,7 +40,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
 	},
 	[RXE_TYPE_SRQ] = {
-		.name		= "rxe-srq",
+		.name		= "srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.flags		= RXE_POOL_INDEX,
@@ -49,7 +49,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
 	},
 	[RXE_TYPE_QP] = {
-		.name		= "rxe-qp",
+		.name		= "qp",
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
@@ -59,14 +59,14 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_QP_INDEX - RXE_MIN_QP_INDEX + 1,
 	},
 	[RXE_TYPE_CQ] = {
-		.name		= "rxe-cq",
+		.name		= "cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
-		.name		= "rxe-mr",
+		.name		= "mr",
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
@@ -76,7 +76,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
 	},
 	[RXE_TYPE_MW] = {
-		.name		= "rxe-mw",
+		.name		= "mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-- 
2.32.0

