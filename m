Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88D1CCBB0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJO4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 10:56:10 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:58156 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgEJO4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 10:56:09 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 May 2020 17:56:06 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04AEu6eF007532;
        Sun, 10 May 2020 17:56:06 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH 0/4] Introducing RDMA shared CQ pool
Date:   Sun, 10 May 2020 17:55:53 +0300
Message-Id: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the fourth re-incarnation of the CQ pool patches proposed
by Sagi and Christoph. I have started with the patches that Sagi last
submitted and built the CQ pool as a new API for acquiring shared CQs.

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

The patch set convert nvme-rdma and nvmet-rdma to use the new API.

Test setup:
Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
TX-depth = 32. Number of cores refers to the initiator side. Four disks are
accessed from each core. In the current case we have four CQs per core and
in the shared case we have a single CQ per core. Until 14 cores there is no
significant change in performance and the number of interrupts per second
is less than a million in the current case.
==================================================
|Cores|Current KIOPs  |Shared KIOPs  |improvement|
|-----|---------------|--------------|-----------|
|14   |2188           |2620          |19.7%      |
|-----|---------------|--------------|-----------|
|20   |2063           |2308          |11.8%      |
|-----|---------------|--------------|-----------|
|28   |1933           |2235          |15.6%      |
|=================================================
|Cores|Current avg lat|Shared avg lat|improvement|
|-----|---------------|--------------|-----------|
|14   |817us          |683us         |16.4%      |
|-----|---------------|--------------|-----------|
|20   |1239us         |1108us        |10.6%      |
|-----|---------------|--------------|-----------|
|28   |1852us         |1601us        |13.5%      |
========================================================
|Cores|Current interrupts|Shared interrupts|improvement|
|-----|------------------|-----------------|-----------|
|14   |2131K/sec         |425K/sec         |80%        |
|-----|------------------|-----------------|-----------|
|20   |2267K/sec         |594K/sec         |73.8%      |
|-----|------------------|-----------------|-----------|
|28   |2370K/sec         |1057K/sec        |55.3%      |
====================================================================
|Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
|-----|------------------------|-----------------------|-----------|
|14   |85Kus                   |9Kus                   |88%        |
|-----|------------------------|-----------------------|-----------|
|20   |6Kus                    |5.3Kus                 |14.6%      |
|-----|------------------------|-----------------------|-----------|
|28   |11.6Kus                 |9.5Kus                 |18%        |
|===================================================================

Performance improvement with 16 disks (16 CQs per core) is comparable.
What we can see is that once we reach a couple million interrupts per
second the Intel CPU can no longer sustain line rate and this feature
mitigates that effect.

Comments and feedback are welcome.

Yamin Friedman (4):
  infiniband/core: Add protection for shared CQs used by ULPs
  RDMA/core: Introduce shared CQ pool API
  nvme-rdma: use new shared CQ mechanism
  nvmet-rdma: use new shared CQ mechanism

 drivers/infiniband/core/core_priv.h |   8 ++
 drivers/infiniband/core/cq.c        | 170 ++++++++++++++++++++++++++++++++++--
 drivers/infiniband/core/device.c    |   3 +-
 drivers/infiniband/core/verbs.c     |  37 +++++++-
 drivers/nvme/host/rdma.c            |  65 +++++++++-----
 drivers/nvme/target/rdma.c          |  14 +--
 include/rdma/ib_verbs.h             |  52 ++++++++++-
 7 files changed, 308 insertions(+), 41 deletions(-)

-- 
1.8.3.1

