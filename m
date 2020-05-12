Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C41CF014
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgELJAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729408AbgELJAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:00:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977AAC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so14306231wrp.12
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VL9TtbPRMRPCTQiRlmMi8z5JITNnf6io7xX7MRKl+Ko=;
        b=kRhMNR3hP3pKPVHZhZ9cT25ln+EAm07SNjcy31Y4dhe3XkzIe07JM4Ya995O4xRy86
         +saK6s4RC0NG7qbyo1lVxn1eZUImoXrpCgVi47HZi5titk7nGYe9UjbrS8UkF6O3hPRR
         ovYttYkktjgExaN6BUOrX19W0nVFlKxDNLAKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VL9TtbPRMRPCTQiRlmMi8z5JITNnf6io7xX7MRKl+Ko=;
        b=oWwlPhGWRyqU/oexyBxAD7qY8DaLnkNFRrrkMtZ3hPU/2lPm139nqhujOuckpq9+K0
         rIoMROxQrPVKpemZNgGSPw5L8wcXjNYgtSBLnj3C8g7nADwrBHhyxMguTT4jgjeBfqZX
         P/qqcr487ypvfRDfqPAZPYXayBMGFjuSgXHhn8i5hRpJYpzd6YG2f/ZhZD222EIKHYnI
         0LuutFe8MOcNz8cW4G/byanlwgAA6/NNXPcHeqYXRboJujDlmmoodqhBO63ReZqthRFv
         QeDkE16lehrAL3WPoOawOiauA8EpzUFs7QD+RLq0TC6s3F2jACxdgpRmJGg+PqlsMthc
         ZSRQ==
X-Gm-Message-State: AGi0PuYgZxIma7gcariEXxUSJBw7jJuDwqS0Rq2Dfb2lyETOxT8PXhRp
        v6NXQDrvRD7ZcTBoutKAGIE+rA==
X-Google-Smtp-Source: APiQypISnc9hbO9Grrz8ir5cKtb2Z6Km73KFVxCF0gD5VBDJDeUiMEfX/2s/6rU4lnpOUPSzhy7kNw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr23345391wrt.215.1589274013291;
        Tue, 12 May 2020 02:00:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:12 -0700 (PDT)
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
Subject: [RFC 15/17] Revert "drm/amdgpu: add fbdev suspend/resume on gpu reset"
Date:   Tue, 12 May 2020 10:59:42 +0200
Message-Id: <20200512085944.222637-16-daniel.vetter@ffwll.ch>
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

This is one from the department of "maybe play lottery if you hit
this, karma compensation might work". Or at least lockdep ftw!

This reverts commit 565d1941557756a584ac357d945bc374d5fcd1d0.

It's not quite as low-risk as the commit message claims, because this
grabs console_lock, which might be held when we allocate memory, which
might never happen because the dma_fence_wait() is stuck waiting on
our gpu reset:

[  136.763714] ======================================================
[  136.763714] WARNING: possible circular locking dependency detected
[  136.763715] 5.7.0-rc3+ #346 Tainted: G        W
[  136.763716] ------------------------------------------------------
[  136.763716] kworker/2:3/682 is trying to acquire lock:
[  136.763716] ffffffff8226f140 (console_lock){+.+.}-{0:0}, at: drm_fb_helper_set_suspend_unlocked+0x7b/0xa0 [drm_kms_helper]
[  136.763723]
               but task is already holding lock:
[  136.763724] ffffffff82318c80 (dma_fence_map){++++}-{0:0}, at: drm_sched_job_timedout+0x25/0xf0 [gpu_sched]
[  136.763726]
               which lock already depends on the new lock.

[  136.763726]
               the existing dependency chain (in reverse order) is:
[  136.763727]
               -> #2 (dma_fence_map){++++}-{0:0}:
[  136.763730]        __dma_fence_might_wait+0x41/0xb0
[  136.763732]        dma_resv_lockdep+0x171/0x202
[  136.763734]        do_one_initcall+0x5d/0x2f0
[  136.763736]        kernel_init_freeable+0x20d/0x26d
[  136.763738]        kernel_init+0xa/0xfb
[  136.763740]        ret_from_fork+0x27/0x50
[  136.763740]
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  136.763743]        fs_reclaim_acquire.part.0+0x25/0x30
[  136.763745]        kmem_cache_alloc_trace+0x2e/0x6e0
[  136.763747]        device_create_groups_vargs+0x52/0xf0
[  136.763747]        device_create+0x49/0x60
[  136.763749]        fb_console_init+0x25/0x145
[  136.763750]        fbmem_init+0xcc/0xe2
[  136.763750]        do_one_initcall+0x5d/0x2f0
[  136.763751]        kernel_init_freeable+0x20d/0x26d
[  136.763752]        kernel_init+0xa/0xfb
[  136.763753]        ret_from_fork+0x27/0x50
[  136.763753]
               -> #0 (console_lock){+.+.}-{0:0}:
