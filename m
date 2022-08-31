Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FB5A81CF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiHaPlc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiHaPkz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 11:40:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D335A836;
        Wed, 31 Aug 2022 08:40:15 -0700 (PDT)
Received: from dimapc.. (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DA906601EAB;
        Wed, 31 Aug 2022 16:39:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661960398;
        bh=ZApSbqO1FjV2w77zy5U4R3HD15M9STCl+wb5U44H4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8zRYWTRNkBNWGT26wLdHkOjb+QLle2qMZB0VpEhsnVL5lE3kgZrv/iM6C2f9B4fd
         P9X6CMh7Cfz8ATl64IX7dIUtyuzW8+xjOGv1ZR0O3dG87VIJX3UMwxE5fmAUFzt4EB
         7yIhl9XIUrKUBpbjdOuzYBHKoXnQDcON3d742kO+Z0m/+f92IoSv4zHVktRjLT7biX
         0rRP6pvDVRfV6QX0rCrjPGEeC0fVEtmFk7LfGf5Z7ZRKxMxpqQ2EHi9kAhVYt0Mc4t
         TnUySs7YPa7DjGLVd7e3tdNShYLEIo6U173RqyLqrk/v+EebpiegL610LyUTF/vHcR
         ZDZKPaW5A7b0A==
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
Subject: [PATCH v4 14/21] media: tegra-vde: Prepare to dynamic dma-buf locking specification
Date:   Wed, 31 Aug 2022 18:37:50 +0300
Message-Id: <20220831153757.97381-15-dmitry.osipenko@collabora.com>
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

Prepare Tegra video decoder driver to the common dynamic dma-buf
locking convention by starting to use the unlocked versions of dma-buf
API functions.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c b/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
index 69c346148070..1c5b94989aec 100644
--- a/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
+++ b/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
@@ -38,7 +38,7 @@ static void tegra_vde_release_entry(struct tegra_vde_cache_entry *entry)
 	if (entry->vde->domain)
 		tegra_vde_iommu_unmap(entry->vde, entry->iova);
 
-	dma_buf_unmap_attachment(entry->a, entry->sgt, entry->dma_dir);
+	dma_buf_unmap_attachment_unlocked(entry->a, entry->sgt, entry->dma_dir);
 	dma_buf_detach(dmabuf, entry->a);
 	dma_buf_put(dmabuf);
 
@@ -102,7 +102,7 @@ int tegra_vde_dmabuf_cache_map(struct tegra_vde *vde,
 		goto err_unlock;
 	}
 
-	sgt = dma_buf_map_attachment(attachment, dma_dir);
+	sgt = dma_buf_map_attachment_unlocked(attachment, dma_dir);
 	if (IS_ERR(sgt)) {
 		dev_err(dev, "Failed to get dmabufs sg_table\n");
 		err = PTR_ERR(sgt);
@@ -152,7 +152,7 @@ int tegra_vde_dmabuf_cache_map(struct tegra_vde *vde,
 err_free:
 	kfree(entry);
 err_unmap:
-	dma_buf_unmap_attachment(attachment, sgt, dma_dir);
+	dma_buf_unmap_attachment_unlocked(attachment, sgt, dma_dir);
 err_detach:
 	dma_buf_detach(dmabuf, attachment);
 err_unlock:
-- 
2.37.2

