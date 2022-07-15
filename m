Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF86F5758B9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiGOAxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 20:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiGOAxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 20:53:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E6A491EC;
        Thu, 14 Jul 2022 17:53:19 -0700 (PDT)
Received: from dimapc.. (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56DEA6601A44;
        Fri, 15 Jul 2022 01:53:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657846397;
        bh=08a2nboQlEuWwlfAHFXkuoQn5obKyHZ/ZVFgCHrEt8s=;
        h=From:To:Cc:Subject:Date:From;
        b=VsAEIkbATEnA4Nbk3aERHQn8fLTLVUHNv8kWnssP/Qm3YXMVzWlFtWtdiMoahCGPS
         Kme2EsYIfptxjyFqr0HTYnhHM2YDrmur5rK32XO50Iv7OJMG9x+bqrwazS7dy309Hr
         1b+7CYfqa5NrdY/U09oRNR6aOmNsc2mF6BOnsa/ZBo+gnufnonFAu467YUDfXNnyVT
         2+7CcdCl1nQYdMBehjDmpbmWcCdsqMJ0HzNITuntSQayJH8o68ShuNneWHuMz+ft9f
         zsNlizMtyEmX65xBz2nEMDvbw5Q3Bpj+6ANqTt35ZjsRdjlP7HA6II7WWUrvegljIb
         rs2/bpj1V1R9Q==
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
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 0/6] Move all drivers to a common dma-buf locking convention
Date:   Fri, 15 Jul 2022 03:52:38 +0300
Message-Id: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
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

Hello,

This series moves all drivers to a dynamic dma-buf locking specification.
From now on all dma-buf importers are made responsible for holding
dma-buf's reservation lock around all operations performed over dma-bufs.
This common locking convention allows us to utilize reservation lock more
broadly around kernel without fearing of potential dead locks.

This patchset passes all i915 selftests. It was also tested using VirtIO,
Panfrost, Lima and Tegra drivers. I tested cases of display+GPU,
display+V4L and GPU+V4L dma-buf sharing, which covers majority of kernel
drivers since rest of the drivers share same or similar code paths.

This is a continuation of [1] where Christian König asked to factor out
the dma-buf locking changes into separate series.

[1] https://lore.kernel.org/dri-devel/20220526235040.678984-1-dmitry.osipenko@collabora.com/

Dmitry Osipenko (6):
  dma-buf: Add _unlocked postfix to function names
  drm/gem: Take reservation lock for vmap/vunmap operations
  dma-buf: Move all dma-bufs to dynamic locking specification
  dma-buf: Acquire wait-wound context on attachment
  media: videobuf2: Stop using internal dma-buf lock
  dma-buf: Remove internal lock

 drivers/dma-buf/dma-buf.c                     | 198 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   4 +-
 drivers/gpu/drm/armada/armada_gem.c           |  14 +-
 drivers/gpu/drm/drm_client.c                  |   4 +-
 drivers/gpu/drm/drm_gem.c                     |  28 +++
 drivers/gpu/drm/drm_gem_cma_helper.c          |   6 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c  |   6 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   6 +-
 drivers/gpu/drm/drm_prime.c                   |  12 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  20 +-
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |   6 +-
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  20 +-
 drivers/gpu/drm/i915/i915_gem_evict.c         |   2 +-
 drivers/gpu/drm/i915/i915_gem_ww.c            |  26 ++-
 drivers/gpu/drm/i915/i915_gem_ww.h            |  15 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c     |   8 +-
 drivers/gpu/drm/qxl/qxl_object.c              |  17 +-
 drivers/gpu/drm/qxl/qxl_prime.c               |   4 +-
 drivers/gpu/drm/tegra/gem.c                   |  27 +--
 drivers/infiniband/core/umem_dmabuf.c         |  11 +-
 .../common/videobuf2/videobuf2-dma-contig.c   |  26 +--
 .../media/common/videobuf2/videobuf2-dma-sg.c |  23 +-
 .../common/videobuf2/videobuf2-vmalloc.c      |  17 +-
 .../platform/nvidia/tegra-vde/dmabuf-cache.c  |  12 +-
 drivers/misc/fastrpc.c                        |  12 +-
 drivers/xen/gntdev-dmabuf.c                   |  14 +-
 include/drm/drm_gem.h                         |   3 +
 include/linux/dma-buf.h                       |  49 ++---
 32 files changed, 347 insertions(+), 257 deletions(-)

-- 
2.36.1

