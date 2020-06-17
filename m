Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D441FC7D4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFQHqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:36 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37738 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbgFQHqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:36 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kT0n017647;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTmH007185;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kTEv007184;
        Wed, 17 Jun 2020 10:46:29 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 07/13] verbs: Introduce ibv_import/unimport_pd() verbs
Date:   Wed, 17 Jun 2020 10:45:50 +0300
Message-Id: <1592379956-7043-8-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce ibv_import/unimport_pd() verbs, this enables an application
who previously imported a device to import a PD from that context and
use this shared object for its needs.

A detailed man page as part of this patch describes the expected usage
and flow.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 debian/libibverbs1.symbols        |  2 ++
 libibverbs/driver.h               |  3 +++
 libibverbs/dummy_ops.c            | 15 +++++++++++
 libibverbs/libibverbs.map.in      |  2 ++
 libibverbs/man/CMakeLists.txt     |  2 ++
 libibverbs/man/ibv_import_pd.3.md | 57 +++++++++++++++++++++++++++++++++++++++
 libibverbs/verbs.c                | 14 ++++++++++
 libibverbs/verbs.h                | 11 ++++++++
 8 files changed, 106 insertions(+)
 create mode 100644 libibverbs/man/ibv_import_pd.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index e636c1d..ee32bf4 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -68,6 +68,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_get_pkey_index@IBVERBS_1.5 20
  ibv_get_sysfs_path@IBVERBS_1.0 1.1.6
  ibv_import_device@IBVERBS_1.10 31
+ ibv_import_pd@IBVERBS_1.10 31
  ibv_init_ah_from_wc@IBVERBS_1.1 1.1.6
  ibv_modify_qp@IBVERBS_1.0 1.1.6
  ibv_modify_qp@IBVERBS_1.1 1.1.6
@@ -102,6 +103,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_resize_cq@IBVERBS_1.0 1.1.6
  ibv_resize_cq@IBVERBS_1.1 1.1.6
  ibv_resolve_eth_l2_from_gid@IBVERBS_1.1 1.2.0
+ ibv_unimport_pd@IBVERBS_1.10 31
  ibv_wc_status_str@IBVERBS_1.1 1.1.6
  mbps_to_ibv_rate@IBVERBS_1.1 1.1.8
  mult_to_ibv_rate@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 1883df3..fbf63f3 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -311,6 +311,8 @@ struct verbs_context_ops {
 	void (*free_context)(struct ibv_context *context);
 	int (*free_dm)(struct ibv_dm *dm);
 	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
+	struct ibv_pd *(*import_pd)(struct ibv_context *context,
+				    uint32_t pd_handle);
 	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
 	int (*modify_flow_action_esp)(struct ibv_flow_action *action,
 				      struct ibv_flow_action_esp_attr *attr);
@@ -361,6 +363,7 @@ struct verbs_context_ops {
 	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
 			void *addr, size_t length, int access);
 	int (*resize_cq)(struct ibv_cq *cq, int cqe);
+	void (*unimport_pd)(struct ibv_pd *pd);
 };
 
 static inline struct verbs_device *
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 32fec71..9d6d2af 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -287,6 +287,13 @@ static int get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
 	return EOPNOTSUPP;
 }
 
+static  struct ibv_pd *import_pd(struct ibv_context *context,
+				 uint32_t pd_handle)
+{
+	errno = EOPNOTSUPP;
+	return NULL;
+}
+
 static int modify_cq(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr)
 {
 	return EOPNOTSUPP;
@@ -450,6 +457,10 @@ static int resize_cq(struct ibv_cq *cq, int cqe)
 	return EOPNOTSUPP;
 }
 
