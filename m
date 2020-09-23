Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8A3275DD5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIWQuV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 12:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIWQuV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 12:50:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5484B20791;
        Wed, 23 Sep 2020 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600879821;
        bh=6oFT3yqIM60YSBBhabwUJUzil0O8kbU7HRqvsfoe77A=;
        h=From:To:Cc:Subject:Date:From;
        b=GzLiAOdW+TC8+HJUOkIgC5MQTpVuykABH5awlJlFWoqSCOKLSCtm8T0AysZLEECrx
         BgEZkfmqi8U2usBIqFrvhPtx0u45AZGrlD3rA/7ne7NNyGvbaYBN1h5ZUMi/swYLm2
         suebdb4cqquJbQ27CnLjGXoKz7pUX03eVarFb8Mo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-next v3 0/4] Query GID table API
Date:   Wed, 23 Sep 2020 19:50:11 +0300
Message-Id: <20200923165015.2491894-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
 * Returned back port validity check, because we are using port number
 to check protocol type.
 * Removed check that interface is up from rdma_read_gid_attr_ndev_rcu(),
 without it, this API behaved differently from sysfs by not showing GIDs
 for interfaces that in DOWN state. We will send followup patch in next
 cycle to nullify GID in netdev_unregister event (not critical but better
 to have).
v2: https://lore.kernel.org/lkml/20200922082641.2149549-1-leon@kernel.org
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

 drivers/infiniband/core/cache.c               |  79 ++++++-
 drivers/infiniband/core/cma.c                 |   4 +
 drivers/infiniband/core/cma_configfs.c        |   9 +-
 drivers/infiniband/core/sysfs.c               |   3 +-
 .../infiniband/core/uverbs_std_types_device.c | 196 +++++++++++++++++-
 drivers/infiniband/core/verbs.c               |   2 +-
 drivers/infiniband/hw/mlx5/cq.c               |   2 +-
 drivers/infiniband/hw/mlx5/main.c             |   4 +-
 drivers/infiniband/hw/qedr/verbs.c            |   4 +-
 include/rdma/ib_cache.h                       |   3 +
 include/rdma/ib_verbs.h                       |  19 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  16 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  14 ++
 13 files changed, 332 insertions(+), 23 deletions(-)

--
2.26.2

