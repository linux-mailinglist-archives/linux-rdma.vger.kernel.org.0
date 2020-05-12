Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B81CF0EC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELI76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728854AbgELI75 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 04:59:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE6C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 01:59:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j5so14361449wrq.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KglkhzKOknxegoh1rG3YIcHJTSInQ4UYexVPjKH+PE=;
        b=Jfw/Q8OAuPLQhbinu2k0zHhh0xSeFKQ+ThNX/lWWS+g5EnktPdt71Fw1SPCOSwO1DT
         I3yyprPxJEMCBedaNFOI15C4V0uzgHiDSLQJrIbB/b3hkg3kxfmRKfXkWgRlvRkrLTZN
         b2clRwBLTEBEySfCkrQHDGAQCbz2YgFZxsQMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KglkhzKOknxegoh1rG3YIcHJTSInQ4UYexVPjKH+PE=;
        b=loX7Hp6gT80Uhk2XMmqcx+GkHm2Y0zWOObsalSYQLugPZk7zYZQrLVuV21BdQpp/1V
         q5eeWZH24xm03zuN98gexsu1w+rNyDgENvZXD+mWmoMKyWOKOFBgr81f1/1jwQ/WkTNA
         OnfqmMvWUBletQPkpwdJc59FTestDBYIKn9CHh4B8IOQtiCNpyGaxaZKY6S97j2ypCiE
         eeurKAdVQ3IIvb5g2FCQdXPvSjlHyJUiZLmlHft0VOqWJctmzJxX9lLRgMqHLKrReAvn
         PeYFz/pY8a8axvvasc8xD4sqmnEFNE0zF5j5wSDz0MjlNyvD4sS1c2aeGyZXohIUCZrU
         CL5w==
X-Gm-Message-State: AGi0PuYMXHczcGkwF+8JWYoKasfxL4nys1fZvzbnVzSRu8B/E3XtmxCj
        mVMIDLhPNFlSoGluQ9yPfilfbbVbzLs=
X-Google-Smtp-Source: APiQypLFrNQ+vP1/FoQClKLQ9dOM5ud5CMkP+EXrISMxOesIEptzvE+zOlFydX6AdELQrZnabHpwnA==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr24357427wrp.142.1589273996049;
        Tue, 12 May 2020 01:59:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.01.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 01:59:55 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 00/17] dma-fence lockdep annotations
Date:   Tue, 12 May 2020 10:59:27 +0200
Message-Id: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

I've dragged my feet for years on this, hoping that cross-release lockdep
would do this for us, but well that never really happened unfortunately.
So here we are.

Cc'ed quite a pile of people since this is about the cross-driver contract
around dma_fences. Which is heavily used for dma_buf, and I'm hearing more
noises that rdma folks are looking into this, hence also on cc.

There's a bunch of different parts to this RFC:

- The annotations itself, in the 2nd patch after the prep patch to add
  might_sleep annotations. Commit message has all the motivation for what
  kind of deadlocks I want to catch, best you just read it.

  Since lockdep doesn't understand cross-release natively we need to
  cobble something together using rwlocks and a few more tricks, but from
  the test rollout in a few places in drm/vkms, amdgpu & i915 I think what
  I have now seems to actually work. Downside is that we have to
  explicitly annotate all code involved in eventual dma_fence signalling.

- Second important part is locking down the current dma-fence cross-driver
  contract, using lockdep priming like we already do for dma_resv_lock.
  I've just started with my own take on what we probably need to make the
  current code work (-ish), but both amdgpu and i915 have issues with
  that. So this needs some careful discussions, and also some thought on
  how we land it all eventually to not break lockdep completely for
  everyone.

  The important patch for that is "dma-fence: prime lockdep annotations"
  plus of course the various annotations patches and driver hacks to
  highlight some of the issues caught.

  Note that depending upon what exactly we end up deciding we might need
  to improve the annotations for fs_reclaim_acquire/release - for
  dma_fence_wait in mmu notifiers we can only allow GFP_NOWAIT (afaiui),
  and currently fs_reclaim_acquire/release only has a lockdep class for
  __GFP_FS only, we'd need to add another one for __GFP_DIRECT_RECLAIM in
  general maybe.

- Finally there's clearly some gaps in the current dma_fence driver
  interfaces: Amdgpu's hang recovery is essentially impossible to fix
  as-is - it needs to reset the display state and you can't get at modeset
  locks from tdr without deadlock potential. i915 has an internal trick
  (but it stops working once we involve real cross-driver fences) for this
  issues, but then for i915 modeset reset is only needed on very ancient
  gen2/3. Modern hw is a lot more reasonable.

  I'm kinda hoping that the annotations and priming for basic command
  submission and atomic modeset paths could be merged soonish, while we
  the tdr side clearly needs a pile more work to get going. But since we
  have to explicitly annotate all code paths anyway we can hide bugs in
  e.g. tdr code by simply not yet annotating those functions.

  I'm trying to lay out at least one idea for solving the tdr issue in the
  patch titled "drm/scheduler: use dma-fence annotations in tdr work".

Finally, once we have some agreement on where we're going with all this,
we also need some documentation. Currently that's missing because I don't
want to re-edit the text all the time while we still figure out the
details of the exact cross-driver semantics.

My goal here is that with this we can lock down the cross-driver contract
for the last bit of the dma_buf/resv/fence story and make sure this stops
being such a wobbly thing where everyone just does whatever they feel
like.

Ideas, thoughts, reviews, testing (with specific annotations for that
driver) on other drivers very much welcome.

Cheers, Daniel

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>

Daniel Vetter (17):
  dma-fence: add might_sleep annotation to _wait()
  dma-fence: basic lockdep annotations
  dma-fence: prime lockdep annotations
  drm/vkms: Annotate vblank timer
  drm/vblank: Annotate with dma-fence signalling section
  drm/atomic-helper: Add dma-fence annotations
  drm/amdgpu: add dma-fence annotations to atomic commit path
  drm/scheduler: use dma-fence annotations in main thread
  drm/amdgpu: use dma-fence annotations in cs_submit()
  drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
  drm/amdgpu: DC also loves to allocate stuff where it shouldn't
  drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
  drm/scheduler: use dma-fence annotations in tdr work
  drm/amdgpu: use dma-fence annotations for gpu reset code
  Revert "drm/amdgpu: add fbdev suspend/resume on gpu reset"
  drm/amdgpu: gpu recovery does full modesets
  drm/i915: Annotate dma_fence_work

 drivers/dma-buf/dma-fence.c                   | 56 +++++++++++++++++++
 drivers/dma-buf/dma-resv.c                    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 18 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 16 ++++++
 drivers/gpu/drm/drm_vblank.c                  |  8 ++-
 drivers/gpu/drm/i915/i915_sw_fence_work.c     |  3 +
 drivers/gpu/drm/scheduler/sched_main.c        | 11 ++++
 drivers/gpu/drm/vkms/vkms_crtc.c              |  8 ++-
 include/linux/dma-fence.h                     | 13 +++++
 16 files changed, 160 insertions(+), 13 deletions(-)

-- 
2.26.2

