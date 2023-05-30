Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5717C71707B
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjE3WNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjE3WNw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0DEC
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6af7d6f6f41so2235073a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484830; x=1688076830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1LuLVWDztIGCc51u3Rxwm9gCFuUsa6Ji6Oea2b3QkI=;
        b=GBeP8zDBfTOglnTK2vDP8XtAXxu6ZHjxRYQInQ8KiNQ7zJ2RHyQbfWh0mcerBS0F4x
         xOqdn7v60ajIwEBef/KpnMowdP/ADEtV35lM2ZFm+j1hYG6h/hC/YxcPPAAD09YeBjod
         l5bS/GDwL6FjV8iWqLfMjawZXc6zJCwzubgY+GY9bJ9NURYvTmwGDaPq1pF8q/OdcvNb
         z1ko7lIVHlHXaDs1B0fics53UHLe2McElobtCAZYrewuzp7e4HVYRVrgeA4lkYN8fRNH
         PKL9dwICj4wAQL0wVA2xHbFgGBhB5xSp61Niu63fNAVjzuKurNtvN70p1OxlLr19+0t0
         kI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484830; x=1688076830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1LuLVWDztIGCc51u3Rxwm9gCFuUsa6Ji6Oea2b3QkI=;
        b=Ev//xTaJmdY3USOPEVr2tpJ0BG62tG+3hKSs66/K1mOyxjf3Zjkdtk79cczrNacyUb
         o2U0xn2E0LgLcp4UeH2925JsNKrRtbuMwGBhhOtWS8qGr8BQJUpn/WS/5FIGHRdyANSn
         +VTFNyeaYy0nGD7AHbIsPzUTj1KOWFZDbYtqv/ZpXlHnlSO4TSxknm5p/RQkTPv59gVt
         kiLFpoBJ94ERofcCHvezj2rPIfpgRgAtZgaiKVIFkZ5pRG1eEfZzyGnZDxVTQiTW1HGA
         SZ1bhLtKWj2cTrHNU80az3qH3ECslfMcG4kje61Iy3XnXDKuK+AjF3IVsK1/N88ZAs8z
         i7NA==
X-Gm-Message-State: AC+VfDw498bYiD3MNRixFx4z1qbeFQ52fDW4J/esbW9Aqwli8FBh3eah
        2wqxhZa28OkbPmCccJI/1Wr+tFuWMF4=
X-Google-Smtp-Source: ACHHUZ7uckYt8HlOaIZ8VEGWi4mnYOQzvmHZPl2sFmcRrqAUO6C4IQ+tVIjO8/P3IZp+AEtyMcMuXA==
X-Received: by 2002:a05:6808:306:b0:398:4601:4d06 with SMTP id i6-20020a056808030600b0039846014d06mr1708225oie.59.1685484830293;
        Tue, 30 May 2023 15:13:50 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/6] RDMA/rxe: Rename IB_ACCESS_REMOTE
Date:   Tue, 30 May 2023 17:13:30 -0500
Message-Id: <20230530221334.89432-2-rpearsonhpe@gmail.com>
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

Rename IB_ACCESS_REMOTE to RXE_ACCESS_REMOTE and move to
rxe_verbs.h as an enum instead of a #define. Shouldn't
use IB_xxx for rxe symbols.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 10 +++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 ++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0e538fafcc20..b3bc4ac5fedd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -45,14 +45,10 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 	}
 }
 
-#define IB_ACCESS_REMOTE	(IB_ACCESS_REMOTE_READ		\
-				| IB_ACCESS_REMOTE_WRITE	\
-				| IB_ACCESS_REMOTE_ATOMIC)
-
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
 	u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
-	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
+	u32 rkey = (access & RXE_ACCESS_REMOTE) ? lkey : 0;
 
 	/* set ibmr->l/rkey and also copy into private l/rkey
 	 * for user MRs these will always be the same
@@ -195,7 +191,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	int err;
 
 	/* always allow remote access for FMRs */
-	rxe_mr_init(IB_ACCESS_REMOTE, mr);
+	rxe_mr_init(RXE_ACCESS_REMOTE, mr);
 
 	err = rxe_mr_alloc(mr, max_pages);
 	if (err)
@@ -715,7 +711,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	mr->access = access;
 	mr->lkey = key;
-	mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
+	mr->rkey = (access & RXE_ACCESS_REMOTE) ? key : 0;
 	mr->ibmr.iova = wqe->wr.wr.reg.mr->iova;
 	mr->state = RXE_MR_STATE_VALID;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 26a20f088692..0a2b7343e38f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -253,6 +253,12 @@ struct rxe_qp {
 	struct execute_work	cleanup_work;
 };
 
+enum rxe_access {
+	RXE_ACCESS_REMOTE	= (IB_ACCESS_REMOTE_READ
+				| IB_ACCESS_REMOTE_WRITE
+				| IB_ACCESS_REMOTE_ATOMIC),
+};
+
 enum rxe_mr_state {
 	RXE_MR_STATE_INVALID,
 	RXE_MR_STATE_FREE,
-- 
2.39.2

