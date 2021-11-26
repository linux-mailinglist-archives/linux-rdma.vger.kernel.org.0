Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0145EDFC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377487AbhKZMi3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhKZMg2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC0C08EA6F;
        Fri, 26 Nov 2021 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BZ5PLUQpkwxEusMxJULA8/aX7ao2K6qNcU+5BMpwrAI=; b=U8eUC0O6eGRFHijfSLYkVEw0Tj
        Gfk1aDceaCQ9H9opBXohhF4z7iTnhlEgHN2RepPx9b+CZzGkrwGdLaP2x0FXfJ4hZhOunTQeFLfo2
        VYKPuQyx9gKF97dqmcFy2T3XWzDAdpse5flriIGIB3D6j0un4zcO3Ek6+oFeyBZkH2mCGCmJT2VXb
        iqerEGQsTD9YCrMXWapjmu1gGJU6Q22TKmimH8l0qenQHZs/UPWSb7wL+vG25B5uITnUf4F2rFQ8I
        F3DZiAsL6U0eE76Q2lMpd7Wc9Yz9hbsLWvLsiHOb1GOrdsVr4bLqzjBLxv/zg3bxUWVMaC8HjcEyD
        FGJIRUfw==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZrx-00ASHc-Qu; Fri, 26 Nov 2021 11:58:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 02/14] fork: move copy_io to block/blk-ioc.c
Date:   Fri, 26 Nov 2021 12:58:05 +0100
Message-Id: <20211126115817.2087431-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the copying of the I/O context to the block layer as that is where
we can use the proper low-level interfaces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c           | 27 +++++++++++++++++++++++++++
 include/linux/iocontext.h | 23 +++++++++++++----------
 kernel/fork.c             | 26 --------------------------
 3 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 70c99e85aee50..3b31cfad4b75b 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -322,6 +322,33 @@ struct io_context *get_task_io_context(struct task_struct *task,
 	return NULL;
 }
 
+int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
+{
+	struct io_context *ioc = current->io_context;
+	struct io_context *new_ioc;
+
+	/*
+	 * Share io context with parent, if CLONE_IO is set
+	 */
+	if (clone_flags & CLONE_IO) {
+		get_io_context_active(ioc);
+
+		WARN_ON_ONCE(atomic_read(&ioc->nr_tasks) <= 0);
+		atomic_inc(&ioc->nr_tasks);
+
+		tsk->io_context = ioc;
+	} else if (ioprio_valid(ioc->ioprio)) {
+		new_ioc = get_task_io_context(tsk, GFP_KERNEL, NUMA_NO_NODE);
+		if (unlikely(!new_ioc))
+			return -ENOMEM;
+
+		new_ioc->ioprio = ioc->ioprio;
+		put_io_context(new_ioc);
+	}
+
+	return 0;
+}
+
 /**
  * ioc_lookup_icq - lookup io_cq from ioc
  * @ioc: the associated io_context
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 0a9dc40b7be84..bcd47d104d8e6 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -129,14 +129,6 @@ static inline void get_io_context_active(struct io_context *ioc)
 	atomic_inc(&ioc->active_ref);
 }
 
-static inline void ioc_task_link(struct io_context *ioc)
-{
-	get_io_context_active(ioc);
-
-	WARN_ON_ONCE(atomic_read(&ioc->nr_tasks) <= 0);
-	atomic_inc(&ioc->nr_tasks);
-}
-
 struct task_struct;
 #ifdef CONFIG_BLOCK
 void put_io_context(struct io_context *ioc);
@@ -144,10 +136,21 @@ void put_io_context_active(struct io_context *ioc);
 void exit_io_context(struct task_struct *task);
 struct io_context *get_task_io_context(struct task_struct *task,
 				       gfp_t gfp_flags, int node);
+int __copy_io(unsigned long clone_flags, struct task_struct *tsk);
+static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
+{
+	if (!current->io_context)
+		return 0;
+	return __copy_io(clone_flags, tsk);
+}
 #else
 struct io_context;
 static inline void put_io_context(struct io_context *ioc) { }
 static inline void exit_io_context(struct task_struct *task) { }
-#endif
+static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
+{
+	return 0;
+}
+#endif /* CONFIG_BLOCK */
 
-#endif
+#endif /* IOCONTEXT_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697d..3161d7980155e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1556,32 +1556,6 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	return error;
 }
 
-static int copy_io(unsigned long clone_flags, struct task_struct *tsk)
-{
-#ifdef CONFIG_BLOCK
-	struct io_context *ioc = current->io_context;
-	struct io_context *new_ioc;
-
-	if (!ioc)
-		return 0;
-	/*
-	 * Share io context with parent, if CLONE_IO is set
-	 */
-	if (clone_flags & CLONE_IO) {
-		ioc_task_link(ioc);
-		tsk->io_context = ioc;
-	} else if (ioprio_valid(ioc->ioprio)) {
-		new_ioc = get_task_io_context(tsk, GFP_KERNEL, NUMA_NO_NODE);
-		if (unlikely(!new_ioc))
-			return -ENOMEM;
-
-		new_ioc->ioprio = ioc->ioprio;
-		put_io_context(new_ioc);
-	}
-#endif
-	return 0;
-}
-
 static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct sighand_struct *sig;
-- 
2.30.2

