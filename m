Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634B8311A26
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Feb 2021 04:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhBFDc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 22:32:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:32272 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhBFD3r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Feb 2021 22:29:47 -0500
IronPort-SDR: tw6F1PRg+A7QczwF+Zlmy/l4Z6yKBCCt17MVQ4UbkL8iW6o2b57Z65LUU41Sk05xDVxoFLwiON
 99SHRXn85W0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="168615076"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="168615076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:18:36 -0800
IronPort-SDR: lbCeaALN/nqM77jqgsS/Z5TllBtjuK9YynM57BQT4WqOte0+r5LlKtIomeEJrZf+FN037rkfoJ
 nZguHOm2/Q0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="394034426"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2021 14:18:36 -0800
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
Subject: [PATCH rdma-core v3 0/3] Dma-buf related fixes
Date:   Fri,  5 Feb 2021 14:33:36 -0800
Message-Id: <1612564419-103455-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the third version of the patch series. Change log:

v3:
* Limit the use of find_path() to checking headers installed by the
  kernel-headers package only
* Add status summary when DRM headers are not found
* Rework how dmabuf_alloc.c or dmabuf_alloc_stub.c is selected

v2: https://www.spinics.net/lists/linux-rdma/msg99838.html
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
  configure: Add check for DRM headers

 CMakeLists.txt              | 17 ++++++++++
 libibverbs/cmd_mr.c         |  2 +-
 libibverbs/verbs.c          |  2 +-
 pyverbs/CMakeLists.txt      |  8 ++++-
 pyverbs/dmabuf.pyx          | 12 +++----
 pyverbs/dmabuf_alloc.c      | 20 ++++++------
 pyverbs/dmabuf_alloc.h      |  2 +-
 pyverbs/dmabuf_alloc_stub.c | 39 +++++++++++++++++++++++
 pyverbs/mr.pyx              |  6 ++--
 tests/test_mr.py            | 78 ++++++++++++++++++++++-----------------------
 10 files changed, 124 insertions(+), 62 deletions(-)
 create mode 100644 pyverbs/dmabuf_alloc_stub.c

-- 
1.8.3.1

