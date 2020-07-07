Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21122178A4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGGUMn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGUMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5BC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so46549671wrw.12
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPjc1QiDkpaQJ6gj5QOnEN0IMsVli0wQ5gnB2ck1gMU=;
        b=EQACmdsr4BPtlAJqkzr9R5XdvYuqjZDGUJpcqynaR9dnUXl02uFKttw6FBlNs0dXdM
         F1WA5lhOXW8PWkJRtyNj9enm/04MG/SPTWbLk/B/DWmB8NUidBzFoxhIh+yWwjOicU8d
         l0HLk/Ns1FQJNcp2mnNmbINTdJZngyt/vHHzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPjc1QiDkpaQJ6gj5QOnEN0IMsVli0wQ5gnB2ck1gMU=;
        b=TMZtymUzmRQ0VNIeaK8T+DAKAjDa0qNsLiedR3Nbk0/qOIChjT+44lWc0u6LEi8osE
         0Ea6zo15uhKFGbyYWJwktzunWIlthiYpTPexGcgQPXxthOtMFmElrWTMygE4F26RtoLx
         vN5m6HBfTByUtp4r5RZALSZ6XSBaVDLSY1+1kPrUmIwsHqzZIp1dCgeBAh0qCjc19kEg
         RroCTZNcV4ZFR6yuU9bipTo+QrUZR9sJ3CJZADBxleOrkvmV/b2BvOB2Rt+yFaQyFnjt
         ro8Y+Oodi+jupAMdRhQ34Y2Dnzv8MB5g1+ZHHRcL+mxq7iyyRoBRfVkvFNYwH6Kx+LlR
         YaMw==
X-Gm-Message-State: AOAM5310KtFQWd5RT5xCgOZkYMkrES29mVr3D+nWbb/d/wzMKIfFhbC8
        ICYZpcdAFCBOGcvV0R3w8FY+QwsZDqc=
X-Google-Smtp-Source: ABdhPJzP+3waGhBq+3r68iTg+28anENV8Lyik0jqTsjw13d4CVIDG3/NEfzcHUaOmSNhle7ELZ4b7A==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr54730638wra.165.1594152760781;
        Tue, 07 Jul 2020 13:12:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:40 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 00/25] dma-fence annotations, round 3
Date:   Tue,  7 Jul 2020 22:12:04 +0200
Message-Id: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Bunch of changes that might matter:

- Clarification that dma_fences are for drivers/gpu, requested by Jason
  Gunthorpe.

- New patch to list all the past discussions around
  indefinite/future/whatever fences, and why this (sadly) still just plain
  doesn't work. Came up again when discussing this stuff, I'd like to just
  be able to point at some doc going forward.

- I rolled dma-fence critical section annotations to (almost, vc4, nouveau
  and i915 have a bit too much custom commit functions) atomic kms
  drivers. Really looking for some serious testing with these, aside from
  the amdgpu atomic commit issues we've also found some problems in vmwgfx
  commit code. All real issues, and noted in the patches.

After the modeset stuff there's still the drm/scheduler annotations.
Testing with other drivers than amdgpu using the drm scheduler would be
very much welcome.

Then the usual pile of amdgpu hacks that I used for developing this. That
stuff isn't for merging, I'm hoping amd is working on proper patches for
these things.

Testing for this series means, especially for the atomic kms drivers:
- build with CONFIG_PROVE_LOCKING
- run the kms_atomic igt, that one actually uses atomic in&out fences -
  withotu these it's only half the fun
- run anything else you feel like which might use fences, like your
  rendering driver. You do have testcases for that right :-)

The mmu notifier annotation integration landed in -mm for a few days
meanwhile, but I busted it pretty bad. That one needs more baking, I'm
trying to figure out how to write unit tests for these annotations so I'm
not blowing them up all the time.

Also I think it'd be nice if we could start merging some of the earlier
stuff maybe, that doest start to feel solid (at least to me).

Review, commenst and testing on drivers as per above very much welcome.

Thanks, Daniel

Daniel Vetter (25):
  dma-fence: basic lockdep annotations
  dma-fence: prime lockdep annotations
  dma-buf.rst: Document why idenfinite fences are a bad idea
  drm/vkms: Annotate vblank timer
  drm/vblank: Annotate with dma-fence signalling section
  drm/amdgpu: add dma-fence annotations to atomic commit path
  drm/komdea: Annotate dma-fence critical section in commit path
  drm/malidp: Annotate dma-fence critical section in commit path
  drm/atmel: Use drm_atomic_helper_commit
  drm/imx: Annotate dma-fence critical section in commit path
  drm/omapdrm: Annotate dma-fence critical section in commit path
  drm/rcar-du: Annotate dma-fence critical section in commit path
  drm/tegra: Annotate dma-fence critical section in commit path
  drm/tidss: Annotate dma-fence critical section in commit path
  drm/tilcdc: Use standard drm_atomic_helper_commit
  drm/atomic-helper: Add dma-fence annotations
  drm/scheduler: use dma-fence annotations in main thread
  drm/amdgpu: use dma-fence annotations in cs_submit()
  drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
  drm/amdgpu: DC also loves to allocate stuff where it shouldn't
  drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
  drm/scheduler: use dma-fence annotations in tdr work
  drm/amdgpu: use dma-fence annotations for gpu reset code
  Revert "drm/amdgpu: add fbdev suspend/resume on gpu reset"
  drm/amdgpu: gpu recovery does full modesets

 Documentation/driver-api/dma-buf.rst          |  82 +++++++
 drivers/dma-buf/dma-fence.c                   | 207 ++++++++++++++++++
 drivers/dma-buf/dma-resv.c                    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |   3 +
 drivers/gpu/drm/arm/malidp_drv.c              |   3 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  96 +-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |   4 -
 drivers/gpu/drm/drm_atomic_helper.c           |  16 ++
 drivers/gpu/drm/drm_vblank.c                  |   8 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |   2 +
 drivers/gpu/drm/omapdrm/omap_drv.c            |   9 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         |   2 +
 drivers/gpu/drm/scheduler/sched_main.c        |  11 +
 drivers/gpu/drm/tegra/drm.c                   |   3 +
 drivers/gpu/drm/tidss/tidss_kms.c             |   4 +
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  47 +---
 drivers/gpu/drm/virtio/virtgpu_display.c      |  20 --
 drivers/gpu/drm/vkms/vkms_crtc.c              |   8 +-
 include/linux/dma-fence.h                     |  13 ++
 27 files changed, 421 insertions(+), 182 deletions(-)

-- 
2.27.0

