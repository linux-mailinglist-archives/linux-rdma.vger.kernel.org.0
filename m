Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E72F4B26
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 13:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbhAMMRt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 07:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbhAMMRt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 07:17:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 697D62076A;
        Wed, 13 Jan 2021 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610540229;
        bh=s82zac8l84x/ND2KOa0N4CVkY+n0CoSG+LO5fW0UsQU=;
        h=From:To:Cc:Subject:Date:From;
        b=jAubUXIctv0MoLTKQ7UO478mNt38XiBILMSParXMp5ykMkYZu+DdWX3Pvk8siH/F7
         eeNuv9J+FJPuPE4Zz0Edr3uaisj7dJwn9fKR8EgOu2EnEQQLYng8xvokQvveQRCk2W
         7HcYB7MKw7Ya8L0ULDHYzhTeF9PIHxQDw59dAsEoWY6Zf6ZEv8d1hmop81deWZB6Va
         tZ030K/RAQNsfWus+9H0/xZIMv/iaKNCQMP8QHjNdjOs3vvTibQHYT09+Yz1Hcybot
         xTWhH0rgYfNFqHBDf/miaMj3npK6DvRENsOEk1g4IFt2hSZYft0Np5KbJYMlXFn3Xf
         /PMc+Re4zwpcw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 0/5] Set of fixes
Date:   Wed, 13 Jan 2021 14:16:58 +0200
Message-Id: <20210113121703.559778-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Small set of fixes for -next, only Aharon's fix has potential to be
taken to the -rc.

Thanks

Aharon Landau (1):
  RDMA/umem: Avoid undefined behavior of rounddown_pow_of_two

Mark Bloch (1):
  RDMA/mlx5: Fix wrong free of blue flame register on error

Parav Pandit (3):
  IB/mlx5: Fix error unwinding when set_has_smi_cap fails
  IB/mlx5: Add mutex destroy call to cap_mask_mutex mutex
  IB/mlx5: Make function static

 drivers/infiniband/core/umem.c       |  2 +-
 drivers/infiniband/hw/mlx5/mad.c     |  4 ++--
 drivers/infiniband/hw/mlx5/main.c    | 15 +++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 --
 4 files changed, 10 insertions(+), 13 deletions(-)

--
2.29.2

