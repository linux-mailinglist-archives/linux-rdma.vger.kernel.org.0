Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4ACAFF5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfJCUUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733146AbfJCUUV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12463B052;
        Thu,  3 Oct 2019 20:20:19 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 04/11] drm: convert drm_mm_interval_tree to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:51 -0700
Message-Id: <20191003201858.11666-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The drm_mm interval tree really wants [a, b) intervals, not
fully closed as it is now. As such convert it to use the new
interval_tree_gen.h.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/gpu/drm/drm_mm.c                              | 8 ++++----
 drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c | 2 +-
 drivers/gpu/drm/selftests/test-drm_mm.c               | 2 +-
 include/drm/drm_mm.h                                  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 4581c5387372..17feb00e7d80 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -43,7 +43,7 @@
  */
 
 #include <linux/export.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
@@ -150,11 +150,11 @@ static void show_leaks(struct drm_mm *mm) { }
 #endif
 
 #define START(node) ((node)->start)
-#define LAST(node)  ((node)->start + (node)->size - 1)
+#define END(node)   ((node)->start + (node)->size)
 
 INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
 		     u64, __subtree_last,
-		     START, LAST, static inline, drm_mm_interval_tree)
+		     START, END, static inline, drm_mm_interval_tree)
 
 struct drm_mm_node *
 __drm_mm_interval_first(const struct drm_mm *mm, u64 start, u64 last)
@@ -172,7 +172,7 @@ static void drm_mm_interval_tree_add_node(struct drm_mm_node *hole_node,
 	struct drm_mm_node *parent;
 	bool leftmost;
 
-	node->__subtree_last = LAST(node);
+	node->__subtree_last = END(node);
 
 	if (hole_node->allocated) {
 		rb = &hole_node->rb;
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 3e6f4a65d356..af40d3bfa065 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -1150,7 +1150,7 @@ static int check_scratch(struct i915_gem_context *ctx, u64 offset)
 {
 	struct drm_mm_node *node =
 		__drm_mm_interval_first(&ctx->vm->mm,
-					offset, offset + sizeof(u32) - 1);
+					offset, offset + sizeof(u32));
 	if (!node || node->start > offset)
 		return 0;
 
diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 388f9844f4ba..f34f975c1570 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -853,7 +853,7 @@ static bool assert_contiguous_in_range(struct drm_mm *mm,
 	}
 
 	if (start > 0) {
-		node = __drm_mm_interval_first(mm, 0, start - 1);
+		node = __drm_mm_interval_first(mm, 0, start);
 		if (node->allocated) {
 			pr_err("node before start: node=%llx+%llu, start=%llx\n",
 			       node->start, node->size, start);
diff --git a/include/drm/drm_mm.h b/include/drm/drm_mm.h
index 2c3bbb43c7d1..0eda6180e1ef 100644
--- a/include/drm/drm_mm.h
+++ b/include/drm/drm_mm.h
@@ -485,19 +485,19 @@ __drm_mm_interval_first(const struct drm_mm *mm, u64 start, u64 last);
  * @node__: drm_mm_node structure to assign to in each iteration step
  * @mm__: drm_mm allocator to walk
  * @start__: starting offset, the first node will overlap this
- * @end__: ending offset, the last node will start before this (but may overlap)
+ * @end__: ending offset, the last node will start before this
  *
  * This iterator walks over all nodes in the range allocator that lie
  * between @start and @end. It is implemented similarly to list_for_each(),
  * but using the internal interval tree to accelerate the search for the
  * starting node, and so not safe against removal of elements. It assumes
  * that @end is within (or is the upper limit of) the drm_mm allocator.
- * If [@start, @end] are beyond the range of the drm_mm, the iterator may walk
+ * If [@start, @end) are beyond the range of the drm_mm, the iterator may walk
  * over the special _unallocated_ &drm_mm.head_node, and may even continue
  * indefinitely.
  */
 #define drm_mm_for_each_node_in_range(node__, mm__, start__, end__)	\
-	for (node__ = __drm_mm_interval_first((mm__), (start__), (end__)-1); \
+	for (node__ = __drm_mm_interval_first((mm__), (start__), (end__)); \
 	     node__->start < (end__);					\
 	     node__ = list_next_entry(node__, node_list))
 
-- 
2.16.4

