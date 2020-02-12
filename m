Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB10015A1F3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgBLH1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgBLH1P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:15 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E552073C;
        Wed, 12 Feb 2020 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492435;
        bh=WTOuxnAf69VZB6PWBFesvFHXvANz8qD+i2VaJTkqnOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJ8Kq33n6B8/PwPy+t9D9lrORLGqMq4TiEKntGn93uc7pOizbczAijDEouEGZiWpN
         0s15b+2B7cvfD/gTvc2QuvQNKhl0HwzbZBr9DdVt0TNuqRerdZ7VyIVmlw1OYzUq5z
         QYeIVpBKkMaP9ZVAaZosZIHHGJkvxlmVSPm1yWI4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 9/9] RDMA/mlx5: Prevent overflow in mmap offset calculations
Date:   Wed, 12 Feb 2020 09:26:35 +0200
Message-Id: <20200212072635.682689-10-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The cmd and index variables declared as u16 and the result is supposed
to be stored in u64. The C arithmetic rules doesn't promote "(index >>
8) << 16" to be u64 and leaves the end result to be u16.

Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e874d688d040..987bfdcd12a5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2283,8 +2283,8 @@ static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
 
 static u64 mlx5_entry_to_mmap_offset(struct mlx5_user_mmap_entry *entry)
 {
-	u16 cmd = entry->rdma_entry.start_pgoff >> 16;
-	u16 index = entry->rdma_entry.start_pgoff & 0xFFFF;
+	u64 cmd = (entry->rdma_entry.start_pgoff >> 16) & 0xFFFF;
+	u64 index = entry->rdma_entry.start_pgoff & 0xFFFF;
 
 	return (((index >> 8) << 16) | (cmd << MLX5_IB_MMAP_CMD_SHIFT) |
 		(index & 0xFF)) << PAGE_SHIFT;
-- 
2.24.1

