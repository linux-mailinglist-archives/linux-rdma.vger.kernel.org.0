Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43C0D7EA1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfJOSQ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34981 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so12631959pgl.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBrgIx0hifh9NggoSUxRvl2c/6uC1S5tDuowJEqJG40=;
        b=KAPCxFZWvPNR+o1eJpCr9JMke5tJjHO+Hw9Iby/usIHw8WW8yx8ZHGZo+YLoOM9xhi
         BrS9FkdxeYYQnmA3kMwjfZehr1ZJDdE2uP/FUGYcefwdm5CvnHDB4tNB5s3Ox06eDb48
         Jb/YPdSDDprVsyg72N4vSrObGc8lT0Q71qWUpRYvzaBNQqvJUtIzBrZO8hHCu0c2ClZ/
         ulJ9Do/bK44RzjeqrIB+m6ZQMpCg0ooyRecRaZlxz5NMfDyCsIdgT58tSnE8FLm534Li
         LWw6pyYULmh1oaU6vJDlSidrjUOOoruaKt4rA86DXQZttETufDew2mO/CrMUWdiSjgfY
         FyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBrgIx0hifh9NggoSUxRvl2c/6uC1S5tDuowJEqJG40=;
        b=h3HvXre+agNxvU/7XlYn75EUFnRGxMyfKOQDp4erzA6bh7VEJgiR6fnUySLV/vY0BZ
         khQIH+O3ERLnWGitEvFcMWyZfUFMdRhW1jraaKl60y4I4JfWvrvFml3EZK3gYjhSi+dn
         C5ZqCFNdRwA2G1A+F40WhPFhWz7T4fN0OzZZ8NB4ASL90mR2crjBHwR8YkkZpMxUnQx8
         it9UD9ATFbEKFfS3cWrFqUrXS9lPSErl5nDOCp66cPClftvyjBEg5NAXtBN20rVsiRI8
         tYSa1BzBQH8neBGKUMUAtK63NjgAykpmo86c3/UEG65f45ZP71lGPipoG25BQjkflNGu
         6aEg==
X-Gm-Message-State: APjAAAXsowvpuBeCxOG7p/ctZqR9dM3lThD1bzv619n+TS6TldV9cC+7
        Zb5T2pnnbLsR92n5Ki6GwWceKQ==
X-Google-Smtp-Source: APXvYqyjfEo9wCFmNSKLzZPxrK/t8HgqE9dhiH72Gj5GoT9VOYhZwDkgJ97d1yM9RxM4iDCZzQrQLg==
X-Received: by 2002:a17:90a:1b49:: with SMTP id q67mr45572591pjq.115.1571163386669;
        Tue, 15 Oct 2019 11:16:26 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id e10sm29803744pfh.77.2019.10.15.11.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:26 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002Bh-64; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and locking
Date:   Tue, 15 Oct 2019 15:12:27 -0300
Message-Id: <20191015181242.8343-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, hfi1,
scif_dma, vhost, gntdev, hmm) drivers are using a common pattern where
they only use invalidate_range_start/end and immediately check the
invalidating range against some driver data structure to tell if the
driver is interested. Half of them use an interval_tree, the others are
simple linear search lists.

Of the ones I checked they largely seem to have various kinds of races,
bugs and poor implementation. This is a result of the complexity in how
the notifier interacts with get_user_pages(). It is extremely difficult to
use it correctly.

Consolidate all of this code together into the core mmu_notifier and
provide a locking scheme similar to hmm_mirror that allows the user to
safely use get_user_pages() and reliably know if the page list still
matches the mm.

This new arrangment plays nicely with the !blockable mode for
OOM. Scanning the interval tree is done such that the intersection test
will always succeed, and since there is no invalidate_range_end exposed to
drivers the scheme safely allows multiple drivers to be subscribed.

Four places are converted as an example of how the new API is used.
Four are left for future patches:
 - i915_gem has complex locking around destruction of a registration,
   needs more study
 - hfi1 (2nd user) needs access to the rbtree
 - scif_dma has a complicated logic flow
 - vhost's mmu notifiers are already being rewritten

This is still being tested, but I figured to send it to start getting help
from the xen, amd and hfi drivers which I cannot test here.

It would be intended for the hmm tree.

Jason Gunthorpe (15):
  mm/mmu_notifier: define the header pre-processor parts even if
    disabled
  mm/mmu_notifier: add an interval tree notifier
  mm/hmm: allow hmm_range to be used with a mmu_range_notifier or
    hmm_mirror
  mm/hmm: define the pre-processor related parts of hmm.h even if
    disabled
  RDMA/odp: Use mmu_range_notifier_insert()
  RDMA/hfi1: Use mmu_range_notifier_inset for user_exp_rcv
  drm/radeon: use mmu_range_notifier_insert
  xen/gntdev: Use select for DMA_SHARED_BUFFER
  xen/gntdev: use mmu_range_notifier_insert
  nouveau: use mmu_notifier directly for invalidate_range_start
  nouveau: use mmu_range_notifier instead of hmm_mirror
  drm/amdgpu: Call find_vma under mmap_sem
  drm/amdgpu: Use mmu_range_insert instead of hmm_mirror
  drm/amdgpu: Use mmu_range_notifier instead of hmm_mirror
  mm/hmm: remove hmm_mirror and related

 Documentation/vm/hmm.rst                      | 105 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 445 ++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  53 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 111 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 229 +++++---
 drivers/gpu/drm/radeon/radeon.h               |   9 +-
 drivers/gpu/drm/radeon/radeon_mn.c            | 218 ++-----
 drivers/infiniband/core/device.c              |   1 -
 drivers/infiniband/core/umem_odp.c            | 288 +---------
 drivers/infiniband/hw/hfi1/file_ops.c         |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h              |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 144 ++---
 drivers/infiniband/hw/hfi1/user_exp_rcv.h     |   3 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
 drivers/infiniband/hw/mlx5/mr.c               |   3 +-
 drivers/infiniband/hw/mlx5/odp.c              |  48 +-
 drivers/xen/Kconfig                           |   3 +-
 drivers/xen/gntdev-common.h                   |   8 +-
 drivers/xen/gntdev.c                          | 179 ++----
 include/linux/hmm.h                           | 195 +------
 include/linux/mmu_notifier.h                  | 124 +++-
 include/rdma/ib_umem_odp.h                    |  65 +--
 include/rdma/ib_verbs.h                       |   2 -
 kernel/fork.c                                 |   1 -
 mm/Kconfig                                    |   2 +-
 mm/hmm.c                                      | 275 +--------
 mm/mmu_notifier.c                             | 542 +++++++++++++++++-
 32 files changed, 1180 insertions(+), 1923 deletions(-)

-- 
2.23.0

