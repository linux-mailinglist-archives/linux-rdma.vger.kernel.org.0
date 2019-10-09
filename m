Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9953ED13B6
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfJIQKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41785 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbfJIQKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so2701310qkg.8
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJG7hv+CyNvfYHoKUZ3QigHyCNK2PKFP5V5f0uI5xbg=;
        b=OqwyAGslcIddishmgENs6rvQ7bNG/4d9YqXWGOcmEjJAZMYZ0w0w529inj+kA1aP1S
         7jLhNug6CuanTN4EyMxpXbEgJYDZfXlYJ8VkLPhRdA/pZA3BvJS0LQE8183gdxSiwBg8
         a/+fyAzjlN9sZkZa7KLMvnqguuhbkgQxQOFIExK4D4yQw6iJB3sworI8GsyqICIGemRd
         6qZbotIOn73VIqHOhFtK6rNVLpKCObb+gSSAHgYJPclgSuI9tsSJOkqwv7pAFUnCTNwc
         4ARIcXh3PgdZKc3LcPi0KUiahenxuDUU6lcrSt7YkEg4MfRCua9U/xxCKfuqfW/Fi72x
         e4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJG7hv+CyNvfYHoKUZ3QigHyCNK2PKFP5V5f0uI5xbg=;
        b=mEg5lFvqzfaNrf9r6Xq1YebsgIB4Rd0bMlFZHVnmNHW7RIwOQRl5mE1zTXgeDCi2Zt
         oLcwZaZ8gFF6MY1suLhq9lNxoZKSqKVzrIs1/jtZ4HSUYrMZ7XUuMMhlx4FdWbI3dLfa
         IPghcNhdOoqT4IVf+1H/iGkNWB2Y1cHz45QqdhyLd+cRxPaFvYRVWDtesblBldBapkfn
         0fby+Gm8VnXIj6lxqZNtBRDa48c66EEaBKCdbf38VVJd+xpFNYgLQFsPJ1CkMgH1Sw7I
         AgDh+zHPChVSeXrSoGvLkvbw2wz46ty3je776hX7wo51RG1Bl1TlWV2FIMpjNP29XDL6
         RY1w==
X-Gm-Message-State: APjAAAV6rkLV+TTj9en/Q7ZiTdQGFWRa53IDg5tb/93jgcU7lIes26AD
        K/cAnGFKGoODsBWA/9jTV0UyJmZzm00=
X-Google-Smtp-Source: APXvYqznE2xKm303I+XK6HNIy/PdnAsyvwf/6LcuoM6qy+/g/QahLEc2FZ3k+0fI/GUYo52mkHXH6w==
X-Received: by 2002:a37:396:: with SMTP id 144mr4368194qkd.479.1570637409813;
        Wed, 09 Oct 2019 09:10:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c185sm1105216qkf.122.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000qy-1j; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 08/15] RDMA/mlx5: Split implicit handling from pagefault_mr
Date:   Wed,  9 Oct 2019 13:09:28 -0300
Message-Id: <20191009160934.3143-9-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The single routine has a very confusing scheme to advance to the next
child MR when working on an implicit parent. This scheme can only be used
when working with an implicit parent and must not be triggered when
working on a normal MR.

