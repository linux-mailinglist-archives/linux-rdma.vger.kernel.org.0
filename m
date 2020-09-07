Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013725FA78
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgIGMWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgIGMWC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:22:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252C42075A;
        Mon,  7 Sep 2020 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481321;
        bh=iYUb+Zsd4GrCPNUdtbpxR+WKk7SvIZEULip+gpNTCbY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZevYvN0acMnmWlQZ8iq3aV/c4og9RjIhs2VxJ2tGhqdp69YRtbyWS/zrLcAIrkHN3
         VkUy5pWJoWfDqxkxWAzVsp3FyfmXtJ6Rhk5nrmcOJBG47xRUulBdL2l1SfpI1+H6Xp
         8Qn9SZmTALdBrvgFn+iIFO2KmHE36dG3CHxUAQxU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v2 00/14] Track memory allocation with restrack DB help
Date:   Mon,  7 Sep 2020 15:21:42 +0300
Message-Id: <20200907122156.478360-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
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
Hi,

The resource tracker has built-in kref counter to synchronize object
release. It makes restrack perfect choice to be responsible for the
memory lifetime of any object in which restrack entry is embedded.

In order to make it, the restrack was changed to be mandatory and all
callers of rdma_restrack_add() started to rely on result returned from
that call. Being mandatory means that all objects specific to restrack
type must be tracked.

Before this series, the restrack and rdmatool were aid tools in debug
session of user space applications, this caused to some of the
functionality to be left behind, like support XRC QPs, device memory MRs
and QP0/QP1 in multi-port devices.

This series fixes all mentioned above without extending rdmatool at all.

Thanks

Leon Romanovsky (14):
  RDMA/cma: Delete from restrack DB after successful destroy
  RDMA/mlx5: Don't call to restrack recursively
  RDMA/mlx4: Provide port number for special QPs
  RDMA/restrack: Count references to the verbs objects
  RDMA/restrack: Simplify restrack tracking in kernel flows
  RDMA/restrack: Improve readability in task name management
  RDMA/cma: Be strict with attaching to CMA device
  RDMA/core: Allow drivers to disable restrack DB
  RDMA/counter: Combine allocation and bind logic
  RDMA/restrack: Store all special QPs in restrack DB
  RDMA/restrack: Make restrack DB mandatory for IB objects
  RDMA/restrack: Support all QP types
  RDMA/core: Track device memory MRs
  RDMA/restrack: Drop valid restrack field as source of ambiguity

 drivers/infiniband/core/cma.c                 | 225 +++++++++++-------
 drivers/infiniband/core/core_priv.h           |  39 ++-
 drivers/infiniband/core/counters.c            | 178 +++++++-------
 drivers/infiniband/core/cq.c                  |  24 +-
 drivers/infiniband/core/rdma_core.c           |   3 +-
 drivers/infiniband/core/restrack.c            | 207 ++++++++--------
 drivers/infiniband/core/restrack.h            |  10 +-
 drivers/infiniband/core/uverbs_cmd.c          |  50 +++-
 drivers/infiniband/core/uverbs_std_types_cq.c |  12 +-
 drivers/infiniband/core/uverbs_std_types_mr.c |  10 +
 drivers/infiniband/core/uverbs_std_types_qp.c |   4 +-
 drivers/infiniband/core/verbs.c               |  91 +++++--
 drivers/infiniband/hw/mlx4/mad.c              |   9 +-
 drivers/infiniband/hw/mlx5/gsi.c              |  16 +-
 drivers/infiniband/hw/mlx5/qp.c               |   2 +-
 include/rdma/ib_verbs.h                       |  10 +-
 include/rdma/restrack.h                       |  46 ++--
 17 files changed, 541 insertions(+), 395 deletions(-)

--
2.26.2

