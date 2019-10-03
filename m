Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156A9CB002
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfJCUU2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388861AbfJCUU1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AF0FB03B;
        Thu,  3 Oct 2019 20:20:25 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net, Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 06/11] IB,usnic: convert usnic_uiom_interval_tree to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:53 -0700
Message-Id: <20191003201858.11666-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The usnic_uiom interval tree really wants [a, b) intervals,
not fully closed. As such convert it to use the new
interval_tree_gen.h, and also rename the 'last' endpoint
in the node to 'end', which both a more suitable name for
the half closed interval and also reduces the chances of some
caller being missed.

The conversion can get non-trivial when calling into things like:

 - find_intervals_intersection_sorted()
 - usnic_uiom_insert_interval()

which have been converted to no longer subtracting one from the
interval->end, hoping that the semantics of ad-hoc usage remain
untouched.

Cc: Christian Benvenuti <benve@cisco.com>
Cc: Nelson Escobar <neescoba@cisco.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c           |  8 +++----
 .../infiniband/hw/usnic/usnic_uiom_interval_tree.c | 26 ++++++++++------------
 .../infiniband/hw/usnic/usnic_uiom_interval_tree.h |  2 +-
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 62e6ffa9ad78..14f607c398a8 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -200,7 +200,7 @@ static void usnic_uiom_unmap_sorted_intervals(struct list_head *intervals,
 
 	list_for_each_entry_safe(interval, tmp, intervals, link) {
 		va = interval->start << PAGE_SHIFT;
-		size = ((interval->last - interval->start) + 1) << PAGE_SHIFT;
+		size = (interval->end - interval->start) << PAGE_SHIFT;
 		while (size > 0) {
 			/* Workaround for RH 970401 */
 			usnic_dbg("va 0x%lx size 0x%lx", va, PAGE_SIZE);
@@ -223,7 +223,7 @@ static void __usnic_uiom_reg_release(struct usnic_uiom_pd *pd,
 
 	npages = PAGE_ALIGN(uiomr->length + uiomr->offset) >> PAGE_SHIFT;
 	vpn_start = (uiomr->va & PAGE_MASK) >> PAGE_SHIFT;
-	vpn_last = vpn_start + npages - 1;
+	vpn_last = vpn_start + npages;
 
 	spin_lock(&pd->lock);
 	usnic_uiom_remove_interval(&pd->root, vpn_start,
@@ -293,7 +293,7 @@ static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
 				pa_end = pa;
 			}
 
-			if ((va >> PAGE_SHIFT) == interval_node->last) {
+			if ((va >> PAGE_SHIFT) == interval_node->end) {
 				/* Last page of the interval */
 				size = pa - pa_start + PAGE_SIZE;
 				usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x\n",
@@ -354,7 +354,7 @@ struct usnic_uiom_reg *usnic_uiom_reg_get(struct usnic_uiom_pd *pd,
 	offset = addr & ~PAGE_MASK;
 	npages = PAGE_ALIGN(size + offset) >> PAGE_SHIFT;
 	vpn_start = (addr & PAGE_MASK) >> PAGE_SHIFT;
-	vpn_last = vpn_start + npages - 1;
+	vpn_last = vpn_start + npages;
 
 	uiomr = kmalloc(sizeof(*uiomr), GFP_KERNEL);
 	if (!uiomr)
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c b/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c
index d399523206c7..12c968447673 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c
@@ -36,11 +36,11 @@
 #include <linux/slab.h>
 #include <linux/list_sort.h>
 
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 #include "usnic_uiom_interval_tree.h"
 
 #define START(node) ((node)->start)
-#define LAST(node) ((node)->last)
+#define END(node) ((node)->end)
 
 #define MAKE_NODE(node, start, end, ref_cnt, flags, err, err_out)	\
 		do {							\
@@ -76,7 +76,7 @@ usnic_uiom_interval_node_alloc(long int start, long int last, int ref_cnt,
 		return NULL;
 
 	interval->start = start;
-	interval->last = last;
+	interval->end = last;
 	interval->flags = flags;
 	interval->ref_cnt = ref_cnt;
 
@@ -133,7 +133,7 @@ int usnic_uiom_get_intervals_diff(unsigned long start, unsigned long last,
 
 	list_for_each_entry(interval, &intersection_set, link) {
 		if (pivot < interval->start) {
-			MAKE_NODE_AND_APPEND(tmp, pivot, interval->start - 1,
+			MAKE_NODE_AND_APPEND(tmp, pivot, interval->start,
 						1, flags, err, err_out,
 						diff_set);
 			pivot = interval->start;
@@ -144,12 +144,10 @@ int usnic_uiom_get_intervals_diff(unsigned long start, unsigned long last,
 		 * but not in both.
 		 */
 
-		if (pivot > interval->last) {
+		if (pivot > interval->end - 1) {
 			continue;
-		} else if (pivot <= interval->last &&
-				FLAGS_EQUAL(interval->flags, flags,
-				flag_mask)) {
-			pivot = interval->last + 1;
+		} else if (FLAGS_EQUAL(interval->flags, flags, flag_mask)) {
+			pivot = interval->end;
 		}
 	}
 
@@ -195,15 +193,15 @@ int usnic_uiom_insert_interval(struct rb_root_cached *root, unsigned long start,
 		 * inserted
 		 */
 		istart = interval->start;
-		ilast = interval->last;
+		ilast = interval->end - 1;
 		iref_cnt = interval->ref_cnt;
 		iflags = interval->flags;
 
 		if (istart < lpivot) {
-			MAKE_NODE_AND_APPEND(tmp, istart, lpivot - 1, iref_cnt,
+			MAKE_NODE_AND_APPEND(tmp, istart, lpivot, iref_cnt,
 						iflags, err, err_out, &to_add);
 		} else if (istart > lpivot) {
-			MAKE_NODE_AND_APPEND(tmp, lpivot, istart - 1, 1, flags,
+			MAKE_NODE_AND_APPEND(tmp, lpivot, istart, 1, flags,
 						err, err_out, &to_add);
 			lpivot = istart;
 		} else {
@@ -222,7 +220,7 @@ int usnic_uiom_insert_interval(struct rb_root_cached *root, unsigned long start,
 						&to_add);
 		}
 
-		lpivot = ilast + 1;
+		lpivot = interval->end;
 	}
 
 	if (lpivot <= last)
@@ -267,4 +265,4 @@ void usnic_uiom_remove_interval(struct rb_root_cached *root,
 
 INTERVAL_TREE_DEFINE(struct usnic_uiom_interval_node, rb,
 			unsigned long, __subtree_last,
-			START, LAST, , usnic_uiom_interval_tree)
+			START, END, , usnic_uiom_interval_tree)
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h b/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h
index 1d7fc3226bca..496edc9758c1 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h
@@ -40,7 +40,7 @@ struct usnic_uiom_interval_node {
 	struct rb_node			rb;
 	struct list_head		link;
 	unsigned long			start;
-	unsigned long			last;
+	unsigned long		        end;
 	unsigned long			__subtree_last;
 	unsigned int			ref_cnt;
 	int				flags;
-- 
2.16.4

