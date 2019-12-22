Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49086128DF3
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Dec 2019 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLVMqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Dec 2019 07:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLVMqz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Dec 2019 07:46:55 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60C1206D3;
        Sun, 22 Dec 2019 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577018814;
        bh=cwfZSeZ/IpayEhtozkIxcfS07JnNpS10UsC8ki0mgfg=;
        h=From:To:Cc:Subject:Date:From;
        b=kw4skJcAhR9+rOqALWjrCoMP3LAA7gggmSiA6s44w4L8yqYyPds/7tyaNpy8a4rCJ
         vkjH/tVH1mMHybq7Gwtyg8TE5rng6wJPIFTkbzPKt5zFkIpG694vaWysr+Mmaa5VPD
         LDE7hk7Ept1LOe13vI97wAAHvVvtgzkY+9M9npeE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc v1 0/3] ODP Fixes
Date:   Sun, 22 Dec 2019 14:46:46 +0200
Message-Id: <20191222124649.52300-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v0 -> v1: https://lore.kernel.org/linux-rdma/20191219134646.413164-1-leon@kernel.org
 * Added description of fix to patch #1
 * Added Jason's ROB tag to patch #2
 * Dropped changes in page fault handler in patch #3

-------------------------------------------------------------------------------------------
Please find below three patches that fix ODP flow.

Thanks

Artemy Kovalyov (1):
  IB/mlx5: Unify ODP MR code paths to allow extra flexibility

Yishai Hadas (2):
  IB/core: Fix ODP get user pages flow
  IB/core: Fix ODP with IB_ACCESS_HUGETLB handling

 drivers/infiniband/core/umem_odp.c   | 23 +++--------
 drivers/infiniband/hw/mlx5/mem.c     | 25 ------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 ++---
 drivers/infiniband/hw/mlx5/mr.c      | 58 +++++++++++-----------------
 drivers/infiniband/hw/mlx5/odp.c     | 42 +++++++++++++++++++-
 5 files changed, 72 insertions(+), 85 deletions(-)

--
2.20.1

