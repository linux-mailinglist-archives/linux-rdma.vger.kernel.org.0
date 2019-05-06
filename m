Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65D145B5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEFIEp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 04:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFIEp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 04:04:45 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77E1208C0;
        Mon,  6 May 2019 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557129884;
        bh=T4JfMikLbCh2U2OK3OAO2Tlan4ensLhM0Jdcnoxg4sU=;
        h=From:To:Cc:Subject:Date:From;
        b=OpOqRsp/4O/Nm4yqex57c0SSoOI28QarOMtyYi1iMBj+luyTy3GD8K+Y85rP8cmx5
         u9/inG/JIgFyvXgfFPks8LkT6zXI6g3uwc/TnZOjpKI9pSRVcRpw5hZgOhKfJIFJut
         CiT77zqgsgWjnzd6GUt0xnb0R/7cyFmDUdsxFrPc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-next] RDMA/mlx5: Remove MAYEXEC flag
Date:   Mon,  6 May 2019 10:45:56 +0300
Message-Id: <20190506074556.25066-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

MAYEXEC flag was mistakenly added in the commit cited
in fixes line.

Fixes: 4eb6ab13b991 ("RDMA: Remove rdma_user_mmap_page")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 692759914d20..5d922e684bf5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2073,7 +2073,7 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx5_ib_dev *dev,
 
 	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
 		return -EPERM;
-	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
+	vma->vm_flags &= ~VM_MAYWRITE;
 
 	if (!dev->mdev->clock_info)
 		return -EOPNOTSUPP;
-- 
2.20.1

