Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA572A66A4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgKDOqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 09:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbgKDOqC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 09:46:02 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D61920756;
        Wed,  4 Nov 2020 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604501162;
        bh=CYbbCztgkPv73rGNjNK0mcqcOPTC4t+w0Vu80LkOh7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Uxs1Sd0+DibJy0GXWobw8PYv+j60gK7p4XDNkxZhh33XlHL8ffp+VpO8av4N4/Ela
         0Qfx4R2gCA0TTsDjrDP2TJ/ag79jG1n+suSgYbFShi1ZaxftH2YcxEg5JBSY6txJls
         Pu9EMIjZJm/YQiNJj4v+gWjfzKGwSh+M9VC8XW3s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 0/2] Cleanup FD destroy
Date:   Wed,  4 Nov 2020 16:45:54 +0200
Message-Id: <20201104144556.3809085-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

v1: Added Jason's variant of first patch
v0: https://lore.kernel.org/lkml/20201012045600.418271-1-leon@kernel.org

Leon Romanovsky (2):
  RDMA/core: Postpone uobject cleanup on failure till FD close
  RDMA/core: Make FD destroy callback void

 drivers/infiniband/core/rdma_core.c           | 50 +++++++------------
 drivers/infiniband/core/uverbs_cmd.c          |  5 +-
 drivers/infiniband/core/uverbs_std_types.c    | 18 +++----
 .../core/uverbs_std_types_async_fd.c          |  5 +-
 .../core/uverbs_std_types_counters.c          |  5 +-
 drivers/infiniband/core/uverbs_std_types_cq.c |  4 +-
 drivers/infiniband/core/uverbs_std_types_dm.c |  6 +--
 .../core/uverbs_std_types_flow_action.c       |  6 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  4 +-
 .../infiniband/core/uverbs_std_types_srq.c    |  4 +-
 drivers/infiniband/core/uverbs_std_types_wq.c |  4 +-
 drivers/infiniband/hw/mlx5/devx.c             | 14 +++---
 drivers/infiniband/hw/mlx5/fs.c               |  6 +--
 include/rdma/ib_verbs.h                       | 44 +---------------
 include/rdma/uverbs_types.h                   |  4 +-
 15 files changed, 54 insertions(+), 125 deletions(-)

--
2.28.0

