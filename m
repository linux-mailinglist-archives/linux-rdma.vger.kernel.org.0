Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF11CF082
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgELJAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729434AbgELJAM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:00:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC7C061A0F
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so14362577wrq.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSDqH5ij1BPhN02yjRk7X7Ch94EKjTTeY1hANr+YPIg=;
        b=LgQftZug1+s6r/6sfV0w6yEj/NMgDnXPjQ9rogWtkgMYDejoFBo0bPnwGW56hu1d7I
         qs3FiIgJnTmbmBqRQhBg/d/9mf6F8tXHWnk5q6Y4hrcpMMBBXw0ZHjxKx/PXQDwpH8gi
         /lG4giH5AqDaIZXE6JQNuQUTWIUktkeQZkN8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSDqH5ij1BPhN02yjRk7X7Ch94EKjTTeY1hANr+YPIg=;
        b=UP+z6oyxz1ah1HnVgEWF+7uP738PcnJ/ygzy3C4rlHpclH5v7whf9QteGWglmwnMI/
         ktzuxcRNRtyMjEUQAWIaGE2TNajF4/VCZCZhdytmKwEeBs5/5O1Uj20EYCpg10tIJAAa
         HGQ4sSHAmQlMVaj30NyA0bUTm8/3HLpOljF81FHEXYULLnarpN8rE4pIi/x/1PhHpqqI
         DjwL/t/Bke863kz1XpXiAXRHWzGivSqbUtKtxf4afcujGgjWVxrAHCcj7YpPQj2hj0qA
         4ocSC8H08dyZqy704k6nFht71BAhRVNOBlJ+MD4YgdniyiiWlpsC1Z2VAKIO3qV6jFYm
         eF6w==
X-Gm-Message-State: AGi0PuZcA8Qz3vwMhzMqvTrh5SgoUUUkMggD9mwLHnzVTgeoII6tJm10
        t3V0BMKUFGxTJLODURx3Kp+czQ==
X-Google-Smtp-Source: APiQypIHDkKnk39vr0THs9MDd2lPRfxpCvBWLiPU8TBM9Ly4fBvHufkGUrgX+LdKysku7drbWjQ/Mg==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr25405016wrw.29.1589274010831;
        Tue, 12 May 2020 02:00:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:10 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC 13/17] drm/scheduler: use dma-fence annotations in tdr work
Date:   Tue, 12 May 2020 10:59:40 +0200
Message-Id: <20200512085944.222637-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the face of unpriviledged userspace being able to submit bogus gpu
workloads the kernel needs gpu timeout and reset (tdr) to guarantee
that dma_fences actually complete. Annotate this worker to make sure
we don't have any accidental locking inversions or other problems
lurking.

Originally this was part of the overall scheduler annotation patch.
But amdgpu has some glorious inversions here:

- grabs console_lock
- does a full modeset, which grabs all kinds of locks
  (drm_modeset_lock, dma_resv_lock) which can deadlock with
  dma_fence_wait held inside them.
- almost minor at that point, but the modeset code also allocates
  memory

These all look like they'll be very hard to fix properly, the hardware
seems to require a full display reset with any gpu recovery.

Hence split out as a seperate patch.

Since amdgpu isn't the only hardware driver that needs to reset the
display (at least gen2/3 on intel have the same problem) we need a
generic solution for this. There's two tricks we could still from
drm/i915 and lift to dma-fence:

- The big whack, aka force-complete all fences. i915 does this for all
  pending jobs if the reset is somehow stuck. Trouble is we'd need to
  do this for all fences in the entire system, and just the
  book-keeping for that will be fun. Plus lots of drivers use fences
  for all kinds of internal stuff like memory management, so
  unconditionally resetting all of them doesn't work.

  I'm also hoping that with these fence annotations we could enlist
  lockdep in finding the last offenders causing deadlocks, and we
  could remove this get-out-of-jail trick.

- The more feasible approach (across drivers at least as part of the
  dma_fence contract) is what drm/i915 does for gen2/3: When we need
  to reset the display we wake up all dma_fence_wait_interruptible
  calls, or well at least the equivalent of those in i915 internally.

  Relying on ioctl restart we force all other threads to release their
  locks, which means the tdr thread is guaranteed to be able to get
  them. I think we could implement this at the dma_fence level,
  including proper lockdep annotations.

  dma_fence_begin_tdr():
  - must be nested within a dma_fence_begin/end_signalling section
  - will wake up all interruptible (but not the non-interruptible)
    dma_fence_wait() calls and force them to complete with a
    -ERESTARTSYS errno code. All new interrupitble calls to
    dma_fence_wait() will immeidately fail with the same error code.

  dma_fence_end_trdr():
  - this will convert dma_fence_wait() calls back to normal.

  Of course interrupting dma_fence_wait is only ok if the caller
  specified that, which means we need to split the annotations into
  interruptible and non-interruptible version. If we then make sure
  that we only use interruptible dma_fence_wait() calls while holding
  drm_modeset_lock we can grab them in tdr code, and allow display
  resets. Doing the same for dma_resv_lock might be a lot harder, so
  buffer updates must be avoided.

  What's worse, we're not going to be able to make the dma_fence_wait
  calls in mmu-notifiers interruptible, that doesn't work. So
  allocating memory still wont' be allowed, even in tdr sections. Plus
  obviously we can use this trick only in tdr, it is rather intrusive.

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
 drivers/gpu/drm/scheduler/sched_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 06a736e506ad..e34a44376e87 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -279,9 +279,12 @@ static void drm_sched_job_timedout(struct work_struct *work)
 {
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_job *job;
+	bool fence_cookie;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
 	spin_lock(&sched->job_list_lock);
 	job = list_first_entry_or_null(&sched->ring_mirror_list,
@@ -313,6 +316,8 @@ static void drm_sched_job_timedout(struct work_struct *work)
 	spin_lock(&sched->job_list_lock);
 	drm_sched_start_timeout(sched);
 	spin_unlock(&sched->job_list_lock);
+
+	dma_fence_end_signalling(fence_cookie);
 }
 
  /**
-- 
2.26.2

