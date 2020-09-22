Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC4273E30
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 11:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgIVJLM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 05:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIVJLM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 05:11:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320EA20715;
        Tue, 22 Sep 2020 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600765871;
        bh=GVia0JXgKIIBDsCBd6O09b/mtpUgx23EUqeCHBXAEzo=;
        h=From:To:Cc:Subject:Date:From;
        b=bR6w561hElacpHrX3YNmpWwpB5fwz2pLskKix6LVj1FhT49P53nsM8ec3arkWbxI7
         NZrHsL4kzErUHZ0lZBRqwDtCpAmJHkvZq5GN2nPOHzx04H+74P4JEJCl2VhrdglaA7
         YxjlOp/fYEauN4mFlE3OwafMVFKPuiREojewhQ3A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: [PATCH rdma-next v3 0/5] Cleanup restrack code
Date:   Tue, 22 Sep 2020 12:11:01 +0300
Message-Id: <20200922091106.2152715-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
 * Removed the mlx4 SR-IOV patch in favour of more robust fix that not needed in
   this series.
 * Cut the eroginal series to already reviewed and standalone patches.
v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-1-leon@kernel.org/
 * Added new patch to fix mlx4 failure on SR-IOV, it didn't have port set.
 * Changed "RDMA/cma: Delete from restrack DB after successful destroy" patch.
v1:
 * Fixed rebase error, deleted second assignment of qp_type.
 * Rebased code on latests rdma-next, the changes in cma.c caused to change
   in patch "RDMA/cma: Delete from restrack DB after successful destroy".
 * Dropped patch of port assignment, it is already done as part of this
   series.
 * I didn't add @calller description, regular users should not use _named() funciton.
 * https://lore.kernel.org/lkml/20200830101436.108487-1-leon@kernel.org
v0: https://lore.kernel.org/lkml/20200824104415.1090901-1-leon@kernel.org

----------------------------------------------------------------------------------

Leon Romanovsky (5):
  RDMA/cma: Delete from restrack DB after successful destroy
  RDMA/mlx5: Don't call to restrack recursively
  RDMA/restrack: Count references to the verbs objects
  RDMA/restrack: Simplify restrack tracking in kernel flows
  RDMA/restrack: Improve readability in task name management

 drivers/infiniband/core/cma.c                 | 140 +++++++++------
 drivers/infiniband/core/core_priv.h           |  13 +-
 drivers/infiniband/core/counters.c            |  15 +-
 drivers/infiniband/core/cq.c                  |   9 +-
 drivers/infiniband/core/restrack.c            | 161 +++++++++---------
 drivers/infiniband/core/restrack.h            |  10 +-
 drivers/infiniband/core/ucma.c                |   7 +-
 drivers/infiniband/core/uverbs_cmd.c          |  27 ++-
 drivers/infiniband/core/uverbs_std_types_cq.c |   8 +-
 drivers/infiniband/core/verbs.c               |  31 ++--
 drivers/infiniband/hw/mlx5/gsi.c              |  16 +-
 include/rdma/rdma_cm.h                        |  47 ++---
 include/rdma/restrack.h                       |  21 +--
 13 files changed, 266 insertions(+), 239 deletions(-)

--
2.26.2

