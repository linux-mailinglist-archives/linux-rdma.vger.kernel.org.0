Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE95B32CED9
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 09:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhCDIwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 03:52:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13857 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbhCDIw1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 03:52:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Drl1L3bmjz7t3G;
        Thu,  4 Mar 2021 16:49:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 16:51:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH RFC v2 rdma-core 6/6] libhns: Add man pages to introduce DCA feature
Date:   Thu, 4 Mar 2021 16:49:19 +0800
Message-ID: <1614847759-33139-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
References: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Document hns DCA feature and related direct verbs.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 CMakeLists.txt                            |  1 +
 debian/ibverbs-providers.install          |  2 +-
 debian/libibverbs-dev.install             |  2 +
 libibverbs/man/ibv_create_qp_ex.3         |  1 +
 providers/hns/man/CMakeLists.txt          |  6 +++
 providers/hns/man/hns_dca.7.md            | 35 ++++++++++++++++
 providers/hns/man/hnsdv.7.md              | 34 +++++++++++++++
 providers/hns/man/hnsdv_is_supported.3.md | 39 +++++++++++++++++
 providers/hns/man/hnsdv_open_device.3.md  | 70 +++++++++++++++++++++++++++++++
 redhat/rdma-core.spec                     |  2 +
 10 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 providers/hns/man/CMakeLists.txt
 create mode 100644 providers/hns/man/hns_dca.7.md
 create mode 100644 providers/hns/man/hnsdv.7.md
 create mode 100644 providers/hns/man/hnsdv_is_supported.3.md
 create mode 100644 providers/hns/man/hnsdv_open_device.3.md

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 80fb747..3ab7fb3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -666,6 +666,7 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
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
diff --git a/libibverbs/man/ibv_create_qp_ex.3 b/libibverbs/man/ibv_create_qp_ex.3
index 3092812..e27a50f 100644
--- a/libibverbs/man/ibv_create_qp_ex.3
+++ b/libibverbs/man/ibv_create_qp_ex.3
@@ -61,6 +61,7 @@ IBV_QP_CREATE_SCATTER_FCS               = 1 << 8, /* FCS field will be scattered
 IBV_QP_CREATE_CVLAN_STRIPPING           = 1 << 9, /* CVLAN field will be stripped from incoming packets */
 IBV_QP_CREATE_SOURCE_QPN                = 1 << 10, /* The created QP will use the source_qpn as its wire QP number */
 IBV_QP_CREATE_PCI_WRITE_END_PADDING     = 1 << 11, /* Incoming packets will be padded to cacheline size */
+IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH	= 1 << 13, /* The WQE buffer will be allocated from a memory pool which belongs to the user context */
 .in -8
 };
 .fi
diff --git a/providers/hns/man/CMakeLists.txt b/providers/hns/man/CMakeLists.txt
new file mode 100644
index 0000000..30d39ac
--- /dev/null
+++ b/providers/hns/man/CMakeLists.txt
@@ -0,0 +1,6 @@
+rdma_man_pages(
+  hnsdv_is_supported.3.md
+  hnsdv_open_device.3.md
+  hnsdv.7
+  hns_dca.7
+)
diff --git a/providers/hns/man/hns_dca.7.md b/providers/hns/man/hns_dca.7.md
new file mode 100644
index 0000000..85715ed
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
+*hnsdv_open_device(3)*, *ibv_create_qp_ex(3)*
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
index 0000000..a665bc6
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
+*ibv_create_qp_ex(3)*, *hns_dca(7)*
+
+# AUTHOR
+
+Xi Wang <wangxi11@huawei.com>
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index f4e00c3..ad752b5 100644
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
2.8.1

