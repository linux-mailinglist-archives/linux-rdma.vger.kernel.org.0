Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFF438ADD
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhJXRPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 13:15:39 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:43136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231733AbhJXRPi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Oct 2021 13:15:38 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EFE7D1802DE18;
        Sun, 24 Oct 2021 17:13:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id CFF0F315D76;
        Sun, 24 Oct 2021 17:13:15 +0000 (UTC)
Message-ID: <166b715d71f98336e8ecab72b0dbdd266eee9193.camel@perches.com>
Subject: [PATCH] RDMA/rxe: Make rxe_type_info static const
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sun, 24 Oct 2021 10:13:14 -0700
In-Reply-To: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
References: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CFF0F315D76
X-Spam-Status: No, score=-2.89
X-Stat-Signature: eaqduqszygpdgo88awypee3idegqptde
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+6G+uMhvdJwmd5MXDRRsV85FPlZ9gqVlQ=
X-HE-Tag: 1635095595-990800
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make struct rxe_type_info static const and local to the only uses.
Moves a bit of data to text.

$ size drivers/infiniband/sw/rxe/rxe_pool.o* (defconfig w/ infiniband swe)
   text	   data	    bss	    dec	    hex	filename
   4456	     12	      0	   4468	   1174	drivers/infiniband/sw/rxe/rxe_pool.o.new
   3817	    652	      0	   4469	   1175	drivers/infiniband/sw/rxe/rxe_pool.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---

On Sun, 2021-10-24 at 18:43 +0200, Christophe JAILLET wrote:
> 'table_size' is never read, it can be removed.
> 
> In fact, the only place that uses something that could be 'table_size' is
> 'alloc_index()'. In this function, it is re-computed from 'min_index' and
> 'max_index'.

 drivers/infiniband/sw/rxe/rxe_pool.c | 28 ++++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.h | 14 --------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7b4cb46edfd9d..8ba2de0ca2faa 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -7,9 +7,17 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* info about object pools
- */
-struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
+static const struct rxe_type_info {
+	const char		*name;
+	size_t			size;
+	size_t			elem_offset;
+	void			(*cleanup)(struct rxe_pool_entry *obj);
+	enum rxe_pool_flags	flags;
+	u32			min_index;
+	u32			max_index;
+	size_t			key_offset;
+	size_t			key_size;
+} rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
@@ -60,8 +68,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.elem_offset	= offsetof(struct rxe_mr, pelem),
 		.cleanup	= rxe_mr_cleanup,
 		.flags		= RXE_POOL_INDEX,
-		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
+		.max_index	= RXE_MAX_MR_INDEX,
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
@@ -69,8 +77,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.elem_offset	= offsetof(struct rxe_mw, pelem),
 		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
-		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
+		.max_index	= RXE_MAX_MW_INDEX,
 	},
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
@@ -329,7 +337,7 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
@@ -354,7 +362,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
@@ -397,7 +405,7 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_entry *elem =
 		container_of(kref, struct rxe_pool_entry, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	u8 *obj;
 
 	if (pool->cleanup)
@@ -413,7 +421,7 @@ void rxe_elem_release(struct kref *kref)
 
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -455,7 +463,7 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 1feca1bffcedf..05c036eb52acb 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -32,20 +32,6 @@ enum rxe_elem_type {
 
 struct rxe_pool_entry;
 
-struct rxe_type_info {
-	const char		*name;
-	size_t			size;
-	size_t			elem_offset;
-	void			(*cleanup)(struct rxe_pool_entry *obj);
-	enum rxe_pool_flags	flags;
-	u32			max_index;
-	u32			min_index;
-	size_t			key_offset;
-	size_t			key_size;
-};
-
-extern struct rxe_type_info rxe_type_info[];
-
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
 	struct kref		ref_cnt;


