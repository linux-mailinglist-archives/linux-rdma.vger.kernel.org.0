Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F155801A9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiGYPVz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jul 2022 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiGYPVn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jul 2022 11:21:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95FD19018;
        Mon, 25 Jul 2022 08:20:51 -0700 (PDT)
Received: from dimapc.. (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 105BA66015C8;
        Mon, 25 Jul 2022 16:20:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658762449;
        bh=WDIIFq+FwvZE2r0LkWg7SRzWlcZ28eKnpAmrtcK8/Tw=;
        h=From:To:Cc:Subject:Date:From;
        b=fCTuAO8tPmjR8tSbNU7j5+ykPVxJHvHdPYqB/q+SO9WPw0GWAQAZkTjrZK8Ms+wxk
         G8rwf70tH+Z7xpEq8t/v+2fubGWelhddXEvkkJBM30fCF2yps5VAV7CIVdbtKRHH/w
         OMDdlnNZwyvWDn/TIT8zdX8oabwj94F+u00uDHGBHiSpimKonDm5oMmo+ApDHwm3EC
         dghjMfnSVgIYt6j+q/Nw01pS56Qm7i6GdsZfcBRRx9eD0F7n9BQjVuPuclpu0BAGPD
         CW1k5b1tcXd3QaLbqsMsOWWl5s6Kpo4O5oGyowxH7HT1f+It08Ez+VTu4+PAIC5gAI
         dmKpANkjOU+wQ==
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
Subject: [PATCH v2 0/5] Move all drivers to a common dma-buf locking convention
Date:   Mon, 25 Jul 2022 18:18:34 +0300
Message-Id: <20220725151839.31622-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

This series moves all drivers to a dynamic dma-buf locking specification.
From now on all dma-buf importers are made responsible for holding
dma-buf's reservation lock around all operations performed over dma-bufs
in accordance to the locking specification. This allows us to utilize
reservation lock more broadly around kernel without fearing of a potential
deadlocks.

This patchset passes all i915 selftests. It was also tested using VirtIO,
Panfrost, Lima and Tegra drivers. I tested cases of display+GPU,
display+V4L and GPU+V4L dma-buf sharing, which covers majority of kernel
drivers since rest of the drivers share same or similar code paths.

Changelog:

v2: - Changed locking specification to avoid problems with a cross-driver
      ww locking, like was suggested by Christian König. Now the attach/detach
      callbacks are invoked without the held lock and exporter should take the
      lock.

    - Added "locking convention" documentation that explains which dma-buf
      functions and callbacks are locked/unlocked for importers and exporters,
      which was requested by Christian König.

    - Added ack from Tomasz Figa to the V4L patches that he gave to v1.

Dmitry Osipenko (5):
  dma-buf: Add _unlocked postfix to function names
  drm/gem: Take reservation lock for vmap/vunmap operations
  dma-buf: Move all dma-bufs to dynamic locking specification
  media: videobuf2: Stop using internal dma-buf lock
  dma-buf: Remove internal lock

 Documentation/driver-api/dma-buf.rst          |   6 +
 drivers/dma-buf/dma-buf.c                     | 253 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   4 +-
 drivers/gpu/drm/armada/armada_gem.c           |  14 +-
 drivers/gpu/drm/drm_client.c                  |   4 +-
 drivers/gpu/drm/drm_gem.c                     |  24 ++
 drivers/gpu/drm/drm_gem_cma_helper.c          |   6 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c  |   6 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   6 +-
 drivers/gpu/drm/drm_prime.c                   |  12 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  14 +-
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  20 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c     |   8 +-
 drivers/gpu/drm/qxl/qxl_object.c              |  17 +-
 drivers/gpu/drm/qxl/qxl_prime.c               |   4 +-
 drivers/gpu/drm/tegra/gem.c                   |  27 +-
 drivers/infiniband/core/umem_dmabuf.c         |  11 +-
 .../common/videobuf2/videobuf2-dma-contig.c   |  26 +-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  23 +-
 .../common/videobuf2/videobuf2-vmalloc.c      |  17 +-
 .../platform/nvidia/tegra-vde/dmabuf-cache.c  |  12 +-
 drivers/misc/fastrpc.c                        |  12 +-
 drivers/xen/gntdev-dmabuf.c                   |  14 +-
 include/drm/drm_gem.h                         |   3 +
 include/linux/dma-buf.h                       |  71 ++---
 28 files changed, 372 insertions(+), 254 deletions(-)

-- 
2.36.1

