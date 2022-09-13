Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5A5B7B21
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Sep 2022 21:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIMTa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIMT3c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 15:29:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B2574DEF;
        Tue, 13 Sep 2022 12:29:20 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D9E26602002;
        Tue, 13 Sep 2022 20:29:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663097359;
        bh=pCSmC3VPtA7CuegS38L6lty54ziB9yvQFvfJf8KB1ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YarCkar20kAqG3+1VkRt6R2uAtYr8CG7tRx1a1T8+zB7m/UTSW7eAZK5DQJypvU/D
         08tcY9EiseRoSDRJuc3NNPXvBx95BTJwZyUMZHpqIFxYCBCyV4TouAOh/URDQn5gmt
         Q1A9b54CsLGVqE+GX3GjFOD1MM4NCMpU3VJ6UmBRk4EWvtJn/v9SwrDH0usOWMH9WY
         Zo4wHy881VyHL8qtdjbahxbfNQhmB95faFl8YXOgeDzWs/hqbMKX/OvXlZS3d29tw7
         o5+gD9Kt/8jyM2rVqpOaIQAYhaSldsRGqeH2E5IjD5fcs7zqBFu8glSW/TqTlBv9Pc
         MjDH0B5C7kQDg==
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
Subject: [PATCH v5 12/21] xen/gntdev: Prepare to dynamic dma-buf locking specification
Date:   Tue, 13 Sep 2022 22:27:48 +0300
Message-Id: <20220913192757.37727-13-dmitry.osipenko@collabora.com>
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

Prepare gntdev driver to the common dynamic dma-buf locking convention
by starting to use the unlocked versions of dma-buf API functions.

Acked-by: Juergen Gross <jgross@suse.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/xen/gntdev-dmabuf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 940e5e9e8a54..4440e626b797 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -600,7 +600,7 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	gntdev_dmabuf->u.imp.attach = attach;
 
-	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
+	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(sgt)) {
 		ret = ERR_CAST(sgt);
 		goto fail_detach;
@@ -658,7 +658,7 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 fail_end_access:
 	dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs, count);
 fail_unmap:
-	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
+	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
 fail_detach:
 	dma_buf_detach(dma_buf, attach);
 fail_free_obj:
@@ -708,8 +708,8 @@ static int dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
 	attach = gntdev_dmabuf->u.imp.attach;
 
 	if (gntdev_dmabuf->u.imp.sgt)
-		dma_buf_unmap_attachment(attach, gntdev_dmabuf->u.imp.sgt,
-					 DMA_BIDIRECTIONAL);
+		dma_buf_unmap_attachment_unlocked(attach, gntdev_dmabuf->u.imp.sgt,
+						  DMA_BIDIRECTIONAL);
 	dma_buf = attach->dmabuf;
 	dma_buf_detach(attach->dmabuf, attach);
 	dma_buf_put(dma_buf);
-- 
2.37.3

