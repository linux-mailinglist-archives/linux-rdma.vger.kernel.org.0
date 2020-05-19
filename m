Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B421A1D97B0
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgESN2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESN2F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 09:28:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA547C08C5C0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 06:28:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so15928945wrr.4
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hM5OXAptbKPP/8+yKuT4RVgcPXCSJuvxjvItOcy5Ch4=;
        b=JUB9zXMhx3IM69uNuCaGPLpgNhM5ZRwyVZ5kb0gbG6jKM48juOC5th7p4u10t6jVoO
         YfTIxKkevTaESlEO462+goKgJtOvUNl34FxAkta5T0Nsb9E9KujbymSahURdiNV6u8ls
         BacBPl5XG/yx7XZo7SlEHPm6RYXO2+gzLmayU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hM5OXAptbKPP/8+yKuT4RVgcPXCSJuvxjvItOcy5Ch4=;
        b=lGBbnvJlVlte4alPOOT2aAlFI4KAGxlGmdBMfwY72M3tWoYbN35OxbFVxJDxqVRgZf
         +JtTV8scfYsrNzaTHv6o9yTR0HQJFawCnQuzlx+FdnqdxSNtRRR+vanzuVL8zKT7g8Ka
         d3rbbCkJ30V4RxpkiQge0DIvthPT5kKgruTE9FkpUslZvFZ9KobalD/pc1xQuFdXOx1G
         ADFB6GibhdvW1h3imfzPkN116mmEmVKRwQwkCTx4/JsmYJYszc3nofqiAttpl9Qm/pX3
         PWm4NTt+kkFB66dyJ2l7VTjrIqliLohKhTfLUESgo6mLeebaZrna5tgX8ca9dpwi/dG+
         rjGw==
X-Gm-Message-State: AOAM531O9gDqYnLwvXQwKinJoKf8nfirUx5LA5p6Gq0RD7Wwf5Ii0x9c
        BRa8qe0A+DML/l7b40J/IJ6IQubAqSw=
X-Google-Smtp-Source: ABdhPJzSWGtPCk2INREnYHV0P2JSQYvdRopa+WJ/sS5YMlaRPcHSE74y7pbs0cpiCamKX4cFMl9Z/Q==
X-Received: by 2002:adf:8b98:: with SMTP id o24mr26575236wra.156.1589894883485;
        Tue, 19 May 2020 06:28:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n9sm4092620wmj.5.2020.05.19.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:28:02 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "VMware Graphics" <linux-graphics-maintainer@vmware.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] dma-fence: add might_sleep annotation to _wait()
Date:   Tue, 19 May 2020 15:27:56 +0200
Message-Id: <20200519132756.682888-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Do it uncontionally, there's a separate peek function with
dma_fence_is_signalled() which can be called from atomic context.

v2: Consensus calls for an unconditional might_sleep (Chris,
Christian)

Full audit:
- dma-fence.h: Uses MAX_SCHEDULE_TIMOUT, good chance this sleeps
- dma-resv.c: Timeout always at least 1
- st-dma-fence.c: Save to sleep in testcases
- amdgpu_cs.c: Both callers are for variants of the wait ioctl
- amdgpu_device.c: Two callers in vram recover code, both right next
  to mutex_lock.
- amdgpu_vm.c: Use in the vm_wait ioctl, next to _reserve/unreserve
- remaining functions in amdgpu: All for test_ib implementations for
  various engines, caller for that looks all safe (debugfs, driver
  load, reset)
- etnaviv: another wait ioctl
- habanalabs: another wait ioctl
- nouveau_fence.c: hardcoded 15*HZ ... glorious
- nouveau_gem.c: hardcoded 2*HZ ... so not even super consistent, but
  this one does have a WARN_ON :-/ At least this one is only a
  fallback path for when kmalloc fails. Maybe this should be put onto
  some worker list instead, instead of a work per unamp ...
- i915/selftests: Hardecoded HZ / 4 or HZ / 8
- i915/gt/selftests: Going up the callchain looks safe looking at
  nearby callers
- i915/gt/intel_gt_requests.c. Wrapped in a mutex_lock
- i915/gem_i915_gem_wait.c: The i915-version which is called instead
  for i915 fences already has a might_sleep() annotation, so all good

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: "VMware Graphics" <linux-graphics-maintainer@vmware.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/dma-buf/dma-fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 90edf2b281b0..656e9ac2d028 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -208,6 +208,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	if (WARN_ON(timeout < 0))
 		return -EINVAL;
 
+	might_sleep();
+
 	trace_dma_fence_wait_start(fence);
 	if (fence->ops->wait)
 		ret = fence->ops->wait(fence, intr, timeout);
-- 
2.26.2

