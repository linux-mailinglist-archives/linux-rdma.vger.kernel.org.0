Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1924171229
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfGWG5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfGWG5j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:57:39 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2B42190F;
        Tue, 23 Jul 2019 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865058;
        bh=w/qoJErHWrpLoJKrNlTRV5k5XvMbDYauQ+7M4+2JLIM=;
        h=From:To:Cc:Subject:Date:From;
        b=M+q93qyK8fQi3nDD+YjCcxeWjBOQiFWCQKiymaCZaoMb9DGp2SttzL+UhTGVgzmn1
         o0tFjQseaCneHKGbcvqw3aVBqiiWXDpmYSy1jag4kOyr/WT3XVoUYbX/PrPZ9ztg41
         57k91qJUJgDSgDumRP4jEnQl6Hxks7gJ2lvA4H8s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 00/10] Collection of fixes for 5.3
Date:   Tue, 23 Jul 2019 09:57:23 +0300
Message-Id: <20190723065733.4899-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is small patch set of fixes targeted for 5.3 and stable@.

Thanks

Moni Shoua (1):
  IB/mlx5: Prevent concurrent MR updates during invalidation

Parav Pandit (4):
  RDMA/core: Annotate destroy of mutex to ensure that it is released as
    unlocked
  IB/mlx5: Avoid unnecessary typecast
  IB/core: Fix querying total rdma stats
  IB/counters: Initialize port counter and annotate mutex_destroy

Yishai Hadas (5):
  IB/mlx5: Fix unreg_umr to ignore the mkey state
  IB/mlx5: Use direct mkey destroy command upon UMR unreg failure
  IB/mlx5: Fix unreg_umr to set a device PD
  IB/mlx5: Fix clean_mr() to work in the expected order
  IB/mlx5: Fix RSS Toeplitz function to be specification aligned

 drivers/infiniband/core/cache.c        |  1 +
 drivers/infiniband/core/cma_configfs.c |  8 +++++++-
 drivers/infiniband/core/counters.c     | 19 +++++++++++--------
 drivers/infiniband/core/device.c       |  3 +++
 drivers/infiniband/core/user_mad.c     |  2 +-
 drivers/infiniband/core/uverbs_main.c  |  4 ++++
 drivers/infiniband/core/verbs.c        |  1 +
 drivers/infiniband/hw/mlx5/main.c      |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h   |  1 +
 drivers/infiniband/hw/mlx5/mr.c        | 23 ++++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c       |  3 ++-
 drivers/infiniband/hw/mlx5/qp.c        | 13 ++++++++-----
 12 files changed, 54 insertions(+), 26 deletions(-)

--
2.20.1

