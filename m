Return-Path: <linux-rdma+bounces-5660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD829B79A0
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 12:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898521F231F0
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99919AD73;
	Thu, 31 Oct 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ellnV45T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8B155322
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373792; cv=none; b=cdhTsrOnah5zR1UTpDwwDzhjogkVrrDKy9YAzdaXLLqly4lK8an6L8k0UX538ebUPglWbFt+dmeTTUuZ1NmXEBsU9yBKn1wJPZuUoFg+X1Y90F5+5rBB46108/ITw+fok5WElqr8MAG0K67Vgx9TmK0ai1UQCNse/IfyXlFzbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373792; c=relaxed/simple;
	bh=RhgzhRqQWis2f7l6rYOqDN0u2dyhSVIr67XQcJUZbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEP0RKAD/ZizuhmHF/8FNma6OwbGzfPS24InLzdipLCboMZ79GnmahXG/ylwswMuMD3klkO+w1jbt5R3Alr4FoK4tLwS+oSjR8OUTDp8muL5Wm8yY934NK/XLWk083sCbP1bxABt2wCmwlTrB9ixnWa+m+OZcJFe4HSRxjOZUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ellnV45T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3447C4CEF0;
	Thu, 31 Oct 2024 11:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730373792;
	bh=RhgzhRqQWis2f7l6rYOqDN0u2dyhSVIr67XQcJUZbas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ellnV45TzSQRRARpyT+gMaN+jpjkiYVicYjCheR+RGL+ueRlJVI3IkPnC4Y9hGHlY
	 0JHjFoFauaCJvdwd2JSD770nUtXX5OHm+zQQIvYueU2b27w79AF2LtkdUspBayaDUg
	 C0h9RVKaGa/kH3Vy0AUzqmBzXH3ZrkxI9f9l1Z5IYBsq8d+LAelDuVWcZBXe8yxpZN
	 On0dEY3OVGVHdAnlE8sQDNl54wQoDcB5/5Y9rg3qK0eizJg6Wsq86c4O1hXnluqJYh
	 oVxpNCHxNwxRGWXm0VAOtFZ3ybYlIoARZNDJPsnWXjsdrZXRFIdl4XtxzZPpBG6ZT5
	 qlQIgUW1KVs/Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/core: Move ib_uverbs_file struct to uverbs_types.h
Date: Thu, 31 Oct 2024 13:22:52 +0200
Message-ID: <29b718e0dca35daa5f496320a39284fc1f5a1722.1730373303.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730373303.git.leon@kernel.org>
References: <cover.1730373303.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

In light of the previous commit, make the ib_uverbs_file accessible to
drivers by moving its definition to uverbs_types.h, to allow drivers to
freely access the struct argument and create a personalized cleanup flow.

For the same reason expose uverbs_try_lock_object function to allow driver
to safely access the uverbs objects.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c |  5 +++--
 drivers/infiniband/core/uverbs.h    | 31 ---------------------------
 include/rdma/uverbs_types.h         | 33 +++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 02ef09e77bf8..90c177edf9b0 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -58,8 +58,8 @@ void uverbs_uobject_put(struct ib_uobject *uobject)
 }
 EXPORT_SYMBOL(uverbs_uobject_put);
 
-static int uverbs_try_lock_object(struct ib_uobject *uobj,
-				  enum rdma_lookup_mode mode)
+int uverbs_try_lock_object(struct ib_uobject *uobj,
+			   enum rdma_lookup_mode mode)
 {
 	/*
 	 * When a shared access is required, we use a positive counter. Each
@@ -84,6 +84,7 @@ static int uverbs_try_lock_object(struct ib_uobject *uobj,
 	}
 	return 0;
 }
+EXPORT_SYMBOL(uverbs_try_lock_object);
 
 static void assert_uverbs_usecnt(struct ib_uobject *uobj,
 				 enum rdma_lookup_mode mode)
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index dfd2e5a86e6f..797e2fcc8072 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -133,37 +133,6 @@ struct ib_uverbs_completion_event_file {
 	struct ib_uverbs_event_queue		ev_queue;
 };
 
-struct ib_uverbs_file {
-	struct kref				ref;
-	struct ib_uverbs_device		       *device;
-	struct mutex				ucontext_lock;
-	/*
-	 * ucontext must be accessed via ib_uverbs_get_ucontext() or with
-	 * ucontext_lock held
-	 */
-	struct ib_ucontext		       *ucontext;
-	struct ib_uverbs_async_event_file      *default_async_file;
-	struct list_head			list;
-
-	/*
-	 * To access the uobjects list hw_destroy_rwsem must be held for write
-	 * OR hw_destroy_rwsem held for read AND uobjects_lock held.
-	 * hw_destroy_rwsem should be called across any destruction of the HW
-	 * object of an associated uobject.
-	 */
-	struct rw_semaphore	hw_destroy_rwsem;
-	spinlock_t		uobjects_lock;
-	struct list_head	uobjects;
-
-	struct mutex umap_lock;
-	struct list_head umaps;
-	struct page *disassociate_page;
-
-	struct xarray		idr;
-
-	struct mutex disassociation_lock;
-};
-
 struct ib_uverbs_event {
 	union {
 		struct ib_uverbs_async_event_desc	async;
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index ccd11631c167..26ba919ac245 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -134,6 +134,8 @@ static inline void uverbs_uobject_get(struct ib_uobject *uobject)
 }
 void uverbs_uobject_put(struct ib_uobject *uobject);
 
+int uverbs_try_lock_object(struct ib_uobject *uobj, enum rdma_lookup_mode mode);
+
 struct uverbs_obj_fd_type {
 	/*
 	 * In fd based objects, uverbs_obj_type_ops points to generic
@@ -150,6 +152,37 @@ struct uverbs_obj_fd_type {
 	int				flags;
 };
 
+struct ib_uverbs_file {
+	struct kref				ref;
+	struct ib_uverbs_device		       *device;
+	struct mutex				ucontext_lock;
+	/*
+	 * ucontext must be accessed via ib_uverbs_get_ucontext() or with
+	 * ucontext_lock held
+	 */
+	struct ib_ucontext		       *ucontext;
+	struct ib_uverbs_async_event_file      *default_async_file;
+	struct list_head			list;
+
+	/*
+	 * To access the uobjects list hw_destroy_rwsem must be held for write
+	 * OR hw_destroy_rwsem held for read AND uobjects_lock held.
+	 * hw_destroy_rwsem should be called across any destruction of the HW
+	 * object of an associated uobject.
+	 */
+	struct rw_semaphore	hw_destroy_rwsem;
+	spinlock_t		uobjects_lock;
+	struct list_head	uobjects;
+
+	struct mutex umap_lock;
+	struct list_head umaps;
+	struct page *disassociate_page;
+
+	struct xarray		idr;
+
+	struct mutex disassociation_lock;
+};
+
 extern const struct uverbs_obj_type_class uverbs_idr_class;
 extern const struct uverbs_obj_type_class uverbs_fd_class;
 int uverbs_uobject_fd_release(struct inode *inode, struct file *filp);
-- 
2.46.2


