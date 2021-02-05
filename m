Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE331016D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 01:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhBEAO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 19:14:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:45136 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhBEAO4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Feb 2021 19:14:56 -0500
IronPort-SDR: Tm6PE1G8xMeYMofZrQfUQDJo4TraUk+tzCNZmlx0ixm3fmeecPH5b01QlWLBLX5HndlLQi4LSI
 9BHsebfhStCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="160511898"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="160511898"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 16:14:14 -0800
IronPort-SDR: Em58YsvkWeHRtvoJS0C7LsMieIWhvViKA3Ys0SNYYfBhmrGjisR4YPcEK2IYInKVX9pWeWpATF
 gvbVX8hDo00w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="508326481"
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
Subject: [PATCH rdma-core v2 0/3] Dma-buf related fixes
Date:   Thu,  4 Feb 2021 16:29:11 -0800
Message-Id: <1612484954-75514-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the second version of the patch series. Change log:

v2:
* Use pgk_check_modules() to check libdrm configuration instead of calling
  pkg-config directly
* Put all the DRM header checking logic in CMakeLists.txt
* Use a seperate source file for dma-buf allocation stubs
* Remove the definition of HAVE_DRM_H from config.h
* Add space between the acronym and the full name

v1: https://www.spinics.net/lists/linux-rdma/msg99815.html
* Fix compilation warnings for 32bit builds
* Cosmetic improvement for dma-buf allocation routines
* Add check for DRM headers

This series fixes a few issues related to the dma-buf support. It consists
of three patches. The first patch fixes a compilation warning for 32-bit
builds. Patch 2 renames a function parameter and adds full name to an
acronym. Patch 3 adds check for DRM headers.

Pull request at github: https://github.com/linux-rdma/rdma-core/pull/942

Jianxin Xiong (3):
  verbs: Fix gcc warnings when building for 32bit systems
  pyverbs,tests: Cosmetic improvements for dma-buf allocation routines
  configure: Add check for the presence of DRM headers

 CMakeLists.txt              | 15 +++++++++
 libibverbs/cmd_mr.c         |  2 +-
 libibverbs/verbs.c          |  2 +-
 pyverbs/CMakeLists.txt      | 14 ++++++--
 pyverbs/dmabuf.pyx          | 12 +++----
 pyverbs/dmabuf_alloc.c      | 20 ++++++------
 pyverbs/dmabuf_alloc.h      |  2 +-
 pyverbs/dmabuf_alloc_stub.c | 39 +++++++++++++++++++++++
 pyverbs/mr.pyx              |  6 ++--
 tests/test_mr.py            | 78 ++++++++++++++++++++++-----------------------
 10 files changed, 127 insertions(+), 63 deletions(-)
 create mode 100644 pyverbs/dmabuf_alloc_stub.c

-- 
1.8.3.1

