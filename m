Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5D189E90
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 16:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgCRPDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 11:03:01 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:38033 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726619AbgCRPDA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 11:03:00 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:57 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEK008733;
        Wed, 18 Mar 2020 17:02:57 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2 0/5] nvmet-rdma/srpt: SRQ per completion vector
Date:   Wed, 18 Mar 2020 17:02:52 +0200
Message-Id: <20200318150257.198402-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This set is a renewed version of the feature for NVMEoF/RDMA target. In
this series I've decided to implement it also for SRP target that had
similar implementatiom (SRQ per HCA) after previous requests from the
community. The logic is intended to save resource allocation (by sharing
them) and utilize the locality of completions to get the best performance
with Shared Receive Queues (SRQs). We'll create a SRQ per completion
vector (and not per device) using a new API (basic SRQ pool, added to this
patchset too) and associate each created QP/CQ/channel with an
appropriate SRQ. This will also reduce the lock contention on the single
SRQ per device (today's solution).

For NVMEoF, my testing environment included 4 initiators (CX5, CX5, CX4,
CX3) that were connected to 4 subsystems (1 ns per sub) throw 2 ports
(each initiator connected to unique subsystem backed in a different
bull_blk device) using a switch to the NVMEoF target (CX5).
I used RoCE link layer. For SRP, I used 1 server with RoCE loopback connection
(results are not mentioned below) for testing. Hopefully I'll get a tested-by
signature and feedback from Laurence and Rupesh on the SRP part during the review
process.

The below results were made a while ago using NVMEoF.

Configuration:
 - Irqbalancer stopped on each server
 - set_irq_affinity.sh on each interface
 - 2 initiators run traffic throw port 1
 - 2 initiators run traffic throw port 2
 - On initiator set register_always=N
 - Fio with 12 jobs, iodepth 128

Memory consumption calculation for recv buffers (target):
 - Multiple SRQ: SRQ_size * comp_num * ib_devs_num * inline_buffer_size
 - Single SRQ: SRQ_size * 1 * ib_devs_num * inline_buffer_size
 - MQ: RQ_size * CPU_num * ctrl_num * inline_buffer_size

Cases:
 1. Multiple SRQ with 1024 entries:
    - Mem = 1024 * 24 * 2 * 4k = 192MiB (Constant number - not depend on initiators number)
 2. Multiple SRQ with 256 entries:
    - Mem = 256 * 24 * 2 * 4k = 48MiB (Constant number - not depend on initiators number)
 3. MQ:
    - Mem = 256 * 24 * 8 * 4k = 192MiB (Mem grows for every new created ctrl)
 4. Single SRQ (current SRQ implementation):
    - Mem = 4096 * 1 * 2 * 4k = 32MiB (Constant number - not depend on initiators number)

results:

BS    1.read (target CPU)   2.read (target CPU)    3.read (target CPU)   4.read (target CPU)
---  --------------------- --------------------- --------------------- ----------------------
1k     5.88M (80%)            5.45M (72%)            6.77M (91%)          2.2M (72%)

2k     3.56M (65%)            3.45M (59%)            3.72M (64%)          2.12M (59%)

4k     1.8M (33%)             1.87M (32%)            1.88M (32%)          1.59M (34%)

BS    1.write (target CPU)   2.write (target CPU) 3.write (target CPU)   4.write (target CPU)
---  --------------------- --------------------- --------------------- ----------------------
1k     5.42M (63%)            5.14M (55%)            7.75M (82%)          2.14M (74%)

2k     4.15M (56%)            4.14M (51%)            4.16M (52%)          2.08M (73%)

4k     2.17M (28%)            2.17M (27%)            2.16M (28%)          1.62M (24%)


We can see the perf improvement between Case 2 and Case 4 (same order of resource).
We can see the benefit in resource consumption (mem and CPU) with a small perf loss
between cases 2 and 3.
There is still an open question between the perf differance for 1k between Case 1 and
Case 3, but I guess we can investigate and improve it incrementaly.

Thanks to Idan Burstein and Oren Duer for suggesting this nice feature.

Changes from v1:
 - rename srq_set to srq_pool (Leon)
 - changed srpt to use ib_alloc_cq (patch 4/5)
 - removed caching of comp_vector in ib_cq
 - minor fixes got from Leon's review

Max Gurtovoy (5):
  IB/core: add a simple SRQ pool per PD
  nvmet-rdma: add srq pointer to rdma_cmd
  nvmet-rdma: use SRQ per completion vector
  RDMA/srpt: use ib_alloc_cq instead of ib_alloc_cq_any
  RDMA/srpt: use SRQ per completion vector

 drivers/infiniband/core/Makefile      |   2 +-
 drivers/infiniband/core/srq_pool.c    |  75 +++++++++++++
 drivers/infiniband/core/verbs.c       |   3 +
 drivers/infiniband/ulp/srpt/ib_srpt.c | 187 +++++++++++++++++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  28 ++++-
 drivers/nvme/target/rdma.c            | 203 ++++++++++++++++++++++++++--------
 include/rdma/ib_verbs.h               |   4 +
 include/rdma/srq_pool.h               |  18 +++
 8 files changed, 419 insertions(+), 101 deletions(-)
 create mode 100644 drivers/infiniband/core/srq_pool.c
 create mode 100644 include/rdma/srq_pool.h

-- 
1.8.3.1

