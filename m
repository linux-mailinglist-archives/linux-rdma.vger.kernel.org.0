Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB1CB007
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbfJCUUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389158AbfJCUUr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17007B011;
        Thu,  3 Oct 2019 20:20:39 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 11/11] x86/mm, pat: convert pat tree to generic interval tree
Date:   Thu,  3 Oct 2019 13:18:58 -0700
Message-Id: <20191003201858.11666-12-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With some considerations, the custom pat_rbtree implementation can be
simplified to use most of the generic interval_tree machinery.

o The tree inorder traversal can slightly differ when there are key
('start') collisions in the tree due to one going left and another right.
This, however, only affects the output of debugfs' pat_memtype_list file.

o Generic interval trees are now semi open [a,b), which suits well with
what pat wants.

o Erasing logic must remain untouched as well.

In order for the types to remain u64, the 'memtype_interval' calls are
introduced, as opposed to simply using struct interval_tree.

In addition, pat tree might potentially also benefit by the fast overlap
detection for the insertion case when looking up the first overlapping node
in the tree.

Finally, I've tested this on various servers, via sanity warnings, running
side by side with the current version and so far see no differences in the
returned pointer node when doing memtype_rb_lowest_match() lookups.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/pat.c        |  22 +++----
 arch/x86/mm/pat_rbtree.c | 151 ++++++++++-------------------------------------
 2 files changed, 43 insertions(+), 130 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f69920..a3d47b5db704 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -482,8 +482,8 @@ static int reserve_ram_pages_type(u64 start, u64 end,
 		page = pfn_to_page(pfn);
 		type = get_page_memtype(page);
 		if (type != _PAGE_CACHE_MODE_WB) {
-			pr_info("x86/PAT: reserve_ram_pages_type failed [mem %#010Lx-%#010Lx], track 0x%x, req 0x%x\n",
-				start, end - 1, type, req_type);
+			pr_info("x86/PAT: reserve_ram_pages_type failed [mem %#010Lx-%#010Lx), track 0x%x, req 0x%x\n",
+				start, end, type, req_type);
 			if (new_type)
 				*new_type = type;
 
@@ -553,8 +553,8 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 	start = sanitize_phys(start);
 	end = sanitize_phys(end);
 	if (start >= end) {
-		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
-				start, end - 1, cattr_name(req_type));
+		WARN(1, "%s failed: [mem %#010Lx-%#010Lx), req %s\n", __func__,
+				start, end, cattr_name(req_type));
 		return -EINVAL;
 	}
 
@@ -605,8 +605,8 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	err = rbt_memtype_check_insert(new, new_type);
 	if (err) {
-		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
-			start, end - 1,
+		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx), track %s, req %s\n",
+			start, end,
 			cattr_name(new->type), cattr_name(req_type));
 		kfree(new);
 		spin_unlock(&memtype_lock);
@@ -616,8 +616,8 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	spin_unlock(&memtype_lock);
 
-	dprintk("reserve_memtype added [mem %#010Lx-%#010Lx], track %s, req %s, ret %s\n",
-		start, end - 1, cattr_name(new->type), cattr_name(req_type),
+	dprintk("reserve_memtype added [mem %#010Lx-%#010Lx), track %s, req %s, ret %s\n",
+		start, end, cattr_name(new->type), cattr_name(req_type),
 		new_type ? cattr_name(*new_type) : "-");
 
 	return err;
@@ -654,14 +654,14 @@ int free_memtype(u64 start, u64 end)
 	spin_unlock(&memtype_lock);
 
 	if (IS_ERR(entry)) {
-		pr_info("x86/PAT: %s:%d freeing invalid memtype [mem %#010Lx-%#010Lx]\n",
-			current->comm, current->pid, start, end - 1);
+		pr_info("x86/PAT: %s:%d freeing invalid memtype [mem %#010Lx-%#010Lx)\n",
+			current->comm, current->pid, start, end);
 		return -EINVAL;
 	}
 
 	kfree(entry);
 
-	dprintk("free_memtype request [mem %#010Lx-%#010Lx]\n", start, end - 1);
+	dprintk("free_memtype request [mem %#010Lx-%#010Lx)\n", start, end);
 
 	return 0;
 }
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index 65ebe4b88f7c..89d097c50adb 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -5,14 +5,13 @@
  * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
  *          Suresh B Siddha <suresh.b.siddha@intel.com>
  *
