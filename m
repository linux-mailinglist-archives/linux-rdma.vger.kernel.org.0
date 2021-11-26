Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E661C45EE1E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349220AbhKZMjd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbhKZMh0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2AC08EA76;
        Fri, 26 Nov 2021 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=75Yd+UjqZ8mEVC5ZdOQmcq+vXP3FIOnKl9cEqCAA/c0=; b=F+bAXzkZvw6q/0b2SNKRR/ph95
        8MY6tXc+k6Mmcg3v7qm16ASN6/jEEybgpLtaf4tHVvB2y+5GQ9Hs4aGI362328nsjpSqgkuBgi5bz
        lAj6vl0sdqmgk5IB//NNUhgt9jpFxF7SjnXsLOIphjJDF8Ez5LH6WEHlRbi9OviZa6kuxUhBjK2Z3
        L+9VBCnjABpBghEoHCD4l83vqxKaQhbswoX3KjOx2X0ptajyZzgC/qrGZEy+bo6IS+tIFIg0hm2KE
        OANxj+6D3DvH66QivU3I2IzTu4DjTTgZmrBaDDlWp/nlUDAaLDT5DcZtTGGwFzL2RvCZcEeGDJ1db
        g690wvgw==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs6-00ASKg-Tn; Fri, 26 Nov 2021 11:58:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 09/14] block: remove get_io_context_active
Date:   Fri, 26 Nov 2021 12:58:12 +0100
Message-Id: <20211126115817.2087431-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fold it into it's only caller, and remove a lof of the debug checks
that are not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c           |  8 +++-----
 include/linux/iocontext.h | 16 ----------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 3ba15c867dfa6..cc4eb2ba87f74 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL_GPL(put_io_context);
  * put_io_context_active - put active reference on ioc
  * @ioc: ioc of interest
  *
- * Undo get_io_context_active().  If active reference reaches zero after
+ * Put an active reference to an ioc.  If active reference reaches zero after
  * put, @ioc can never issue further IOs and ioscheds are notified.
  */
 static void put_io_context_active(struct io_context *ioc)
@@ -333,11 +333,9 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 	 * Share io context with parent, if CLONE_IO is set
 	 */
 	if (clone_flags & CLONE_IO) {
-		get_io_context_active(ioc);
-
-		WARN_ON_ONCE(atomic_read(&ioc->nr_tasks) <= 0);
+		atomic_long_inc(&ioc->refcount);
+		atomic_inc(&ioc->active_ref);
 		atomic_inc(&ioc->nr_tasks);
-
 		tsk->io_context = ioc;
 	} else if (ioprio_valid(ioc->ioprio)) {
 		new_ioc = get_task_io_context(tsk, GFP_KERNEL, NUMA_NO_NODE);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 3ba45953d5228..c1229fbd6691c 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -113,22 +113,6 @@ struct io_context {
 	struct work_struct release_work;
 };
 
-/**
- * get_io_context_active - get active reference on ioc
- * @ioc: ioc of interest
- *
- * Only iocs with active reference can issue new IOs.  This function
- * acquires an active reference on @ioc.  The caller must already have an
- * active reference on @ioc.
- */
-static inline void get_io_context_active(struct io_context *ioc)
-{
-	WARN_ON_ONCE(atomic_long_read(&ioc->refcount) <= 0);
-	WARN_ON_ONCE(atomic_read(&ioc->active_ref) <= 0);
-	atomic_long_inc(&ioc->refcount);
-	atomic_inc(&ioc->active_ref);
-}
-
 struct task_struct;
 #ifdef CONFIG_BLOCK
 void put_io_context(struct io_context *ioc);
-- 
2.30.2

