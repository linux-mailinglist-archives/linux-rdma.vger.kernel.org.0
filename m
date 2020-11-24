Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7025E2C32A9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgKXVY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 16:24:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:3765 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbgKXVY5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 16:24:57 -0500
IronPort-SDR: nxIl9W6Q9sjSjg+5qtqFp+6kP8Pm7Z8f51h7Z4p1zJh1qZUQrlG284hNL4LbY/lpyYZvevQw3r
 2jYEEMnbH5qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172117604"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="172117604"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 13:24:56 -0800
IronPort-SDR: 4TOuOP6yYJ3slrMDycvNmdirD2qd/Ew7jKq+kGuSol4JUBPm8kCgtHZDguvaAQGgbHGFkB3DbE
 6V6BQxvNkXPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="332701576"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga006.jf.intel.com with ESMTP; 24 Nov 2020 13:24:56 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH rdma-core v2 0/6] Add user space dma-buf support
Date:   Tue, 24 Nov 2020 13:38:48 -0800
Message-Id: <1606253934-67181-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the user space counter-part of the kernel patch set to add
dma-buf support to the RDMA subsystem.

This is the second version of the patch series. Most of the issues found
so far in v1 are addressed except for the use of /dev/dri/card* and
dumb_buf for allocating dma-buf object. The current implementation at
least provides a testing setup that works for most GPUs. Alternatives
are being investigated.

Change log:

v2:
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

This series consists of six patches. The first patch updates the
kernel headers for dma-buf support. Patch 2 adds the new API function
and updates the man pages. Patch 3 implements the new API in the mlx5
provider. Patch 3 adds new class definitions to pyverbs for the new API.
Patch 4 adds a set of new tests for the new API. Patch 5 fixes bug in
the utility code of the tests.

Pull request at github: https://github.com/linux-rdma/rdma-core/pull/895

Jianxin Xiong (6):
  Update kernel headers
  verbs: Support dma-buf based memory region
  mlx5: Support dma-buf based memory region
  pyverbs: Add dma-buf based MR support
  tests: Add tests for dma-buf based memory regions
  tests: Bug fix for get_access_flags()

 debian/libibverbs1.symbols               |   2 +
 kernel-headers/rdma/ib_user_ioctl_cmds.h |  14 ++++
 kernel-headers/rdma/ib_user_verbs.h      |  14 ----
 libibverbs/CMakeLists.txt                |   2 +-
 libibverbs/cmd_mr.c                      |  38 +++++++++
 libibverbs/driver.h                      |   7 ++
 libibverbs/dummy_ops.c                   |  11 +++
 libibverbs/libibverbs.map.in             |   6 ++
 libibverbs/man/ibv_reg_mr.3              |  21 ++++-
 libibverbs/verbs.c                       |  17 ++++
 libibverbs/verbs.h                       |  11 +++
 providers/mlx5/mlx5.c                    |   2 +
 providers/mlx5/mlx5.h                    |   3 +
 providers/mlx5/verbs.c                   |  22 ++++++
 pyverbs/CMakeLists.txt                   |   2 +
 pyverbs/dmabuf.pxd                       |  13 ++++
 pyverbs/dmabuf.pyx                       |  85 ++++++++++++++++++++
 pyverbs/libibverbs.pxd                   |   2 +
 pyverbs/mr.pxd                           |   5 ++
 pyverbs/mr.pyx                           |  77 +++++++++++++++++-
 tests/test_mr.py                         | 130 ++++++++++++++++++++++++++++++-
 tests/utils.py                           |  29 ++++++-
 22 files changed, 491 insertions(+), 22 deletions(-)
 create mode 100644 pyverbs/dmabuf.pxd
 create mode 100644 pyverbs/dmabuf.pyx

-- 
1.8.3.1

