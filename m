Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8F1EDF1D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFDIMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgFDIMe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACBC05BD1E
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so5066939wro.1
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjYKgl1BXaEH8GQKLg8VxMrSCY/k0US00QhIRvYYPEA=;
        b=kyBPPaRamy/HmHh5JRj3lm6cSO9mrjCTe6nPVNXWZl7sLcwpFLZH03d7IXCaDQAbU9
         bWT+/fuJcxKCIvQeAz+7/CPD/m6BbEWAbJlfzQwnsSAN+AsbvA8QndXdYZFwQO0ucpeW
         +N5wby58BJfSZKsnQFztX13ktrN76Zl77KJZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjYKgl1BXaEH8GQKLg8VxMrSCY/k0US00QhIRvYYPEA=;
        b=bmilnok+F9LhsHB59PMotQuSVTZr1dR6NeUvwges9wnaXtAKhQzpPMox9qgkJirVps
         h/abHq99s+nvptbu0/ZCw0wk/lvnRVj3BisNE9+fXySR0oc0R8qfHavdyKdUkL9kz/ND
         Yw0yVwEE+e4tnq1ZjJfVoGyMj16E2OislWGL4ipjOk3H+ps58hA/eFJ00375lJriJqSl
         QuaSPFUSekIPfT4b36HRnifrG6FXHmNrgSaFk5pFzX5WEnEk04X8b7ah7MAowH+/4U8J
         AKDw6yzyymi9FSsFLGSsK3CBu/zQ286TMmKBZWDwwmX+JclxoKufRVqi7FSkA4E+J6Ac
         HT4g==
X-Gm-Message-State: AOAM532CT5zV7DaAvSapgBB7stV8GWkqH2iTs3gSyGaUa+D2n3VuYORB
        UKwAhHlB3db+aFHHuXe6rwk8vA==
X-Google-Smtp-Source: ABdhPJwck51N31CTXP+8yfy3JqBTy0FFs7zaLP/6w37Ug1NNs626RcdqKC1IFsIertUA5A07+TX4Qw==
X-Received: by 2002:adf:aa97:: with SMTP id h23mr3419463wrc.251.1591258352295;
        Thu, 04 Jun 2020 01:12:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:31 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 00/18] dma-fence lockdep annotations, round 2
Date:   Thu,  4 Jun 2020 10:12:06 +0200
Message-Id: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Still very much early stuff, still very much looking for initial thoughts
and maybe some ideas how this could all be rolled out across drivers.

Full intro probably best from the RFC cover letter:

https://lore.kernel.org/amd-gfx/20200512085944.222637-1-daniel.vetter@ffwll.ch/

Changes since last time around:

- might_sleep annotation has landed already, I split that out as a
  stand-alone

- now with an mm patch to improve direct reclaim annotations for mmu
  notifiers. This allows us to very easily catch issues in that area, no
  more need for exaustive testing and luck to make sure we're not leaving
  a GFP_NOFS or GPF_NOIO around which should be a GFP_ATOMIC

- kerneldoc that explains all the reasoning behind the annotations and
  priming, hopefully

Driver patches still largely just meant as examples to illustrate usage,
but from various irc chats I think discussing them is really useful to
gain clarity on the exact places the annotations should be put.

Cheers, Daniel

Daniel Vetter (18):
  mm: Track mmu notifiers in fs_reclaim_acquire/release
  dma-buf: minor doc touch-ups
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

 Documentation/driver-api/dma-buf.rst          |  18 +-
 drivers/dma-buf/dma-buf.c                     |   6 +-
 drivers/dma-buf/dma-fence.c                   | 202 ++++++++++++++++++
 drivers/dma-buf/dma-resv.c                    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  16 ++
 drivers/gpu/drm/drm_vblank.c                  |   8 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c     |   3 +
 drivers/gpu/drm/scheduler/sched_main.c        |  11 +
 drivers/gpu/drm/vkms/vkms_crtc.c              |   8 +-
 include/linux/dma-fence.h                     |  13 ++
 mm/mmu_notifier.c                             |   7 -
 mm/page_alloc.c                               |  23 +-
 20 files changed, 341 insertions(+), 35 deletions(-)

-- 
2.26.2

