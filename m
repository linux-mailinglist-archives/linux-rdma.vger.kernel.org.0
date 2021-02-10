Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAC3169D8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 16:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBJPPI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 10:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhBJPPI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Feb 2021 10:15:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BDFE64DEC;
        Wed, 10 Feb 2021 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612970066;
        bh=ii66ci1wwtAsNnZPwdILdOlu6Vs5fajqRL3tNi1hIsE=;
        h=From:To:Cc:Subject:Date:From;
        b=HCQHFKP1wSd0bXI+KXYZ+uutevvCMWNvfeuBVMljkK7rrfqDqok4OK7TmJQxQ7d2S
         Ry8KftPp1Ysh4pGsKRe+Ky/XPu3oUpjhq4EaZxkxgMBnl9Gd9gsCGOjKHfx4PaNBQW
         +6G9i7ASp1nevVttlXYa2aFO6Vh7aUeN6RSnrvOTbnzu9hoaWkuFJH2VkuCZU4z7Hi
         o24aqgqq7ANY3uR/DMeghYI5Lj2cX0ii6lHB7oocq+IOeME1iOsndR3WP/LCjROLJT
         yrYzZYUZkLdoWuGbVOOYG+3ShuIjviLT0z7UG8tQJCN3pa/ugS7qaGqLaNQRkm1oNI
         aGu8ip8oUmeQQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH rdma-next] RDMA/core: Fix kernel doc warnings
Date:   Wed, 10 Feb 2021 17:14:21 +0200
Message-Id: <20210210151421.1108809-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

drivers/infiniband/core/device.c:859: warning: Function parameter or member 'dev' not described in 'ib_port_immutable_read'
drivers/infiniband/core/device.c:859: warning: Function parameter or member 'port' not described in 'ib_port_immutable_read'

Fixes: 7416790e2245 ("RDMA/core: Introduce and use API to read port immutable data")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 051c018fb73c..aac0fe14e1d9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -850,9 +850,9 @@ static int setup_port_data(struct ib_device *device)

 /**
  * ib_port_immutable_read() - Read rdma port's immutable data
- * @dev - IB device
- * @port - port number whose immutable data to read. It starts with index 1 and
- *         valid upto including rdma_end_port().
+ * @dev: IB device
+ * @port: port number whose immutable data to read. It starts with index 1 and
+ *        valid upto including rdma_end_port().
  */
 const struct ib_port_immutable*
 ib_port_immutable_read(struct ib_device *dev, unsigned int port)
--
2.29.2

