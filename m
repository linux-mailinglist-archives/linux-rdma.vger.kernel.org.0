Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED51CF0EB
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgELJD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729275AbgELJAB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:00:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A9C05BD0A
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 01:59:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so20802817wmj.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6zGk0sRXoiLMVlOrHdYKmGYdqgb8HIUHeWjfHU8LZ8=;
        b=G3K7uswlmhW+rpia5CreMV57ZkKdKlwZ6FOlSyfm3Oe7LuGmiEiRHD/PML6gjh4GhM
         OdvDdQt4u51YIl+RwDLbW7P8kjQMLKpQZcHKzE4dlQdQnOJqX7Su2t5BwmDsqLUnYibz
         JMBsPiQPy7q4aI4KfXGjLvCIMnBefB60TFyyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6zGk0sRXoiLMVlOrHdYKmGYdqgb8HIUHeWjfHU8LZ8=;
        b=EMEXAO377RQBHIzDUPOtjtO/axQG8USzmlmg32N0+9zNGrGkJ5zwdpYooyQLt05cSI
         7IhnRp2mQDDRuEivtHvHbzZBUdCmOTsto2L+iFeOzP+NuldXfzZO5//DE+ds0/1I9XEN
         pdnW8wEoSPhaXBR4jLPlJTOuXPaxzbzGwNAuE9OKYvwjIdnJ79623QFvgSrUK4Sx5I4c
         1Tzt2mqBx//H9J+Y1xuC63DvzMS6VxLryyY9qjrhh9MidWvrzjneOWh+DY6ONenY2e3r
         Ex6eFyB2lYqSoiSdd0bPib9k696l5AHfu4TE2S/D3dqumWULjH9Otd9x612m5EeewDJK
         8Icw==
X-Gm-Message-State: AGi0PubtPdsFX5ogD8bf7j8TRpB8TZbaADmdE/qj5Ufz8dm0Sz3ge70w
        o/dS3jk5Ji4dhTjiiV08MiYuZg==
X-Google-Smtp-Source: APiQypLCYf7Wgh0Wtz0pUmQn/xpulX/EPJ0KyLgnUHWq+1CmCns3LkuSYY1ZCdFMCm+vHgIBfsEl0Q==
X-Received: by 2002:a1c:3bc5:: with SMTP id i188mr25545127wma.90.1589273998427;
        Tue, 12 May 2020 01:59:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.01.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 01:59:57 -0700 (PDT)
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
Subject: [RFC 02/17] dma-fence: basic lockdep annotations
Date:   Tue, 12 May 2020 10:59:29 +0200
Message-Id: <20200512085944.222637-3-daniel.vetter@ffwll.ch>
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

Design is similar to the lockdep annotations for workers, but with
some twists:

- We use a read-lock for the execution/worker/completion side, so that
  this explicit annotation can be more liberally sprinkled around.
  With read locks lockdep isn't going to complain if the read-side
  isn't nested the same way under all circumstances, so ABBA deadlocks
  are ok. Which they are, since this is an annotation only.

- We're using non-recursive lockdep read lock mode, since in recursive
  read lock mode lockdep does not catch read side hazards. And we
  _very_ much want read side hazards to be caught. For full details of
  this limitation see

  commit e91498589746065e3ae95d9a00b068e525eec34f
  Author: Peter Zijlstra <peterz@infradead.org>
  Date:   Wed Aug 23 13:13:11 2017 +0200

      locking/lockdep/selftests: Add mixed read-write ABBA tests

- To allow nesting of the read-side explicit annotations we explicitly
  keep track of the nesting. lock_is_held() allows us to do that.

- The wait-side annotation is a write lock, and entirely done within
  dma_fence_wait() for everyone by default.

- To be able to freely annotate helper functions I want to make it ok
  to call dma_fence_begin/end_signalling from soft/hardirq context.
  First attempt was using the hardirq locking context for the write
  side in lockdep, but this forces all normal spinlocks nested within
  dma_fence_begin/end_signalling to be spinlocks. That bollocks.

  The approach now is to simple check in_atomic(), and for these cases
  entirely rely on the might_sleep() check in dma_fence_wait(). That
  will catch any wrong nesting against spinlocks from soft/hardirq
  contexts.

The idea here is that every code path that's critical for eventually
signalling a dma_fence should be annotated with
dma_fence_begin/end_signalling. The annotation ideally starts right
after a dma_fence is published (added to a dma_resv, exposed as a
sync_file fd, attached to a drm_syncobj fd, or anything else that
makes the dma_fence visible to other kernel threads), up to and
including the dma_fence_wait(). Examples are irq handlers, the
scheduler rt threads, the tail of execbuf (after the corresponding
fences are visible), any workers that end up signalling dma_fences and
really anything else. Not annotated should be code paths that only
complete fences opportunistically as the gpu progresses, like e.g.
shrinker/eviction code.

