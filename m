Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79885FF86F
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfKQHlj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 02:41:39 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42900 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfKQHlj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Nov 2019 02:41:39 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from haggaie@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 Nov 2019 09:41:34 +0200
Received: from gen-l-vrt-097.mtl.labs.mlnx (gen-l-vrt-097.mtl.labs.mlnx [10.137.168.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xAH7fXR7002035;
        Sun, 17 Nov 2019 09:41:33 +0200
From:   Haggai Eran <haggaie@mellanox.com>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, michaelgur@mellanox.com,
        Haggai Eran <haggaie@mellanox.com>
Subject: [PATCH RFC rdma-core] verbs: relaxed ordering memory regions
Date:   Sun, 17 Nov 2019 09:41:28 +0200
Message-Id: <1573976488-24301-1-git-send-email-haggaie@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add flag to allow the creation of relaxed ordering memory regions.
Access through such MRs can improve performance by allowing the system
to reorder certain memory accesses.

As relaxed ordering is an optimization, drivers that do not support it
can simply ignore it, and it is recommended that users enable it
whenever completions are used to synchronize with the HCA.

We replace the symbols ibv_reg_mr/ibv_reg_mr_iova with a new symbol
(ibv_reg_mr_iova2). The new function would check against the kernel
whether relaxed ordering is supported or not, and disable it if
necessary. Running against an older library will fail with a linker
error instead of an obscure EINVAL from the kernel.

Signed-off-by: Haggai Eran <haggaie@mellanox.com>
---
 libibverbs/libibverbs.map.in |  5 +++++
 libibverbs/man/ibv_reg_mr.3  | 15 +++++++++++++++
 libibverbs/verbs.c           | 15 +++++++++++++++
 libibverbs/verbs.h           | 34 +++++++++++++++++++++++++++++++++-
 providers/mlx5/verbs.c       |  3 ++-
 5 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index c1b4537a5d1f..5280cfe6cc44 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -121,6 +121,11 @@ IBVERBS_1.7 {
 		ibv_reg_mr_iova;
 } IBVERBS_1.6;
 
+IBVERBS_1.8 {
+	global:
+		ibv_reg_mr_iova2;
+} IBVERBS_1.7;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
    version. See the top level CMakeLists.txt for this setting. */
 
diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
index be90a57bb989..163fca20d85f 100644
--- a/libibverbs/man/ibv_reg_mr.3
+++ b/libibverbs/man/ibv_reg_mr.3
@@ -43,6 +43,21 @@ describes the desired memory protection attributes; it is either 0 or the bitwis
 .B IBV_ACCESS_ZERO_BASED\fR    Use byte offset from beginning of MR to access this MR, instead of a pointer address
 .TP
 .B IBV_ACCESS_ON_DEMAND\fR    Create an on-demand paging MR
+.TP
+.B IBV_ACCESS_RELAXED_ORDERING\fR    Create an MR that uses relaxed ordering.
+
+Such MRs may reorder the scattering of Send/Write/Atomic operations to memory,
+so the target CPU and other RDMA operations may observe them in a
+different order than requested at the initiator. In addition, memory
+reads from such MR do not flush PCI-Express writes from peer devices.
+
+It is only safe to read a data buffer that was written to a relaxed MR after
+observing the approperiate completion, or after observing a subsequent atomic
+operation on a strongly ordered MR.
+
+Relaxed MRs can improve performance on some systems. On systems/drivers without
+adequate support this flag is ignored.
+
 .PP
 If
 .B IBV_ACCESS_REMOTE_WRITE
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index e5063af26dd4..e0f44129376e 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -296,6 +296,7 @@ LATEST_SYMVER_FUNC(ibv_dealloc_pd, 1_1, "IBVERBS_1.1",
 	return get_ops(pd->context)->dealloc_pd(pd);
 }
 
+#undef ibv_reg_mr
 LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 		   struct ibv_mr *,
 		   struct ibv_pd *pd, void *addr,
@@ -319,6 +320,8 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 	return mr;
 }
 
+
+#undef ibv_reg_mr_iova
 struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 			       uint64_t iova, int access)
 {
@@ -339,6 +342,18 @@ struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 	return mr;
 }
 
