Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF639305FB8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA0PFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235240AbhA0PA4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:00:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B567207D8;
        Wed, 27 Jan 2021 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759615;
        bh=5RrZeRzyyqgONaEurLCI9VSNk2qxED+CmOh7EofRy8I=;
        h=From:To:Cc:Subject:Date:From;
        b=Gb11+dDZv9vBOt2fnzGmQz28oJgDlnZ32XysNPl2Oi9rAkEcsZs3iMphddErDsQiF
         1wcs0mq4ltlv6D08gT6x3e7funuKsr/iEEbP8tvcDBVtJWi1hRaWC8ia6kq5cNcUGH
         EyODeqvYLbrJzMyN/tsNlmgD6jnUqlar4SQllEOY7d7A7lNq2oRjHQvTUZ13zPO3tB
         tFDZSlSiA/STY16wZm6fesm/XnYT9ZMMWQ35znRcmmYTgOeKN3UDLk3l7jF9T2MLUs
         GWp080yA1i9L4ImzKtbuUZD2W8z5jGZShLRlhwgaRWs2QTP5eqDHotT3fVZi4VDMlJ
         u7bOG5xNqfRaw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 00/10] Various cleanups
Date:   Wed, 27 Jan 2021 17:00:00 +0200
Message-Id: <20210127150010.1876121-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Various simple cleanups to mlx4, mlx5 and core.

Parav Pandit (10):
  IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
  IB/mlx5: Avoid calling query device for reading pkey table length
  IB/mlx5: Support default partition key for representor port
  IB/mlx5: Improve query port for representor port
  RDMA/core: Introduce and use API to read port immutable data
  IB/mlx5: Use rdma_for_each_port for port iteration
  IB/mlx5: Return appropriate error code instead of ENOMEM
  IB/cm: Avoid a loop when device has 255 ports
  IB/mlx4: Use port iterator and validation APIs
  IB/core: Use valid port number to check link layer

 drivers/infiniband/core/cm.c         |   8 +-
 drivers/infiniband/core/device.c     |  14 +++
 drivers/infiniband/core/verbs.c      |   4 +-
 drivers/infiniband/hw/mlx4/main.c    |   2 +-
 drivers/infiniband/hw/mlx4/sysfs.c   |   4 +-
 drivers/infiniband/hw/mlx5/mad.c     |  10 +-
 drivers/infiniband/hw/mlx5/main.c    | 137 +++++++--------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   9 +-
 drivers/infiniband/hw/mlx5/odp.c     |   4 -
 drivers/infiniband/hw/mlx5/qp.c      |  20 ++--
 drivers/infiniband/hw/mlx5/wr.c      |   2 +-
 include/linux/mlx5/driver.h          |   8 --
 include/rdma/ib_verbs.h              |   3 +
 13 files changed, 84 insertions(+), 141 deletions(-)

--
2.29.2

