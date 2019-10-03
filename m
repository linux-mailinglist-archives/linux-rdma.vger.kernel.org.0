Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0295CB001
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbfJCUUY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388824AbfJCUUX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0BE4B03B;
        Thu,  3 Oct 2019 20:20:21 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net, Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 05/11] IB/hfi1: convert __mmu_int_rb to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:52 -0700
Message-Id: <20191003201858.11666-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The __mmu_int_rb interval tree really wants [a, b) intervals,
not fully closed as currently. As such convert it to use the new
interval_tree_gen.h.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 14d2a90964c3..fb6382b2d44e 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -47,7 +47,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/mmu_notifier.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 
 #include "mmu_rb.h"
 #include "trace.h"
@@ -89,7 +89,7 @@ static unsigned long mmu_node_start(struct mmu_rb_node *node)
 
 static unsigned long mmu_node_last(struct mmu_rb_node *node)
 {
-	return PAGE_ALIGN(node->addr + node->len) - 1;
+	return PAGE_ALIGN(node->addr + node->len);
 }
 
 int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
@@ -195,13 +195,13 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	trace_hfi1_mmu_rb_search(addr, len);
 	if (!handler->ops->filter) {
 		node = __mmu_int_rb_iter_first(&handler->root, addr,
-					       (addr + len) - 1);
+					       addr + len);
 	} else {
 		for (node = __mmu_int_rb_iter_first(&handler->root, addr,
-						    (addr + len) - 1);
+						    addr + len);
 		     node;
 		     node = __mmu_int_rb_iter_next(node, addr,
-						   (addr + len) - 1)) {
+						   addr + len)) {
 			if (handler->ops->filter(node, addr, len))
 				return node;
 		}
@@ -293,11 +293,10 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 	bool added = false;
 
 	spin_lock_irqsave(&handler->lock, flags);
-	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
+	for (node = __mmu_int_rb_iter_first(root, range->start, range->end);
 	     node; node = ptr) {
 		/* Guard against node removal. */
-		ptr = __mmu_int_rb_iter_next(node, range->start,
-					     range->end - 1);
+		ptr = __mmu_int_rb_iter_next(node, range->start, range->end);
 		trace_hfi1_mmu_mem_invalidate(node->addr, node->len);
 		if (handler->ops->invalidate(handler->ops_arg, node)) {
 			__mmu_int_rb_remove(node, root);
-- 
2.16.4

