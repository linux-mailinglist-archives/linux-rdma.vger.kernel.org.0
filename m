Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209EF214B1F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgGEIUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33106 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbgGEIUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:13 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5I0001664;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K4hX009262;
        Sun, 5 Jul 2020 11:20:04 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K4ns009257;
        Sun, 5 Jul 2020 11:20:04 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 00/13] verbs: Introduce import verbs for device, PD, MR
Date:   Sun,  5 Jul 2020 11:19:36 +0300
Message-Id: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series Introduces import verbs for device, PD, MR which enables processes
to share their ibv_context and then share PD(s) and MR(s) that are associated
with.

This functionality enables utilizing and optimizing some application flows, few
examples below.

Any solution which is a single business logic based on multi-process design
needs this. Example include NGINX, with TCP load balancing, sharing the RSS
indirection table with RQ per process. HPC frameworks with multi-rank (process)
solution on single hosts. UCX can share IB resources using the shared PD and
can help dispatch data to multiple processes/MR's in single RDMA operation.
Also, there are use cases when a primary processes registered a large shared
memory range, and each worker process spawned will create a private QP on the
shared PD, and use the shared MR to save the registration time per-process.

As part of this series was added also some pyverbs stuff to support and
demonstrate some usage of the APIs.

The verbs APIs were introduced in the mailing list by the below RFC [1], the
matching kernel series was sent to rdma-next,

PR: https://github.com/linux-rdma/rdma-core/pull/776
[1] https://patchwork.kernel.org/patch/11540665/

Changes from V0:
- Replace ordering of patches #3 and #4 to prevent incomplete functionality.
- Added some note as part of ibv_import_device() to explain why it's safe
  for dissociated flow.
- Improve man pages in some places.
- Drop the IOVA attribute setting which was not really in use.
- Fix some style notes.
- Refer in commit messages to ioctl command instead of KABI.

Yishai

Edward Srouji (3):
  pyverbs: Support verbs import APIs
  Documentation: Add usage example for verbs import
  tests: Add a shared PD Pyverbs test

Yishai Hadas (10):
  Update kernel headers
  verbs: Close async_fd only when it was previously created
  verbs: Enhance async FD usage
  verbs: Introduce ibv_import_device() verb
  mlx5: Refactor mlx5_alloc_context()
  mlx5: Implement the import device functionality
  verbs: Introduce ibv_import/unimport_pd() verbs
  mlx5: Implement the import/unimport PD verbs
  verbs: Introduce ibv_import/unimport_mr() verbs
  mlx5: Implement the import/unimport MR verbs

 Documentation/pyverbs.md                   |  40 ++++
 debian/libibverbs1.symbols                 |   5 +
 kernel-headers/rdma/ib_user_ioctl_cmds.h   |  15 ++
 kernel-headers/rdma/mlx5_user_ioctl_cmds.h |  14 ++
 kernel-headers/rdma/rdma_netlink.h         |   8 +
 kernel-headers/rdma/rdma_user_ioctl_cmds.h |   2 +-
 libibverbs/cmd_cq.c                        |   9 +-
 libibverbs/cmd_device.c                    |  32 ++-
 libibverbs/cmd_mr.c                        |  31 +++
 libibverbs/cmd_qp.c                        |   4 +
 libibverbs/cmd_srq.c                       |   4 +
 libibverbs/cmd_wq.c                        |   4 +
 libibverbs/device.c                        |  73 ++++++-
 libibverbs/driver.h                        |  14 ++
 libibverbs/dummy_ops.c                     |  30 +++
 libibverbs/ibverbs.h                       |   1 +
 libibverbs/libibverbs.map.in               |   7 +
 libibverbs/man/CMakeLists.txt              |   5 +
 libibverbs/man/ibv_import_device.3.md      |  48 +++++
 libibverbs/man/ibv_import_mr.3.md          |  64 ++++++
 libibverbs/man/ibv_import_pd.3.md          |  59 ++++++
 libibverbs/verbs.c                         |  30 +++
 libibverbs/verbs.h                         |  26 +++
 providers/mlx5/mlx5.c                      | 319 ++++++++++++++++++-----------
 providers/mlx5/mlx5.h                      |   6 +
 providers/mlx5/verbs.c                     |  78 ++++++-
 pyverbs/device.pyx                         |  12 +-
 pyverbs/libibverbs.pxd                     |   5 +
 pyverbs/mr.pxd                             |   1 +
 pyverbs/mr.pyx                             |  60 +++++-
 pyverbs/pd.pxd                             |   1 +
 pyverbs/pd.pyx                             |  37 +++-
 tests/CMakeLists.txt                       |   1 +
 tests/base.py                              |  11 +-
 tests/test_shared_pd.py                    |  95 +++++++++
 35 files changed, 999 insertions(+), 152 deletions(-)
 create mode 100644 libibverbs/man/ibv_import_device.3.md
 create mode 100644 libibverbs/man/ibv_import_mr.3.md
 create mode 100644 libibverbs/man/ibv_import_pd.3.md
 create mode 100644 tests/test_shared_pd.py

-- 
1.8.3.1

