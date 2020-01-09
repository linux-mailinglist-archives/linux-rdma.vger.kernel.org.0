Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81A135AF4
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgAIOF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:26 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33797 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730034AbgAIOF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:26 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5GuD016612;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5GI8001338;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5Gw2001337;
        Thu, 9 Jan 2020 16:05:16 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-core 4/7] verbs: Relaxed ordering memory regions
Date:   Thu,  9 Jan 2020 16:04:33 +0200
Message-Id: <1578578676-752-5-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Add a flag to allow creation of relaxed ordering memory regions.
Access through such MRs can improve performance by allowing the system
to reorder certain accesses.

As relaxed ordering is an optimization, drivers that do not support it
can simply ignore it.

An optional MR access bit range is defined based on the kernel matching
part and its first entry will be IBV_ACCESS_RELAXED_ORDERING.

In case an application uses one of the bits from the optional range the
library will mask it out in case the 'MR optional mode' is not supported by
the kernel.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 debian/libibverbs1.symbols   |  2 ++
 libibverbs/CMakeLists.txt    |  2 +-
 libibverbs/libibverbs.map.in |  5 +++++
 libibverbs/man/ibv_reg_mr.3  |  2 ++
 libibverbs/verbs.c           | 13 +++++++++++
 libibverbs/verbs.h           | 51 ++++++++++++++++++++++++++++++++++++++++++--
 libibverbs/verbs_api.h       |  2 ++
 7 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index 51c5407..ec40b29 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -5,6 +5,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.5@IBVERBS_1.5 20
  IBVERBS_1.6@IBVERBS_1.6 24
  IBVERBS_1.7@IBVERBS_1.7 25
+ IBVERBS_1.8@IBVERBS_1.8 28
  (symver)IBVERBS_PRIVATE_25 25
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
@@ -91,6 +92,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_reg_mr@IBVERBS_1.0 1.1.6
  ibv_reg_mr@IBVERBS_1.1 1.1.6
  ibv_reg_mr_iova@IBVERBS_1.7 25
+ ibv_reg_mr_iova2@IBVERBS_1.8 28
  ibv_register_driver@IBVERBS_1.1 1.1.6
  ibv_rereg_mr@IBVERBS_1.1 1.2.1
  ibv_resize_cq@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index a5926bb..4328548 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"
 
 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.7.${PACKAGE_VERSION}
+  1 1.8.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index c1b4537..5280cfe 100644
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
index aa0fe48..2bfc955 100644
--- a/libibverbs/man/ibv_reg_mr.3
+++ b/libibverbs/man/ibv_reg_mr.3
@@ -45,6 +45,8 @@ describes the desired memory protection attributes; it is either 0 or the bitwis
 .B IBV_ACCESS_ON_DEMAND\fR    Create an on-demand paging MR
 .TP
 .B IBV_ACCESS_HUGETLB\fR      Huge pages are guaranteed to be used for this MR, applicable with IBV_ACCESS_ON_DEMAND in explicit mode only
+.TP
+.B IBV_ACCESS_RELAXED_ORDERING\fR Allow system to reorder accesses to the MR to improve performance
 .PP
 If
 .B IBV_ACCESS_REMOTE_WRITE
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index e5063af..b5efd63 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -296,6 +296,7 @@ LATEST_SYMVER_FUNC(ibv_dealloc_pd, 1_1, "IBVERBS_1.1",
 	return get_ops(pd->context)->dealloc_pd(pd);
 }
 
+#undef ibv_reg_mr
 LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 		   struct ibv_mr *,
 		   struct ibv_pd *pd, void *addr,
@@ -319,6 +320,7 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 	return mr;
 }
 
+#undef ibv_reg_mr_iova
 struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 			       uint64_t iova, int access)
 {
@@ -339,6 +341,17 @@ struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 	return mr;
 }
 
