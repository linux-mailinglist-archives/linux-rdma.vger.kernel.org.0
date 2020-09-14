Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98352689C2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgINLMV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgINLLh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:11:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CBB208DB;
        Mon, 14 Sep 2020 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600081896;
        bh=VgiBygJayp3Yq+rBv/px72wCsFME/htiIlDTHCnzEBI=;
        h=From:To:Cc:Subject:Date:From;
        b=JU1/kyI7oA9Ur2c1p8SNk1MQOEtAbo4NSdWqvSMIj4Ya7DUP4AskS4SHqdV2vD7Wm
         A+Mht9CPp+N79ZudRTFICIn5JLYc4DWS1s54pIBkabHtlYJVvskvLviunG6xpjP/50
         0J4XYdsoagqV/+A/jZk+AxHfM6leNmM8tnVE8nR0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-next v1 0/4] Query GID table API
Date:   Mon, 14 Sep 2020 14:11:25 +0300
Message-Id: <20200914111129.343651-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
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

 drivers/infiniband/core/cache.c               |  97 +++++++++-
 drivers/infiniband/core/cma.c                 |   4 +
 drivers/infiniband/core/cma_configfs.c        |   9 +-
 drivers/infiniband/core/sysfs.c               |   3 +-
 .../infiniband/core/uverbs_std_types_device.c | 182 +++++++++++++++++-
 drivers/infiniband/core/verbs.c               |   2 +-
 drivers/infiniband/hw/mlx5/cq.c               |   2 +-
 drivers/infiniband/hw/mlx5/main.c             |   4 +-
 drivers/infiniband/hw/qedr/verbs.c            |   4 +-
 include/rdma/ib_cache.h                       |   5 +
 include/rdma/ib_verbs.h                       |  19 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  16 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  14 ++
 13 files changed, 341 insertions(+), 20 deletions(-)

--
2.26.2

