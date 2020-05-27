Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB681E3C1B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgE0IfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 04:35:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49887 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387859AbgE0IfA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 04:35:00 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 May 2020 11:34:57 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04R8YvRV003290;
        Wed, 27 May 2020 11:34:57 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH V4 0/4] Introducing RDMA shared CQ pool
Date:   Wed, 27 May 2020 11:34:51 +0300
Message-Id: <1590568495-101621-1-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the fourth re-incarnation of the CQ pool patches proposed
by Sagi and Christoph. I have started with the patches that Sagi last
submitted and built the CQ pool as a new API for acquiring shared CQs.

The main change from Sagi's last proposal is that I have simplified the
method that ULP drivers interact with the CQ pool. Instead of calling 
ib_alloc_cq they now call ib_cq_pool_get but use the CQ in the same manner
that they did before. This allows for a much easier transition to using
shared CQs by the ULP and makes it easier to deal with IB_POLL_DIRECT
contexts. Certain types of actions on CQs have been prevented on shared
CQs in order to prevent one user from harming another.

Our ULPs often want to make smart decisions on completion vector
affinitization when using multiple completion queues spread on
multiple cpu cores. We can see examples for this in iser, srp, nvme-rdma.

This patch set attempts to move this smartness to the rdma core by
introducing per-device CQ pools that by definition spread
across cpu cores. In addition, we completely make the completion
queue allocation transparent to the ULP by adding affinity hints
to create_qp which tells the rdma core to select (or allocate)
a completion queue that has the needed affinity for it.

This API gives us a similar approach to whats used in the networking
stack where the device completion queues are hidden from the application.
With the affinitization hints, we also do not compromise performance
as the completion queue will be affinitized correctly.

One thing that should be noticed is that now different ULPs using this
API may share completion queues (given that they use the same polling context).
However, even without this API they share interrupt vectors (and CPUs
that are assigned to them). Thus aggregating consumers on less completion
queues will result in better overall completion processing efficiency per
completion event (or interrupt).

An advantage of this method of using the CQ pool is that changes in the ULP
driver are minimal (around 14 altered lines of code).

The patch set converts nvme-rdma and nvmet-rdma to use the new API.

Test results can be found in patch-0002.

Comments and feedback are welcome.

Changes since v3
----------------

*Refactored ib_poll_ctx enum
*Moved to correct use of unsigned types
*Removed use of spin_lock_irqsave
*Moved pool init and destroy function calls
*Corrected function documentation

Changes since v2
----------------

*Minor code refactoring

Changes since v1
----------------

*Simplified cq pool shutdown process
*Renamed cq pool functions to be like mr pool
*Simplified process for finding cqs in pool
*Removed unhelpful WARN prints
*Removed one liner functions
*Replaced cq_type with boolean shared
*Updated test results to more properly show effect of patch
*Minor bug fixes

Yamin Friedman (4):
  RDMA/core: Add protection for shared CQs used by ULPs
  RDMA/core: Introduce shared CQ pool API
  nvme-rdma: use new shared CQ mechanism
  nvmet-rdma: use new shared CQ mechanism

 drivers/infiniband/core/core_priv.h |   3 +
 drivers/infiniband/core/cq.c        | 171 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/device.c    |   2 +
 drivers/infiniband/core/verbs.c     |   9 ++
 drivers/nvme/host/rdma.c            |  75 ++++++++++------
 drivers/nvme/target/rdma.c          |  14 +--
 include/rdma/ib_verbs.h             |  21 ++++-
 7 files changed, 261 insertions(+), 34 deletions(-)

-- 
1.8.3.1

