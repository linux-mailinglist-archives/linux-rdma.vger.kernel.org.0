Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDB8B58D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfHMK2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 06:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfHMK2U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 06:28:20 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024B720679;
        Tue, 13 Aug 2019 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565692099;
        bh=9IarA4/dtmRy3Y0wpO5y/wLrwDde6l1EnY14UDeXvz4=;
        h=From:To:Cc:Subject:Date:From;
        b=yiOINXvGkQN5m2/6P+Uu8x9HPIufY29pjpyESiritA59mo4aCM6JyaKnmFFmxuYiP
         FnEF9jmdR1LsnOTQMbAGty7AT5xYlZ6mKqNIval04HY7p/qFTK2IPO8CsKFIkw9oWP
         bECveEPF/9x5kaxdGx2R+n+TmFGng+fpyMU9ZFFQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next v1] RDMA/mlx5: Annotate lock dependency in bind/unbind slave port
Date:   Tue, 13 Aug 2019 13:28:14 +0300
Message-Id: <20190813102814.22350-1-leon@kernel.org>
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
 Changelog v1:
 * Removed comments as we added lockdep annotations
 * Added lockdep to bind port flow too
 * https://lore.kernel.org/linux-rdma/20190808083907.29316-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7933534be931..e3a57646ddd3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5825,7 +5825,6 @@ static void init_delay_drop(struct mlx5_ib_dev *dev)
 		mlx5_ib_warn(dev, "Failed to init delay drop debugfs\n");
 }

-/* The mlx5_ib_multiport_mutex should be held when calling this function */
 static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 				      struct mlx5_ib_multiport_info *mpi)
 {
@@ -5835,6 +5834,8 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 	int err;
 	int i;

+	lockdep_assert_held(&mlx5_ib_multiport_mutex);
+
 	mlx5_ib_cleanup_cong_debugfs(ibdev, port_num);

 	spin_lock(&port->mp.mpi_lock);
@@ -5884,13 +5885,14 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 	ibdev->port[port_num].roce.last_port_state = IB_PORT_DOWN;
 }

-/* The mlx5_ib_multiport_mutex should be held when calling this function */
 static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				    struct mlx5_ib_multiport_info *mpi)
 {
 	u8 port_num = mlx5_core_native_port_num(mpi->mdev) - 1;
 	int err;

+	lockdep_assert_held(&mlx5_ib_multiport_mutex);
+
 	spin_lock(&ibdev->port[port_num].mp.mpi_lock);
 	if (ibdev->port[port_num].mp.mpi) {
 		mlx5_ib_dbg(ibdev, "port %d already affiliated.\n",
--
2.20.1

