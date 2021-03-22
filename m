Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB534506C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 21:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCVUGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 16:06:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:42774 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhCVUFt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 16:05:49 -0400
IronPort-SDR: 90q2AmEWLvtsVLo9GDmM9QzhWOxhB9rNnUszC3kscq1Ca7PUvk4PoQZrDUbA4429HlPRIEKFZl
 RBYF9up19r4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188020099"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188020099"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:05:48 -0700
IronPort-SDR: agUJneYGUKfJKav0mRuH/nFG7fXzB8im86Aq3A+8HVdm7AUwEh0Gz20nQwUAoVXAKpMAYLIaIO
 vSvFc8ahKTkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="592733736"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2021 13:05:46 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        liweihang <liweihang@huawei.com>
Subject: [PATCH rdma-core] configure: Check the existence of all needed DRM headers
Date:   Mon, 22 Mar 2021 13:20:21 -0700
Message-Id: <1616444421-148423-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some vendor specific DRM headers may be missing on systems with old
kernels. Make sure that all headers needed by pyverbs/dmabuf_alloc.c
are present before enabling that module.

Remove unused reference of "radeon_drm.h" from pyverbs/dmabuf_alloc.c.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 CMakeLists.txt         | 6 +++++-
 pyverbs/dmabuf_alloc.c | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e9a2f49..1208ab6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -526,7 +526,11 @@ if (NOT DRM_INCLUDE_DIRS)
 endif()
 
 if (DRM_INCLUDE_DIRS)
-  include_directories(${DRM_INCLUDE_DIRS})
+  if (EXISTS ${DRM_INCLUDE_DIRS}/i915_drm.h AND EXISTS ${DRM_INCLUDE_DIRS}/amdgpu_drm.h)
+    include_directories(${DRM_INCLUDE_DIRS})
+  else()
+    unset(DRM_INCLUDE_DIRS CACHE)
+  endif()
 endif()
 
 #-------------------------
diff --git a/pyverbs/dmabuf_alloc.c b/pyverbs/dmabuf_alloc.c
index 9978a5b..e3ea0a4 100644
--- a/pyverbs/dmabuf_alloc.c
+++ b/pyverbs/dmabuf_alloc.c
@@ -14,7 +14,6 @@
 #include <drm.h>
 #include <i915_drm.h>
 #include <amdgpu_drm.h>
-#include <radeon_drm.h>
 #include "dmabuf_alloc.h"
 
 /*
-- 
1.8.3.1

