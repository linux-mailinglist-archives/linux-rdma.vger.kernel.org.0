Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C985D06
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfHHIjM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 04:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfHHIjM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 04:39:12 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D37214C6;
        Thu,  8 Aug 2019 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565253551;
        bh=o5PqNUXJmhUMHMkDA2T+kTIOSCIlP05poot3V5vhulw=;
        h=From:To:Cc:Subject:Date:From;
        b=wcCfGAgdOHHlANsyqYA2qmvfE1H6wjtdBOoFQeJ6fkKmOfcK3a7Jb6+x8VnFLr59R
         6JvHSlFd7mm+8u8ReXbrv07dcbtODLWxj2mnQJciynlY0rLUxPd0avIALP+y6bhhpr
         Lr+zZ46ej/sUQE1K/NZLk3CS4FF7fZiLRncTY6oI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/mlx5: Annotate lock dependency in unbinding slave port
Date:   Thu,  8 Aug 2019 11:39:07 +0300
Message-Id: <20190808083907.29316-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

NULL-ing notifier_call is performed under protection
of mlx5_ib_multiport_mutex lock. Such protection is
not easily spotted and better to be guarded by lockdep
annotation.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Based on -rc commit: 23eaf3b5c1a7 ("RDMA/mlx5: Release locks during notifier unregister")
---
 drivers/infiniband/hw/mlx5/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7933534be931..63969484421c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5835,6 +5835,8 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 	int err;
 	int i;

+	lockdep_assert_held(&mlx5_ib_multiport_mutex);
+
 	mlx5_ib_cleanup_cong_debugfs(ibdev, port_num);

 	spin_lock(&port->mp.mpi_lock);
--
2.20.1

