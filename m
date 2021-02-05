Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA316311A2C
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Feb 2021 04:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhBFDcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 22:32:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:32304 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhBFDaS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Feb 2021 22:30:18 -0500
IronPort-SDR: 1Z/OBRoa59PLrMSkOxTGIVVM+MySeo1cAIkIy3wdNIMgRpRw4rFQsR2QeU/AbjW40g961aQwYS
 055z6M0hWd1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="168615077"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="168615077"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:18:36 -0800
IronPort-SDR: oSMgBYdbG7dIhEy80q9y6mnprtWCtO4wcRnt7P0TGsV2zKPqcB0S61FfddNJQLKy86SFAWyaB0
 d8rhkgTTDzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="394034429"
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
Subject: [PATCH rdma-core v3 1/3] verbs: Fix gcc warnings when building for 32bit systems
Date:   Fri,  5 Feb 2021 14:33:37 -0800
Message-Id: <1612564419-103455-2-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612564419-103455-1-git-send-email-jianxin.xiong@intel.com>
References: <1612564419-103455-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 6b0a3238289f ("verbs: Support dma-buf based memory region") caused
a build failure when building for 32b systems with gcc:

$ mkdir build && cd build && CFLAGS="-m32" cmake -GNinja .. \
  -DIOCTL_MODE=both -DNO_PYVERBS=1 -DENABLE_WERROR=1 && ninja
...
../libibverbs/cmd_mr.c: In function 'ibv_cmd_reg_dmabuf_mr':
../libibverbs/cmd_mr.c:152:21: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  vmr->ibv_mr.addr = (void *)offset;
...
../libibverbs/verbs.c: In function 'ibv_reg_dmabuf_mr':
../libibverbs/verbs.c:387:13: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  mr->addr = (void *)offset;
...

Reported-by: Ali Alnubani <alialnu@nvidia.com>
Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 libibverbs/cmd_mr.c | 2 +-
 libibverbs/verbs.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
index af0fad7..736fce0 100644
--- a/libibverbs/cmd_mr.c
+++ b/libibverbs/cmd_mr.c
@@ -149,7 +149,7 @@ int ibv_cmd_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
 	vmr->ibv_mr.lkey = lkey;
 	vmr->ibv_mr.rkey = rkey;
 	vmr->ibv_mr.pd = pd;
-	vmr->ibv_mr.addr = (void *)offset;
+	vmr->ibv_mr.addr = (void *)(uintptr_t)offset;
 	vmr->ibv_mr.length = length;
 	vmr->mr_type = IBV_MR_TYPE_DMABUF_MR;
 	return 0;
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index b93046a..f666695 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -384,7 +384,7 @@ struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
 
 	mr->context = pd->context;
 	mr->pd = pd;
-	mr->addr = (void *)offset;
+	mr->addr = (void *)(uintptr_t)offset;
 	mr->length = length;
 	return mr;
 }
-- 
1.8.3.1

