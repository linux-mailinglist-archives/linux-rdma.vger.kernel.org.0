Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1524942A3FF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhJLMLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 08:11:45 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:32241 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhJLMLl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 08:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1634040580; x=1665576580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSuVs5S6tnjWc3g6nyq5nGrnvDmj8HbW3uAg1PWAkhQ=;
  b=sfH3VjEu/bzhErZf2OlO8+3muI44Q7522Ub28RJ0RNPZtva0aChRbZYn
   2FEHEQOfV+nxm4ubTxRbj9vDUTjw7jTOo7Wm/iW14k2DwtYaV2wS90Vr7
   dwNHR82iDqwXcMqpki45xQO8nXaDuvJvl4sSrzEID0FBjKX6dq0CLELRe
   0=;
X-IronPort-AV: E=Sophos;i="5.85,367,1624320000"; 
   d="scan'208";a="964133445"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-ff3df2fe.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 12 Oct 2021 12:09:30 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-ff3df2fe.us-west-2.amazon.com (Postfix) with ESMTPS id D15B342017;
        Tue, 12 Oct 2021 12:09:26 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 12 Oct 2021 12:09:25 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Tue, 12 Oct 2021 12:09:21 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Firas Jahjah <firasj@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 2/3] RDMA/umem: Allow pinned dmabuf umem usage
Date:   Tue, 12 Oct 2021 15:09:02 +0300
Message-ID: <20211012120903.96933-3-galpress@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012120903.96933-1-galpress@amazon.com>
References: <20211012120903.96933-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce ib_umem_dmabuf_get_pinned() which allows the driver to get a
dmabuf umem which is pinned and does not require move_notify
callback implementation.
The returned umem is pinned and DMA mapped like standard cpu umems, and
is released through ib_umem_release() (incl. unpinning and unmapping).

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 51 +++++++++++++++++++++++++++
 include/rdma/ib_umem.h                | 12 +++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index c6e875619fac..4fd6abc4dd17 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -164,12 +164,63 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get);
 
+static void
+ib_umem_dmabuf_unsupported_move_notify(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+
+	ibdev_warn_ratelimited(umem_dmabuf->umem.ibdev,
+			       "Invalidate callback should not be called when memory is pinned\n");
+}
+
+static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
+	.allow_peer2peer = true,
+	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
+};
+
+struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
+						 unsigned long offset,
+						 size_t size, int fd,
+						 int access)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	int err;
+
+	umem_dmabuf = ib_umem_dmabuf_get(device, offset, size, fd, access,
+					 &ib_umem_dmabuf_attach_pinned_ops);
+	if (IS_ERR(umem_dmabuf))
+		return umem_dmabuf;
+
+	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
+	err = dma_buf_pin(umem_dmabuf->attach);
+	if (err)
+		goto err_release;
+	umem_dmabuf->pinned = 1;
+
+	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
+	if (err)
+		goto err_unpin;
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+
+	return umem_dmabuf;
+
+err_unpin:
+	dma_buf_unpin(umem_dmabuf->attach);
+err_release:
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+	ib_umem_release(&umem_dmabuf->umem);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned);
+
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	if (umem_dmabuf->pinned)
+		dma_buf_unpin(umem_dmabuf->attach);
 	dma_resv_unlock(dmabuf->resv);
 
 	dma_buf_detach(dmabuf, umem_dmabuf->attach);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 676c57f5ca80..db9b73e765c3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -40,6 +40,7 @@ struct ib_umem_dmabuf {
 	unsigned long first_sg_offset;
 	unsigned long last_sg_trim;
 	void *private;
+	u8 pinned : 1;
 };
 
 static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
@@ -140,6 +141,10 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 					  unsigned long offset, size_t size,
 					  int fd, int access,
 					  const struct dma_buf_attach_ops *ops);
+struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
+						 unsigned long offset,
+						 size_t size, int fd,
+						 int access);
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
@@ -180,6 +185,13 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
+						 unsigned long offset,
+						 size_t size, int fd,
+						 int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	return -EOPNOTSUPP;
-- 
2.33.0