[  136.763755]        __lock_acquire+0x1241/0x23f0
[  136.763756]        lock_acquire+0xad/0x370
[  136.763757]        console_lock+0x47/0x70
[  136.763761]        drm_fb_helper_set_suspend_unlocked+0x7b/0xa0 [drm_kms_helper]
[  136.763809]        amdgpu_device_gpu_recover.cold+0x21e/0xe7b [amdgpu]
[  136.763850]        amdgpu_job_timedout+0xfb/0x150 [amdgpu]
[  136.763851]        drm_sched_job_timedout+0x8a/0xf0 [gpu_sched]
[  136.763852]        process_one_work+0x23c/0x580
[  136.763853]        worker_thread+0x50/0x3b0
[  136.763854]        kthread+0x12e/0x150
[  136.763855]        ret_from_fork+0x27/0x50
[  136.763855]
               other info that might help us debug this:

[  136.763856] Chain exists of:
                 console_lock --> fs_reclaim --> dma_fence_map

[  136.763857]  Possible unsafe locking scenario:

[  136.763857]        CPU0                    CPU1
[  136.763857]        ----                    ----
[  136.763857]   lock(dma_fence_map);
[  136.763858]                                lock(fs_reclaim);
[  136.763858]                                lock(dma_fence_map);
[  136.763858]   lock(console_lock);
[  136.763859]
                *** DEADLOCK ***

[  136.763860] 4 locks held by kworker/2:3/682:
[  136.763860]  #0: ffff8887fb81c938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1bc/0x580
[  136.763862]  #1: ffffc90000cafe58 ((work_completion)(&(&sched->work_tdr)->work)){+.+.}-{0:0}, at: process_one_work+0x1bc/0x580
[  136.763863]  #2: ffffffff82318c80 (dma_fence_map){++++}-{0:0}, at: drm_sched_job_timedout+0x25/0xf0 [gpu_sched]
[  136.763865]  #3: ffff8887ab621748 (&adev->lock_reset){+.+.}-{3:3}, at: amdgpu_device_gpu_recover.cold+0x5ab/0xe7b [amdgpu]
[  136.763914]
               stack backtrace:
[  136.763915] CPU: 2 PID: 682 Comm: kworker/2:3 Tainted: G        W         5.7.0-rc3+ #346
[  136.763916] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 4011 04/19/2018
[  136.763918] Workqueue: events drm_sched_job_timedout [gpu_sched]
[  136.763919] Call Trace:
[  136.763922]  dump_stack+0x8f/0xd0
[  136.763924]  check_noncircular+0x162/0x180
[  136.763926]  __lock_acquire+0x1241/0x23f0
[  136.763927]  lock_acquire+0xad/0x370
[  136.763932]  ? drm_fb_helper_set_suspend_unlocked+0x7b/0xa0 [drm_kms_helper]
[  136.763933]  ? mark_held_locks+0x2d/0x80
[  136.763934]  ? _raw_spin_unlock_irqrestore+0x46/0x60
[  136.763936]  console_lock+0x47/0x70
[  136.763940]  ? drm_fb_helper_set_suspend_unlocked+0x7b/0xa0 [drm_kms_helper]
[  136.763944]  drm_fb_helper_set_suspend_unlocked+0x7b/0xa0 [drm_kms_helper]
[  136.763993]  amdgpu_device_gpu_recover.cold+0x21e/0xe7b [amdgpu]
[  136.764036]  amdgpu_job_timedout+0xfb/0x150 [amdgpu]
[  136.764038]  drm_sched_job_timedout+0x8a/0xf0 [gpu_sched]
[  136.764040]  process_one_work+0x23c/0x580
[  136.764041]  worker_thread+0x50/0x3b0
[  136.764042]  ? process_one_work+0x580/0x580
[  136.764044]  kthread+0x12e/0x150
[  136.764045]  ? kthread_create_worker_on_cpu+0x70/0x70
[  136.764046]  ret_from_fork+0x27/0x50

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5560d045b2e0..3584e29323c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4047,8 +4047,6 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				if (r)
 					goto out;
 
-				amdgpu_fbdev_set_suspend(tmp_adev, 0);
-
 				/* must succeed. */
 				amdgpu_ras_resume(tmp_adev);
 
@@ -4217,8 +4215,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		amdgpu_fbdev_set_suspend(tmp_adev, 1);
-
 		/* disable ras on ALL IPs */
 		if (!(in_ras_intr && !use_baco) &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
-- 
2.26.2

