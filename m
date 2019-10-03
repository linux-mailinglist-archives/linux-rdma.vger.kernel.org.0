Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C7CB006
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfJCUUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389079AbfJCUUi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C61F0B052;
        Thu,  3 Oct 2019 20:20:35 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 10/11] lib: drop interval_tree_generic.h
Date:   Thu,  3 Oct 2019 13:18:57 -0700
Message-Id: <20191003201858.11666-11-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that we have the semi-open equivalent, interval_tree_gen.h, and
all users updated, we can do without this header file.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/interval_tree_generic.h | 187 ----------------------------------
 1 file changed, 187 deletions(-)
 delete mode 100644 include/linux/interval_tree_generic.h

diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
deleted file mode 100644
index aaa8a0767aa3..000000000000
--- a/include/linux/interval_tree_generic.h
+++ /dev/null
@@ -1,187 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
-  Interval Trees
-  (C) 2012  Michel Lespinasse <walken@google.com>
-
-
-  include/linux/interval_tree_generic.h
-*/
-
-#include <linux/rbtree_augmented.h>
-
-/*
- * Template for implementing interval trees
- *
- * ITSTRUCT:   struct type of the interval tree nodes
- * ITRB:       name of struct rb_node field within ITSTRUCT
- * ITTYPE:     type of the interval endpoints
- * ITSUBTREE:  name of ITTYPE field within ITSTRUCT holding last-in-subtree
- * ITSTART(n): start endpoint of ITSTRUCT node n
- * ITLAST(n):  last endpoint of ITSTRUCT node n
- * ITSTATIC:   'static' or empty
- * ITPREFIX:   prefix to use for the inline tree definitions
- *
- * Note - before using this, please consider if generic version
- * (interval_tree.h) would work for you...
- */
-
-#define INTERVAL_TREE_DEFINE(ITSTRUCT, ITRB, ITTYPE, ITSUBTREE,		      \
-			     ITSTART, ITLAST, ITSTATIC, ITPREFIX)	      \
-									      \
-/* Callbacks for augmented rbtree insert and remove */			      \
-									      \
-RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,			      \
-			 ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)	      \
-									      \
-/* Insert / remove interval nodes from the tree */			      \
-									      \
-ITSTATIC void ITPREFIX ## _insert(ITSTRUCT *node,			      \
-				  struct rb_root_cached *root)	 	      \
-{									      \
-	struct rb_node **link = &root->rb_root.rb_node, *rb_parent = NULL;    \
-	ITTYPE start = ITSTART(node), last = ITLAST(node);		      \
-	ITSTRUCT *parent;						      \
-	bool leftmost = true;						      \
-									      \
-	while (*link) {							      \
-		rb_parent = *link;					      \
-		parent = rb_entry(rb_parent, ITSTRUCT, ITRB);		      \
-		if (parent->ITSUBTREE < last)				      \
-			parent->ITSUBTREE = last;			      \
-		if (start < ITSTART(parent))				      \
-			link = &parent->ITRB.rb_left;			      \
-		else {							      \
-			link = &parent->ITRB.rb_right;			      \
-			leftmost = false;				      \
-		}							      \
-	}								      \
-									      \
-	node->ITSUBTREE = last;						      \
-	rb_link_node(&node->ITRB, rb_parent, link);			      \
-	rb_insert_augmented_cached(&node->ITRB, root,			      \
-				   leftmost, &ITPREFIX ## _augment);	      \
-}									      \
-									      \
-ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
-				  struct rb_root_cached *root)		      \
-{									      \
-	rb_erase_augmented_cached(&node->ITRB, root, &ITPREFIX ## _augment);  \
-}									      \
-									      \
-/*									      \
- * Iterate over intervals intersecting [start;last]			      \
- *									      \
- * Note that a node's interval intersects [start;last] iff:		      \
- *   Cond1: ITSTART(node) <= last					      \
- * and									      \
- *   Cond2: start <= ITLAST(node)					      \
- */									      \
-									      \
-static ITSTRUCT *							      \
-ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
-{									      \
-	while (true) {							      \
-		/*							      \
-		 * Loop invariant: start <= node->ITSUBTREE		      \
-		 * (Cond2 is satisfied by one of the subtree nodes)	      \
-		 */							      \
-		if (node->ITRB.rb_left) {				      \
-			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
-						  ITSTRUCT, ITRB);	      \
-			if (start <= left->ITSUBTREE) {			      \
-				/*					      \
-				 * Some nodes in left subtree satisfy Cond2.  \
-				 * Iterate to find the leftmost such node N.  \
-				 * If it also satisfies Cond1, that's the     \
-				 * match we are looking for. Otherwise, there \
-				 * is no matching interval as nodes to the    \
-				 * right of N can't satisfy Cond1 either.     \
-				 */					      \
-				node = left;				      \
-				continue;				      \
-			}						      \
-		}							      \
-		if (ITSTART(node) <= last) {		/* Cond1 */	      \
-			if (start <= ITLAST(node))	/* Cond2 */	      \
-				return node;	/* node is leftmost match */  \
-			if (node->ITRB.rb_right) {			      \
-				node = rb_entry(node->ITRB.rb_right,	      \
-						ITSTRUCT, ITRB);	      \
-				if (start <= node->ITSUBTREE)		      \
-					continue;			      \
-			}						      \
-		}							      \
-		return NULL;	/* No match */				      \
-	}								      \
-}									      \
-									      \
-ITSTATIC ITSTRUCT *							      \
-ITPREFIX ## _iter_first(struct rb_root_cached *root,			      \
-			ITTYPE start, ITTYPE last)			      \
-{									      \
-	ITSTRUCT *node, *leftmost;					      \
-									      \
-	if (!root->rb_root.rb_node)					      \
-		return NULL;						      \
-									      \
-	/*								      \
-	 * Fastpath range intersection/overlap between A: [a0, a1] and	      \
-	 * B: [b0, b1] is given by:					      \
-	 *								      \
-	 *         a0 <= b1 && b0 <= a1					      \
-	 *								      \
-	 *  ... where A holds the lock range and B holds the smallest	      \
-	 * 'start' and largest 'last' in the tree. For the later, we	      \
-	 * rely on the root node, which by augmented interval tree	      \
-	 * property, holds the largest value in its last-in-subtree.	      \
-	 * This allows mitigating some of the tree walk overhead for	      \
-	 * for non-intersecting ranges, maintained and consulted in O(1).     \
-	 */								      \
-	node = rb_entry(root->rb_root.rb_node, ITSTRUCT, ITRB);		      \
-	if (node->ITSUBTREE < start)					      \
-		return NULL;						      \
-									      \
-	leftmost = rb_entry(root->rb_leftmost, ITSTRUCT, ITRB);		      \
-	if (ITSTART(leftmost) > last)					      \
-		return NULL;						      \
-									      \
-	return ITPREFIX ## _subtree_search(node, start, last);		      \
-}									      \
-									      \
-ITSTATIC ITSTRUCT *							      \
-ITPREFIX ## _iter_next(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
-{									      \
-	struct rb_node *rb = node->ITRB.rb_right, *prev;		      \
-									      \
-	while (true) {							      \
-		/*							      \
-		 * Loop invariants:					      \
-		 *   Cond1: ITSTART(node) <= last			      \
-		 *   rb == node->ITRB.rb_right				      \
-		 *							      \
-		 * First, search right subtree if suitable		      \
-		 */							      \
-		if (rb) {						      \
-			ITSTRUCT *right = rb_entry(rb, ITSTRUCT, ITRB);	      \
-			if (start <= right->ITSUBTREE)			      \
-				return ITPREFIX ## _subtree_search(right,     \
-								start, last); \
-		}							      \
-									      \
-		/* Move up the tree until we come from a node's left child */ \
-		do {							      \
-			rb = rb_parent(&node->ITRB);			      \
-			if (!rb)					      \
-				return NULL;				      \
-			prev = &node->ITRB;				      \
-			node = rb_entry(rb, ITSTRUCT, ITRB);		      \
-			rb = node->ITRB.rb_right;			      \
-		} while (prev == rb);					      \
-									      \
-		/* Check if the node intersects [start;last] */		      \
-		if (last < ITSTART(node))		/* !Cond1 */	      \
-			return NULL;					      \
-		else if (start <= ITLAST(node))		/* Cond2 */	      \
-			return node;					      \
-	}								      \
-}
-- 
2.16.4

