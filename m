Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E811CDADB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgEKNMo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:12:44 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55953 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbgEKNMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 09:12:43 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 May 2020 16:12:37 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04BDCbP7027912;
        Mon, 11 May 2020 16:12:37 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 04BDCaV1012468;
        Mon, 11 May 2020 16:12:37 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 04BDCaqx012467;
        Mon, 11 May 2020 16:12:36 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com,
        Alexr@mellanox.com
Subject: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device, PD, MR
Date:   Mon, 11 May 2020 16:12:08 +0300
Message-Id: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce import verbs for device, PD, MR, it enables processes to share
their ibv_contxet and then share PD and MR that is associated with.

A process is creating a device and then uses some of the Linux systems
calls to dup its 'cmd_fd' member which lets other process to obtain
owning on.

Once other process obtains the 'cmd_fd' it can call ibv_import_device()
which returns an ibv_contxet on the original RDMA device.

On the imported device there is an option to import PD(s) and MR(s) to
achieve a sharing on those objects.

This is the responsibility of the application to coordinate between all
ibv_context(s) that use the imported objects, such that once destroy is
done no other process can touch the object except for unimport. All
users of the context must collaborate to ensure this.

A matching unimport verbs where introduced for PD and MR, for the device
the ibv_close_device() API should be used.

Detailed man pages are introduced as part of this RFC patch to clarify
the expected usage and notes.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/man/CMakeLists.txt         |  5 +++
 libibverbs/man/ibv_import_device.3.md | 48 ++++++++++++++++++++
 libibverbs/man/ibv_import_mr.3.md     | 63 +++++++++++++++++++++++++++
 libibverbs/man/ibv_import_pd.3.md     | 56 ++++++++++++++++++++++++
 libibverbs/verbs.h                    | 56 ++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 libibverbs/man/ibv_import_device.3.md
 create mode 100644 libibverbs/man/ibv_import_mr.3.md
 create mode 100644 libibverbs/man/ibv_import_pd.3.md

diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index e1d5edf8..9ebfeaac 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -36,6 +36,9 @@ rdma_man_pages(
   ibv_get_device_name.3.md
   ibv_get_pkey_index.3.md
   ibv_get_srq_num.3.md
+  ibv_import_device.3.md
+  ibv_import_mr.3.md
+  ibv_import_pd.3.md
   ibv_inc_rkey.3.md
   ibv_modify_qp.3
   ibv_modify_qp_rate_limit.3
@@ -97,6 +100,8 @@ rdma_alias_man_pages(
   ibv_get_async_event.3 ibv_ack_async_event.3
   ibv_get_cq_event.3 ibv_ack_cq_events.3
   ibv_get_device_list.3 ibv_free_device_list.3
+  ibv_import_mr.3 ibv_unimport_mr.3
+  ibv_import_pd.3 ibv_unimport_pd.3
   ibv_open_device.3 ibv_close_device.3
   ibv_open_xrcd.3 ibv_close_xrcd.3
   ibv_rate_to_mbps.3 mbps_to_ibv_rate.3
diff --git a/libibverbs/man/ibv_import_device.3.md b/libibverbs/man/ibv_import_device.3.md
new file mode 100644
index 00000000..601b50a8
--- /dev/null
+++ b/libibverbs/man/ibv_import_device.3.md
@@ -0,0 +1,48 @@
+---
+date: 2020-5-3
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: ibv_import_device
+---
+
+# NAME
+
+ibv_import_device - import a device from a given comamnd FD
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+struct ibv_context *ibv_import_device(int cmd_fd);
+
+```
+
+
+# DESCRIPTION
+
+**ibv_import_device()** returns an *ibv_context* pointer that is associated with the given
+*cmd_fd*.
+
+The *cmd_fd* is obtained from the ibv_context cmd_fd member, which must be dup'd (eg by dup(), SCM_RIGHTS, etc)
+before being passed to ibv_import_device().
+
+Once the *ibv_context* usage has been ended *ibv_close_device()* should be called.
+This call may cleanup whatever is needed/opposite of the import including closing the command FD.
+
+# RETURN VALUE
+
+**ibv_import_device()** returns a pointer to the allocated RDMA context, or NULL if the request fails.
+
+# SEE ALSO
+
+**ibv_open_device**(3),
+**ibv_close_device**(3),
+
+# AUTHOR
+
+Yishai Hadas <yishaih@mellanox.com>
+
diff --git a/libibverbs/man/ibv_import_mr.3.md b/libibverbs/man/ibv_import_mr.3.md
new file mode 100644
index 00000000..ca698a96
--- /dev/null
+++ b/libibverbs/man/ibv_import_mr.3.md
@@ -0,0 +1,63 @@
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
+ibv_import_mr - import an MR from a given ibv_context
+ibv_unimport_mr - unimport an MR
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+struct ibv_mr *ibv_import_mr(struct ibv_pd *pd, uint32_t handle);
+void ibv_unimport_mr(struct ibv_mr *mr)
+
+```
+
+
+# DESCRIPTION
+
+**ibv_import_mr()** returns a Memory region (MR) that is associated with the given
+*handle* in the RDMA context that assosicated with the given *pd*.
+
+The input *handle* value must be a valid kernel handle for an MR object in the given *context*.
+The returned *ibv_mr* can be used in all verbs that use an MR.
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
+The *addr* and the *length* fields in the imported MR are not applicable, NULL and zero is expected.
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
diff --git a/libibverbs/man/ibv_import_pd.3.md b/libibverbs/man/ibv_import_pd.3.md
new file mode 100644
index 00000000..be1d079f
--- /dev/null
+++ b/libibverbs/man/ibv_import_pd.3.md
@@ -0,0 +1,56 @@
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
+ibv_unimport_pd - unimport a PD
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+struct ibv_pd *ibv_import_pd(struct ibv_context *context, uint32_t handle);
+void ibv_unimport_pd(struct ibv_pd *pd)
+
+```
+
+
+# DESCRIPTION
+
+**ibv_import_pd()** returns a protection domain (PD) that is associated with the given
+*handle* in the given *context*.
+
+The input *handle* value must be a valid kernel handle for a PD object in the given *context*.
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
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 288985d5..8548a7dd 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2033,6 +2033,12 @@ struct ibv_values_ex {
 
 struct verbs_context {
 	/*  "grows up" - new fields go here */
+	void (*unimport_pd)(struct ibv_pd *pd);
+	struct ibv_pd *(*import_pd)(struct ibv_context *context,
+				    uint32_t pd_handle);
+	void (*unimport_mr)(struct ibv_mr *mr);
+	struct ibv_mr *(*import_mr)(struct ibv_pd *pd,
+				    uint32_t mr_handle);
 	int (*query_port)(struct ibv_context *context, uint8_t port_num,
 			  struct ibv_port_attr *port_attr,
 			  size_t port_attr_len);
@@ -2217,6 +2223,12 @@ struct ibv_context *ibv_open_device(struct ibv_device *device);
  */
 int ibv_close_device(struct ibv_context *context);
 
+/**
+ * ibv_import_device - Import device
+ */
+struct ibv_context *ibv_import_device(int cmd_fd);
+
+
 /**
  * ibv_get_async_event - Get next async event
  * @event: Pointer to use to return async event
@@ -2546,6 +2558,50 @@ static inline int ibv_advise_mr(struct ibv_pd *pd,
 	return vctx->advise_mr(pd, advice, flags, sg_list, num_sge);
 }
 
+static inline struct ibv_mr *ibv_import_mr(struct ibv_pd *pd,
+					   uint32_t mr_handle)
+{
+	struct verbs_context *vctx;
+
+	vctx = verbs_get_ctx_op(pd->context, import_mr);
+	if (!vctx) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return vctx->import_mr(pd, mr_handle);
+}
+
+static inline void ibv_unimport_mr(struct ibv_mr *mr)
+{
+	struct verbs_context *vctx;
+
+	vctx = verbs_get_ctx_op(mr->context, unimport_mr);
+	vctx->unimport_mr(mr);
+}
+
+static inline struct ibv_pd *ibv_import_pd(struct ibv_context *context,
+					   uint32_t pd_handle)
+{
+	struct verbs_context *vctx;
+
+	vctx = verbs_get_ctx_op(context, import_pd);
+	if (!vctx) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return vctx->import_pd(context, pd_handle);
+}
+
+static inline void ibv_unimport_pd(struct ibv_pd *pd)
+{
+	struct verbs_context *vctx;
+
+	vctx = verbs_get_ctx_op(pd->context, unimport_pd);
+	vctx->unimport_pd(pd);
+}
+
 /**
  * ibv_alloc_dm - Allocate device memory
  * @context - Context DM will be attached to
-- 
2.18.1