+static void unimport_pd(struct ibv_pd *pd)
+{
+}
+
 /*
  * Ops in verbs_dummy_ops simply return an EOPNOTSUPP error code when called, or
  * do nothing. They are placed in the ops structures if the provider does not
@@ -504,6 +515,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	free_context,
 	free_dm,
 	get_srq_num,
+	import_pd,
 	modify_cq,
 	modify_flow_action_esp,
 	modify_qp,
@@ -529,6 +541,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	req_notify_cq,
 	rereg_mr,
 	resize_cq,
+	unimport_pd,
 };
 
 /*
@@ -620,6 +633,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP_IC(ctx, free_context);
 	SET_OP(vctx, free_dm);
 	SET_OP(vctx, get_srq_num);
+	SET_PRIV_OP_IC(vctx, import_pd);
 	SET_OP(vctx, modify_cq);
 	SET_OP(vctx, modify_flow_action_esp);
 	SET_PRIV_OP(ctx, modify_qp);
@@ -645,6 +659,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_OP(ctx, req_notify_cq);
 	SET_PRIV_OP(ctx, rereg_mr);
 	SET_PRIV_OP(ctx, resize_cq);
+	SET_PRIV_OP_IC(vctx, unimport_pd);
 
 #undef SET_OP
 #undef SET_OP2
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index a17e6ad..d356e63 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -134,6 +134,8 @@ IBVERBS_1.9 {
 IBVERBS_1.10 {
 	global:
 		ibv_import_device;
+		ibv_import_pd;
+		ibv_unimport_pd;
 } IBVERBS_1.9;
 
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index 58ad832..422d6fd 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -38,6 +38,7 @@ rdma_man_pages(
   ibv_get_pkey_index.3.md
   ibv_get_srq_num.3.md
   ibv_import_device.3.md
+  ibv_import_pd.3.md
   ibv_inc_rkey.3.md
   ibv_modify_qp.3
   ibv_modify_qp_rate_limit.3
@@ -99,6 +100,7 @@ rdma_alias_man_pages(
   ibv_get_async_event.3 ibv_ack_async_event.3
   ibv_get_cq_event.3 ibv_ack_cq_events.3
   ibv_get_device_list.3 ibv_free_device_list.3
+  ibv_import_pd.3 ibv_unimport_pd.3
   ibv_open_device.3 ibv_close_device.3
   ibv_open_xrcd.3 ibv_close_xrcd.3
   ibv_rate_to_mbps.3 mbps_to_ibv_rate.3
diff --git a/libibverbs/man/ibv_import_pd.3.md b/libibverbs/man/ibv_import_pd.3.md
new file mode 100644
index 0000000..39ad0dc
--- /dev/null
+++ b/libibverbs/man/ibv_import_pd.3.md
@@ -0,0 +1,57 @@
+---
+date: 2020-5-3
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: ibv_import_pd, ibv_unimport_pd
+---
+
+# NAME
+
+ibv_import_pd - import a PD from a given ibv_context
+
+ibv_unimport_pd - unimport a PD
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+struct ibv_pd *ibv_import_pd(struct ibv_context *context, uint32_t pd_handle);
+void ibv_unimport_pd(struct ibv_pd *pd)
+
+```
+
+
+# DESCRIPTION
+
+**ibv_import_pd()** returns a protection domain (PD) that is associated with the given
+*pd_handle* in the given *context*.
+
+The input *pd_handle* value must be a valid kernel handle for a PD object in the given *context*.
+The returned *ibv_pd* can be used in all verbs that get a protection domain.
+
+**ibv_unimport_pd()** unimport the PD.
+Once the PD usage has been ended ibv_dealloc_pd() or ibv_unimport_pd() should be called.
+The first one will go to the kernel to destroy the object once the second one way cleanup what
+ever is needed/opposite of the import without calling the kernel.
+
+This is the responsibility of the application to coordinate between all ibv_context(s) that use this PD.
+Once destroy is done no other process can touch the object except for unimport. All users of the context must
+collaborate to ensure this.
+
+# RETURN VALUE
+
+**ibv_import_pd()** returns a pointer to the allocated PD, or NULL if the request fails.
+
+# SEE ALSO
+
+**ibv_alloc_pd**(3),
+**ibv_dealloc_pd**(3),
+
+# AUTHOR
+
+Yishai Hadas <yishaih@mellanox.com>
+
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index f380036..9380146 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -352,6 +352,20 @@ struct ibv_mr *ibv_reg_mr_iova2(struct ibv_pd *pd, void *addr, size_t length,
 	return ibv_reg_mr_iova(pd, addr, length, iova, access);
 }
 
+
+struct ibv_pd *ibv_import_pd(struct ibv_context *context,
+			     uint32_t pd_handle)
+{
+	return get_ops(context)->import_pd(context, pd_handle);
+}
+
+
+void ibv_unimport_pd(struct ibv_pd *pd)
+{
+	get_ops(pd->context)->unimport_pd(pd);
+}
+
+
 LATEST_SYMVER_FUNC(ibv_rereg_mr, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_mr *mr, int flags,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 67ec946..632ddb9 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2232,6 +2232,17 @@ int ibv_close_device(struct ibv_context *context);
 struct ibv_context *ibv_import_device(int cmd_fd);
 
 /**
+ * ibv_import_pd - Import a protetion domain
+ */
+struct ibv_pd *ibv_import_pd(struct ibv_context *context,
+			     uint32_t pd_handle);
+
+/**
+ * ibv_unimport_pd - Unimport a protetion domain
+ */
+void ibv_unimport_pd(struct ibv_pd *pd);
+
+/**
  * ibv_get_async_event - Get next async event
  * @event: Pointer to use to return async event
  *
-- 
1.8.3.1

