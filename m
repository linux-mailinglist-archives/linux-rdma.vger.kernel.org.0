Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E87E6ECC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfJ1JP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:15:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37883 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387873AbfJ1JP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fq6C032532;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fql1031559;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9FqPF031558;
        Mon, 28 Oct 2019 11:15:52 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 3/6] mlx5: Extend mlx5_alloc_parent_domain() to support custom allocator
Date:   Mon, 28 Oct 2019 11:14:56 +0200
Message-Id: <1572254099-30864-4-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend mlx5_alloc_parent_domain() to support custom allocator,
downstream patches from this series will use this functionality.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 providers/mlx5/mlx5.h  |  5 +++++
 providers/mlx5/verbs.c | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index e63319e..e960e6f 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -352,6 +352,11 @@ struct mlx5_pd {
 struct mlx5_parent_domain {
 	struct mlx5_pd mpd;
 	struct mlx5_td *mtd;
+	void *(*alloc)(struct ibv_pd *pd, void *pd_context, size_t size,
+		       size_t alignment, uint64_t resource_type);
+	void (*free)(struct ibv_pd *pd, void *pd_context, void *ptr,
+		     uint64_t resource_type);
+	void *pd_context;
 };
 
 enum {
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 0a66a33..166ea4f 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -326,7 +326,9 @@ mlx5_alloc_parent_domain(struct ibv_context *context,
 	if (ibv_check_alloc_parent_domain(attr))
 		return NULL;
 
-	if (attr->comp_mask) {
+	if (!check_comp_mask(attr->comp_mask,
+			     IBV_PARENT_DOMAIN_INIT_ATTR_ALLOCATORS |
+			     IBV_PARENT_DOMAIN_INIT_ATTR_PD_CONTEXT)) {
 		errno = EINVAL;
 		return NULL;
 	}
@@ -350,6 +352,14 @@ mlx5_alloc_parent_domain(struct ibv_context *context,
 	    &mparent_domain->mpd.ibv_pd,
 	    &mparent_domain->mpd.mprotection_domain->ibv_pd);
 
+	if (attr->comp_mask & IBV_PARENT_DOMAIN_INIT_ATTR_ALLOCATORS) {
+		mparent_domain->alloc = attr->alloc;
+		mparent_domain->free = attr->free;
+	}
+
+	if (attr->comp_mask & IBV_PARENT_DOMAIN_INIT_ATTR_PD_CONTEXT)
+		mparent_domain->pd_context = attr->pd_context;
+
 	return &mparent_domain->mpd.ibv_pd;
 }
 
-- 
1.8.3.1

