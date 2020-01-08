Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB324134937
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgAHRWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41794 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729516AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMV8C009587;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMUkL009516;
        Wed, 8 Jan 2020 19:22:30 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMOk5009512;
        Wed, 8 Jan 2020 19:22:24 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 00/14] Refactoring FD usage
Date:   Wed,  8 Jan 2020 19:21:52 +0200
Message-Id: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series refactors the usage of FDs in both IB core and mlx5 driver.
It includes:
- Simplify destruction of FD uobjects by making them pure uobjects and use
   a generic release method for all struct file operations.
- Make ib_uverbs_async_event_file into a uobject.
- Improve locking in few related areas.
- Simplify type usage for ib_uverbs_async_handler().

This refactoring series may be followed by some other series that will allow
the async FD to be allocated separately from the context and then enables
having the alloc_context command over ioctl.

Yishai

Jason Gunthorpe (14):
  RDMA/mlx5: Use RCU and direct refcounts to keep memory alive
  RDMA/core: Simplify destruction of FD uobjects
  RDMA/mlx5: Simplify devx async commands
  RDMA/core: Do not allow alloc_commit to fail
  RDMA/core: Make ib_ucq_object use ib_uevent_object
  RDMA/core: Do not erase the type of ib_cq.uobject
  RDMA/core: Do not erase the type of ib_qp.uobject
  RDMA/core: Do not erase the type of ib_srq.uobject
  RDMA/core: Do not erase the type of ib_wq.uobject
  RDMA/core: Simplify type usage for ib_uverbs_async_handler()
  RDMA/core: Fix locking in ib_uverbs_event_read
  RDMA/core: Remove the ufile arg from rdma_alloc_begin_uobject
  RDMA/core: Make ib_uverbs_async_event_file into a uobject
  RDMA/core: Use READ_ONCE for ib_ufile.async_file

 drivers/infiniband/core/Makefile                   |   3 +-
 drivers/infiniband/core/core_priv.h                |   2 +-
 drivers/infiniband/core/nldev.c                    |   3 +-
 drivers/infiniband/core/rdma_core.c                | 189 ++++++-------
 drivers/infiniband/core/rdma_core.h                |  45 +---
 drivers/infiniband/core/uverbs.h                   |  28 +-
 drivers/infiniband/core/uverbs_cmd.c               | 201 +++++++-------
 drivers/infiniband/core/uverbs_ioctl.c             |  45 +---
 drivers/infiniband/core/uverbs_main.c              | 292 ++++++---------------
 drivers/infiniband/core/uverbs_std_types.c         |  44 +++-
 .../infiniband/core/uverbs_std_types_async_fd.c    |  33 +++
 drivers/infiniband/core/uverbs_std_types_cq.c      |  19 +-
 drivers/infiniband/core/uverbs_uapi.c              |   7 +-
 drivers/infiniband/hw/mlx5/devx.c                  | 159 +++++------
 include/rdma/ib_verbs.h                            |  13 +-
 include/rdma/uverbs_std_types.h                    |  13 +-
 include/rdma/uverbs_types.h                        |  33 ++-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   1 +
 18 files changed, 494 insertions(+), 636 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_async_fd.c

-- 
1.8.3.1

