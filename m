Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555624535C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgHOWA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgHOVve (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:34 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD586C061242
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l204so10017011oib.3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0Hc1+OSuo7YChLGC59HHK+vRdciDCQlRnhy6pM56xE=;
        b=ZXgoXIme/3P+ylcI3FVGR4IPJRdwnsyNpL/Lc/kNivsiL1RjPklXJrgbnL29ITmnLz
         yrW1mc8sC0EL2E8JsZ+PE9oJUbm3tdby53nZOxY3QuxBQOWT7TS4YZO3iltbAjGJK832
         LvzdtLsY3SPsyVrbd1LFJb5m7R69FEj0z4adFLIj3XOLcuVK/LD5dAKZ2JKoS9DZzYfU
         WPcbweDKJMAGlxL/V2Ntq6lN45F0wMCzLuDDiGtWL+ltg37jAw+EviVFmNdhaSBoylNz
         CJT8HM3H1f1daWbD4/SzwzWvE0BOIwpf56lnPuu5OasawH46yCeZa/jBlVp+nnV9p6LH
         knKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0Hc1+OSuo7YChLGC59HHK+vRdciDCQlRnhy6pM56xE=;
        b=jjlvD+zxHJYE4fGaJENBnhGMpkxE4sZqOeBdfyJYPHkVMRo7Q/mXqhdf/z3g52jU9t
         ZOuVKs4/lGA3o2+KwBIv2fOTw0VHCGBeLthPQs94zgy4hLukFtcJ1H4tkga//ObwVoGv
         13J6fl5bcP116w6JXyT7VqAN5l2ABW7izCN+7FSjAPWQLgWTjQAIPIBrN/0FKvO2XgEt
         4QVwUogS9waA265QICpei8HFd0i8pLUp9b2Vx9cc/Zw+5S8clVu8JNtVXDTjOTTzuX76
         Cdzdi6WR//5F0xIz3wRuFJx3qin6tGeY72ipSso8D/eudrrO4zAzPuQyhJUIBEC2sb2g
         th2A==
X-Gm-Message-State: AOAM530TMjBH1eZ8kTctglXa8w5nUMxEPrlxlELFdWDha7IJtBfhX8SC
        a95Xu0pX+cdYWEx6gEzHz7eX2JG11Uf3IQ==
X-Google-Smtp-Source: ABdhPJwehWbjshGKcH1QD/2bpoDFzv7aTLYrqcCxRVfob0SHLodiDTsaV8l2uMMYSwK9SZUwd15OPg==
X-Received: by 2002:a54:4791:: with SMTP id o17mr3385026oic.4.1597467606122;
        Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id r197sm1865301oie.43.2020.08.14.22.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:05 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 15/20] Fixed a dumb bug
Date:   Fri, 14 Aug 2020 23:58:39 -0500
Message-Id: <20200815045912.8626-16-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

added code to prevent infinite loops in get l/rkey
added a drop_key in mr dereg (fixing the root cause of loops)

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 22 +++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 24 +++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 +
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index ba4e33227633..533b02fc2d0e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -34,20 +34,20 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* choose a unique non zero random number for lkey */
+/* choose a unique non zero random number for lkey
+ * use high order bit to indicate MR vs MW */
 void rxe_set_mr_lkey(struct rxe_mr *mr)
 {
-	int ret;
 	u32 lkey;
-
-next_lkey:
-	get_random_bytes(&lkey, sizeof(lkey));
-	lkey &= 0x7fffffff;
-	if (unlikely(lkey == 0))
-		goto next_lkey;
-	ret = rxe_add_key(mr, &lkey);
-	if (unlikely(ret == -EAGAIN))
-		goto next_lkey;
+	int tries = 0;
+
+	do {
+		get_random_bytes(&lkey, sizeof(lkey));
+		lkey &= 0x7fffffff;
+		if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
+			return;
+	} while (tries++ < 10);
+	pr_err("rxe_set_mr_lkey: unable to get random lkey\n");
 }
 
 #if 0
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index b45a04efa4a0..a0ff2543d0cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -35,22 +35,24 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* choose a unique non zero random number for rkey */
+/* choose a unique non zero random number for rkey
+ * use high order bit to indicate MR vs MW */
 void rxe_set_mw_rkey(struct rxe_mw *mw)
 {
-	int ret;
 	u32 rkey;
-
-next_rkey:
-	get_random_bytes(&rkey, sizeof(rkey));
-	if (unlikely(rkey == 0))
-		goto next_rkey;
-	rkey |= 0x80000000;
-	ret = rxe_add_key(mw, &rkey);
-	if (unlikely(ret == -EAGAIN))
-		goto next_rkey;
+	int tries = 0;
+
+	do {
+		get_random_bytes(&rkey, sizeof(rkey));
+		rkey |= 0x80000000;
+		if (likely((rkey & 0x7fffffff) &&
+			   (rxe_add_key(mw, &rkey) == 0)))
+			return;
+	} while (tries++ < 10);
+	pr_err("rxe_set_mw_rkey: unable to get random rkey\n");
 }
 
+
 /* place holder alloc and dealloc routines
  * TODO add cross references between qp and mr with mw
  * and cleanup when one side is deleted. Enough to make
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b91364ba2c68..476d90e3f91f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -986,6 +986,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
 	rxe_drop_index(mr);
+	rxe_drop_key(mr);
 	rxe_drop_ref(mr);
 	return 0;
 }
-- 
2.25.1