- * Interval tree (augmented rbtree) used to store the PAT memory type
- * reservations.
+ * Interval tree used to store the PAT memory type reservations.
  */
 
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
-#include <linux/rbtree_augmented.h>
+#include <linux/interval_tree_gen.h>
 #include <linux/sched.h>
 #include <linux/gfp.h>
 
@@ -33,72 +32,25 @@
  *
  * memtype_lock protects the rbtree.
  */
+#define START(node) ((node)->start)
+#define END(node)  ((node)->end)
+INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
+		     START, END, static, memtype_interval)
 
-static struct rb_root memtype_rbroot = RB_ROOT;
-
-static int is_node_overlap(struct memtype *node, u64 start, u64 end)
-{
-	if (node->start >= end || node->end <= start)
-		return 0;
-
-	return 1;
-}
-
-static u64 get_subtree_max_end(struct rb_node *node)
-{
-	u64 ret = 0;
-	if (node) {
-		struct memtype *data = rb_entry(node, struct memtype, rb);
-		ret = data->subtree_max_end;
-	}
-	return ret;
-}
-
-#define NODE_END(node) ((node)->end)
-
-RB_DECLARE_CALLBACKS_MAX(static, memtype_rb_augment_cb,
-			 struct memtype, rb, u64, subtree_max_end, NODE_END)
-
-/* Find the first (lowest start addr) overlapping range from rb tree */
-static struct memtype *memtype_rb_lowest_match(struct rb_root *root,
-				u64 start, u64 end)
-{
-	struct rb_node *node = root->rb_node;
-	struct memtype *last_lower = NULL;
-
-	while (node) {
-		struct memtype *data = rb_entry(node, struct memtype, rb);
-
-		if (get_subtree_max_end(node->rb_left) > start) {
-			/* Lowest overlap if any must be on left side */
-			node = node->rb_left;
-		} else if (is_node_overlap(data, start, end)) {
-			last_lower = data;
-			break;
-		} else if (start >= data->start) {
-			/* Lowest overlap if any must be on right side */
-			node = node->rb_right;
-		} else {
-			break;
-		}
-	}
-	return last_lower; /* Returns NULL if there is no overlap */
-}
+static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
 
 enum {
 	MEMTYPE_EXACT_MATCH	= 0,
 	MEMTYPE_END_MATCH	= 1
 };
 
