Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA330109C
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 00:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbhAVTjU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbhAVTbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:31:41 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226FC061794
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:09 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d1so6172556otl.13
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKvKuND9nVqM8c1qCj4KjZBcq0n6sK1TXbvaI7RPjd0=;
        b=LC9nDPgKvB+qhAspCr8v47GFegAaLFlIBIS6kBx/IRQER86saEgZAN/4w6XPLl559f
         g2w9hKjdfJLDZtyL+iMIlwckO3N1NddosWB76FsRQSk4/lGju3ZWGtRC+DozDKCY8+vL
         3lyqkp+53gkqvz6d2swy/VMjDF/2I+GM+L0gGuXNwMDhxDhJO+w+hfCcdIeibus51gjg
         5G6WufuL52hIQR4NIVIjeG4LTC+et6vbwmaX60MwUNTgJ28IXtlKeqoYvGfWE7iTIMw3
         WUPF+BFGAjr+sIMQ6znYvNfrQSFq8etkAI7rMt8WmYiflLU206p3oMJQw7L49FYz2JXU
         IcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKvKuND9nVqM8c1qCj4KjZBcq0n6sK1TXbvaI7RPjd0=;
        b=ujTiyvYBalfNlHFNH2ggfTmELIX+8vAv8KTNRoPQweZFYRsC/Qu/7AlFAHN6+v2itC
         9CKjvGkoEzgMlVxY8SBEpAPDsormZjQ1ArG3DSuOCeQu1T5J5a7eBvHHds5YG2FXzRUH
         kMj/4aDxrbmOEACObCQhP7vjas+3tvPQoTR5FojCMpz/Krtj1eEziaoMHRl+9qwyYQnh
         KSFolQcc0O2fc7LDg/5cPvqC7EsZbcPUvxdDta/2YAUKDDrz/4CPvl+2KSQc9OyOOekc
         R9vbber8EbPzms7DnvqOaGvXf3hQ/QTTlZ7+DnDBK3WY0tXal7lZinCmEj3XeG8KaeTM
         n6Fg==
X-Gm-Message-State: AOAM531z+EwfWNPnLF6KW1ijFVTc52yZX0znZUvbx7ckYGP+E2GDpR9D
        SKO7cysP3TWvV9Nk7X+VUr8=
X-Google-Smtp-Source: ABdhPJwogg+bwnQXNrQJCwtvqv/H5z8XX8pCOtP//EOai7PrACIgCRYI6ZcboaB4kiYOWaSeV/jxrg==
X-Received: by 2002:a9d:3642:: with SMTP id w60mr3567845otb.322.1611343807522;
        Fri, 22 Jan 2021 11:30:07 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:07 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 6/6] RDMA/rxe: Replace missing rxe_pool_get_index__
Date:   Fri, 22 Jan 2021 13:29:43 -0600
Message-Id: <20210122192943.5538-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122192943.5538-1-rpearson@hpe.com>
References: <20210122192943.5538-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

One of the pool APIs for when caller is holding lock was not defined
but is declared in rxe_pool.h. This patch adds the definition.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7a03d49b263d..3755e163f257 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -398,15 +398,12 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+void *rxe_pool_get_index__(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj = NULL;
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
+	u8 *obj;
 
 	node = pool->index.tree.rb_node;
 
@@ -428,6 +425,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 		obj = NULL;
 	}
 
+	return obj;
+}
+
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+{
+	u8 *obj;
+	unsigned long flags;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_pool_get_index__(pool, index);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
@@ -438,7 +445,7 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj = NULL;
+	u8 *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -469,7 +476,7 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
-	u8 *obj = NULL;
+	u8 *obj;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
-- 
2.27.0

