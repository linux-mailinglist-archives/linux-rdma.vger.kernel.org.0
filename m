Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F332C6CB1
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 21:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgK0Uoc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 15:44:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:6740 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgK0Uni (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 15:43:38 -0500
IronPort-SDR: SgV77tcMid5eoYx9I1e4Ebi8JzUffCL2qeX8WWadYAH0kle6w/C5gIT5dylxQcFQjIXhXPoLwF
 kZlEumkki9IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172533985"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172533985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 12:41:44 -0800
IronPort-SDR: SV/suYrGoIujcV0Ob+A9kC2cT8oMD8kbNr6ZQX5g4tZlIiM399naXfVfwca9M23NmYp/NjXaEv
 y5KGk8hitXzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="537737677"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2020 12:41:44 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH rdma-core v3 0/6] Add user space dma-buf support
Date:   Fri, 27 Nov 2020 12:55:37 -0800
Message-Id: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the third version of the patch series. Change log:

v3:
* Add parameter 'iova' to the new ibv_reg_dmabuf_mr() API
* Change the way of allocating dma-buf object - use /dev/dri/renderD*
  instead of /dev/dri/card* and use GEM object instead of dumb buffer
* Add cmake function to allow building modules with mixed cython and C
  source files
* Add new tests that use dma-buf MRs for send/recv and rdma traffic
* Skip dma-buf tests on unsupported systems
* Remove some use of random values in the new tests
* Add dealloc() and close() methods to the new classes
* Replace string.format with f-string in python code
* Fix some coding style issues: spacing, indentation, typo, comments

v2: https://www.spinics.net/lists/linux-rdma/msg97936.html
* Put the kernel header updates into a separate commit
* Add comments for the data structure used in python ioctl calls
* Fix issues related to symbol versioning
* Fix styling issues: extra spaces, unncecessary variable, typo
* Fix an inproper error code usage
* Put the new op into ibv_context_ops instead if verbs_context

v1: https://www.spinics.net/lists/linux-rdma/msg97865.html
* Add user space API for registering dma-buf based memory regions
* Update pyverbs with the new API
* Add new tests

This is the user space counter-part of the kernel patch set to add
dma-buf support to the RDMA subsystem.

This series consists of six patches. The first patch updates the
kernel headers for dma-buf support. Patch 2 adds the new API function
and updates the man pages. Patch 3 implements the new API in the mlx5
provider. Patch 4 adds new class definitions to pyverbs for the new API.
Patch 5 adds a set of new tests for the new API. Patch 6 fixes bug in
the utility code of the tests.

Pull request at github: https://github.com/linux-rdma/rdma-core/pull/895

Jianxin Xiong (6):
  Update kernel headers
  verbs: Support dma-buf based memory region
  mlx5: Support dma-buf based memory region
  pyverbs: Add dma-buf based MR support
  tests: Add tests for dma-buf based memory regions
  tests: Bug fix for get_access_flags()

 buildlib/pyverbs_functions.cmake         |  52 ++++++
 debian/libibverbs1.symbols               |   2 +
 kernel-headers/rdma/ib_user_ioctl_cmds.h |  14 ++
 kernel-headers/rdma/ib_user_verbs.h      |  14 --
 libibverbs/CMakeLists.txt                |   2 +-
 libibverbs/cmd_mr.c                      |  38 ++++
 libibverbs/driver.h                      |   7 +
 libibverbs/dummy_ops.c                   |  11 ++
 libibverbs/libibverbs.map.in             |   6 +
 libibverbs/man/ibv_reg_mr.3              |  27 ++-
 libibverbs/verbs.c                       |  18 ++
 libibverbs/verbs.h                       |  11 ++
 providers/mlx5/mlx5.c                    |   2 +
 providers/mlx5/mlx5.h                    |   3 +
 providers/mlx5/verbs.c                   |  22 +++
 pyverbs/CMakeLists.txt                   |   7 +
 pyverbs/dmabuf.pxd                       |  15 ++
 pyverbs/dmabuf.pyx                       |  72 ++++++++
 pyverbs/dmabuf_alloc.c                   | 296 +++++++++++++++++++++++++++++++
 pyverbs/dmabuf_alloc.h                   |  19 ++
 pyverbs/libibverbs.pxd                   |   2 +
 pyverbs/mr.pxd                           |   6 +
 pyverbs/mr.pyx                           | 103 ++++++++++-
 tests/test_mr.py                         | 239 ++++++++++++++++++++++++-
 tests/utils.py                           |  30 +++-
 25 files changed, 996 insertions(+), 22 deletions(-)
 create mode 100644 pyverbs/dmabuf.pxd
 create mode 100644 pyverbs/dmabuf.pyx
 create mode 100644 pyverbs/dmabuf_alloc.c
 create mode 100644 pyverbs/dmabuf_alloc.h

-- 
1.8.3.1