+struct ibv_mr *ibv_reg_mr_iova2(struct ibv_pd *pd, void *addr, size_t length,
+				uint64_t iova, int access)
+{
+	struct verbs_device *device = verbs_get_device(pd->context->device);
+
+	if (!(device->core_support & IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS))
+		access &= ~(typeof(access))IBV_ACCESS_OPTIONAL_RANGE;
+
+	return ibv_reg_mr_iova(pd, addr, length, iova, access);
+}
+
 LATEST_SYMVER_FUNC(ibv_rereg_mr, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_mr *mr, int flags,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index fa9833a..13509aa 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -581,6 +581,7 @@ enum ibv_access_flags {
 	IBV_ACCESS_ZERO_BASED		= (1<<5),
 	IBV_ACCESS_ON_DEMAND		= (1<<6),
 	IBV_ACCESS_HUGETLB		= (1<<7),
+	IBV_ACCESS_RELAXED_ORDERING	= IBV_ACCESS_OPTIONAL_FIRST,
 };
 
 struct ibv_mw_bind_info {
@@ -2383,11 +2384,41 @@ static inline int ibv_close_xrcd(struct ibv_xrcd *xrcd)
 	return vctx->close_xrcd(xrcd);
 }
 
+#define _IBV_IS_OPTIONAL_ACCESS(access, is_access_const)                       \
+	(!is_access_const || ((access) & IBV_ACCESS_OPTIONAL_RANGE))
+/**
+ * ibv_reg_mr_iova2 - Register memory region with a virtual offset address
+ *
+ * This version will be called if ibv_reg_mr or ibv_reg_mr_iova were called
+ * with at least one potential access flag from the IBV_OPTIONAL_ACCESS_RANGE
+ * flags range The optional access flags will be masked if running over kernel
+ * that does not support passing them.
+ */
+struct ibv_mr *ibv_reg_mr_iova2(struct ibv_pd *pd, void *addr, size_t length,
+				uint64_t iova, int access);
+
 /**
  * ibv_reg_mr - Register a memory region
  */
-struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
-			  size_t length, int access);
+struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			  int access);
+/* use new ibv_reg_mr version only if access flags that require it are used */
+static inline struct ibv_mr *__ibv_reg_mr(struct ibv_pd *pd, void *addr,
+					  size_t length, int access,
+					  int is_access_const)
+{
+	struct ibv_mr *__mr;
+
+	if (_IBV_IS_OPTIONAL_ACCESS(access, is_access_const))
+		__mr = ibv_reg_mr_iova2(pd, addr, length, (uintptr_t)addr,
+					access);
+	else
+		__mr = ibv_reg_mr(pd, addr, length, access);
+	return __mr;
+}
+
+#define ibv_reg_mr(pd, addr, length, access)                                   \
+	__ibv_reg_mr(pd, addr, length, access, __builtin_constant_p(access))
 
 /**
  * ibv_reg_mr_iova - Register a memory region with a virtual offset
@@ -2395,7 +2426,23 @@ struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
  */
 struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 			       uint64_t iova, int access);
+/* use new ibv_reg_mr version only if access flags that require it are used */
+static inline struct ibv_mr *__ibv_reg_mr_iova(struct ibv_pd *pd, void *addr,
+					       size_t length, uint64_t iova,
+					       int access, int is_access_const)
+{
+	struct ibv_mr *__mr;
+
+	if (_IBV_IS_OPTIONAL_ACCESS(access, is_access_const))
+		__mr = ibv_reg_mr_iova2(pd, addr, length, iova, access);
+	else
+		__mr = ibv_reg_mr_iova(pd, addr, length, iova, access);
+	return __mr;
+}
 
+#define ibv_reg_mr_iova(pd, addr, length, iova, access)                        \
+	__ibv_reg_mr_iova(pd, addr, length, iova, access,                      \
+			  __builtin_constant_p(access))
 
 enum ibv_rereg_mr_err_code {
 	/* Old MR is valid, invalid input */
diff --git a/libibverbs/verbs_api.h b/libibverbs/verbs_api.h
index bdfd677..ded6fa4 100644
--- a/libibverbs/verbs_api.h
+++ b/libibverbs/verbs_api.h
@@ -93,5 +93,7 @@
 
 #define IBV_QPF_GRH_REQUIRED				IB_UVERBS_QPF_GRH_REQUIRED
 
+#define IBV_ACCESS_OPTIONAL_RANGE			IB_UVERBS_ACCESS_OPTIONAL_RANGE
+#define IBV_ACCESS_OPTIONAL_FIRST			IB_UVERBS_ACCESS_OPTIONAL_FIRST
 #endif
 
-- 
1.8.3.1

