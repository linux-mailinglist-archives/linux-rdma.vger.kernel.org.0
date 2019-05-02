Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C493B11480
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBHsP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfEBHsO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:14 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B8220873;
        Thu,  2 May 2019 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783294;
        bh=xfSHzIfs9WXjZ+wX592Kd1n/935u8C/v7NHIgPkMPZg=;
        h=From:To:Cc:Subject:Date:From;
        b=Xsl4dn/nZUs94Q9N8tMUdillc6ALNlOQ0mng9/REssQXPi4fzj+n59ZG8CXmKh9cr
         QZR85FtaOq1ZEZFK4k3DjMMS6SxhsWNwbeORioGUF1cfCTpRQWhJXLL3VNTcpADu7G
         iKgLFgk53yaHryOwSO8VignElDlM4JzOPWj0XIoY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 0/7] Allow RoCE GID attribute netdev detachment
Date:   Thu,  2 May 2019 10:48:00 +0300
Message-Id: <20190502074807.26566-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v1 -> v2:
 * Resent
 v0 -> v1:
 * Fixed wrong RCU pointer access in patch "RDMA/core: Allow detaching
   gid attribute netdevice for RoCE"

-----------------------------------------------------------------------

From Parav,

This series covers following changes.

1. A fix in RXE to consider right reserved space of the netdev.
2. ib_cm to avoid accessing netdev of GID attribute.
3. Several RoCE drivers and net/smc needs to know the mac and vlan of
the GID entry.

Instead of open coded accessing netdev fields, we introduce an API
to get such fields filled up using new API rdma_read_gid_l2_fields().

4. When there is active traffic through a GID, a QP/AH holds reference
to this GID entry. GID entry holds reference to its attached netdevice.
Due to this when netdevice (such as vlan netdev) is deleted by admin user,
its refcount is not dropped.

Therefore, use netdev under rcu lock so that netdev reference can be
dropped when netdev and associated RoCE GID entry is deleted. This is
facilitated by existing API rdma_read_gid_attr_ndev_rcu.

Thanks


Parav Pandit (7):
  RDMA/rxe: Consider skb reserve space based on netdev of GID
  IB/cm: Reduce dependency on gid attribute ndev check
  RDMA: Introduce and use GID attr helper to read RoCE L2 fields
  RDMA/cma: Use rdma_read_gid_attr_ndev_rcu to access netdev
  RDMA/rxe: Use rdma_read_gid_attr_ndev_rcu to access netdev
  net/smc: Use rdma_read_gid_l2_fields to L2 fields
  RDMA/core: Allow detaching gid attribute netdevice for RoCE

 drivers/infiniband/core/addr.c             |   1 +
 drivers/infiniband/core/cache.c            | 117 +++++++++++++++++++--
 drivers/infiniband/core/cm.c               |   5 +-
 drivers/infiniband/core/cma.c              |  12 ++-
 drivers/infiniband/core/sysfs.c            |  13 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  18 ++--
 drivers/infiniband/hw/hns/hns_roce_ah.c    |  14 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   7 +-
 drivers/infiniband/hw/mlx4/ah.c            |   8 +-
 drivers/infiniband/hw/mlx4/qp.c            |   6 +-
 drivers/infiniband/hw/mlx5/main.c          |  42 ++------
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c   |   9 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c   |   7 +-
 drivers/infiniband/hw/qedr/qedr_roce_cm.c  |  11 +-
 drivers/infiniband/hw/qedr/verbs.c         |   5 +-
 drivers/infiniband/sw/rxe/rxe_net.c        |  18 +++-
 include/rdma/ib_cache.h                    |   4 +
 include/rdma/ib_verbs.h                    |   2 +-
 net/smc/smc_ib.c                           |  16 +--
 19 files changed, 221 insertions(+), 94 deletions(-)

--
2.20.1

