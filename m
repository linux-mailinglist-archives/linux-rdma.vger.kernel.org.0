Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15835A81E2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiHaPlj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiHaPlJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 11:41:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220AC76775;
        Wed, 31 Aug 2022 08:40:21 -0700 (PDT)
Received: from dimapc.. (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68D6C6601EBA;
        Wed, 31 Aug 2022 16:39:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661960395;
        bh=yuFPPZLpZu5HiT00pXyoIXNbNU+jh/z2zDqW9/uKf/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/B+b8bOYPtHEQfD37MFztmBLUQG1Fw59ElRW+eMzo5mBqnLPKKxtrTtpJ5b3A9Re
         TeoegHw8MNPuFRGxmerjQaX0cftS5KdDOB9bjKMJkW1d9QrMiRYxurgsUEY8dMXDlV
         gGytpQShxs12u0FLdR+l9TU5JAf3nC+nIGtzgJjObxtxJA5YlNZNeGstwA44tRjNIj
         LGz6cxeSNsncUszPcRWjDRSIZufs697VuN6aMG7EXTUJzbo5FFMYbEhJO0nPtrwhaa
         /H3pVyYysLeApxxArprlFRxS4YnCYkIqYz491f3i6b2n5C1Uoq4VSnPUybsmx9GWcd
         Z+ig7XvygSbGA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 13/21] media: videobuf2: Prepare to dynamic dma-buf locking specification
Date:   Wed, 31 Aug 2022 18:37:49 +0300
Message-Id: <20220831153757.97381-14-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Prepare V4L2 memory allocators to the common dynamic dma-buf locking
convention by starting to use the unlocked versions of dma-buf API
functions.

Acked-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 11 ++++++-----
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     |  8 ++++----
 drivers/media/common/videobuf2/videobuf2-vmalloc.c    |  6 +++---
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 678b359717c4..79f4d8301fbb 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -101,7 +101,7 @@ static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
 	if (buf->db_attach) {
 		struct iosys_map map;
 
-		if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
+		if (!dma_buf_vmap_unlocked(buf->db_attach->dmabuf, &map))
 			buf->vaddr = map.vaddr;
 
 		return buf->vaddr;
@@ -711,7 +711,7 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
 	}
 
 	/* get the associated scatterlist for this buffer */
-	sgt = dma_buf_map_attachment(buf->db_attach, buf->dma_dir);
+	sgt = dma_buf_map_attachment_unlocked(buf->db_attach, buf->dma_dir);
 	if (IS_ERR(sgt)) {
 		pr_err("Error getting dmabuf scatterlist\n");
 		return -EINVAL;
@@ -722,7 +722,8 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
 	if (contig_size < buf->size) {
 		pr_err("contiguous chunk is too small %lu/%lu\n",
 		       contig_size, buf->size);
-		dma_buf_unmap_attachment(buf->db_attach, sgt, buf->dma_dir);
+		dma_buf_unmap_attachment_unlocked(buf->db_attach, sgt,
+						  buf->dma_dir);
 		return -EFAULT;
 	}
 
@@ -750,10 +751,10 @@ static void vb2_dc_unmap_dmabuf(void *mem_priv)
 	}
 
 	if (buf->vaddr) {
-		dma_buf_vunmap(buf->db_attach->dmabuf, &map);
+		dma_buf_vunmap_unlocked(buf->db_attach->dmabuf, &map);
 		buf->vaddr = NULL;
 	}
-	dma_buf_unmap_attachment(buf->db_attach, sgt, buf->dma_dir);
+	dma_buf_unmap_attachment_unlocked(buf->db_attach, sgt, buf->dma_dir);
 
 	buf->dma_addr = 0;
 	buf->dma_sgt = NULL;
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index fa69158a65b1..36ecdea8d707 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -309,7 +309,7 @@ static void *vb2_dma_sg_vaddr(struct vb2_buffer *vb, void *buf_priv)
 
 	if (!buf->vaddr) {
 		if (buf->db_attach) {
-			ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
+			ret = dma_buf_vmap_unlocked(buf->db_attach->dmabuf, &map);
 			buf->vaddr = ret ? NULL : map.vaddr;
 		} else {
 			buf->vaddr = vm_map_ram(buf->pages, buf->num_pages, -1);
@@ -565,7 +565,7 @@ static int vb2_dma_sg_map_dmabuf(void *mem_priv)
 	}
 
 	/* get the associated scatterlist for this buffer */
-	sgt = dma_buf_map_attachment(buf->db_attach, buf->dma_dir);
+	sgt = dma_buf_map_attachment_unlocked(buf->db_attach, buf->dma_dir);
 	if (IS_ERR(sgt)) {
 		pr_err("Error getting dmabuf scatterlist\n");
 		return -EINVAL;
@@ -594,10 +594,10 @@ static void vb2_dma_sg_unmap_dmabuf(void *mem_priv)
 	}
 
 	if (buf->vaddr) {
-		dma_buf_vunmap(buf->db_attach->dmabuf, &map);
+		dma_buf_vunmap_unlocked(buf->db_attach->dmabuf, &map);
 		buf->vaddr = NULL;
 	}
-	dma_buf_unmap_attachment(buf->db_attach, sgt, buf->dma_dir);
+	dma_buf_unmap_attachment_unlocked(buf->db_attach, sgt, buf->dma_dir);
 
 	buf->dma_sgt = NULL;
 }
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 948152f1596b..7831bf545874 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -376,7 +376,7 @@ static int vb2_vmalloc_map_dmabuf(void *mem_priv)
 	struct iosys_map map;
 	int ret;
 
-	ret = dma_buf_vmap(buf->dbuf, &map);
+	ret = dma_buf_vmap_unlocked(buf->dbuf, &map);
 	if (ret)
 		return -EFAULT;
 	buf->vaddr = map.vaddr;
@@ -389,7 +389,7 @@ static void vb2_vmalloc_unmap_dmabuf(void *mem_priv)
 	struct vb2_vmalloc_buf *buf = mem_priv;
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
 
-	dma_buf_vunmap(buf->dbuf, &map);
+	dma_buf_vunmap_unlocked(buf->dbuf, &map);
 	buf->vaddr = NULL;
 }
 
@@ -399,7 +399,7 @@ static void vb2_vmalloc_detach_dmabuf(void *mem_priv)
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
 
 	if (buf->vaddr)
-		dma_buf_vunmap(buf->dbuf, &map);
+		dma_buf_vunmap_unlocked(buf->dbuf, &map);
 
 	kfree(buf);
 }
-- 
2.37.2

