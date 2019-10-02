Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D93C8858
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfJBMZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfJBMZZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 08:25:25 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B9F21920;
        Wed,  2 Oct 2019 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570019125;
        bh=AS4zwuFwoep/SqEGDlUqpuLW0jqcZClkOMsEcfQBXJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5lGNWINTlFJC1UtrMiJztslw5su8J8s618DPlEtcLxG22iLxU3UaOwKS5T2jqOou
         bpyjQa+MW2FPsPAqMAe1efYg+wv2HHcbTVkT8kxN/yskuGL3OIQDH3O96vW5w/gPI3
         cE62PVBzaRbHSc1UsG4X5uDixt6ocbMizrH4mJ0c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 2/4] IB/mlx5: Remove unnecessary return statement
Date:   Wed,  2 Oct 2019 15:25:15 +0300
Message-Id: <20191002122517.17721-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002122517.17721-1-leon@kernel.org>
References: <20191002122517.17721-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

There is no reason to call return at the end of function which
returns void. Remove this unnecessary statement.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 2e9b43061797..95cf0249b015 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -359,8 +359,6 @@ void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 	    MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset) &&
 	    !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled))
 		caps->general_caps |= IB_ODP_SUPPORT_IMPLICIT;
-
-	return;
 }
 
 static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
-- 
2.20.1

