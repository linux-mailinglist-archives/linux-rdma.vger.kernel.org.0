Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9CD300CC6
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbhAVTil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbhAVTap (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:30:45 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A555C0613D6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:05 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id h192so7249838oib.1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyfsrg0WcwUJ4gBjz9SeNw+/uhMhz7C6FbWShe2pYj8=;
        b=f44++fJ2CP0tPOuOdXaDXsaW2AD1oLnV65wqR7Mfytw0QX5pKOId00iXjdpaXAaUnq
         iaRI5nPQXbEVg5wKzNv43khWpC7/ZhYYzUWaNvGVJ7uPMqIh52B9LRhmOF/KX+bgBfCe
         Qbn/lJg31aBrrGJmD5iTE+7gqnG6wXRE059+/R7t9nkIJl7woPEezunm9vjL+CJm4nro
         u1afrHmFxB7YrrtMYpNufINQsmtVbTrBZtbukqJIPd0RAD8ID23s2kJrfOkrtFnZrk7f
         /SERTSgLKul0bJKtPllwJjQqEGXcEqgMsGCyfB7u3/zKaLt1iHY+sehAVMRk/Uj5DAeS
         BbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyfsrg0WcwUJ4gBjz9SeNw+/uhMhz7C6FbWShe2pYj8=;
        b=Mzccy2cdNF5EGDnnupFJh0WpfeFwPCuApbR4Gv49r4BN0N0D8WxNJjZ8sDEslHw8oN
         2Sr0RMqhiwi1Nip6+7fYitjGXtm9F5mnKVf8YFDcYL72wVU/meb2qQZ7xOrUe0SLNSGp
         mvMXvlRXkanviP5+Ffgfa4ffFL1wCpczpaiHuJeqkkIz0JbwfmR7k2a9OYKSq8N4rtST
         5V+OljXibcRB3uhJ0JyTO9ZlD1sLLpXSU9rbq71I5z8tsiPkUaFP6mHffKqGELQEKqy+
         K6AVX+BUsk901mffJoTabAOUq515/q551qfn9fiXLI87UH3CqPsg7fK4KA99/7qegLuv
         OiWA==
X-Gm-Message-State: AOAM531lfvfsI97+uE7/jbv/5Y2Qswotj08LDAvpX6/wcWTdNp46PB4w
        q8JN5kVLO6SjwXkhYm9vADN02NLQ6TE=
X-Google-Smtp-Source: ABdhPJw9QMQo7M2q5QK5J97DAf91AltH0OQ4Xv7fQ0FO3X5vXk0AmCXpXdGWhaf9XK6hZ/1p9jhXTQ==
X-Received: by 2002:aca:911:: with SMTP id 17mr4262117oij.162.1611343804784;
        Fri, 22 Jan 2021 11:30:04 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:04 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 3/6] RDMA/rxe: Remove RXE_POOL_ATOMIC
Date:   Fri, 22 Jan 2021 13:29:40 -0600
Message-Id: <20210122192943.5538-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122192943.5538-1-rpearson@hpe.com>
References: <20210122192943.5538-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_alloc() used the RXE_POOL_ATOMIC flag in rxe_type_info
to select GFP_ATOMIC in calls to kzalloc(). This was intended
to handle cases where an object could be created in interrupt
context. This no longer occurs since allocating those objects
has moved into the core so this flag is not necessary. An
incorrect use of this flag was still present for rxe_mc_elem
objects and is removed.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 6 +-----
 drivers/infiniband/sw/rxe/rxe_pool.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 80deec1e2924..7e68f99558a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -84,7 +84,6 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
 		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
-		.flags		= RXE_POOL_ATOMIC,
 	},
 };
 
@@ -380,8 +379,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
-
 	read_lock_irqsave(&pool->pool_lock, flags);
 	if (pool->state != RXE_POOL_STATE_VALID) {
 		read_unlock_irqrestore(&pool->pool_lock, flags);
@@ -397,8 +394,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
-		      GFP_ATOMIC : GFP_KERNEL);
+	obj = kzalloc(info->size, GFP_KERNEL);
 	if (!obj)
 		goto out_cnt;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b9680f9e907c..f916ad4d0406 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -11,7 +11,6 @@
 #define RXE_POOL_CACHE_FLAGS	(0)
 
 enum rxe_pool_flags {
-	RXE_POOL_ATOMIC		= BIT(0),
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
 	RXE_POOL_NO_ALLOC	= BIT(4),
-- 
2.27.0

