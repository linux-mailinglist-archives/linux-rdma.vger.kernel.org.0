Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D42273D3E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVI0r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgIVI0r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:26:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17F7239E5;
        Tue, 22 Sep 2020 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600763206;
        bh=+wLGhuvBipQJDc5R24NSR7JgfQiCe86ceunbt34Awi4=;
        h=From:To:Cc:Subject:Date:From;
        b=u3ihSVvhoihD45AS6xIW4tHGqrkE46WNYMoLUnolnrT47IFeLuCRt4GTm8e1E6kC/
         5QDAy1dhu3XHoYsev2HNdx2bFtBMGjhSFEeC7gMoC3buMI5Xhi9H/UhWEVnVl+jTCz
         ZPNPXb+K8Qr/9mX+Vzj/Is/OVVCCDq0rosJdUvFI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-next v2 0/4] Query GID table API
Date:   Tue, 22 Sep 2020 11:26:37 +0300
Message-Id: <20200922082641.2149549-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
 * Embedded RoCE protocol type into rdma_read_gid_attr_ndev_rcu
v1: https://lore.kernel.org/lkml/20200914111129.343651-1-leon@kernel.org
 * Moved git_type logic to cma_set_default_gid_type - Patch #2
 * Changed signature of rdma_query_gid_table - Patch #3
 * Changed i to be unsigned - Patch #3
 * Fixed multiplication overflow - Patch #4
v0: https://lore.kernel.org/lkml/20200910142204.1309061-1-leon@kernel.org

------------------------------------------------------------------------------

From Avihai,

When an application is not using RDMA CM and if it is using multiple RDMA
devices with one or more RoCE ports, finding the right GID table entry is
a long process.

For example, with two RoCE dual-port devices in a system, when IP
failover is used between two RoCE ports, searching a suitable GID
entry for a given source IP, matching netdevice of given RoCEv1/v2 type
requires iterating over all 4 ports * 256 entry GID table.

Even though the best first match GID table for given criteria is used,
when the matching entry is on the 4th port, it requires reading
3 ports * 256 entries * 3 files (GID, netdev, type) = 2304 files.

The GID table needs to be referred on every QP creation during IP
failover on other netdevice of an RDMA device.

In an alternative approach, a GID cache may be maintained and updated on
GID change event was reported by the kernel. However, it comes with below
two limitations:
(a) Maintain a thread per application process instance to listen and update
 the cache.
(b) Without the thread, on cache miss event, query the GID table. Even in
 this approach, if multiple processes are used, a GID cache needs to be
 maintained on a per-process basis. With a large number of processes,
 this method doesn't scale.

Hence, we introduce this series of patches, which introduces an API to
query the complete GID tables of an RDMA device, that returns all valid
GID table entries.

This is done through single ioctl, eliminating 2304 read, 2304 open and
2304 close system calls to just a total of 2 calls (one for each device).

While at it, we also introduce an API to query an individual GID entry
over ioctl interface, which provides all GID attributes information.

Thanks

Avihai Horon (4):
  RDMA/core: Change rdma_get_gid_attr returned error code
  RDMA/core: Modify enum ib_gid_type and enum rdma_network_type
  RDMA/core: Introduce new GID table query API
  RDMA/uverbs: Expose the new GID query API to user space

 drivers/infiniband/core/cache.c               |  81 +++++++-
 drivers/infiniband/core/cma.c                 |   4 +
 drivers/infiniband/core/cma_configfs.c        |   9 +-
 drivers/infiniband/core/sysfs.c               |   3 +-
 .../infiniband/core/uverbs_std_types_device.c | 193 +++++++++++++++++-
 drivers/infiniband/core/verbs.c               |   2 +-
 drivers/infiniband/hw/mlx5/cq.c               |   2 +-
 drivers/infiniband/hw/mlx5/main.c             |   4 +-
 drivers/infiniband/hw/qedr/verbs.c            |   4 +-
 include/rdma/ib_cache.h                       |   3 +
 include/rdma/ib_verbs.h                       |  19 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  16 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  14 ++
 13 files changed, 331 insertions(+), 23 deletions(-)

--
2.26.2

