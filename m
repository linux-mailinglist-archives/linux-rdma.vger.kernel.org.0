Return-Path: <linux-rdma+bounces-4155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F247B944ADE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCA2B2447C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9F1A0725;
	Thu,  1 Aug 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwCLvLdx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B6189B90;
	Thu,  1 Aug 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513947; cv=none; b=Pw3UnUym0o1WqAFDJdyhbiaWoFedzbWnokKGyErC/vnXXRi2oIr5dSTzHk5NihUJuE8jS+2/X9+GbyO9tMKlrQwel/YmmJCdF+4mCsonC0ZG4i+RWPrlVngHRzCkuG8x/3/k5mV/vfgofQ9Djc9okYIIFwJuU15Ui0aajuYhl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513947; c=relaxed/simple;
	bh=Lrwpx2uyOMMd30miKkZzGs29UF0PiPnGLNhz0BxCTdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6bbAFVZ1PpCA8XTxAEUmgzxn91d/ityqMTHS5sDWSpzNVOsCaJ592IxFKdm+mQqKfp2ZwrYHh4j2FFwCZ/jFXk1sSsUwGlJkUag2kPY6ZpKIqyPi568LIKsYdF99FAWbe+Su3qYIXdKwyWczItsVyugNRduTlSkGFfG6rsiDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwCLvLdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326DEC32786;
	Thu,  1 Aug 2024 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722513946;
	bh=Lrwpx2uyOMMd30miKkZzGs29UF0PiPnGLNhz0BxCTdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwCLvLdxcKpwb7cQ70CLYC6NFRTEF+QAC/gzwzp4xw5PgesySI7OoWnQUVVb+R1rK
	 ZwcCI0ocdUczf4Fmj8OpGqIbdDJ5saXfxCLVfeNWkYZO9jrSrZ/z2YdppZrmkGWaM9
	 DX8eT8AXuBJjqIfTEbGqYVl9QT17vPHC1SQO0Qf7ajeF7javo7gLVsqFeD3w+nbUKW
	 x+kFkd6LxG0b7WgGrlsTT0lMsgTQmFZlHVgIisqy3VXYMS7yMBclo2ZnJkfR9JgfzN
	 q4EEKDj9qEEDtL6IYqmuDOdnpBcdIBW8Ax0XJzY9cCNxqbqrwuEsJkVbbGySuz5KRy
	 /B1kEFuJPW2fQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 5/8] RDMA/umem: Introduce an option to revoke DMABUF umem
Date: Thu,  1 Aug 2024 15:05:14 +0300
Message-ID: <a38270f2fe4a194868ca2312f4c1c760e51bcbff.1722512548.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722512548.git.leon@kernel.org>
References: <cover.1722512548.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Introduce an option to revoke DMABUF umem.

This option will retain the umem allocation while revoking its DMA
mapping. Furthermore, any subsequent attempts to map the pages should
fail once the umem has been revoked.

This functionality will be utilized in the upcoming patches in the
series, where we aim to delay umem deallocation until the mkey
deregistration. However, we must unmap its pages immediately.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 21 +++++++++++++++++++--
 include/rdma/ib_umem.h                |  3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 726a09786547..9fcd37761264 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -23,6 +23,9 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 
 	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
 
+	if (umem_dmabuf->revoked)
+		return -EINVAL;
+
 	if (umem_dmabuf->sgt)
 		goto wait_fence;
 
@@ -242,15 +245,29 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned);
 
-void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
+void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
+	if (umem_dmabuf->revoked)
+		goto end;
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	if (umem_dmabuf->pinned)
+	if (umem_dmabuf->pinned) {
 		dma_buf_unpin(umem_dmabuf->attach);
+		umem_dmabuf->pinned = 0;
+	}
+	umem_dmabuf->revoked = 1;
+end:
 	dma_resv_unlock(dmabuf->resv);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke);
+
+void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	ib_umem_dmabuf_revoke(umem_dmabuf);
 
 	dma_buf_detach(dmabuf, umem_dmabuf->attach);
 	dma_buf_put(dmabuf);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index de05268ed632..7dc7b1cc71b5 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -38,6 +38,7 @@ struct ib_umem_dmabuf {
 	unsigned long last_sg_trim;
 	void *private;
 	u8 pinned : 1;
+	u8 revoked : 1;
 };
 
 static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
@@ -158,6 +159,7 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
@@ -217,6 +219,7 @@ static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 }
 static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
+static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */
 #endif /* IB_UMEM_H */
-- 
2.45.2


