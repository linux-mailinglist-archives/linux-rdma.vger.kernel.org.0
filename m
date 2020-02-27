Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD217162F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 12:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgB0Lla (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 06:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgB0Lla (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 06:41:30 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC8624690;
        Thu, 27 Feb 2020 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582803689;
        bh=2vXL9vWvSuYntYV5/1CcHf3NXDnSdRfG48RpJ9xHzB4=;
        h=From:To:Cc:Subject:Date:From;
        b=KUY95CZ59cA0pBqbTa/BMtegTo/h5pt5lHcqI2KXB/5nb4O4WQ1yBMWZnfVsxkuao
         tMXQxsJde/qNen45hB+xPPE2mPlTQdkJKEKyIzefnX1eptVVoyhA58JlVXDT3OolCV
         0XSY69kjnbsOSEHLj+6xdr4e9skg+UZaPB6qzXKM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/odp: Ensure the mm is still alive before creating an implicit child
Date:   Thu, 27 Feb 2020 13:41:18 +0200
Message-Id: <20200227114118.94736-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Registration of a mmu_notifier requires the caller to hold a mmget() on
the mm as registration is not permitted to race with exit_mmap(). There is
a BUG_ON inside the mmu_notifier to guard against this.

Normally creating a umem is done against current which implicitly holds
the mmget(), however an implicit ODP child is created from a pagefault
work queue and is not guaranteed to have a mmget().

Call mmget() around this registration and abort faulting if the MM has
gone to exit_mmap().

Before the patch below the notifier was registered when the implicit ODP
parent was created, so there was no chance to register a notifier outside
of current.

Fixes: c571feca2dc9 ("RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index b8c657b28380..168f4f260c23 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -181,14 +181,27 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
 	odp_data->page_shift = PAGE_SHIFT;
 	odp_data->notifier.ops = ops;
 
+	/*
+	 * A mmget must be held when registering a notifier, the owming_mm only
+	 * has a mm_grab at this point.
+	 */
+	if (!mmget_not_zero(umem->owning_mm)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
 	odp_data->tgid = get_pid(root->tgid);
 	ret = ib_init_umem_odp(odp_data, ops);
-	if (ret) {
-		put_pid(odp_data->tgid);
-		kfree(odp_data);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto out_mm;
+	mmput(umem->owning_mm);
 	return odp_data;
+
+out_mm:
+	mmput(umem->owning_mm);
+out_free:
+	kfree(odp_data);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(ib_umem_odp_alloc_child);
 
-- 
2.24.1

