Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53A310170
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 01:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBEAPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 19:15:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:45189 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhBEAPg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Feb 2021 19:15:36 -0500
IronPort-SDR: y+zu2zxeJUK6xS4dG/PxnLj1W3wfuw1NPCqknLva7FUnDegeTQnvl9/wKfBglc9bEdI6T/peHy
 eYECP2vJuiMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="160511901"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="160511901"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 16:14:15 -0800
IronPort-SDR: D3cvr6pkQle/431HmVHgzGhHpoJT3Vz2APQJe7PHxH3fOZsCNlgczDR8tsEm3SwIQkssOwixBU
 FpPIf90jgEcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="508326489"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2021 16:14:14 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ali Alnubani <alialnu@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH rdma-core v2 3/3] configure: Add check for the presence of DRM headers
Date:   Thu,  4 Feb 2021 16:29:14 -0800
Message-Id: <1612484954-75514-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612484954-75514-1-git-send-email-jianxin.xiong@intel.com>
References: <1612484954-75514-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Compilation of pyverbs/dmabuf_alloc.c depends on a few DRM headers
that are installed by either the kernel-header or the libdrm package.
The installation is optional and the location is not unique.

Check the presence of the headers at both the standard locations and
any location defined by custom libdrm installation. If the headers
are missing, the dmabuf allocation routines are replaced by stubs that
return suitable error to allow the related tests to skip.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 CMakeLists.txt              | 15 +++++++++++++++
 pyverbs/CMakeLists.txt      | 14 ++++++++++++--
 pyverbs/dmabuf_alloc.c      |  8 ++++----
 pyverbs/dmabuf_alloc_stub.c | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 6 deletions(-)
 create mode 100644 pyverbs/dmabuf_alloc_stub.c

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4113423..95aec11 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -515,6 +515,21 @@ find_package(Systemd)
 include_directories(${SYSTEMD_INCLUDE_DIRS})
 RDMA_DoFixup("${SYSTEMD_FOUND}" "systemd/sd-daemon.h")
 
+# drm headers
+
+# First check the standard locations. The headers could have been installed
+# by either the kernle-headers package or the libdrm package.
+find_path(DRM_INCLUDE_DIRS "drm.h" PATH_SUFFIXES "drm" "libdrm")
+
+# Then check custom installation of libdrm
+if (NOT DRM_INCLUDE_DIRS)
+  pkg_check_modules(DRM libdrm)
+endif()
+
+if (DRM_INCLUDE_DIRS)
+  include_directories(${DRM_INCLUDE_DIRS})
+endif()
+
 #-------------------------
 # Apply fixups
 
diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 6fd7625..922253f 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -13,8 +13,6 @@ rdma_cython_module(pyverbs ""
   cmid.pyx
   cq.pyx
   device.pyx
-  dmabuf.pyx
-  dmabuf_alloc.c
   enums.pyx
   mem_alloc.pyx
   mr.pyx
@@ -25,6 +23,18 @@ rdma_cython_module(pyverbs ""
   xrcd.pyx
 )
 
+if (DRM_INCLUDE_DIRS)
+rdma_cython_module(pyverbs ""
+  dmabuf.pyx
+  dmabuf_alloc.c
+)
+else()
+rdma_cython_module(pyverbs ""
+  dmabuf.pyx
+  dmabuf_alloc_stub.c
+)
+endif()
+
 rdma_python_module(pyverbs
   __init__.py
   pyverbs_error.py
diff --git a/pyverbs/dmabuf_alloc.c b/pyverbs/dmabuf_alloc.c
index 85ffb7a..9978a5b 100644
--- a/pyverbs/dmabuf_alloc.c
+++ b/pyverbs/dmabuf_alloc.c
@@ -9,12 +9,12 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <drm/drm.h>
-#include <drm/i915_drm.h>
-#include <drm/amdgpu_drm.h>
-#include <drm/radeon_drm.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <drm.h>
+#include <i915_drm.h>
+#include <amdgpu_drm.h>
+#include <radeon_drm.h>
 #include "dmabuf_alloc.h"
 
 /*
diff --git a/pyverbs/dmabuf_alloc_stub.c b/pyverbs/dmabuf_alloc_stub.c
new file mode 100644
index 0000000..a73a5da
--- /dev/null
+++ b/pyverbs/dmabuf_alloc_stub.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2021 Intel Corporation. All rights reserved. See COPYING file
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <errno.h>
+#include "dmabuf_alloc.h"
+
+struct dmabuf *dmabuf_alloc(uint64_t size, int gpu, int gtt)
+{
+	errno = EOPNOTSUPP;
+	return NULL;
+}
+
+void dmabuf_free(struct dmabuf *dmabuf)
+{
+	errno = EOPNOTSUPP;
+}
+
+int dmabuf_get_drm_fd(struct dmabuf *dmabuf)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int dmabuf_get_fd(struct dmabuf *dmabuf)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+uint64_t dmabuf_get_offset(struct dmabuf *dmabuf)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
-- 
1.8.3.1

