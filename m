Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4165E2C122E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 18:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbgKWRjK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 12:39:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:51712 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388458AbgKWRjJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 12:39:09 -0500
IronPort-SDR: OGcppsB/leBDezbNrHVcxZ0pnLuqTWSoTbUvKuRSnJJ1MVXHVYTLQWd3t/xi6gIUulx5uaRZVV
 0gxHV7LXJ7JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168301213"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="168301213"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:39:09 -0800
IronPort-SDR: 2wG7QKoMyGBALxz/acAfvDTXdakVXq3fhePyU7hjISktsLLcaiNJqzPZvOp2t9K67gr6DQNXj8
 pPbPANBvJVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="361525786"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2020 09:39:09 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH rdma-core 0/5] Add user space dma-buf support
Date:   Mon, 23 Nov 2020 09:52:59 -0800
Message-Id: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the user space counter-part of the kernel patch set to add
dma-buf support to the RDMA subsystem. This patch series adds user
space API for registering dma-buf based memory regions, updates
pyverbs with the new API, and adds new tests.

This series consists of five patches. The first patch adds the new API
function and updates the man pages. Patch 2 implements the new API in
the mlx5 provider. Patch 3 adds new class definitions to pyverbs for
the new API. Patch 4 adds new tests for the new API. Patch 5 fixes bug
in the utility code of the tests.

Jianxin Xiong (5):
  verbs: Support dma-buf based memory region
  mlx5: Support dma-buf based memory region
  pyverbs: Add dma-buf based MR support
  tests: Add tests for dma-buf based memory regions
  tests: Bug fix for get_access_flags()

 kernel-headers/rdma/ib_user_ioctl_cmds.h |  14 ++++
 libibverbs/cmd_mr.c                      |  38 +++++++++
 libibverbs/driver.h                      |   7 ++
 libibverbs/dummy_ops.c                   |  11 +++
 libibverbs/libibverbs.map.in             |   6 ++
 libibverbs/man/ibv_reg_mr.3              |  21 ++++-
 libibverbs/verbs.c                       |  19 +++++
 libibverbs/verbs.h                       |  10 +++
 providers/mlx5/mlx5.c                    |   2 +
 providers/mlx5/mlx5.h                    |   3 +
 providers/mlx5/verbs.c                   |  23 ++++++
 pyverbs/CMakeLists.txt                   |   2 +
 pyverbs/dmabuf.pxd                       |  13 ++++
 pyverbs/dmabuf.pyx                       |  58 ++++++++++++++
 pyverbs/libibverbs.pxd                   |   2 +
 pyverbs/mr.pxd                           |   5 ++
 pyverbs/mr.pyx                           |  77 +++++++++++++++++-
 tests/test_mr.py                         | 130 ++++++++++++++++++++++++++++++-
 tests/utils.py                           |  31 +++++++-
 19 files changed, 464 insertions(+), 8 deletions(-)
 create mode 100644 pyverbs/dmabuf.pxd
 create mode 100644 pyverbs/dmabuf.pyx

-- 
1.8.3.1

