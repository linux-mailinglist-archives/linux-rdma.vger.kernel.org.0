Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D44214B23
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgGEIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33108 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgGEIUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:12 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5E0001707;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5RD009313;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5M0009312;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 09/13] verbs: Introduce ibv_import/unimport_mr() verbs
Date:   Sun,  5 Jul 2020 11:19:45 +0300
Message-Id: <1593937189-8744-10-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce ibv_import/unimport_mr() verbs, this enables an application which
previously imported the device and an associated PD to import an MR that
is associated with.

A detailed man page as part of this patch describes the expected usage
and flow.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 debian/libibverbs1.symbols        |  2 ++
 libibverbs/driver.h               |  3 ++
 libibverbs/dummy_ops.c            | 15 +++++++++
 libibverbs/libibverbs.map.in      |  2 ++
 libibverbs/man/CMakeLists.txt     |  2 ++
 libibverbs/man/ibv_import_mr.3.md | 64 +++++++++++++++++++++++++++++++++++++++
 libibverbs/verbs.c                | 16 ++++++++++
 libibverbs/verbs.h                | 10 ++++++
 8 files changed, 114 insertions(+)
 create mode 100644 libibverbs/man/ibv_import_mr.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index f92e77e..2efbe89 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -68,6 +68,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_get_pkey_index@IBVERBS_1.5 20
  ibv_get_sysfs_path@IBVERBS_1.0 1.1.6
  ibv_import_device@IBVERBS_1.10 31
+ ibv_import_mr@IBVERBS_1.10 31
  ibv_import_pd@IBVERBS_1.10 31
  ibv_init_ah_from_wc@IBVERBS_1.1 1.1.6
  ibv_modify_qp@IBVERBS_1.0 1.1.6
@@ -105,6 +106,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_resize_cq@IBVERBS_1.1 1.1.6
  ibv_resolve_eth_l2_from_gid@IBVERBS_1.1 1.2.0
  ibv_set_ece@IBVERBS_1.10 31
+ ibv_unimport_mr@IBVERBS_1.10 31
  ibv_unimport_pd@IBVERBS_1.10 31
  ibv_wc_status_str@IBVERBS_1.1 1.1.6
  mbps_to_ibv_rate@IBVERBS_1.1 1.1.8
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index edb60d3..9065605 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -318,6 +318,8 @@ struct verbs_context_ops {
 	void (*free_context)(struct ibv_context *context);
 	int (*free_dm)(struct ibv_dm *dm);
 	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
+	struct ibv_mr *(*import_mr)(struct ibv_pd *pd,
+				    uint32_t mr_handle);
 	struct ibv_pd *(*import_pd)(struct ibv_context *context,
 				    uint32_t pd_handle);
 	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
@@ -372,6 +374,7 @@ struct verbs_context_ops {
 			void *addr, size_t length, int access);
 	int (*resize_cq)(struct ibv_cq *cq, int cqe);
 	int (*set_ece)(struct ibv_qp *qp, struct ibv_ece *ece);
+	void (*unimport_mr)(struct ibv_mr *mr);
 	void (*unimport_pd)(struct ibv_pd *pd);
 };
 
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 225e93d..45037a5 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -287,6 +287,13 @@ static int get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
 	return EOPNOTSUPP;
 }
 
+static struct ibv_mr *import_mr(struct ibv_pd *pd,
+				uint32_t mr_handle)
+{
+	errno = EOPNOTSUPP;
+	return NULL;
+}
+
 static struct ibv_pd *import_pd(struct ibv_context *context,
 				uint32_t pd_handle)
 {
@@ -467,6 +474,10 @@ static int set_ece(struct ibv_qp *qp, struct ibv_ece *ece)
 	return EOPNOTSUPP;
 }
 
+static void unimport_mr(struct ibv_mr *mr)
+{
+}
+
 static void unimport_pd(struct ibv_pd *pd)
 {
 }
@@ -525,6 +536,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	free_context,
 	free_dm,
 	get_srq_num,
+	import_mr,
 	import_pd,
 	modify_cq,
 	modify_flow_action_esp,
@@ -553,6 +565,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	rereg_mr,
 	resize_cq,
 	set_ece,
+	unimport_mr,
 	unimport_pd,
 };
 
@@ -645,6 +658,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP_IC(ctx, free_context);
 	SET_OP(vctx, free_dm);
 	SET_OP(vctx, get_srq_num);
+	SET_PRIV_OP_IC(vctx, import_mr);
 	SET_PRIV_OP_IC(vctx, import_pd);
 	SET_OP(vctx, modify_cq);
 	SET_OP(vctx, modify_flow_action_esp);
@@ -673,6 +687,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP(ctx, rereg_mr);
 	SET_PRIV_OP(ctx, resize_cq);
 	SET_PRIV_OP_IC(vctx, set_ece);
