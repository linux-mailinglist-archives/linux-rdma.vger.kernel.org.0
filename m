Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33D1C6A32
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEFHk5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEFHk5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:40:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B17C206E6;
        Wed,  6 May 2020 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588750856;
        bh=rV7aZak5AqnD+5AhswGadINNJStaaGc6tx8yuN814FU=;
        h=From:To:Cc:Subject:Date:From;
        b=ur08FJGXSnB4BZvSTadpOWbfF+SIFALSnYidQmpT/xtda8pHcPUmIYKbNheWZh3gs
         JujitoB4jB4dAORWfocuwYDsTrjFqv3H3U2STRxFqEjBa273FiifDChRJwpeflHvPD
         A4/i3ZJG7D+XjhqfwU9qsxwVtRIURhBtzAi6MmKg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@rimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/9] Enable asynchronous event FD per object
Date:   Wed,  6 May 2020 10:40:40 +0300
Message-Id: <20200506074049.8347-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Yishai:

This series enables applicable events objects (i.e. QP, SRQ, CQ, WQ) to
be created with their own asynchronous event FD.

Before this series any affiliated event on an object was reported on the
first asynchronous event FD that was created on the context without the
ability to create and use a dedicated FD for it.

With this series we enable granularity and control for the usage per
object, according to the application's usage.

For example, a secondary process that uses the same command FD as of the
master one, can create its own objects with its dedicated event FD to be
able to get the events for them once occurred, this couldn't be done before
this series.

To achieve the above, any 'create' method for the applicable objects was
extended to get from rdma-core its optional event FD, if wasn't supplied,
the default one from the context will be used.

As we prefer to not extend the 'write' mode KABIs anymore and fully
move to the 'ioct' mode, as part of this extension QP, SRQ and WQ
create/destroy commands were introduced over 'ioctl', the CQ KABI was
extended over its existing 'ioctl' create command.

As part of moving to 'ioctl' for the above objects the frame work was
improved to abort a fully created uobject upon some later error, some
flows were consolidated with the 'write' mode and few bugs were found
and fixed.

Yishai

Jason Gunthorpe (2):
  RDMA/core: Allow the ioctl layer to abort a fully created uobject
  RDMA/core: Consolidate ib_create_srq flows

Yishai Hadas (7):
  IB/uverbs: Refactor related objects to use their own asynchronous
    event FD
  IB/uverbs: Extend CQ to get its own asynchronous event FD
  IB/uverbs: Cleanup wq/srq context usage from uverbs layer
  IB/uverbs: Introduce create/destroy SRQ commands over ioctl
  IB/uverbs: Fix create WQ to use the given user handle
  IB/uverbs: Introduce create/destroy WQ commands over ioctl
  IB/uverbs: Introduce create/destroy QP commands over ioctl

 drivers/infiniband/core/Makefile              |   5 +-
 drivers/infiniband/core/rdma_core.c           |  28 +-
 drivers/infiniband/core/rdma_core.h           |   7 +-
 drivers/infiniband/core/uverbs.h              |  21 +-
 drivers/infiniband/core/uverbs_cmd.c          |  73 ++--
 drivers/infiniband/core/uverbs_ioctl.c        |  22 +-
 drivers/infiniband/core/uverbs_main.c         |  16 +-
 drivers/infiniband/core/uverbs_std_types.c    |  95 -----
 drivers/infiniband/core/uverbs_std_types_cq.c |  17 +-
 drivers/infiniband/core/uverbs_std_types_mr.c |  12 +-
 drivers/infiniband/core/uverbs_std_types_qp.c | 401 ++++++++++++++++++
 .../infiniband/core/uverbs_std_types_srq.c    | 233 ++++++++++
 drivers/infiniband/core/uverbs_std_types_wq.c | 194 +++++++++
 drivers/infiniband/core/uverbs_uapi.c         |   3 +
 drivers/infiniband/core/verbs.c               |  29 +-
 drivers/infiniband/hw/mlx5/devx.c             |  10 +-
 drivers/infiniband/hw/mlx5/main.c             |  24 +-
 drivers/infiniband/hw/mlx5/qos.c              |  13 +-
 include/rdma/ib_verbs.h                       |  32 +-
 include/rdma/uverbs_ioctl.h                   |   3 +
 include/rdma/uverbs_std_types.h               |   2 +-
 include/rdma/uverbs_types.h                   |   3 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  81 ++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  43 ++
 24 files changed, 1139 insertions(+), 228 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_qp.c
 create mode 100644 drivers/infiniband/core/uverbs_std_types_srq.c
 create mode 100644 drivers/infiniband/core/uverbs_std_types_wq.c

--
2.26.2