The main class of deadlocks this is supposed to catch are:

Thread A:

	mutex_lock(A);
	mutex_unlock(A);

	dma_fence_signal();

Thread B:

	mutex_lock(A);
	dma_fence_wait();
	mutex_unlock(A);

Thread B is blocked on A signalling the fence, but A never gets around
to that because it cannot acquire the lock A.

Note that dma_fence_wait() is allowed to be nested within
dma_fence_begin/end_signalling sections. To allow this to happen the
read lock needs to be upgraded to a write lock, which means that any
other lock is acquired between the dma_fence_begin_signalling() call and
the call to dma_fence_wait(), and still held, this will result in an
immediate lockdep complaint. The only other option would be to not
annotate such calls, defeating the point. Therefore these annotations
cannot be sprinkled over the code entirely mindless to avoid false
positives.

v2: handle soft/hardirq ctx better against write side and dont forget
EXPORT_SYMBOL, drivers can't use this otherwise.

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
 drivers/dma-buf/dma-fence.c | 53 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-fence.h   | 12 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 6802125349fb..d5c0fd2efc70 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
 }
 EXPORT_SYMBOL(dma_fence_context_alloc);
 
+#ifdef CONFIG_LOCKDEP
+struct lockdep_map	dma_fence_lockdep_map = {
+	.name = "dma_fence_map"
+};
+
+bool dma_fence_begin_signalling(void)
+{
+	/* explicitly nesting ... */
+	if (lock_is_held_type(&dma_fence_lockdep_map, 1))
+		return true;
+
+	/* rely on might_sleep check for soft/hardirq locks */
+	if (in_atomic())
+		return true;
+
+	/* ... and non-recursive readlock */
+	lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_IP_);
+
+	return false;
+}
+EXPORT_SYMBOL(dma_fence_begin_signalling);
+
+void dma_fence_end_signalling(bool cookie)
+{
+	if (cookie)
+		return;
+
+	lock_release(&dma_fence_lockdep_map, _RET_IP_);
+}
+EXPORT_SYMBOL(dma_fence_end_signalling);
+
+void __dma_fence_might_wait(void)
+{
+	bool tmp;
+
+	tmp = lock_is_held_type(&dma_fence_lockdep_map, 1);
+	if (tmp)
+		lock_release(&dma_fence_lockdep_map, _THIS_IP_);
+	lock_map_acquire(&dma_fence_lockdep_map);
+	lock_map_release(&dma_fence_lockdep_map);
+	if (tmp)
+		lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _THIS_IP_);
+}
+#endif
+
+
 /**
  * dma_fence_signal_locked - signal completion of a fence
  * @fence: the fence to signal
@@ -170,14 +216,19 @@ int dma_fence_signal(struct dma_fence *fence)
 {
 	unsigned long flags;
 	int ret;
+	bool tmp;
 
 	if (!fence)
 		return -EINVAL;
 
+	tmp = dma_fence_begin_signalling();
+
 	spin_lock_irqsave(fence->lock, flags);
 	ret = dma_fence_signal_locked(fence);
 	spin_unlock_irqrestore(fence->lock, flags);
 
+	dma_fence_end_signalling(tmp);
+
 	return ret;
 }
 EXPORT_SYMBOL(dma_fence_signal);
@@ -211,6 +262,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	if (timeout > 0)
 		might_sleep();
 
+	__dma_fence_might_wait();
+
 	trace_dma_fence_wait_start(fence);
 	if (fence->ops->wait)
 		ret = fence->ops->wait(fence, intr, timeout);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 3347c54f3a87..3f288f7db2ef 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -357,6 +357,18 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu **fencep)
 	} while (1);
 }
 
+#ifdef CONFIG_LOCKDEP
+bool dma_fence_begin_signalling(void);
+void dma_fence_end_signalling(bool cookie);
+#else
+static inline bool dma_fence_begin_signalling(void)
+{
+	return true;
+}
+static inline void dma_fence_end_signalling(bool cookie) {}
+static inline void __dma_fence_might_wait(void) {}
+#endif
+
 int dma_fence_signal(struct dma_fence *fence);
 int dma_fence_signal_locked(struct dma_fence *fence);
 signed long dma_fence_default_wait(struct dma_fence *fence,
-- 
2.26.2

