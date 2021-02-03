Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8524930DA7D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 14:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBCNCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 08:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhBCNCU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 08:02:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53B5A64F53;
        Wed,  3 Feb 2021 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357299;
        bh=CScKqiUnEi7TMKsGyKQ4F9LeCBAzg4D4jiIWJcy3d/U=;
        h=From:To:Cc:Subject:Date:From;
        b=PN3HNDugYZ4dLt+W79xv301s/GgpdTeYOj3NIfeDvTjax4VBMZoSxABuCRthf6ig+
         Oa6IvHcJkO8pFRaRfmQkCtlEwPNFMaiVJux0Kxvl65/j+esR+4c6kbruGUT4yCsBWM
         v0OjGXii1kdGhgFNcaWtyDEG5Yz4pOB1AOvBuZ8qXw7yIi/tnSqBMOQ+5KnOE2wgd0
         Ie1dkgLE3uwg0QmEwKGOWB8v1ldO+pFX0gZ47cxT2YSosRu2MgBhB80o8kTFk7alJO
         mtJ48DCOa3zxnIlvmxyT9g8pCq1JBUQUBCusg1pc25meDfFdounzjICIT+s25qF00p
         Mrg/CpVc8ZwkA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next v1 0/5] Various cleanups
Date:   Wed,  3 Feb 2021 15:01:28 +0200
Message-Id: <20210203130133.4057329-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Rebase
v0: https://lore.kernel.org/linux-rdma/20210127150010.1876121-1-leon@kernel.org

Parav Pandit (5):
  IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
  IB/mlx5: Avoid calling query device for reading pkey table length
  IB/mlx5: Improve query port for representor port
  RDMA/core: Introduce and use API to read port immutable data
  IB/mlx5: Use rdma_for_each_port for port iteration

 drivers/infiniband/core/device.c     |  14 +++
 drivers/infiniband/hw/mlx5/mad.c     |  10 +--
 drivers/infiniband/hw/mlx5/main.c    | 127 ++++++---------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   9 +-
 drivers/infiniband/hw/mlx5/qp.c      |  25 ++----
 drivers/infiniband/hw/mlx5/wr.c      |   2 +-
 include/linux/mlx5/driver.h          |   8 --
 include/rdma/ib_verbs.h              |   3 +
 8 files changed, 65 insertions(+), 133 deletions(-)

--
2.29.2

