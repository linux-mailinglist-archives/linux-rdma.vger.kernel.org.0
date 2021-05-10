Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71D378EE6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbhEJNYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:24:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2615 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhEJNO6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 09:14:58 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ff1cL2xZ4zQlp0;
        Mon, 10 May 2021 21:09:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 21:13:07 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 6/6] libhns: Add man pages to introduce DCA feature
Date:   Mon, 10 May 2021 21:13:04 +0800
Message-ID: <1620652384-34097-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
References: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Document hns DCA feature and related direct verbs.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 CMakeLists.txt                            |  1 +
 debian/ibverbs-providers.install          |  2 +-
 debian/libibverbs-dev.install             |  2 +
 providers/hns/man/CMakeLists.txt          |  7 ++++
 providers/hns/man/hns_dca.7.md            | 35 ++++++++++++++++
 providers/hns/man/hnsdv.7.md              | 34 +++++++++++++++
 providers/hns/man/hnsdv_create_qp.3.md    | 69 ++++++++++++++++++++++++++++++
 providers/hns/man/hnsdv_is_supported.3.md | 39 +++++++++++++++++
 providers/hns/man/hnsdv_open_device.3.md  | 70 +++++++++++++++++++++++++++++++
 redhat/rdma-core.spec                     |  2 +
 10 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 providers/hns/man/CMakeLists.txt
 create mode 100644 providers/hns/man/hns_dca.7.md
 create mode 100644 providers/hns/man/hnsdv.7.md
 create mode 100644 providers/hns/man/hnsdv_create_qp.3.md
 create mode 100644 providers/hns/man/hnsdv_is_supported.3.md
 create mode 100644 providers/hns/man/hnsdv_open_device.3.md

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 74293bf..744179d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -669,6 +669,7 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
 add_subdirectory(providers/efa)
 add_subdirectory(providers/efa/man)
 add_subdirectory(providers/hns)
+add_subdirectory(providers/hns/man)
 add_subdirectory(providers/i40iw) # NO SPARSE
 add_subdirectory(providers/mlx4)
 add_subdirectory(providers/mlx4/man)
diff --git a/debian/ibverbs-providers.install b/debian/ibverbs-providers.install
index c6ecbbc..c4c4c11 100644
--- a/debian/ibverbs-providers.install
+++ b/debian/ibverbs-providers.install
@@ -1,6 +1,6 @@
 etc/libibverbs.d/
 usr/lib/*/libefa.so.*
-usr/lib/*/libibverbs/lib*-rdmav*.so
 usr/lib/*/libhns.so.*
+usr/lib/*/libibverbs/lib*-rdmav*.so
 usr/lib/*/libmlx4.so.*
 usr/lib/*/libmlx5.so.*
