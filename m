Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D34CB004
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbfJCUUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388941AbfJCUUc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF8BDB06B;
        Thu,  3 Oct 2019 20:20:29 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 08/11] mm: convert vma_interval_tree to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:55 -0700
Message-Id: <20191003201858.11666-9-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The vma and anon vma interval tree really wants [a, b) intervals,
not fully closed. As such convert it to use the new
interval_tree_gen.h. Because of vma_last_pgoff(), the conversion
is quite straightforward.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/mm.h | 4 ++--
 mm/interval_tree.c | 4 ++--
 mm/memory.c        | 2 +-
 mm/nommu.c         | 2 +-
 mm/rmap.c          | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 53f9784d917d..3bc06e1de40c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2249,7 +2249,7 @@ struct vm_area_struct *vma_interval_tree_iter_next(struct vm_area_struct *node,
 	     vma; vma = vma_interval_tree_iter_next(vma, start, last))
 
 #define vma_interval_tree_foreach_stab(vma, root, start)		\
-	vma_interval_tree_foreach(vma, root, start, start)
+	vma_interval_tree_foreach(vma, root, start, start + 1)
 
 void anon_vma_interval_tree_insert(struct anon_vma_chain *node,
 				   struct rb_root_cached *root);
@@ -2269,7 +2269,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 #define anon_vma_interval_tree_foreach_stab(vma, root, start)		\
-	anon_vma_interval_tree_foreach(vma, root, start, start)
+	anon_vma_interval_tree_foreach(vma, root, start, start + 1)
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 11c75fb07584..1f8a7c122dd7 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -8,7 +8,7 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/rmap.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 
 static inline unsigned long vma_start_pgoff(struct vm_area_struct *v)
 {
@@ -17,7 +17,7 @@ static inline unsigned long vma_start_pgoff(struct vm_area_struct *v)
 
 static inline unsigned long vma_last_pgoff(struct vm_area_struct *v)
 {
-	return v->vm_pgoff + vma_pages(v) - 1;
+	return v->vm_pgoff + vma_pages(v);
 }
 
 INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..8f6978abf64a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2679,7 +2679,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 
 	details.check_mapping = even_cows ? NULL : mapping;
 	details.first_index = start;
-	details.last_index = start + nr - 1;
+	details.last_index = start + nr;
 	if (details.last_index < details.first_index)
 		details.last_index = ULONG_MAX;
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 99b7ec318824..284c2a948d79 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1793,7 +1793,7 @@ int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
 	size_t r_size, r_top;
 
 	low = newsize >> PAGE_SHIFT;
-	high = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	high = (size + PAGE_SIZE) >> PAGE_SHIFT;
 
 	down_write(&nommu_region_sem);
 	i_mmap_lock_read(inode->i_mapping);
diff --git a/mm/rmap.c b/mm/rmap.c
index d9a23bb773bf..48ca7d1a06b5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1826,7 +1826,7 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		return;
 
 	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + hpage_nr_pages(page) - 1;
+	pgoff_end = pgoff_start + hpage_nr_pages(page);
 	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
 			pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
@@ -1879,11 +1879,11 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		return;
 
 	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + hpage_nr_pages(page) - 1;
+	pgoff_end = pgoff_start + hpage_nr_pages(page);
 	if (!locked)
 		i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap,
-			pgoff_start, pgoff_end) {
+				  pgoff_start, pgoff_end) {
 		unsigned long address = vma_address(page, vma);
 
 		cond_resched();
-- 
2.16.4

