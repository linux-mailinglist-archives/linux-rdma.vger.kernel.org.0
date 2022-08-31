Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDADF5A81A3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiHaPkc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiHaPkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 11:40:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6ABB24;
        Wed, 31 Aug 2022 08:39:44 -0700 (PDT)
Received: from dimapc.. (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAE176601DF4;
        Wed, 31 Aug 2022 16:39:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661960382;
        bh=zNh//xUsR9gO6Pa17YYOufQr/5kZYwJDvTfSDOMKvjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJCGtZIIfrLTvH0IUhpK8WRZ7Udt9M91nUZFLNu5gw+APX3XfXzEfXbLmwe9px7IZ
         SszS4MzmoYZbVzk2XZJqsCgn/baTwXkFCH+wD9JWaNWByzmWYNIVrp6XT4AwyaEhEl
         7W0Z/z5BKz+/9r7fsbVaqvkzyRgAbKSWRzxcxraKqrfB173l+gJ7Tal8JoWiWPwvq6
         PSWSkqY1qaGJ0K09/f9HACABp3NsjzCQoHz3ETH2bpMK/Me0VEAiHKtJ3zpPSifbv+
         oVrI3BCDQ4BSy2Xuc8LFhkBP1hrfFJBcHchbythi7iaN8zCYPwmXQpFVDlEpDFm4Q4
         fIR7QTTM47FMA==
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
Subject: [PATCH v4 09/21] drm/etnaviv: Prepare to dynamic dma-buf locking specification
Date:   Wed, 31 Aug 2022 18:37:45 +0300
Message-Id: <20220831153757.97381-10-dmitry.osipenko@collabora.com>
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

Prepare Etnaviv driver to the common dynamic dma-buf locking convention
by starting to use the unlocked versions of dma-buf API functions.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 3fa2da149639..7031db145a77 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -65,7 +65,7 @@ static void etnaviv_gem_prime_release(struct etnaviv_gem_object *etnaviv_obj)
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(etnaviv_obj->vaddr);
 
 	if (etnaviv_obj->vaddr)
-		dma_buf_vunmap(etnaviv_obj->base.import_attach->dmabuf, &map);
+		dma_buf_vunmap_unlocked(etnaviv_obj->base.import_attach->dmabuf, &map);
 
 	/* Don't drop the pages for imported dmabuf, as they are not
 	 * ours, just free the array we allocated:
-- 
2.37.2