+LATEST_SYMVER_FUNC(ibv_reg_mr_iova2, 1_8, "IBVERBS_1.8",
+		   struct ibv_mr *,
+		   struct ibv_pd *pd, void *addr, size_t length,
+		   uint64_t iova, int access)
+{
+	/* TODO check whether kernel supports optional
+	 * IBV_ACCESS_RELAXED_ORDERING and clear it if it is not supported
+	 */
+
+	return ibv_reg_mr_iova(pd, addr, length, iova, access);
+}
+
 LATEST_SYMVER_FUNC(ibv_rereg_mr, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_mr *mr, int flags,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 7b8d431024b9..597167c4c963 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -580,6 +580,7 @@ enum ibv_access_flags {
 	IBV_ACCESS_MW_BIND		= (1<<4),
 	IBV_ACCESS_ZERO_BASED		= (1<<5),
 	IBV_ACCESS_ON_DEMAND		= (1<<6),
+	IBV_ACCESS_RELAXED_ORDERING	= (1<<8),
 };
 
 struct ibv_mw_bind_info {
@@ -2387,6 +2388,18 @@ static inline int ibv_close_xrcd(struct ibv_xrcd *xrcd)
  */
 struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
 			  size_t length, int access);
+/* Use the new version of ibv_reg_mr only if flags that require it are used. */
+#define ibv_reg_mr(pd, addr, length, access) ({\
+	const int optional_access_flags = IBV_ACCESS_RELAXED_ORDERING; \
+	struct ibv_mr *__mr; \
+	\
+	if (__builtin_constant_p(access) && \
+	    !((access) & optional_access_flags)) \
+		__mr = ibv_reg_mr(pd, addr, length, access); \
+	else \
+		__mr = ibv_reg_mr_iova2(pd, addr, length, (uintptr_t)addr, \
+					access); \
+	__mr; })
 
 /**
  * ibv_reg_mr_iova - Register a memory region with a virtual offset
@@ -2394,7 +2407,26 @@ struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
  */
 struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 			       uint64_t iova, int access);
-
+/* Use the new version of ibv_reg_mr only if flags that require it are used. */
+#define ibv_reg_mr_iova(pd, addr, length, iova, access) ({\
+	const int optional_access_flags = IBV_ACCESS_RELAXED_ORDERING; \
+	struct ibv_mr *__mr; \
+	\
+	if (__builtin_constant_p(access) && \
+	    !((access) & optional_access_flags)) \
+		__mr = ibv_reg_mr_iova(pd, addr, length, iova, access); \
+	else \
+		__mr = ibv_reg_mr_iova2(pd, addr, length, iova, access); \
+	__mr; })
+
+/**
+ * ibv_reg_mr_iova2 - Register a memory region with a virtual offset
+ *
+ * This version of ibv_reg_mr_iova can ignore optional access flags such as
+ * IBV_ACCESS_RELAXED_ORDERING if they are not supported.
+ */
+struct ibv_mr *ibv_reg_mr_iova2(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t iova, int access);
 
 enum ibv_rereg_mr_err_code {
 	/* Old MR is valid, invalid input */
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 48bfd682eb5f..cabb2eca815c 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -454,7 +454,8 @@ enum {
 				 IBV_ACCESS_REMOTE_WRITE	|
 				 IBV_ACCESS_REMOTE_READ		|
 				 IBV_ACCESS_REMOTE_ATOMIC	|
-				 IBV_ACCESS_ZERO_BASED
+				 IBV_ACCESS_ZERO_BASED		|
+				 IBV_ACCESS_RELAXED_ORDERING
 };
 
 struct ibv_mr *mlx5_reg_dm_mr(struct ibv_pd *pd, struct ibv_dm *ibdm,
-- 
1.8.3.1