diff --git a/debian/libibverbs-dev.install b/debian/libibverbs-dev.install
index 7d6e6a2..89a02a8 100644
--- a/debian/libibverbs-dev.install
+++ b/debian/libibverbs-dev.install
@@ -29,11 +29,13 @@ usr/lib/*/pkgconfig/libibverbs.pc
 usr/lib/*/pkgconfig/libmlx4.pc
 usr/lib/*/pkgconfig/libmlx5.pc
 usr/share/man/man3/efadv_*.3
+usr/share/man/man3/hns*.3
 usr/share/man/man3/ibv_*
 usr/share/man/man3/mbps_to_ibv_rate.3
 usr/share/man/man3/mlx4dv_*.3
 usr/share/man/man3/mlx5dv_*.3
 usr/share/man/man3/mult_to_ibv_rate.3
 usr/share/man/man7/efadv.7
+usr/share/man/man3/hns*.7
 usr/share/man/man7/mlx4dv.7
 usr/share/man/man7/mlx5dv.7
diff --git a/providers/hns/man/CMakeLists.txt b/providers/hns/man/CMakeLists.txt
new file mode 100644
index 0000000..b375a65
--- /dev/null
+++ b/providers/hns/man/CMakeLists.txt
@@ -0,0 +1,7 @@
+rdma_man_pages(
+  hnsdv_is_supported.3.md
+  hnsdv_open_device.3.md
+  hnsdv_create_qp.3.md
+  hnsdv.7
+  hns_dca.7
+)
diff --git a/providers/hns/man/hns_dca.7.md b/providers/hns/man/hns_dca.7.md
new file mode 100644
index 0000000..de26d07
--- /dev/null
+++ b/providers/hns/man/hns_dca.7.md
@@ -0,0 +1,35 @@
+---
+layout: page
+title: DCA
+section: 7
+tagline: DCA
+date: 2021-03-03
+header: "HNS DCA Manual"
+footer: hns
+---
+
+# NAME
+
+DCA - Dynamic Context Attachment
+
+This allows all WQEs to share a memory pool that belongs to the user context.
+
+# DESCRIPTION
+
+The DCA feature aims to reduce memory consumption by sharing WQE memory for QPs working in sparse traffic scenarios.
+
+The DCA memory pool consists of multiple umem objects. Each umem object is a buffer allocated in user driver and register into kernel driver. The ULP need to setup the memory pool's parameter by calling hnsdv_open_device() and the driver will expand or shrink the memory pool based on this parameter.
+
+When a QP's DCA was enabled by setting create flags through ibv_create_qp_ex(), the WQE buffer will not be allocated directly until the ULP invokes the ibv_post_xxx(). If the memory in the pool is insufficient and the capacity expansion conditions are met, the driver will add new umem objects to the pool.
+
+When all WQEs of a QP are not used by the ROCEE after ibv_poll_cq() or ibv_modify_qp() are invoked, the WQE buffer will be reclaimed to the DCA memory pool. If the free memory in the pool meets the shrink conditions, the driver will delete the unused umem object.
+
+# SEE ALSO
+
+*hnsdv_open_device(3)*, *hnsdv_create_qp(3)*
+
+# AUTHORS
+
+Xi Wang <wangxi11@huawei.com>
+
+Weihang Li <liweihang@huawei.com>
diff --git a/providers/hns/man/hnsdv.7.md b/providers/hns/man/hnsdv.7.md
new file mode 100644
index 0000000..ada73ec
--- /dev/null
+++ b/providers/hns/man/hnsdv.7.md
@@ -0,0 +1,34 @@
+---
+layout: page
+title: HNSDV
+section: 7
+tagline: Verbs
+date: 2021-03-03
+header: "HNS Direct Verbs Manual"
+footer: hns
+---
+
+# NAME
+
+hnsdv - Direct verbs for hns devices
+
+This provides low level access to hns devices to perform direct operations,
+without general branching performed by libibverbs.
+
+# DESCRIPTION
+
+The libibverbs API is an abstract one. It is agnostic to any underlying provider specific implementation. While this abstraction has the advantage of user applications portability, it has a performance penalty. For some applications optimizing performance is more important than portability.
+
+The hns direct verbs API is intended for such applications. It exposes hns specific low level operations, allowing the application to bypass the libibverbs API.
+
+The direct include of hnsdv.h together with linkage to hns library will allow usage of this new interface.
+
+# SEE ALSO
+
+**verbs**(7)
+
+# AUTHORS
+
+Xi Wang <wangxi11@huawei.com>
+
+Weihang Li <liweihang@huawei.com>
diff --git a/providers/hns/man/hnsdv_create_qp.3.md b/providers/hns/man/hnsdv_create_qp.3.md
new file mode 100644
index 0000000..57446e9
--- /dev/null
+++ b/providers/hns/man/hnsdv_create_qp.3.md
@@ -0,0 +1,69 @@
+---
+layout: page
+title: hnsdv_create_qp
+section: 3
+tagline: Verbs
+date: 2021-3-15
+header: "hns Programmer's Manual"
+footer: hns
+---
+
+# NAME
+
+hnsdv_create_qp - creates a queue pair (QP)
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hnsdv.h>
+
+struct ibv_qp *hnsdv_create_qp(struct ibv_context *context,
+			       struct ibv_qp_init_attr_ex *attr,
+			       struct hnsdv_qp_init_attr *hns_attr)
+```
+
+
+# DESCRIPTION
+
+**hnsdv_create_qp()** creates a queue pair (QP) with specific driver properties.
+
+# ARGUMENTS
+
+Please see *ibv_create_qp_ex(3)* man page for *context* and *attr*.
+
+## hns_attr
+
+```c
+struct hnsdv_qp_init_attr {
+	uint64_t comp_mask;
+	uint32_t create_flags;
+};
+```
+
+*comp_mask*
+:	Bitmask specifying what fields in the structure are valid:
+	HNSDV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS:
+		valid values in *create_flags*
+
+*create_flags*
+:	A bitwise OR of the various values described below.
+
+	HNSDV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH :
+		Enable DCA feature for QP, the WQE buffer will allocate
+		from DCA memory pool when calling ibv_post_send() or
+		ibv_post_recv().
+
+# RETURN VALUE
+
+**hnsdv_create_qp()**
+returns a pointer to the created QP, on error NULL will be returned and errno will be set.
+
+# SEE ALSO
+
+**ibv_create_qp_ex**(3),
+
+# AUTHOR
+
+Xi Wang <wangxi11@huawei.com>
+
+Weihang Li <liweihang@huawei.com>
diff --git a/providers/hns/man/hnsdv_is_supported.3.md b/providers/hns/man/hnsdv_is_supported.3.md
new file mode 100644
index 0000000..b5f00bd
--- /dev/null
+++ b/providers/hns/man/hnsdv_is_supported.3.md
@@ -0,0 +1,39 @@
+---
+layout: page
+title: hnsdv_is_supported
+section: 3
+tagline: Verbs
+---
+
+# NAME
+
+hnsdv_is_supported - Check whether an RDMA device implemented by the hns provider
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hnsdv.h>
+
+bool hnsdv_is_supported(struct ibv_device *device);
+```
+
+# DESCRIPTION
+
+hnsdv functions may be called only if this function returns true for the RDMA device.
+
+# ARGUMENTS
+
+*device*
+:	RDMA device to check.
+
+# RETURN VALUE
+
+Returns true if device is implemented by hns provider.
+
+# SEE ALSO
+
+*hnsdv(7)*
+
+# AUTHOR
+
+Xi Wang <wangxi11@huawei.com>
diff --git a/providers/hns/man/hnsdv_open_device.3.md b/providers/hns/man/hnsdv_open_device.3.md
new file mode 100644
index 0000000..c05ce5d
--- /dev/null
+++ b/providers/hns/man/hnsdv_open_device.3.md
@@ -0,0 +1,70 @@
+---
+layout: page
+title: hnsdv_open_device
+section: 3
+tagline: Verbs
+---
+
+# NAME
+
+hnsdv_open_device - Open an RDMA device context for the hns provider
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hnsdv.h>
+
+struct ibv_context *
+hnsdv_open_device(struct ibv_device *device, struct hnsdv_context_attr *attr);
+```
+
+# DESCRIPTION
+
+Open an RDMA device context with specific hns provider attributes.
+
+# ARGUMENTS
+
+*device*
+:	RDMA device to open.
+
+## *attr* argument
+
+```c
+struct hnsdv_context_attr {
+        uint32_t flags;
+        uint64_t comp_mask;
+	uint32_t dca_unit_size;
+	uint64_t dca_max_size;
+	uint64_t dca_min_size;
+};
+```
+
+*flags*
+:       A bitwise OR of the various values described below.
+
+        *HNSDV_CONTEXT_FLAGS_DCA*:
+        Create a DCA memory pool to support all QPs share it.
+
+*comp_mask*
+:       Bitmask specifying what fields in the structure are valid
+
+*dca_unit_size*
+:       The unit size when adding a new buffer to DCA memory pool.
+
+*dca_max_size*
+:       The DCA pool will be expanded when the total size is smaller than maximal size.
+
+*dca_min_size*
+:       The DCA pool will be shrunk when the free size is bigger than minimal size.
+
+# RETURN VALUE
+
+Returns a pointer to the allocated device context, or NULL if the request fails.
+
+# SEE ALSO
+
+*hnsdv_create_qp(3)*, *hns_dca(7)*
+
+# AUTHOR
+
+Xi Wang <wangxi11@huawei.com>
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index e1dda8f..fcbec50 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -440,6 +440,7 @@ fi
 %{_libdir}/lib*.so
 %{_libdir}/pkgconfig/*.pc
 %{_mandir}/man3/efadv*
+%{_mandir}/man3/hns*
 %{_mandir}/man3/ibv_*
 %{_mandir}/man3/rdma*
 %{_mandir}/man3/umad*
@@ -448,6 +449,7 @@ fi
 %{_mandir}/man3/mlx5dv*
 %{_mandir}/man3/mlx4dv*
 %{_mandir}/man7/efadv*
+%{_mandir}/man7/hns*
 %{_mandir}/man7/mlx5dv*
 %{_mandir}/man7/mlx4dv*
 %{_mandir}/man3/ibnd_*
-- 
2.7.4