Re-arrange things by directly putting all the single-MR stuff into one
function and calling it in a loop for the implicit case. Simplify some of
the error handling in the new pagefault_real_mr() to remove unneeded gotos.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 125 +++++++++++++++++++------------
 1 file changed, 76 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 74f7caa9c99fb9..aba4f17c235467 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -629,33 +629,18 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 }
 
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
-static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
-			u32 *bytes_mapped, u32 flags)
+static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
+			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
+			     u32 flags)
 {
-	int npages = 0, current_seq, page_shift, ret, np;
-	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
+	int current_seq, page_shift, ret, np;
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	u64 access_mask;
 	u64 start_idx, page_mask;
-	struct ib_umem_odp *odp;
-	size_t size;
-
-	if (odp_mr->is_implicit_odp) {
-		odp = implicit_mr_get_data(mr, io_virt, bcnt);
-
-		if (IS_ERR(odp))
-			return PTR_ERR(odp);
-		mr = odp->private;
-	} else {
-		odp = odp_mr;
-	}
-
-next_mr:
-	size = min_t(size_t, bcnt, ib_umem_end(odp) - io_virt);
 
 	page_shift = odp->page_shift;
 	page_mask = ~(BIT(page_shift) - 1);
-	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
+	start_idx = (user_va - (mr->mmkey.iova & page_mask)) >> page_shift;
 	access_mask = ODP_READ_ALLOWED_BIT;
 
 	if (odp->umem.writable && !downgrade)
@@ -668,13 +653,10 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 	 */
 	smp_rmb();
 
-	ret = ib_umem_odp_map_dma_pages(odp, io_virt, size, access_mask,
-					current_seq);
-
-	if (ret < 0)
-		goto out;
-
-	np = ret;
+	np = ib_umem_odp_map_dma_pages(odp, user_va, bcnt, access_mask,
+				       current_seq);
+	if (np < 0)
+		return np;
 
 	mutex_lock(&odp->umem_mutex);
 	if (!ib_umem_mmu_notifier_retry(odp, current_seq)) {
@@ -699,31 +681,12 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 
 	if (bytes_mapped) {
 		u32 new_mappings = (np << page_shift) -
-			(io_virt - round_down(io_virt, 1 << page_shift));
-		*bytes_mapped += min_t(u32, new_mappings, size);
-	}
-
-	npages += np << (page_shift - PAGE_SHIFT);
-	bcnt -= size;
+			(user_va - round_down(user_va, 1 << page_shift));
 
-	if (unlikely(bcnt)) {
-		struct ib_umem_odp *next;
-
-		io_virt += size;
-		next = odp_next(odp);
-		if (unlikely(!next || ib_umem_start(next) != io_virt)) {
-			mlx5_ib_dbg(
-				mr->dev,
-				"next implicit leaf removed at 0x%llx. got %p\n",
-				io_virt, next);
-			return -EAGAIN;
-		}
-		odp = next;
-		mr = odp->private;
-		goto next_mr;
+		*bytes_mapped += min_t(u32, new_mappings, bcnt);
 	}
 
-	return npages;
+	return np << (page_shift - PAGE_SHIFT);
 
 out:
 	if (ret == -EAGAIN) {
@@ -742,6 +705,70 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 	return ret;
 }
 
+/*
+ * Returns:
+ *  -EFAULT: The io_virt->bcnt is not within the MR, it covers pages that are
+ *           not accessible, or the MR is no longer valid.
+ *  -EAGAIN/-ENOMEM: The operation should be retried
+ *
+ *  -EINVAL/others: General internal malfunction
+ *  >0: Number of pages mapped
+ */
+static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
+			u32 *bytes_mapped, u32 flags)
+{
+	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *child;
+	int npages = 0;
+
+	if (!odp->is_implicit_odp) {
+		if (unlikely(io_virt < ib_umem_start(odp) ||
+			     ib_umem_end(odp) - io_virt < bcnt))
+			return -EFAULT;
+		return pagefault_real_mr(mr, odp, io_virt, bcnt, bytes_mapped,
+					 flags);
+	}
+
+	if (unlikely(io_virt >= mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE ||
+		     mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE - io_virt < bcnt))
+		return -EFAULT;
+
+	child = implicit_mr_get_data(mr, io_virt, bcnt);
+	if (IS_ERR(child))
+		return PTR_ERR(child);
+
+	/* Fault each child mr that intersects with our interval. */
+	while (bcnt) {
+		u64 end = min_t(u64, io_virt + bcnt, ib_umem_end(child));
+		u64 len = end - io_virt;
+		int ret;
+
+		ret = pagefault_real_mr(child->private, child, io_virt, len,
+					bytes_mapped, flags);
+		if (ret < 0)
+			return ret;
+		io_virt += len;
+		bcnt -= len;
+		npages += ret;
+
+		if (unlikely(bcnt)) {
+			child = odp_next(child);
+			/*
+			 * implicit_mr_get_data sets up all the leaves, this
+			 * means they got invalidated before we got to them.
+			 */
+			if (!child || ib_umem_start(child) != io_virt) {
+				mlx5_ib_dbg(
+					mr->dev,
+					"next implicit leaf removed at 0x%llx.\n",
+					io_virt);
+				return -EAGAIN;
+			}
+		}
+	}
+	return npages;
+}
+
 struct pf_frame {
 	struct pf_frame *next;
 	u32 key;
-- 
2.23.0

