Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE0437E86
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhJVTV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhJVTVy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:54 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E9C061227
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so5600086otr.7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmD6gv8SJzsbE3q8rg5qYGeTx7mtLGZwbKFDlrgFjiQ=;
        b=Vhx/o1T0eBwQfQ9C59SQEeLAshQkohP7CfSV2Nd2qre9WIw93PV9Xc+PZd9DdLgrgm
         xjnE90LKFqq8mHeSBimgDjnt3C/BKmwbibhX2HljxMjXe6hWoNWNmgbzWJiK0LIsL/kN
         IMe08t60nS+Ekd/l+a6Ihu4QKHd4B+aI1nPcZGAAWIJRF51ev8UCepDIFGmd3ek8wqd7
         mctOubUhPm9dKsZHMY2LJ6l6VgdNBJ0nuSmUi7vM5gJZvsoFdfwpT9+M1fHPTVBBX0Im
         5x/M4AzVYQ9JE3q6HF8p9CvpzEvTSARJzvPzJVCPgrvxJmYukUyGvUb0WPD7t3gMxnGK
         T6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmD6gv8SJzsbE3q8rg5qYGeTx7mtLGZwbKFDlrgFjiQ=;
        b=CwWM4D34JzVc/x9RqCrxKwoyqNn85MNIHLznkrBkb7gvKsE8fKyXHilShIaS/NMejQ
         pUDut13856juv1d9UapNivHin5SFkhgZrEOFz/RMfVs17G9CgND9cpIIUwr3dfmTyS7a
         0BmXfSC952vRP2UfPMrt5I9kdboiA2gTJ50ytp1tNi80fdNpCP+h7PhM8H0a5oP79unD
         TjuJstxUWM/cbTkLFfJyAMjH3ihiNMvvkw3MtAyUMlmQLerOslYuV42neEx3fy/O1nh8
         Rb4hjHhbcCfEbxfT4joMVt/ivs4ynzy+LCe/w/sR9+AJ5ykhLUam+9IC42pDrBJKiNWc
         y2nQ==
X-Gm-Message-State: AOAM533OVXn1Swh7I7/AjPdEsl/ibIe6I/iTUGKvzcsBdXY+M2Q0x4NE
        8ipUv82X2V7iHUSphgDY13yhpNwCaoo=
X-Google-Smtp-Source: ABdhPJxGCRK8k/7CKqNpIjiWLn+9LvaR+Ixsislt+aAGCKmJwdNytVMxF75StP3GkEuEAzy91UVbHw==
X-Received: by 2002:a9d:4b8d:: with SMTP id k13mr1358942otf.103.1634930376229;
        Fri, 22 Oct 2021 12:19:36 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 10/10] RDMA/rxe: Minor cleanup in rxe_pool.c
Date:   Fri, 22 Oct 2021 14:18:25 -0500
Message-Id: <20211022191824.18307-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change pr_warn() to pr_debug()
Check if RXE_POOL_INDEX in rxe_pool_cleanup()

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 2cd4d8803a0e..82efc4626bf6 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -88,7 +88,7 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 	size_t size;
 
 	if ((max - min + 1) < pool->max_elem) {
-		pr_warn("not enough indices for max_elem\n");
+		pr_debug("not enough indices for max_elem\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -155,10 +155,11 @@ int rxe_pool_init(
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	if (atomic_read(&pool->num_elem) > 0)
-		pr_warn("%s pool destroyed with unfree'd elem\n",
+		pr_debug("%s pool destroyed with unfree'd elem\n",
 			pool->name);
 
-	kfree(pool->index.table);
+	if (pool->flags & RXE_POOL_INDEX)
+		kfree(pool->index.table);
 }
 
 /* should never fail because there are at least as many indices as
@@ -194,7 +195,7 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		 * old object was not deleted from the pool index
 		 */
 		if (unlikely(elem == new || elem->index == new->index)) {
-			pr_warn("%s#%d rf=%d: already in pool\n",
+			pr_debug("%s#%d(%d): already in pool\n",
 					pool->name, new->index,
 					refcount_read(&new->refcnt));
 			return -EINVAL;
@@ -228,7 +229,9 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			     pool->key.key_size);
 
 		if (cmp == 0) {
-			pr_warn("key already exists!\n");
+			pr_debug("%s#%d(%d): key already in pool\n",
+					pool->name, new->index,
+					refcount_read(&new->refcnt));
 			return -EINVAL;
 		}
 
-- 
2.30.2

