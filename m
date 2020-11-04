Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E6D2A6685
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKDOkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 09:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgKDOkO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 09:40:14 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B8120739;
        Wed,  4 Nov 2020 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604500814;
        bh=rjIxCzLN9MItYdkQzQZnWR4e3Ms2Y2EgJEepenSDUeo=;
        h=From:To:Cc:Subject:Date:From;
        b=hcR+yYAkXOLF0w6NfSzcrfr3NQd5f2rB0BJoHVfNHMlPUjtt3LKiR36gPsSJ+JcOi
         qz9l254otn6NYGFzpGRDiqRFZ0nEgTW2YrZPrh0gXfZ6q1NAYAgZydPEf0N4D3+a/1
         ItNjQL6YyFcOP3pySrxKv84eCYX6NgTJVhdlcEhQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v4 0/5] Track memory allocation with restrack DB help (Part I)
Date:   Wed,  4 Nov 2020 16:40:03 +0200
Message-Id: <20201104144008.3808124-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v4:
 * Rebased on latest for-upstream, all that time the patches were in
 our regression and didn't introduce any issues.
 * Took first five patches that hadn't any comments
v3: https://lore.kernel.org/lkml/20200926101938.2964394-1-leon@kernel.org
 * Rebased on already accepted patches.
 * Added mlx4 special QPs to the list of not-tracked QPs (dropped previous mlx4 special QP patch).
 * Separated to two patches change in return value of cma_listen_* routines.
 * Changed commit messages and added Fixes as Jason requested.
v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-1-leon@kernel.org/
 * Added new patch to fix mlx4 failure on SR-IOV, it didn't have port set.
 * Changed "RDMA/cma: Delete from restrack DB after successful destroy" patch.
v1: https://lore.kernel.org/lkml/20200830101436.108487-1-leon@kernel.org
 * Fixed rebase error, deleted second assignment of qp_type.
 * Rebased code on latests rdma-next, the changes in cma.c caused to change
   in patch "RDMA/cma: Delete from restrack DB after successful destroy".
 * Dropped patch of port assignment, it is already done as part of this
   series.
 * I didn't add @calller description, regular users should not use _named() funciton.
v0: https://lore.kernel.org/lkml/20200824104415.1090901-1-leon@kernel.org

----------------------------------------------------------------------------------

Simple resend of already posted series.
https://lore.kernel.org/lkml/20200926101938.2964394-1-leon@kernel.org

Thanks

Leon Romanovsky (5):
  RDMA/core: Allow drivers to disable restrack DB
  RDMA/counter: Combine allocation and bind logic
  RDMA/restrack: Store all special QPs in restrack DB
  RDMA/cma: Add missing error handling of listen_id
  RDMA/cma: Be strict with attaching to CMA device

 drivers/infiniband/core/cma.c       | 217 +++++++++++++++++-----------
 drivers/infiniband/core/core_priv.h |   2 +
 drivers/infiniband/core/counters.c  | 132 ++++++++---------
 drivers/infiniband/core/restrack.c  |  23 ++-
 drivers/infiniband/hw/mlx4/qp.c     |   5 +
 drivers/infiniband/hw/mlx5/qp.c     |   2 +-
 include/rdma/restrack.h             |  24 +++
 7 files changed, 239 insertions(+), 166 deletions(-)

--
2.28.0

