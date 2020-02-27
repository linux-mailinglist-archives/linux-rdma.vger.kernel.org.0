Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2968171624
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 12:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgB0Lij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 06:38:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgB0Lij (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 06:38:39 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D2224690;
        Thu, 27 Feb 2020 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582803519;
        bh=mtd9qpgUiU6N4wQBc9WIWkXfByz7o88hLKpjm2a1w3w=;
        h=From:To:Cc:Subject:Date:From;
        b=n9qmKzQDOYVZ1oMBL+iq3nv6vCAfuRsnI+bO7wP/gHW5Zyiso16m3tSrbl2d7vX+K
         p97mlDqjMhTipP4e4lj07iWVvWan7zd54MnU6p3ceawYXJsYHkgaIziOgk/hncZ+Gu
         1bCdOcDeokH80a0Uhr/p7Q+erkpfmmB9ppumfEgg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Prevent UMR usage with RO only when we have RO caps
Date:   Thu, 27 Feb 2020 13:38:34 +0200
Message-Id: <20200227113834.94233-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Relaxed ordering is not supported in UMR so we are disabling UMR usage
when user passes relaxed ordering access flag.

Enable using UMR when user requested relaxed ordering but there are no
relaxed ordering capabilities.
This will prevent user from unnecessarily registering a new mkey.

Fixes: d6de0bb1850f ("RDMA/mlx5: Set relaxed ordering when requested")
Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d9bffcc93587..f21d446249b8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1532,7 +1532,9 @@ static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
 	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
 		return false;
 
-	if (access_flags & IB_ACCESS_RELAXED_ORDERING)
+	if (access_flags & IB_ACCESS_RELAXED_ORDERING &&
+	    (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) ||
+	     MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read)))
 		return false;
 
 	return true;
-- 
2.24.1

