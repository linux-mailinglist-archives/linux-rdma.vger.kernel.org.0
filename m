Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBDF3E56C6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhHJJZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 05:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238969AbhHJJZi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Aug 2021 05:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BC2E60F55;
        Tue, 10 Aug 2021 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628587516;
        bh=eHYXxeeTTCfLZWCr2FPYAisygIo3VzVBmpV01qv1r5s=;
        h=From:To:Cc:Subject:Date:From;
        b=ib2ODbgk/Zf1XANaJzh0QAgm52Vglsjf94B6af6dkjYhi4ApFLUbImQcwLY9kVl4v
         6ofhvVCqGPDXnlVa5FPsbhEdlMAkdK6jUmme3JRrpkL7FVMIps8LK9+6/c9i8ktYk3
         wfovRjMd2mELaooN3MxaB+iFL69zyGx6c+iw0FV7LlKSX10RiD+vOhZskusuVCUb9+
         +itbbZXfJ5y8E58Mmlasj69Al1Yk8IA5AGeFBwImSy1zfRpL52K7IXl2da4WzQhfX0
         +eNmZmUOJ4FYlWUY8R8fJVgPPZj2n/oLM8bTLZE13DAPvga3ryNOFbhcPKyNPdLCjY
         eAqur5Clrqsfg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix crash when unbind multiport slave
Date:   Tue, 10 Aug 2021 12:25:11 +0300
Message-Id: <17ec98989b0ba88f7adfbad68eb20bce8d567b44.1628587493.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Fix the below crash when delete slave from the unaffiliated list
twice. First time when the slave is bounded to the master and the
second when the slave is unloaded.

Fix it by checking if slave is unaffiliated (doesn't have ib device)
before removing from the list.

[ 5140.584361] RIP: 0010:mlx5r_mp_remove+0x4e/0xa0 [mlx5_ib]
[ 5140.595866] Call Trace:
[ 5140.596213]  auxiliary_bus_remove+0x18/0x30
[ 5140.596738]  __device_release_driver+0x177/x220
[ 5140.597304]  device_release_driver+0x24/0x30
[ 5140.597832]  bus_remove_device+0xd8/0x140
[ 5140.598339]  device_del+0x18a/0x3e0
[ 5140.598795]  mlx5_rescan_drivers_locked+0xa9/0x210 [mlx5_core]
[ 5140.599521]  mlx5_unregister_device+0x34/0x60 [mlx5_core]
[ 5140.600184]  mlx5_uninit_one+0x32/0x100 [mlx5_core]
[ 5140.600792]  remove_one+0x6e/0xe0 [mlx5_core]
[ 5140.601350]  pci_device_remove+0x36/0xa0
[ 5140.601846]  __device_release_driver+0x177/0x220
[ 5140.602408]  device_driver_detach+0x3c/0xa0
[ 5140.602931]  unbind_store+0x113/0x130
[ 5140.603400]  kernfs_fop_write_iter+0x110/0x1a0
[ 5140.603942]  new_sync_write+0x116/0x1a0
[ 5140.604428]  vfs_write+0x1ba/0x260
[ 5140.604873]  ksys_write+0x5f/0xe0
[ 5140.605310]  do_syscall_64+0x3d/0x90
[ 5140.605778]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 93f8244431ad ("RDMA/mlx5: Convert mlx5_ib to use auxiliary bus")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 094c976b1eed..2507051f7b89 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4454,7 +4454,8 @@ static void mlx5r_mp_remove(struct auxiliary_device *adev)
 	mutex_lock(&mlx5_ib_multiport_mutex);
 	if (mpi->ibdev)
 		mlx5_ib_unbind_slave_port(mpi->ibdev, mpi);
-	list_del(&mpi->list);
+	else
+		list_del(&mpi->list);
 	mutex_unlock(&mlx5_ib_multiport_mutex);
 	kfree(mpi);
 }
-- 
2.31.1

