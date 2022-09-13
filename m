Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3A5B7B5D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Sep 2022 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIMTb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIMTbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 15:31:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E371719;
        Tue, 13 Sep 2022 12:29:50 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 913356602006;
        Tue, 13 Sep 2022 20:29:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663097388;
        bh=1GtKrwThZVJsniK/ptiZT5S6PL4TRRG1YKxbwpZHIhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iahWG9QhacEAl4VINBeLXiSWEkk0ZfYsZ5ZMd/mQXxBuGVP3fwGIyCDEEPkTBklVw
         F2IrWL/57n6JO11EaSwKt//9LJZQW/Kp3LWtAkz+7MiidjvTgCSPiPu6hfBnckFqM6
         HMUILDoGsfxYprNWaR9CEbuzhEcV3N5Z/saNVT3ZKlwhtuwR3vzpnZ1mSrtMtYO5aN
         pU59cM86CUHdMdoE1HRBI22kpUd0rWKnUy+zMGElw8s+Iyzh6pj+QhIVfwqOcNzHem
         3f5fdgBRvLE5cFN+c19ZuXluy+hc9bcmmgg4KT7LtSexT8Wgg9sPLjQbskg3QEHod/
         HlVfpcq3uK5ZA==
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
Subject: [PATCH v5 18/21] dma-buf: Move dma_buf_mmap() to dynamic locking specification
Date:   Tue, 13 Sep 2022 22:27:54 +0300
Message-Id: <20220913192757.37727-19-dmitry.osipenko@collabora.com>
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

Move dma_buf_mmap() function to the dynamic locking specification by
taking the reservation lock. Neither of the today's drivers take the
reservation lock within the mmap() callback, hence it's safe to enforce
the locking.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/dma-buf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8873315d6edc..8821a3ad9530 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1390,6 +1390,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_end_cpu_access, DMA_BUF);
 int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 		 unsigned long pgoff)
 {
+	int ret;
+
 	if (WARN_ON(!dmabuf || !vma))
 		return -EINVAL;
 
@@ -1410,7 +1412,11 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	vma_set_file(vma, dmabuf->file);
 	vma->vm_pgoff = pgoff;
 
-	return dmabuf->ops->mmap(dmabuf, vma);
+	dma_resv_lock(dmabuf->resv, NULL);
+	ret = dmabuf->ops->mmap(dmabuf, vma);
+	dma_resv_unlock(dmabuf->resv);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, DMA_BUF);
 
-- 
2.37.3

