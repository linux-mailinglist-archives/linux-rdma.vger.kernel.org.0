Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6A1263E2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSNqx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 08:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfLSNqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 08:46:51 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652232146E;
        Thu, 19 Dec 2019 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576763210;
        bh=dDUtTgXzHtKl3/y9Qxgqmda71eNaXErw4VOyD1sF6VU=;
        h=From:To:Cc:Subject:Date:From;
        b=uzvPmWx58guY2IZ2dsjbnANUUxdhAGSSt8j0ne9W431Zi/qRHLDqXp0m59bmIN9qF
         uchrVnIrPiZCTlAl+sb52wi6ZeEP97bjqhudjiLe+fgt2QJOUn+7O/Y5+yCKdWMXOh
         W88ojNNeM4r5D98ujSDhWv7bt2BHD97rL8hcNdKQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 0/3] ODP Fixes
Date:   Thu, 19 Dec 2019 15:46:43 +0200
Message-Id: <20191219134646.413164-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

Please find below three patches that fix ODP flow. The title of first
patch seems not -rc material, but implementation yes. The fact that we
unified code paths allowed us to fix some of the corner cases at the
same time.

Thanks

Artemy Kovalyov (1):
  IB/mlx5: Unify ODP MR code paths to allow extra flexibility

Yishai Hadas (2):
  IB/core: Fix ODP get user pages flow
  IB/core: Fix ODP with IB_ACCESS_HUGETLB handling

 drivers/infiniband/core/umem_odp.c   | 39 ++++++++++---------
 drivers/infiniband/hw/mlx5/mem.c     | 25 ------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 ++---
 drivers/infiniband/hw/mlx5/mr.c      | 58 +++++++++++-----------------
 drivers/infiniband/hw/mlx5/odp.c     | 42 +++++++++++++++++++-
 5 files changed, 87 insertions(+), 86 deletions(-)

--
2.20.1