+	SET_PRIV_OP_IC(vctx, unimport_mr);
 	SET_PRIV_OP_IC(vctx, unimport_pd);
 
 #undef SET_OP
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index bd6fd34..ada856a 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -134,9 +134,11 @@ IBVERBS_1.9 {
 IBVERBS_1.10 {
 	global:
 		ibv_import_device;
+		ibv_import_mr;
 		ibv_import_pd;
 		ibv_query_ece;
 		ibv_set_ece;
+		ibv_unimport_mr;
 		ibv_unimport_pd;
 } IBVERBS_1.9;
 
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index ffca343..b925004 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -38,6 +38,7 @@ rdma_man_pages(
   ibv_get_pkey_index.3.md
   ibv_get_srq_num.3.md
   ibv_import_device.3.md
+  ibv_import_mr.3.md
   ibv_import_pd.3.md
   ibv_inc_rkey.3.md
   ibv_modify_qp.3
@@ -103,6 +104,7 @@ rdma_alias_man_pages(
   ibv_get_cq_event.3 ibv_ack_cq_events.3
   ibv_get_device_list.3 ibv_free_device_list.3
   ibv_import_pd.3 ibv_unimport_pd.3
+  ibv_import_mr.3 ibv_unimport_mr.3
   ibv_open_device.3 ibv_close_device.3
   ibv_open_xrcd.3 ibv_close_xrcd.3
   ibv_rate_to_mbps.3 mbps_to_ibv_rate.3
diff --git a/libibverbs/man/ibv_import_mr.3.md b/libibverbs/man/ibv_import_mr.3.md
new file mode 100644
index 0000000..f6346e4
--- /dev/null
+++ b/libibverbs/man/ibv_import_mr.3.md
@@ -0,0 +1,64 @@
+---
+date: 2020-5-3
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: ibv_import_mr ibv_unimport_mr
+---
+
+# NAME
+
+ibv_import_mr - import an MR from a given ibv_pd
+
+ibv_unimport_mr - unimport an MR
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+struct ibv_mr *ibv_import_mr(struct ibv_pd *pd, uint32_t mr_handle);
+void ibv_unimport_mr(struct ibv_mr *mr)
+
+```
+
+
+# DESCRIPTION
+
+**ibv_import_mr()** returns a Memory region (MR) that is associated with the given
+*mr_handle* in the RDMA context that assosicated with the given *pd*.
+
+The input *mr_handle* value must be a valid kernel handle for an MR object in the assosicated RDMA context.
+It can be achieved from the original MR by getting its ibv_mr->handle member value.
+
+**ibv_unimport_mr()** un import the MR.
+Once the MR usage has been ended ibv_dereg_mr() or ibv_unimport_mr() should be called.
+The first one will go to the kernel to destroy the object once the second one way cleanup what
+ever is needed/opposite of the import without calling the kernel.
+
+This is the responsibility of the application to coordinate between all ibv_context(s) that use this MR.
+Once destroy is done no other process can touch the object except for unimport. All users of the context must
+collaborate to ensure this.
+
+# RETURN VALUE
+
+**ibv_import_mr()** returns a pointer to the allocated MR, or NULL if the request fails.
+
+# NOTES
+
+The *addr* field in the imported MR is not applicable, NULL value is expected.
+
+# SEE ALSO
+
+**ibv_reg_mr**(3),
+**ibv_reg_dm_mr**(3),
+**ibv_reg_mr_iova**(3),
+**ibv_reg_mr_iova2**(3),
+**ibv_dereg_mr**(3),
+
+# AUTHOR
+
+Yishai Hadas <yishaih@mellanox.com>
+
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index ea32c02..b54e2b8 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -366,6 +366,22 @@ void ibv_unimport_pd(struct ibv_pd *pd)
 }
 
 
+/**
+ * ibv_import_mr - Import a memory region
+ */
+struct ibv_mr *ibv_import_mr(struct ibv_pd *pd, uint32_t mr_handle)
+{
+	return get_ops(pd->context)->import_mr(pd, mr_handle);
+}
+
+/**
+ * ibv_unimport_mr - Unimport a memory region
+ */
+void ibv_unimport_mr(struct ibv_mr *mr)
+{
+	get_ops(mr->context)->unimport_mr(mr);
+}
+
 LATEST_SYMVER_FUNC(ibv_rereg_mr, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_mr *mr, int flags,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 1a2c68e..6d66a31 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2258,6 +2258,16 @@ struct ibv_pd *ibv_import_pd(struct ibv_context *context,
 void ibv_unimport_pd(struct ibv_pd *pd);
 
 /**
+ * ibv_import_mr - Import a memory region
+ */
+struct ibv_mr *ibv_import_mr(struct ibv_pd *pd, uint32_t mr_handle);
+
+/**
+ * ibv_unimport_mr - Unimport a memory region
+ */
+void ibv_unimport_mr(struct ibv_mr *mr);
+
+/**
  * ibv_get_async_event - Get next async event
  * @event: Pointer to use to return async event
  *
-- 
1.8.3.1

