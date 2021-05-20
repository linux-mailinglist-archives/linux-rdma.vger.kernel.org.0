Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9483338ABAE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbhETL0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 07:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241667AbhETLZS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 07:25:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 996F8613DB;
        Thu, 20 May 2021 10:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621505622;
        bh=S3gLhoo8Ondtb55yuwsITX8sRcnwOlVkrIyE435lzD8=;
        h=From:To:Cc:Subject:Date:From;
        b=WWv8AoyL8dnq8yQl0YC2rAiF45/PrMsS0iIOhK5XrB+8Seq0CcqfQbM/TA8/5rbdE
         2Ed7bqodJzk12UP3hC4IkSBBDzCTCmULqlEkw32Z8u22kbECFFZR76qVf0HKzL5Vek
         j+nFVcWTc23rxowxkWh3FlBBc/c7H4yAOouVQM6bEGNbfJiJD5K4lF43qwXJdgqMxj
         tfckYrjCWpN3EoWzMbnbOHIw6ppJlIIY1CwzDDl5s3V9eQfPmUtIqBdkWoJYAyHdVr
         Ks6Htsj8N/rHfTa/NkSF66OgzR13Bl3Q7Hff4YLr5BKTnz0wmgH+LbfgfXOuEOW+hg
         72SXh2vZIi+TA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Date:   Thu, 20 May 2021 13:13:34 +0300
Message-Id: <cover.1621505111.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Enabled by default RO in IB/core instead of changing all users
v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org

------------------------------------------------------------------------
From Avihai,

Relaxed Ordering is a PCIe mechanism that relaxes the strict ordering
imposed on PCI transactions, and thus, can improve performance for
applications that can handle this lack of strict ordering.

Currently, relaxed ordering can be set only by user space applications
for user MRs. Not all user space applications support relaxed ordering
and for this reason it was added as an optional capability that is
disabled by default. This behavior is not changed as part of this series,
and relaxed ordering remains disabled by default for user space.

On the other hand, kernel users should universally support relaxed
ordering, as they are designed to read data only after observing the CQE
and use the DMA API correctly. There are a few platforms with broken
relaxed ordering implementation, but for them relaxed ordering is expected
to be turned off globally in the PCI level. In addition, note that this is
not the first use of relaxed ordering. Relaxed ordering has been enabled
by default in mlx5 ethernet driver, and user space apps use it as well for
quite a while.

Hence, this series enabled relaxed ordering by default for kernel users so
they can benefit as well from the performance improvements.

The following test results show the performance improvement achieved
with relaxed ordering. The test was performed by running FIO traffic
between a NVIDIA DGX A100 (ConnectX-6 NICs and AMD CPUs) and a NVMe
storage fabric, using NFSoRDMA:

Without Relaxed Ordering:
READ: bw=16.5GiB/s (17.7GB/s), 16.5GiB/s-16.5GiB/s (17.7GB/s-17.7GB/s),
io=1987GiB (2133GB), run=120422-120422msec

With relaxed ordering:
READ: bw=72.9GiB/s (78.2GB/s), 72.9GiB/s-72.9GiB/s (78.2GB/s-78.2GB/s),
io=2367GiB (2542GB), run=32492-32492msec

The series has been tested over NVMe, iSER, SRP and NFS with ConnectX-6
NIC. The tests included FIO verify and stress tests, and various
resiliency tests (shutting down NIC port in the middle of traffic,
rebooting the target in the middle of traffic etc.).

Thanks

Avihai Horon (2):
  RDMA: Enable Relaxed Ordering by default for kernel ULPs
  RDMA/mlx5: Allow modifying Relaxed Ordering via fast registration

 drivers/infiniband/core/umem.c                |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          | 64 ++++++++++++++--
 drivers/infiniband/core/uverbs_std_types_mr.c | 21 ++++--
 drivers/infiniband/hw/mlx5/devx.c             | 10 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 10 ++-
 drivers/infiniband/hw/mlx5/mr.c               | 22 +++---
 drivers/infiniband/hw/mlx5/wr.c               | 74 ++++++++++++++-----
 include/rdma/ib_verbs.h                       | 68 ++++++++++++++++-
 8 files changed, 220 insertions(+), 51 deletions(-)

-- 
2.31.1

