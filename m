Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53A27EF2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfEWOAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 10:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOAQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 10:00:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B777F2133D;
        Thu, 23 May 2019 14:00:14 +0000 (UTC)
Date:   Thu, 23 May 2019 10:00:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
Message-ID: <20190523100013.52a8d2a6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

In discussing a build failure on x86_32 due to the use of roundup() on
a 64 bit number, I realized that there's no generic equivalent
roundup_64(). It is implemented in two separate places in the kernel,
but there really should be just one that all can use.

Although the other implementations are a static inline function, this
implementation is a macro to allow the use of typeof(x) to denote the
type that is being used. If the build is on a 64 bit machine, then the
roundup_64() macro will just default back to roundup(). But for 32 bit
machines, it will use the version that is will not cause issues with
dividing a 64 bit number on a 32 bit machine.

Link: http://lkml.kernel.org/r/20190522145450.25ff483d@gandalf.local.home

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 34a998012bf6..cdacfe1f732c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -143,14 +143,6 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	kfree(nvbo);
 }
 
-static inline u64
-roundup_64(u64 x, u32 y)
-{
-	x += y - 1;
-	do_div(x, y);
-	return x * y;
-}
-
 static void
 nouveau_bo_fixup_align(struct nouveau_bo *nvbo, u32 flags,
 		       int *align, u64 *size)
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index edbd5a210df2..13de9d49bd52 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -207,13 +207,6 @@ static inline xfs_dev_t linux_to_xfs_dev_t(dev_t dev)
 #define xfs_sort(a,n,s,fn)	sort(a,n,s,fn,NULL)
 #define xfs_stack_trace()	dump_stack()
 
-static inline uint64_t roundup_64(uint64_t x, uint32_t y)
-{
-	x += y - 1;
-	do_div(x, y);
-	return x * y;
-}
-
 static inline uint64_t howmany_64(uint64_t x, uint32_t y)
 {
 	x += y - 1;
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 74b1ee9027f5..cd0063629357 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -115,6 +115,20 @@
 	(((x) + (__y - 1)) / __y) * __y;		\
 }							\
 )
+
+#if BITS_PER_LONG == 32
+# define roundup_64(x, y) (				\
+{							\
+	typeof(y) __y = y;				\
+	typeof(x) __x = (x) + (__y - 1);		\
+	do_div(__x, __y);				\
+	__x * __y;					\
+}							\
+)
+#else
+# define roundup_64(x, y)	roundup(x, y)
+#endif
+
 /**
  * rounddown - round down to next specified multiple
  * @x: the value to round
