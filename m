Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048161898D1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 11:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCRKDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 06:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgCRKDc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 06:03:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9376320768;
        Wed, 18 Mar 2020 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525811;
        bh=2jvpkOhPmcyW8OstKXxNTPwbQsamIqkKWw2AIV8xnFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=e8zO0/aa/Demz473/+X8wuQN3an0I0YShTi4fV0V7eG2aoS8o5YlB79DALfbh2Vuu
         C1hekjLkoxOgFujlGgew2imL+6kobpTaYHVwU4yPqBAxwcLoAV/4mDB+2/Ss8Q9aja
         68CEWuMCp1ld7pyNm/5y1ISLMwC1FhOUGkkZpkV4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Generally use the WC auto detection test result
Date:   Wed, 18 Mar 2020 12:03:23 +0200
Message-Id: <20200318100323.46659-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Now that we have direct and reliable detection of WC support by the
system, use is broadly. The only case we have to worry about is when the
WC autodetector cannot run.

For this fringe case generally assume that that WC is available, except
in the well defined case of no PAT support on x86 which is tested by
calling arch_can_pci_mmap_wc().

If WC is wrongly assumed to be available then it causes a small
performance hit on paths in userspace that are tuned to the assumption
that WC is available. There is no functional loss.

It is very unlikely that any platforms exist that lack WC and also care
about the micro optimization of WC in the fringe case where
autodetection does not work.

By removing the fairly bogus CONFIG tests this makes WC work broadly on
all arches and all platforms.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 16 ++++------------
 drivers/infiniband/hw/mlx5/mem.c  |  2 +-
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 66cd417f5d09..05804e4ba292 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -39,9 +39,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/bitmap.h>
-#if defined(CONFIG_X86)
-#include <asm/memtype.h>
-#endif
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
@@ -2146,14 +2143,6 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
 	switch (cmd) {
 	case MLX5_IB_MMAP_WC_PAGE:
 	case MLX5_IB_MMAP_ALLOC_WC:
-/* Some architectures don't support WC memory */
-#if defined(CONFIG_X86)
-		if (!pat_enabled())
-			return -EPERM;
-#elif !(defined(CONFIG_PPC) || (defined(CONFIG_ARM) && defined(CONFIG_MMU)))
-			return -EPERM;
-#endif
-	/* fall through */
 	case MLX5_IB_MMAP_REGULAR_PAGE:
 		/* For MLX5_IB_MMAP_REGULAR_PAGE do the best effort to get WC */
 		prot = pgprot_writecombine(vma->vm_page_prot);
@@ -2299,9 +2288,12 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 	command = get_command(vma->vm_pgoff);
 	switch (command) {
 	case MLX5_IB_MMAP_WC_PAGE:
+	case MLX5_IB_MMAP_ALLOC_WC:
+		if (!dev->wc_support)
+			return -EPERM;
+		/* fall through */
 	case MLX5_IB_MMAP_NC_PAGE:
 	case MLX5_IB_MMAP_REGULAR_PAGE:
-	case MLX5_IB_MMAP_ALLOC_WC:
 		return uar_mmap(dev, command, vma, context);

 	case MLX5_IB_MMAP_GET_CONTIGUOUS_PAGES:
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index b90a3649e7d1..c19ec9fd8a63 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -316,7 +316,7 @@ int mlx5_ib_test_wc(struct mlx5_ib_dev *dev)
 	if (!dev->mdev->roce.roce_en &&
 	    port_type_cap == MLX5_CAP_PORT_TYPE_ETH) {
 		if (mlx5_core_is_pf(dev->mdev))
-			dev->wc_support = true;
+			dev->wc_support = arch_can_pci_mmap_wc();
 		return 0;
 	}

--
2.24.1

