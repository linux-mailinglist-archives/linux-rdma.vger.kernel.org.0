Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8672424C7F2
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHTWrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEBAC061345
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h22so132103otq.11
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=liKNP0E95pCjhc56klSus48fMWqC+4o/+SlPQR6CzQw=;
        b=abwYGLgiIHhvuHSaSHJROBsd1k3jftR7iVfEWH6uunnYsTVFOgEKihmrv3Bh1mlcEv
         uuf/DEwefym0hdvalgjI0iiNfDNOH9mTjuuDNSE9//J20cy06m6Y5glK5ppdUVy17Q4c
         QnVpd6Y63+f93ks6DNDRefRuUpYjAs1YanD/6X+cXJKhsneaBsDHZS8kZrJWqXxnmah2
         8Y3KrLNJU2Yo+wvwZqtlaDKN59PFtJ3MrCyujYhGSy0flCcN4n2nx53/HXnt8wKOe9IW
         e5glAuM2y7f/TcHqztsbM+/gOce9Vj5Y2SfcjJvAZ29PfbE+6dIu35kxhHagnWqaOIT2
         Pviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=liKNP0E95pCjhc56klSus48fMWqC+4o/+SlPQR6CzQw=;
        b=fq+H41c06PBuYswtV1PeLfJwh1VCnhbQVs6F1BxB8tT3+DvwpdxELZkNj35mM8PEWP
         3SmnffFg9cOc/1NjJaa8i01luY7viwMoU9ExE9g2a13FlZ1+T3aMOmQheWsAwK4Jw8RH
         VOG8aFD/JRARhPuna3R2gNU8xrVWjfX33NzOzHiML4Rt0O7nTsOSXzBeOkegfnA31Nvl
         T95QDHmivvTFHdHb2NtiJ/9Yjzly+HocksGXL9Y6KVK39NPZNDI2m1jmOzn9OOUSgM3T
         gBGAsw7oOwEvWA2Am4pxEaFKkINwXBC1bismIdx9TaXm3H1fDxZUq5MqkxUXK66+Anz+
         zw4w==
X-Gm-Message-State: AOAM530ffZTeUn+bk1tWXLDVWaAjI3R9NOAf4KZZVlfElwfM/4zzZ6yZ
        sqpsbt2LKI5FuSaQiJ1I3qW7UJhDeN2UmA==
X-Google-Smtp-Source: ABdhPJzct35u63JVfOkuwS7gEcxn71cYFqcJAYczIqkInES0IU6h7lq+vyTcTDHEXwbeThR9DWcnKg==
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr3833otq.13.1597963641883;
        Thu, 20 Aug 2020 15:47:21 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id p9sm10243oos.39.2020.08.20.15.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user copy
Date:   Thu, 20 Aug 2020 17:46:32 -0500
Message-Id: <20200820224638.3212-12-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added a new feature to pools to let driver white list a region of
a pool object. This removes a kernel oops caused when create qp
returns the qp number so the next patch will work without errors.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 20 +++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_pool.h |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 5679714827ec..374e56689d30 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -40,9 +40,12 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-qp",
 		.size		= sizeof(struct rxe_qp),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_WHITELIST,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
+		.user_offset	= offsetof(struct rxe_qp, ibqp.qp_num),
+		.user_size	= sizeof(u32),
 	},
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
@@ -116,10 +119,21 @@ int rxe_cache_init(void)
 		type = &rxe_type_info[i];
 		size = ALIGN(type->size, RXE_POOL_ALIGN);
 		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
-			type->cache =
-				kmem_cache_create(type->name, size,
+			if (type->flags & RXE_POOL_WHITELIST) {
+				type->cache =
+					kmem_cache_create_usercopy(
+						type->name, size,
+						RXE_POOL_ALIGN,
+						RXE_POOL_CACHE_FLAGS,
+						type->user_offset,
+						type->user_size, NULL);
+			} else {
+				type->cache =
+					kmem_cache_create(type->name, size,
 						  RXE_POOL_ALIGN,
 						  RXE_POOL_CACHE_FLAGS, NULL);
+			}
+
 			if (!type->cache) {
 				pr_err("Unable to init kmem cache for %s\n",
 				       type->name);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 664153bf9392..fc5b584a8137 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -17,6 +17,7 @@ enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
 	RXE_POOL_NO_ALLOC	= BIT(4),
+	RXE_POOL_WHITELIST	= BIT(5),
 };
 
 enum rxe_elem_type {
@@ -44,6 +45,9 @@ struct rxe_type_info {
 	u32			min_index;
 	size_t			key_offset;
 	size_t			key_size;
+	/* for white listing where necessary */
+	unsigned int		user_offset;
+	unsigned int		user_size;
 	struct kmem_cache	*cache;
 };
 
-- 
2.25.1

