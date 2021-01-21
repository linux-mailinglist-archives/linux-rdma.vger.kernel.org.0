Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65B32FDE5C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 02:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbhAUBA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 20:00:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:2371 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388725AbhAUAFo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 19:05:44 -0500
IronPort-SDR: RDfVl+zSNYwBKYYzxT6j8D6AoQQk1kcqIjqmLTgWxxlpRMhRLxqmQtRj8zOj0J/faPoIZQ/jW1
 Mwv8KWB6IEOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166291170"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="166291170"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 15:59:43 -0800
IronPort-SDR: y9S+GlnPnx3o+8pSvMbNDEiB8jNGxC6+s/vMYiiHHPB5y+uZmVCJTmZWfeNrlmnexK2OXaRoVe
 b56Z//CBDdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="570551138"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2021 15:59:41 -0800
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
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-core v6 0/6] Add user space dma-buf support
Date:   Wed, 20 Jan 2021 16:14:32 -0800
Message-Id: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the sixth version of the patch series. Change log:

v6:
* Rebase to the latest rdma-core master (commit 14006f2f841b0c)
* Update the ABI symbol version to match new package version; also bump
  the private ABI version because new function has been added to the
  provider interface
* Avoid changing 'struct ibv_context_ops' by replacing SET_OP() with
  SET_PRIV_OP_IC()
* Replace sprintf() with snprintf()
* Keep the ops in verbs_set_ops() sorted
* Fix some styling issues: extra spaces, struct 0-initialization, error
  checking control flow

v5: https://www.spinics.net/lists/linux-rdma/msg99015.html
* Use a different mr_type for dmabuf so that ibv_dofork_range() is not
  called inside ibv_dereg_mr() for dmabuf based mr

v4: https://www.spinics.net/lists/linux-rdma/msg98135.html
* Rework the cmake funciton rdma_cython_module to support both single
  source (.pyx) and multiple source (.pyx + [.c]*) scenarios instead
  of using two separate functions
* Rename 'dri_*' to 'drm_*' for the dmabuf allocation interface
* Add option to dmabuf allocation routine to allow allocation from GTT
  instead of VRAM
* Add proper CPU access flags when allocating dmabufs
* Remove 'radeon' driver support from the dmabuf allocation routines
* Add comand line arguments to the tests for selecting GPU unit and
  setting the option for allocating from GTT

v3: https://www.spinics.net/lists/linux-rdma/msg98059.html
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

 CMakeLists.txt                           |   2 +-
 buildlib/pyverbs_functions.cmake         |  78 ++++++---
 debian/control                           |   2 +-
 debian/libibverbs1.symbols               |   4 +-
 kernel-headers/rdma/ib_user_ioctl_cmds.h |  14 ++
 libibverbs/CMakeLists.txt                |   2 +-
 libibverbs/cmd_mr.c                      |  38 +++++
 libibverbs/driver.h                      |   8 +
 libibverbs/dummy_ops.c                   |  11 ++
 libibverbs/libibverbs.map.in             |   6 +
 libibverbs/man/ibv_reg_mr.3              |  27 ++-
 libibverbs/verbs.c                       |  19 +++
 libibverbs/verbs.h                       |   7 +
 providers/mlx5/mlx5.c                    |   2 +
 providers/mlx5/mlx5.h                    |   3 +
 providers/mlx5/verbs.c                   |  22 +++
 pyverbs/CMakeLists.txt                   |  11 +-
 pyverbs/dmabuf.pxd                       |  15 ++
 pyverbs/dmabuf.pyx                       |  73 ++++++++
 pyverbs/dmabuf_alloc.c                   | 278 +++++++++++++++++++++++++++++++
 pyverbs/dmabuf_alloc.h                   |  19 +++
 pyverbs/libibverbs.pxd                   |   2 +
 pyverbs/mr.pxd                           |   6 +
 pyverbs/mr.pyx                           | 105 +++++++++++-
 tests/args_parser.py                     |   4 +
 tests/test_mr.py                         | 264 ++++++++++++++++++++++++++++-
 tests/utils.py                           |  30 +++-
 27 files changed, 1013 insertions(+), 39 deletions(-)
 create mode 100644 pyverbs/dmabuf.pxd
 create mode 100644 pyverbs/dmabuf.pyx
 create mode 100644 pyverbs/dmabuf_alloc.c
 create mode 100644 pyverbs/dmabuf_alloc.h

-- 
1.8.3.1

