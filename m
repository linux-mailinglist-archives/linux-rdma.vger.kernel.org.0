Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0483DA8
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 01:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfHFXQS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 19:16:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36951 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfHFXQR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 19:16:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so86458674qto.4
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjtpPFkSq3UiLsyLXzaYFfxy47hSUzru4mJ5ITxeLVU=;
        b=Aqt2P6wkNDk7Ey4zJ/R2dr20/+p+3YhHJwj0w4amgSQKlEOzS7bH+L1Oepqzsr46++
         aqXCSW5qQ+ZwByqVsAB+aLiCdaOPYHZoHMNlOBje6tt/3/uvpiTCTJbTvN+WthemRndl
         /kJKQxc7MJH2ISRonRwzYob3+PusKHZyNLKSSWfe24VwuwxIhBYqxbeduEP8ekflzqn+
         3yA1G3kjs09AVnNH83BdYQtbyyY6PmgYHmcfgbvOmvx4hl79v7MqlTCtxlX6HMoPt34s
         F8GhD+KbHjGiBPnxWQSt/UpHQqEubqay3aXPCjsT8vtbafoNOzsV5GtwtBxXRIkev7JZ
         fWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjtpPFkSq3UiLsyLXzaYFfxy47hSUzru4mJ5ITxeLVU=;
        b=ZqDVq8+CyA6Z/gduKmitPf9H6LtqUzkpmdvrsR9EgJ2F9XrnGONpkUHmgMsCFJa+Yi
         iBM2rdoNuBxGa8NvIDMFsDsp0m6SzJuzOFa6oYzER7t/t3XWEWVfjepWkPO25SnZ1SBa
         6zdy+nvLrdRlVMyMeDp8mc7VWGGbWJV2jgXMHpLybOKP6kZv/5BrTM0954/zOcgGvwum
         8efU+zxJ/UcTqMMgs1Q6BjqOOCGQa4SitCfn/nXDNFiW1cz6SPDMUvxqLSwiTTXIau1o
         cSCkTEHj8InGaFZcJjlU202lRhyNGM40TrTKJ48SrJBtBoUxyEJyV46d2M7vnGRrZovC
         Y8HA==
X-Gm-Message-State: APjAAAUvCdP7JCsHc1RxtFWyz/TROFf3webCABo5QZAuQWZg5HqhyCzM
        rt+GKq+X9hamIjwHwsP6VLmosw==
X-Google-Smtp-Source: APXvYqz63tweA2E8MzBrzK5yWz5htOs/6XLwX1oleep4fUjPNFszgc4r2awnmY97Q4W0cA2HokN6fA==
X-Received: by 2002:aed:2435:: with SMTP id r50mr1433667qtc.43.1565133376646;
        Tue, 06 Aug 2019 16:16:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x206sm40603751qkb.127.2019.08.06.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv8gg-0006es-Bw; Tue, 06 Aug 2019 20:16:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v3 hmm 07/11] RDMA/odp: remove ib_ucontext from ib_umem
Date:   Tue,  6 Aug 2019 20:15:44 -0300
Message-Id: <20190806231548.25242-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

At this point the ucontext is only being stored to access the ib_device,
so just store the ib_device directly instead. This is more natural and
logical as the umem has nothing to do with the ucontext.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem.c     |  4 ++--
 drivers/infiniband/core/umem_odp.c | 13 ++++++-------
 include/rdma/ib_umem.h             |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c59aa57d36510f..5ab9165ffbef0a 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -242,7 +242,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 			return ERR_PTR(-ENOMEM);
 	}
 
-	umem->context    = context;
+	umem->ibdev = context->device;
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = ib_access_writable(access);
@@ -370,7 +370,7 @@ void ib_umem_release(struct ib_umem *umem)
 		return;
 	}
 
-	__ib_umem_release(umem->context->device, umem, 1);
+	__ib_umem_release(umem->ibdev, umem, 1);
 
 	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
 	__ib_umem_release_tail(umem);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index a02e6e3d7b72fb..da72318e17592f 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -103,7 +103,7 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
 		 */
 		smp_wmb();
 		complete_all(&umem_odp->notifier_completion);
-		umem_odp->umem.context->device->ops.invalidate_range(
+		umem_odp->umem.ibdev->ops.invalidate_range(
 			umem_odp, ib_umem_start(umem_odp),
 			ib_umem_end(umem_odp));
 	}
@@ -116,7 +116,7 @@ static int invalidate_range_start_trampoline(struct ib_umem_odp *item,
 					     u64 start, u64 end, void *cookie)
 {
 	ib_umem_notifier_start_account(item);
-	item->umem.context->device->ops.invalidate_range(item, start, end);
+	item->umem.ibdev->ops.invalidate_range(item, start, end);
 	return 0;
 }
 
@@ -319,7 +319,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 	if (!umem_odp)
 		return ERR_PTR(-ENOMEM);
 	umem = &umem_odp->umem;
-	umem->context = context;
+	umem->ibdev = context->device;
 	umem->writable = ib_access_writable(access);
 	umem->owning_mm = current->mm;
 	umem_odp->is_implicit_odp = 1;
@@ -364,7 +364,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
 	umem = &odp_data->umem;
-	umem->context    = root->umem.context;
+	umem->ibdev = root->umem.ibdev;
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = root->umem.writable;
@@ -477,8 +477,7 @@ static int ib_umem_odp_map_dma_single_page(
 		u64 access_mask,
 		unsigned long current_seq)
 {
-	struct ib_ucontext *context = umem_odp->umem.context;
-	struct ib_device *dev = context->device;
+	struct ib_device *dev = umem_odp->umem.ibdev;
 	dma_addr_t dma_addr;
 	int remove_existing_mapping = 0;
 	int ret = 0;
@@ -691,7 +690,7 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 {
 	int idx;
 	u64 addr;
-	struct ib_device *dev = umem_odp->umem.context->device;
+	struct ib_device *dev = umem_odp->umem.ibdev;
 
 	virt = max_t(u64, virt, ib_umem_start(umem_odp));
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 1052d0d62be7d2..a91b2af64ec47b 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -42,7 +42,7 @@ struct ib_ucontext;
 struct ib_umem_odp;
 
 struct ib_umem {
-	struct ib_ucontext     *context;
+	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
 	size_t			length;
 	unsigned long		address;
-- 
2.22.0

