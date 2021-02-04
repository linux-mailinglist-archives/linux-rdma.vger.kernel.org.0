Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0674C30FBB1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 19:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhBDSi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 13:38:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:43869 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239221AbhBDSgp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Feb 2021 13:36:45 -0500
IronPort-SDR: lvGEI7uKvBRxwQLqaeICBYVJ09uHKVYV+dQ0AaS0K207CmvUM3b4nAbQWwdRjA1fqW+ej9K3f1
 sb5R3g6o+/Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="200296762"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="200296762"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 10:35:58 -0800
IronPort-SDR: nn6HvKHl8/Jk0QPNFAoSRd+UBNokiCtW1QxfYBeUnRciVoOQ+sxhAr9ci0qDIBGcZsrJS5J2MX
 Gu2NlEdWe3SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="580383228"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2021 10:35:58 -0800
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
Subject: [PATCH rdma-core 0/3] Dma-buf related fixes
Date:   Thu,  4 Feb 2021 10:50:48 -0800
Message-Id: <1612464651-54073-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series fixes a few issues related to the dma-buf support. It consists
of three patches. The first patch fixes a compilation warning for 32-bit
builds. Patch 2 renames a function parameter and expands an abbreviation.
Patch 3 adds check for DRM headers.

Pull request at github: https://github.com/linux-rdma/rdma-core/pull/942

Jianxin Xiong (3):
  verbs: Fix gcc warnings when building for 32bit systems
  pyverbs,tests: Cosmetic improvements for dma-buf allocation routines
  configure: Add check for the presence of DRM headers

 CMakeLists.txt         |  7 +++++
 buildlib/Finddrm.cmake | 19 ++++++++++++
 buildlib/config.h.in   |  2 ++
 libibverbs/cmd_mr.c    |  2 +-
 libibverbs/verbs.c     |  2 +-
 pyverbs/dmabuf.pyx     | 12 ++++----
 pyverbs/dmabuf_alloc.c | 59 +++++++++++++++++++++++++++++++-------
 pyverbs/dmabuf_alloc.h |  2 +-
 pyverbs/mr.pyx         |  6 ++--
 tests/test_mr.py       | 78 +++++++++++++++++++++++++-------------------------
 10 files changed, 127 insertions(+), 62 deletions(-)
 create mode 100644 buildlib/Finddrm.cmake

-- 
1.8.3.1