-static struct memtype *memtype_rb_match(struct rb_root *root,
+static struct memtype *memtype_rb_match(struct rb_root_cached *root,
 				u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_rb_lowest_match(root, start, end);
+	match = memtype_interval_iter_first(root, start, end);
 	while (match != NULL && match->start < end) {
-		struct rb_node *node;
-
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
 			return match;
@@ -107,26 +59,21 @@ static struct memtype *memtype_rb_match(struct rb_root *root,
 		    (match->start < start) && (match->end == end))
 			return match;
 
-		node = rb_next(&match->rb);
-		if (node)
-			match = rb_entry(node, struct memtype, rb);
-		else
-			match = NULL;
+		match = memtype_interval_iter_next(match, start, end);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
 }
 
-static int memtype_rb_check_conflict(struct rb_root *root,
+static int memtype_rb_check_conflict(struct rb_root_cached *root,
 				u64 start, u64 end,
 				enum page_cache_mode reqtype,
 				enum page_cache_mode *newtype)
 {
-	struct rb_node *node;
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_rb_lowest_match(&memtype_rbroot, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
 	if (match == NULL)
 		goto success;
 
@@ -136,19 +83,12 @@ static int memtype_rb_check_conflict(struct rb_root *root,
 	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
 	found_type = match->type;
 
-	node = rb_next(&match->rb);
-	while (node) {
-		match = rb_entry(node, struct memtype, rb);
-
-		if (match->start >= end) /* Checked all possible matches */
-			goto success;
-
-		if (is_node_overlap(match, start, end) &&
-		    match->type != found_type) {
+	match = memtype_interval_iter_next(match, start, end);
+	while (match) {
+		if (match->type != found_type)
 			goto failure;
-		}
 
-		node = rb_next(&match->rb);
+		match = memtype_interval_iter_next(match, start, end);
 	}
 success:
 	if (newtype)
@@ -163,28 +103,6 @@ static int memtype_rb_check_conflict(struct rb_root *root,
 	return -EBUSY;
 }
 
-static void memtype_rb_insert(struct rb_root *root, struct memtype *newdata)
-{
-	struct rb_node **node = &(root->rb_node);
-	struct rb_node *parent = NULL;
-
-	while (*node) {
-		struct memtype *data = rb_entry(*node, struct memtype, rb);
-
-		parent = *node;
-		if (data->subtree_max_end < newdata->end)
-			data->subtree_max_end = newdata->end;
-		if (newdata->start <= data->start)
-			node = &((*node)->rb_left);
-		else if (newdata->start > data->start)
-			node = &((*node)->rb_right);
-	}
-
-	newdata->subtree_max_end = newdata->end;
-	rb_link_node(&newdata->rb, parent, node);
-	rb_insert_augmented(&newdata->rb, root, &memtype_rb_augment_cb);
-}
-
 int rbt_memtype_check_insert(struct memtype *new,
 			     enum page_cache_mode *ret_type)
 {
@@ -192,14 +110,13 @@ int rbt_memtype_check_insert(struct memtype *new,
 
 	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
 						new->type, ret_type);
+	if (err)
+		goto done;
 
-	if (!err) {
-		if (ret_type)
-			new->type = *ret_type;
-
-		new->subtree_max_end = new->end;
-		memtype_rb_insert(&memtype_rbroot, new);
-	}
+	if (ret_type)
+		new->type = *ret_type;
+	memtype_interval_insert(new, &memtype_rbroot);
+done:
 	return err;
 }
 
@@ -225,15 +142,12 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 
 	if (data->start == start) {
 		/* munmap: erase this node */
-		rb_erase_augmented(&data->rb, &memtype_rbroot,
-					&memtype_rb_augment_cb);
+		memtype_interval_remove(data, &memtype_rbroot);
 	} else {
 		/* mremap: update the end value of this node */
-		rb_erase_augmented(&data->rb, &memtype_rbroot,
-					&memtype_rb_augment_cb);
+		memtype_interval_remove(data, &memtype_rbroot);
 		data->end = start;
-		data->subtree_max_end = data->end;
-		memtype_rb_insert(&memtype_rbroot, data);
+		memtype_interval_insert(data, &memtype_rbroot);
 		return NULL;
 	}
 
@@ -242,24 +156,23 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 
 struct memtype *rbt_memtype_lookup(u64 addr)
 {
-	return memtype_rb_lowest_match(&memtype_rbroot, addr, addr + PAGE_SIZE);
+	return memtype_interval_iter_first(&memtype_rbroot, addr, addr + PAGE_SIZE);
 }
 
 #if defined(CONFIG_DEBUG_FS)
 int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
 {
-	struct rb_node *node;
+	struct memtype *match;
 	int i = 1;
 
-	node = rb_first(&memtype_rbroot);
-	while (node && pos != i) {
-		node = rb_next(node);
+	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+	while (match && pos != i) {
+		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
 		i++;
 	}
 
-	if (node) { /* pos == i */
-		struct memtype *this = rb_entry(node, struct memtype, rb);
-		*out = *this;
+	if (match) { /* pos == i */
+		*out = *match;
 		return 0;
 	} else {
 		return 1;
-- 
2.16.4

