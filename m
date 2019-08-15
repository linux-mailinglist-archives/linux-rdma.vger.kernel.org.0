Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7028E6F7
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHOIik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIik (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:38:40 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969C22235C;
        Thu, 15 Aug 2019 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858319;
        bh=46Yq+zl//G7zUWKlqawAyH/NQ9s4IR+M2R0EUKgNFy0=;
        h=From:To:Cc:Subject:Date:From;
        b=X1U6NYg3ornT/BJcVK7ottML5nRkionXKC9lcY09R7UXfYDS7wlZgPck4xtYFU9Uy
         8NouAlMfNn8bAjXSJAXk6wLXaUzzaGF0bwOq+AednPx0UyymJHh5mCgW3SIP6RzDmF
         WhzFIp7vhBbxaZ+t7qQ2R+bLrvaxl6bKi8d4jK4Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 0/8] Fixes for v5.3
Date:   Thu, 15 Aug 2019 11:38:26 +0300
Message-Id: <20190815083834.9245-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is a collection of new fixes for v5.3, everything here is fixing
kernel crash or visible bug with one exception: patch #5 "IB/mlx5:
Consolidate use_umr checks into single function". That patch is nice
to have improvement to implement rest of the series.

Thanks

Ido Kalir (1):
  IB/core: Fix NULL pointer dereference when bind QP to counter

Jason Gunthorpe (1):
  RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB

Leon Romanovsky (2):
  RDMA/counters: Properly implement PID checks
  RDMA/restrack: Rewrite PID namespace check to be reliable

Moni Shoua (4):
  IB/mlx5: Consolidate use_umr checks into single function
  IB/mlx5: Report and handle ODP support properly
  IB/mlx5: Fix MR re-registration flow to use UMR properly
  IB/mlx5: Block MR WR if UMR is not possible

 drivers/infiniband/core/counters.c   | 10 ++++------
 drivers/infiniband/core/nldev.c      |  3 +--
 drivers/infiniband/core/restrack.c   | 15 +++++++--------
 drivers/infiniband/core/umem.c       |  7 +------
 drivers/infiniband/hw/mlx5/main.c    |  6 +++---
 drivers/infiniband/hw/mlx5/mem.c     |  5 +++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 ++++++++++++++
 drivers/infiniband/hw/mlx5/mr.c      |  7 +++----
 drivers/infiniband/hw/mlx5/odp.c     | 17 +++++++++--------
 drivers/infiniband/hw/mlx5/qp.c      | 24 +++++++++++++++++++-----
 include/rdma/restrack.h              |  3 +--
 11 files changed, 65 insertions(+), 46 deletions(-)

--
2.20.1

