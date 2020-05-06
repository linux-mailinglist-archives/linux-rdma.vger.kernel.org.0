Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CA1C6D53
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgEFJlo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:41:44 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32963 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729193AbgEFJlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:41:44 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:41:42 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469fg1H015300;
        Wed, 6 May 2020 12:41:42 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469ff1B024550;
        Wed, 6 May 2020 12:41:42 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469fZHr024536;
        Wed, 6 May 2020 12:41:35 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 0/8] verbs: Enable asynchronous event FD per object
Date:   Wed,  6 May 2020 12:41:01 +0300
Message-Id: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series enables applicable events objects (i.e. QP, SRQ, CQ, WQ) to be
created with their own asynchronous event FD from KABI point of view.

Before this series any affiliated event on an object was reported on the first
asynchronous event FD that was created on the context without the ability to
create and use a dedicated FD for it.

With this series we enable granularity and control for the usage per object.

For example, a secondary process that uses the same command FD as of the primary
one, can create its own objects with its dedicated event FD to be able to get
the events for them once occurred, this couldn't be done before this series.

Further series on top of this one may expose some option to an application to
ask for a dedicated FD for its usage instead of using the default one, this may
enable achieving the above use case.

To achieve the above, any 'create' method for the applicable objects was
extended to get from rdma-core its optional event FD. If wasn't supplied, the
default one from the context will be used as part of kernel side.

As we prefer to not extend the 'write' mode KABIs anymore and fully move to the
'ioct' mode, QP, SRQ and WQ create/destroy commands were introduced over
'ioctl', the CQ KABI was extended over its existing 'ioctl' create command.

As part of moving to 'ioctl' for the above objects few bugs were found and
fixed.

The matching kernel part was sent into rdma-next.
PR: 
https://github.com/linux-rdma/rdma-core/pull/753


Jason Gunthorpe (1):
  mlx4: Delete comp_mask from verbs_srq

Yishai Hadas (7):
  Update kernel headers
  verbs: Extend CQ KABI to get an async FD
  verbs: Fix ibv_get_srq_num() man page
  verbs: Move SRQ create and destroy to ioctl
  verbs: Fix ibv_create_wq() to set wq_context
  verbs: Move WQ create and destroy to ioctl
  verbs: Move QP create and destroy commands to ioctl

 kernel-headers/rdma/ib_user_ioctl_cmds.h  |  81 +++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h |  43 +++
 libibverbs/CMakeLists.txt                 |   3 +
 libibverbs/cmd.c                          | 481 ------------------------------
 libibverbs/cmd_cq.c                       |   7 +-
 libibverbs/cmd_fallback.c                 |   2 +-
 libibverbs/cmd_qp.c                       | 476 +++++++++++++++++++++++++++++
 libibverbs/cmd_srq.c                      | 279 +++++++++++++++++
 libibverbs/cmd_wq.c                       | 173 +++++++++++
 libibverbs/driver.h                       |  25 +-
 libibverbs/kern-abi.h                     |  11 +
 libibverbs/man/ibv_get_srq_num.3.md       |   2 +-
 libibverbs/verbs.c                        |  14 -
 libibverbs/verbs.h                        |   1 +
 providers/efa/verbs.c                     |   2 +-
 providers/mlx4/mlx4.c                     |   2 +-
 providers/mlx4/mlx4.h                     |   1 +
 providers/mlx4/srq.c                      |   1 -
 providers/mlx4/verbs.c                    |  17 +-
 providers/mlx5/verbs.c                    |  16 +-
 20 files changed, 1104 insertions(+), 533 deletions(-)
 create mode 100644 libibverbs/cmd_qp.c
 create mode 100644 libibverbs/cmd_srq.c
 create mode 100644 libibverbs/cmd_wq.c

-- 
1.8.3.1

