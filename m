Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C92F9A72
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfKLUWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:51 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42484 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLUWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:51 -0500
Received: by mail-qv1-f65.google.com with SMTP id c9so6939347qvz.9
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWMSOcigcFkvS1mXDN4UZKv/Sz4qJBz/Xw1txpllC58=;
        b=SdP44dA/qt3Cafkmp5tDYwUfTKua1RYFbjfub38WMqp1Vetd5HDAMxGgKpbA4Ao+oK
         gsEL1oHkgBYSL5wAFUvGW4WL3U/pvufnqzGsum5CGpKAJYB+qH5Upt6hHPp0oyUiUVZQ
         luFJjPDkpYMu/LEwn7P4i1KvQc3sG0kQARArCClpXMObiDqr/9YyrAyqL0dxb++bMYDb
         XbTfpT4OBOBeoefNdIfWJ+fDQI8fjcFqTYyS9qXYt67Hx6qKRVE8+RXhoDoz1lpBwD/V
         slDxBVQ6lEnBCWWDRENPVOvt6nSoUCSoIGfYhgVkElAgGx2oznQ/Ekwnr6eHH2zAzayA
         jOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWMSOcigcFkvS1mXDN4UZKv/Sz4qJBz/Xw1txpllC58=;
        b=E8mqlJe+wBaDD8eUkjp07S3WHUOw+V+6/5pu06EX09JGIyzh+LhFF7mf7nIefSqMwO
         ewDPS29z+HZ9lFmCK025bDXtjRp0iSzzqoeyKIQGfR+xeW4xvheqp2WZDFygobRRhb2J
         oaLliTqhUOpTw1+JtOuG0kQ50jLjQbUuxecpTs8f5FUivHouDyL4QZ5dCF7fCo37LoR6
         TSqoR+q1K64sXh7fmywmbElZI3aILmEM/g7ADFmT6PxG5OPXRABbCjVZB9DQFY0I5Utt
         oIMBzSUJjZwd7fk99fdWhVlur9emO6FgjHOp8uplx3Rk+2/ATHdcGwpQ4/80o4lOdi2M
         nkzg==
X-Gm-Message-State: APjAAAXUTbcRschTYBsFC/cQkdwkfqiOLy3UkS1SAbOm7WeeeGzBPZlN
        VrU1NvHgYOqrhqIfSWFvtHioSQ==
X-Google-Smtp-Source: APXvYqyZGwIPop6xwsfhsv3DLyXXAOZa8Eq5KSgCu6w55310PeMbie/nmCz5Pj6znsHarv3wD6pCCQ==
X-Received: by 2002:a05:6214:14b2:: with SMTP id bo18mr30642652qvb.72.1573590168105;
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j71sm10881994qke.90.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003jU-35; Tue, 12 Nov 2019 16:22:47 -0400
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
Subject: [PATCH hmm v3 00/14] Consolidate the mmu notifier interval_tree and locking
Date:   Tue, 12 Nov 2019 16:22:17 -0400
Message-Id: <20191112202231.3856-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.0
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

This is already in linux-next, a git tree is available here:

 https://github.com/jgunthorpe/linux/commits/mmu_notifier

v3:
- Rename mmu_range_notifier to mmu_interval_notifier for clarity
  Avoids confusion with struct mmu_notifier_range
- Fix bugs in odp, amdgpu and xen gntdev from testing
- Make ops an argument to mmu_interval_notifier_insert() to make it
  harder to misuse
- Update many comments
- Add testing of mm_count during insertion

v2: https://lore.kernel.org/r/20191028201032.6352-1-jgg@ziepe.ca
v1: https://lore.kernel.org/r/20191015181242.8343-1-jgg@ziepe.ca

Absent any new discussion I think this will go to Linus at the next merge
window.

Thanks to everyone to helped!

Jason Gunthorpe (14):
  mm/mmu_notifier: define the header pre-processor parts even if
    disabled
  mm/mmu_notifier: add an interval tree notifier
  mm/hmm: allow hmm_range to be used with a mmu_interval_notifier or
    hmm_mirror
  mm/hmm: define the pre-processor related parts of hmm.h even if
    disabled
  RDMA/odp: Use mmu_interval_notifier_insert()
  RDMA/hfi1: Use mmu_interval_notifier_insert for user_exp_rcv
  drm/radeon: use mmu_interval_notifier_insert
  nouveau: use mmu_notifier directly for invalidate_range_start
  nouveau: use mmu_interval_notifier instead of hmm_mirror
  drm/amdgpu: Call find_vma under mmap_sem
  drm/amdgpu: Use mmu_interval_insert instead of hmm_mirror
  drm/amdgpu: Use mmu_interval_notifier instead of hmm_mirror
  mm/hmm: remove hmm_mirror and related
  xen/gntdev: use mmu_interval_notifier_insert

 Documentation/vm/hmm.rst                      | 105 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 443 ++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  53 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 145 +++--
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 230 ++++---
 drivers/gpu/drm/radeon/radeon.h               |   9 +-
 drivers/gpu/drm/radeon/radeon_mn.c            | 218 ++-----
 drivers/infiniband/core/device.c              |   1 -
 drivers/infiniband/core/umem_odp.c            | 303 ++--------
 drivers/infiniband/hw/hfi1/file_ops.c         |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h              |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 146 ++---
 drivers/infiniband/hw/hfi1/user_exp_rcv.h     |   3 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
 drivers/infiniband/hw/mlx5/mr.c               |   3 +-
 drivers/infiniband/hw/mlx5/odp.c              |  50 +-
 drivers/xen/gntdev-common.h                   |   8 +-
 drivers/xen/gntdev.c                          | 179 ++----
 include/linux/hmm.h                           | 195 +-----
 include/linux/mmu_notifier.h                  | 147 ++++-
 include/rdma/ib_umem_odp.h                    |  68 +--
 include/rdma/ib_verbs.h                       |   2 -
 kernel/fork.c                                 |   1 -
 mm/Kconfig                                    |   2 +-
 mm/hmm.c                                      | 276 +--------
 mm/mmu_notifier.c                             | 565 +++++++++++++++++-
 31 files changed, 1271 insertions(+), 1931 deletions(-)

-- 
2.24.0

