Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36515B7AC2
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Sep 2022 21:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIMT2Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIMT2W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 15:28:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C0273936;
        Tue, 13 Sep 2022 12:28:21 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 274456601F99;
        Tue, 13 Sep 2022 20:28:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663097298;
        bh=9oImKG94bbbgo9nd8m27hUQYenjRSdlmBmnPGzIeN6k=;
        h=From:To:Cc:Subject:Date:From;
        b=dbQW0xgBDdLNPsGVQlkFkGCHdOvAe058Q5LKJmed2tclljNUa4P+DpLazS3H4q4As
         WeTKi3VDEd3Z3KQcvOTSOAaZeqc3rQ8es/Z3RyxKjT5dXzqKJmNRhVhXdXJixL3l3l
         ASIgPf5jzJT7XFXEmsWTJm51ReLKtmFE82LvuV6ZPEu/r46ia7Lrm6/O8wdwwL5CSn
         1bGFNv70ufvYYdU84UPwfH0k1iUawn7M8XIw7UQq/arZTMfe4lSZtPgZ7cgr1QJRZy
         5vd4xVZJpsrWc2N7uj3ThsCKM4aCUqQPIdkJyFSNoIybNLg2znm3OPdqwmFJgl0+3/
         tfZUJWyVrZn/Q==
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
Subject: [PATCH v5 00/21] Move all drivers to a common dma-buf locking convention
Date:   Tue, 13 Sep 2022 22:27:36 +0300
Message-Id: <20220913192757.37727-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
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
dma-buf's reservation lock around all operations performed over dma-bufs
in accordance to the locking specification. This allows us to utilize
reservation lock more broadly around kernel without fearing of a potential
deadlocks.

This patchset passes all i915 selftests. It was also tested using VirtIO,
Panfrost, Lima, Tegra, udmabuf, AMDGPU and Nouveau drivers. I tested cases
of display+GPU, display+V4L and GPU+V4L dma-buf sharing (where appropriate),
which covers majority of kernel drivers since rest of the drivers share
same or similar code paths.

Changelog:

v5: - Added acks and r-bs that were given to v4.

    - Changed i915 preparation patch like was suggested by Michael Ruhl.
      The scope of reservation locking is smaller now.

v4: - Added dma_buf_mmap() to the "locking convention" documentation,
      which was missed by accident in v3.

    - Added acks from Christian König, Tomasz Figa and Hans Verkuil that
      they gave to couple v3 patches.

    - Dropped the "_unlocked" postfix from function names that don't have
      the locked variant, as was requested by Christian König.

    - Factored out the per-driver preparations into separate patches
      to ease reviewing of the changes, which is now doable without the
      global dma-buf functions renaming.

    - Factored out the dynamic locking convention enforcements into separate
      patches which add the final dma_resv_assert_held(dmabuf->resv) to the
      dma-buf API functions.

v3: - Factored out dma_buf_mmap_unlocked() and attachment functions
      into aseparate patches, like was suggested by Christian König.

    - Corrected and factored out dma-buf locking documentation into
      a separate patch, like was suggested by Christian König.

    - Intel driver dropped the reservation locking fews days ago from
      its BO-release code path, but we need that locking for the imported
      GEMs because in the end that code path unmaps the imported GEM.
      So I added back the locking needed by the imported GEMs, updating
      the "dma-buf attachment locking specification" patch appropriately.

    - Tested Nouveau+Intel dma-buf import/export combo.

    - Tested udmabuf import to i915/Nouveau/AMDGPU.

    - Fixed few places in Etnaviv, Panfrost and Lima drivers that I missed
      to switch to locked dma-buf vmapping in the drm/gem: Take reservation
      lock for vmap/vunmap operations" patch. In a result invalidated the
      Christian's r-b that he gave to v2.

    - Added locked dma-buf vmap/vunmap functions that are needed for fixing
      vmappping of Etnaviv, Panfrost and Lima drivers mentioned above.
      I actually had this change stashed for the drm-shmem shrinker patchset,
      but then realized that it's already needed by the dma-buf patches.
      Also improved my tests to better cover these code paths.

v2: - Changed locking specification to avoid problems with a cross-driver
      ww locking, like was suggested by Christian König. Now the attach/detach
      callbacks are invoked without the held lock and exporter should take the
      lock.

    - Added "locking convention" documentation that explains which dma-buf
      functions and callbacks are locked/unlocked for importers and exporters,
      which was requested by Christian König.

    - Added ack from Tomasz Figa to the V4L patches that he gave to v1.

Dmitry Osipenko (21):
  dma-buf: Add unlocked variant of vmapping functions
  dma-buf: Add unlocked variant of attachment-mapping functions
  drm/gem: Take reservation lock for vmap/vunmap operations
  drm/prime: Prepare to dynamic dma-buf locking specification
  drm/armada: Prepare to dynamic dma-buf locking specification
  drm/i915: Prepare to dynamic dma-buf locking specification
  drm/omapdrm: Prepare to dynamic dma-buf locking specification
  drm/tegra: Prepare to dynamic dma-buf locking specification
  drm/etnaviv: Prepare to dynamic dma-buf locking specification
  RDMA/umem: Prepare to dynamic dma-buf locking specification
  misc: fastrpc: Prepare to dynamic dma-buf locking specification
  xen/gntdev: Prepare to dynamic dma-buf locking specification
  media: videobuf2: Prepare to dynamic dma-buf locking specification
  media: tegra-vde: Prepare to dynamic dma-buf locking specification
  dma-buf: Move dma_buf_vmap() to dynamic locking specification
  dma-buf: Move dma_buf_attach() to dynamic locking specification
  dma-buf: Move dma_buf_map_attachment() to dynamic locking
    specification
  dma-buf: Move dma_buf_mmap() to dynamic locking specification
  dma-buf: Document dynamic locking convention
  media: videobuf2: Stop using internal dma-buf lock
  dma-buf: Remove obsoleted internal lock

 Documentation/driver-api/dma-buf.rst          |   6 +
 drivers/dma-buf/dma-buf.c                     | 211 +++++++++++++++---
 drivers/gpu/drm/armada/armada_gem.c           |   8 +-
 drivers/gpu/drm/drm_client.c                  |   4 +-
 drivers/gpu/drm/drm_gem.c                     |  24 ++
 drivers/gpu/drm/drm_gem_dma_helper.c          |   6 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c  |   6 +-
 drivers/gpu/drm/drm_gem_ttm_helper.c          |   9 +-
 drivers/gpu/drm/drm_prime.c                   |   6 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |  14 ++
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  16 +-
 drivers/gpu/drm/lima/lima_sched.c             |   4 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c     |   4 +-
 drivers/gpu/drm/panfrost/panfrost_dump.c      |   4 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |   6 +-
 drivers/gpu/drm/qxl/qxl_object.c              |  17 +-
 drivers/gpu/drm/qxl/qxl_prime.c               |   4 +-
 drivers/gpu/drm/tegra/gem.c                   |  17 +-
 drivers/infiniband/core/umem_dmabuf.c         |   7 +-
 .../common/videobuf2/videobuf2-dma-contig.c   |  22 +-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  19 +-
 .../common/videobuf2/videobuf2-vmalloc.c      |  17 +-
 .../platform/nvidia/tegra-vde/dmabuf-cache.c  |   6 +-
 drivers/misc/fastrpc.c                        |   6 +-
 drivers/xen/gntdev-dmabuf.c                   |   8 +-
 include/drm/drm_gem.h                         |   3 +
 include/linux/dma-buf.h                       |  17 +-
 29 files changed, 320 insertions(+), 155 deletions(-)

-- 
2.37.3

