Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30FD135AF1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgAIOFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:24 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33795 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729007AbgAIOFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:23 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:15 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5F5V016589;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5FR2001321;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5Dnw001309;
        Thu, 9 Jan 2020 16:05:13 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-core 0/7] verbs: Relaxed ordering memory regions
Date:   Thu,  9 Jan 2020 16:04:29 +0200
Message-Id: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series exposes an IBV_ACCESS_RELAXED_ORDERING optional MR access flag.
This optional flag allows creation of relaxed ordering memory regions.
Access through such MRs can improve performance by allowing the system to reorder
certain accesses.

The series uses the new ioctl command to get a device context, this command
enables reading some core generic capabilities such as supporting an optional
MR access flags by IB core and its related drivers.

This capability enables transparent masking of the optional flags in libibverbs
when the kernel doesn't support the MR optional access mode.

The series is based on an RFC that was sent to the ML [1], the matching kernel
series was sent to 'for-next'.
[1] https://www.spinics.net/lists/linux-rdma/msg86188.html

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/660

Yishai

Michael Guralnik (6):
  verbs: Move free_context from verbs_device_ops to verbs_context_ops
  verbs: Move alloc_context to ioctl
  verbs: Relaxed ordering memory regions
  mlx5: Add optional access flags range to DM
  pyverbs: Add relaxed ordering access flag
  tests: Add relaxed ordering access test

Yishai Hadas (1):
  Update kernel headers

 debian/libibverbs1.symbols                |  2 +
 kernel-headers/rdma/ib_user_ioctl_cmds.h  | 15 ++++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h | 12 +++++
 libibverbs/CMakeLists.txt                 |  2 +-
 libibverbs/cmd.c                          | 18 -------
 libibverbs/cmd_device.c                   | 79 +++++++++++++++++++++++++++++++
 libibverbs/device.c                       |  5 +-
 libibverbs/driver.h                       |  3 +-
 libibverbs/dummy_ops.c                    |  7 +++
 libibverbs/libibverbs.map.in              |  5 ++
 libibverbs/man/ibv_reg_mr.3               |  2 +
 libibverbs/verbs.c                        | 13 +++++
 libibverbs/verbs.h                        | 51 +++++++++++++++++++-
 libibverbs/verbs_api.h                    |  2 +
 providers/bnxt_re/main.c                  |  6 ++-
 providers/cxgb4/dev.c                     |  4 +-
 providers/efa/efa.c                       |  4 +-
 providers/hfi1verbs/hfiverbs.c            |  4 +-
 providers/hns/hns_roce_u.c                |  4 +-
 providers/i40iw/i40iw_umain.c             |  6 ++-
 providers/ipathverbs/ipathverbs.c         |  4 +-
 providers/mlx4/mlx4.c                     |  4 +-
 providers/mlx5/mlx5.c                     |  4 +-
 providers/mlx5/verbs.c                    |  3 +-
 providers/mthca/mthca.c                   |  6 ++-
 providers/ocrdma/ocrdma_main.c            |  6 ++-
 providers/qedr/qelr_main.c                |  4 +-
 providers/rxe/rxe.c                       |  6 ++-
 providers/siw/siw.c                       |  3 +-
 providers/vmw_pvrdma/pvrdma_main.c        |  4 +-
 pyverbs/libibverbs_enums.pxd              |  1 +
 tests/CMakeLists.txt                      |  5 +-
 tests/test_relaxed_ordering.py            | 55 +++++++++++++++++++++
 33 files changed, 301 insertions(+), 48 deletions(-)
 create mode 100644 tests/test_relaxed_ordering.py

-- 
1.8.3.1

