Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3437BE79B7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfJ1UKr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46819 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1UKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so16472030qtq.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5pRz73cidpozifut11i/Qo3t+yY00cTSdM8idTfn1I=;
        b=b8Wfb91nM9LzESUx0mWWeO1hcooHxpGOSvdLn5mUQNDm+SvwsmozLjOcfd4rT8RvM5
         kNwFzWeqTR5NrFbfuQts9/Mv3C/wIHuRahaPjy4r53xiyMhRJ8maHJv4YGMk3iZO8jKw
         cO7qRH6sUKCstPiObwYKoc3tu4kNTF7zWGDXXB/e4Udi2wdI9shca8gKN31PqAg6jPrp
         u4yVj9dhhjZytLW/RVcuVJly37G+vKGA8blm4qzRqJ6bQK28UertCy66jI8t3r+ML/hw
         sKUDxxVtQX8TbfeMl9fuoEqghJhTvUzf0YOFHKGkMqcp/jQDThJwx5gZYveZ+xiex9ET
         GyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5pRz73cidpozifut11i/Qo3t+yY00cTSdM8idTfn1I=;
        b=FqEymCpRNQJI5bGDtPt/cRYZiXGfNj0sYeiRFZgXnpKrOhQ0QqCYMk63G1h7ht+YGM
         6yYjH+otyQ/p7E5/Z2XvtH8aqvcGncngNlmTi6myG55S/Om61GiLS7/Sxo/6bKbxYL+P
         tW1IHecc0s9Ib2qxRT/1rEWpmubf336fQUdju1iK7Zt+HXKEI838RCfZQeCJCFxB5Nox
         s8ITQ2WdZvx6hwMbIWhr7ed4uN7qX8HQXWMYEGddjDTkH/xWjSX1oOFbPbiqAislevc8
         kih1LWH0+or/z4RYg7KIFCeoGiODYmGCVtkxe5fx0MISvqtfRlkl+nR9fjHgf8NxaxZe
         HJ5A==
X-Gm-Message-State: APjAAAWeKJ6eULjPFIK/9a5jODrqWLXTjPsaqagoEmOST4yJsxOcysl1
        N9TYCoE/JAxcuK1LmjmKWlddjg==
X-Google-Smtp-Source: APXvYqyBvpLtbqvoSc7BERARg9JSjdZy3p22+Vxs4zvuhW77of4HZKy8Nj7mkBzSwHMR2XNBRVGs/g==
X-Received: by 2002:ac8:464f:: with SMTP id f15mr253969qto.323.1572293445566;
        Mon, 28 Oct 2019 13:10:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d10sm5719718qko.29.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLe-0001fy-W1; Mon, 28 Oct 2019 17:10:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 00/15] Consolidate the mmu notifier interval_tree and locking
Date:   Mon, 28 Oct 2019 17:10:17 -0300
Message-Id: <20191028201032.6352-1-jgg@ziepe.ca>
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

This series, and the other code it depends on is available on my github:

https://github.com/jgunthorpe/linux/commits/mmu_notifier

v2 changes:
- Add mmu_range_set_seq() to set the mrn sequence number under the driver
  lock and make the locking more understandable
- Add some additional comments around locking/READ_ONCe
- Make the WARN_ON flow in mn_itree_invalidate a bit easier to follow
- Fix wrong WARN_ON

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 457 +++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  53 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 111 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 231 +++++---
 drivers/gpu/drm/radeon/radeon.h               |   9 +-
 drivers/gpu/drm/radeon/radeon_mn.c            | 219 ++-----
 drivers/infiniband/core/device.c              |   1 -
 drivers/infiniband/core/umem_odp.c            | 288 +--------
 drivers/infiniband/hw/hfi1/file_ops.c         |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h              |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 146 ++---
 drivers/infiniband/hw/hfi1/user_exp_rcv.h     |   3 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
 drivers/infiniband/hw/mlx5/mr.c               |   3 +-
 drivers/infiniband/hw/mlx5/odp.c              |  50 +-
 drivers/xen/Kconfig                           |   3 +-
 drivers/xen/gntdev-common.h                   |   8 +-
 drivers/xen/gntdev.c                          | 180 ++----
 include/linux/hmm.h                           | 195 +------
 include/linux/mmu_notifier.h                  | 144 ++++-
 include/rdma/ib_umem_odp.h                    |  65 +--
 include/rdma/ib_verbs.h                       |   2 -
 kernel/fork.c                                 |   1 -
 mm/Kconfig                                    |   2 +-
 mm/hmm.c                                      | 275 +--------
 mm/mmu_notifier.c                             | 546 +++++++++++++++++-
 32 files changed, 1225 insertions(+), 1922 deletions(-)

-- 
2.23.0

