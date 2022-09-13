Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6555B7B70
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Sep 2022 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIMTb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIMTbf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 15:31:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21574B9A;
        Tue, 13 Sep 2022 12:30:00 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6B756602033;
        Tue, 13 Sep 2022 20:29:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663097398;
        bh=9SeFMAw05BZn16x/ElulgqR7Ax8eaKdCJvDDJbwzdLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V78M3Ys7tVW/6N/kFZRiBQ77zWDoUBgZXEOtUBIkqMXuwXCPPiqYgXXdzekdQF4/b
         A6WJ03WPgSwQj8m4js/VcDAlagUJt7hwRVw6mLP9/+OFNC7qrcFHlLJwqaKwMmNiGI
         4R1FksEUZXm4T9NzcpJFqwcvDq7mIDyUFoR/A9DxIjHVZwRE7jCMO0DsqlKO+CmYs0
         x3pbk+hugQOST7Xf+zmA88Hrq4mk0OH2vhbmBdex+ROA6zg02Uw1xeDXkvmip4V7yR
         jkxYRKhXXfwtt7DZ0VK+o0a0HyD7QWjQ+lh2nQW4fJyNDP/E5yWxOZseoIeXnReSlK
         CpUt4B3XILbuw==
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
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Ruhl Michael J <michael.j.ruhl@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 20/21] media: videobuf2: Stop using internal dma-buf lock
Date:   Tue, 13 Sep 2022 22:27:56 +0300
Message-Id: <20220913192757.37727-21-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913192757.37727-1-dmitry.osipenko@collabora.com>
References: <20220913192757.37727-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

All drivers that use dma-bufs have been moved to the updated locking
specification and now dma-buf reservation is guaranteed to be locked
by importers during the mapping operations. There is no need to take
the internal dma-buf lock anymore. Remove locking from the videobuf2
memory allocators.

Acked-by: Tomasz Figa <tfiga@chromium.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 11 +----------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 11 +----------
 drivers/media/common/videobuf2/videobuf2-vmalloc.c    | 11 +----------
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 79f4d8301fbb..555bd40fa472 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -382,18 +382,12 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
 	struct dma_buf_attachment *db_attach, enum dma_data_direction dma_dir)
 {
 	struct vb2_dc_attachment *attach = db_attach->priv;
-	/* stealing dmabuf mutex to serialize map/unmap operations */
-	struct mutex *lock = &db_attach->dmabuf->lock;
 	struct sg_table *sgt;
 
-	mutex_lock(lock);
-
 	sgt = &attach->sgt;
 	/* return previously mapped sg table */
-	if (attach->dma_dir == dma_dir) {
-		mutex_unlock(lock);
+	if (attach->dma_dir == dma_dir)
 		return sgt;
-	}
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
@@ -409,14 +403,11 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
 	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir,
 			    DMA_ATTR_SKIP_CPU_SYNC)) {
 		pr_err("failed to map scatterlist\n");
-		mutex_unlock(lock);
 		return ERR_PTR(-EIO);
 	}
 
 	attach->dma_dir = dma_dir;
 
-	mutex_unlock(lock);
-
 	return sgt;
 }
 
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 36ecdea8d707..36981a5b5c53 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -424,18 +424,12 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
 	struct dma_buf_attachment *db_attach, enum dma_data_direction dma_dir)
 {
 	struct vb2_dma_sg_attachment *attach = db_attach->priv;
-	/* stealing dmabuf mutex to serialize map/unmap operations */
-	struct mutex *lock = &db_attach->dmabuf->lock;
 	struct sg_table *sgt;
 
-	mutex_lock(lock);
-
 	sgt = &attach->sgt;
 	/* return previously mapped sg table */
-	if (attach->dma_dir == dma_dir) {
-		mutex_unlock(lock);
+	if (attach->dma_dir == dma_dir)
 		return sgt;
-	}
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
@@ -446,14 +440,11 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
 	/* mapping to the client with new direction */
 	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
 		pr_err("failed to map scatterlist\n");
-		mutex_unlock(lock);
 		return ERR_PTR(-EIO);
 	}
 
 	attach->dma_dir = dma_dir;
 
-	mutex_unlock(lock);
-
 	return sgt;
 }
 
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 7831bf545874..41db707e43a4 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -267,18 +267,12 @@ static struct sg_table *vb2_vmalloc_dmabuf_ops_map(
 	struct dma_buf_attachment *db_attach, enum dma_data_direction dma_dir)
 {
 	struct vb2_vmalloc_attachment *attach = db_attach->priv;
-	/* stealing dmabuf mutex to serialize map/unmap operations */
-	struct mutex *lock = &db_attach->dmabuf->lock;
 	struct sg_table *sgt;
 
-	mutex_lock(lock);
-
 	sgt = &attach->sgt;
 	/* return previously mapped sg table */
-	if (attach->dma_dir == dma_dir) {
-		mutex_unlock(lock);
+	if (attach->dma_dir == dma_dir)
 		return sgt;
-	}
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
@@ -289,14 +283,11 @@ static struct sg_table *vb2_vmalloc_dmabuf_ops_map(
 	/* mapping to the client with new direction */
 	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
 		pr_err("failed to map scatterlist\n");
-		mutex_unlock(lock);
 		return ERR_PTR(-EIO);
 	}
 
 	attach->dma_dir = dma_dir;
 
-	mutex_unlock(lock);
-
 	return sgt;
 }
 
-- 
2.37.3

