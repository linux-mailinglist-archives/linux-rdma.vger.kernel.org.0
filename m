Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F39305FBD
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhA0PfO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235509AbhA0PDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E5632173E;
        Wed, 27 Jan 2021 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759644;
        bh=4Sqdlsh92EMYyLj8AgvH4d/ZESgPSlxIYRbjmde9zKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QowtCSzDmhQ9s0oLLOB/AF8mKvwdWOENuTVlUJXdBijvMGG+HCIxJ84vIg0RvoG2O
         BIRAA60WW1hEuZfjz04r8++uJnu0aoYKzYLrXFGU64er8h7Ab0vFdSIJY9qx4+/QbP
         3FT9e9/4REq+AA0rf3L9geQQKFMiTLVIlAlyiP35h3wpLiySu1q7JA89NbKNrksw61
         y/HZBTsLG+ybpRM0LsX9OcXfBwV0nq9PMRuj5f1rITp02PzItaZKrfEs0Xhkc8Ohe6
         JsgJLtTRIyiSnL0e0UKCt0mnPRH/ZSYVna1hl94QmEbiM/DSh87oCvLCRafitD02wr
         AJpjhHiEcpyuQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 09/10] IB/mlx4: Use port iterator and validation APIs
Date:   Wed, 27 Jan 2021 17:00:09 +0200
Message-Id: <20210127150010.1876121-10-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Use IB core provided routine to check if the port is valid or not and
to iterate over IB ports.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c  | 2 +-
 drivers/infiniband/hw/mlx4/sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index e3cd402c079a..f26a0d920842 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1699,7 +1699,7 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 	struct mlx4_dev *dev = (to_mdev(qp->device))->dev;
 	int is_bonded = mlx4_is_bonded(dev);

-	if (flow_attr->port < 1 || flow_attr->port > qp->device->phys_port_cnt)
+	if (!rdma_is_port_valid(qp->device, flow_attr->port))
 		return ERR_PTR(-EINVAL);

 	if (flow_attr->flags & ~IB_FLOW_ATTR_FLAGS_DONT_TRAP)
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 1b5891130aab..24ee79aa2122 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -798,7 +798,7 @@ static void unregister_pkey_tree(struct mlx4_ib_dev *device)

 int mlx4_ib_device_register_sysfs(struct mlx4_ib_dev *dev)
 {
-	int i;
+	unsigned int i;
 	int ret = 0;

 	if (!mlx4_is_master(dev->dev))
@@ -817,7 +817,7 @@ int mlx4_ib_device_register_sysfs(struct mlx4_ib_dev *dev)
 		goto err_ports;
 	}

-	for (i = 1; i <= dev->ib_dev.phys_port_cnt; ++i) {
+	rdma_for_each_port(&dev->ib_dev, i) {
 		ret = add_port_entries(dev, i);
 		if (ret)
 			goto err_add_entries;
--
2.29.2

