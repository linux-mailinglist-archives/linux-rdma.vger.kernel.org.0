Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618F9CAFEE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfJCUUL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbfJCUUL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94374B03B;
        Thu,  3 Oct 2019 20:20:08 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -next 00/11] lib/interval-tree: move to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:47 -0700
Message-Id: <20191003201858.11666-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

It has been discussed[1,2] that almost all users of interval trees would better
be served if the intervals were actually not [a,b], but instead [a, b). This
series attempts to convert all callers by way of transitioning from using
"interval_tree_generic.h" to "interval_tree_gen.h". Once all users are converted,
we remove the former.

Patch 1: adds a call that will make patch 8 easier to review by introducing stab
         queries for the vma interval tree.

Patch 2: adds the new interval_tree_gen.h which is the same as the old one but
         uses [a,b) intervals.

Patch 3-9: converts, in baby steps (as much as possible), each interval tree to
	   the new [a,b) one. It is done this way also to maintain bisectability.
	   Most conversions are pretty straightforward, however, there are some
	   creative ways in which some callers use the interval 'end' when going
	   through intersecting ranges within a tree. Ie: patch 3, 6 and 9.

Patch 10: deletes the interval_tree_generic.h header; there are no longer any users.

Patch 11: finally simplifies x86 pat tree to use the new interval tree machinery.

This has been lightly tested, and certainly not on driver paths that do non
trivial conversions. Also needs more eyeballs as conversions can be easily
missed (even when I've tried mitigating this by renaming the endpoint from 'last'
to 'end' in each corresponding structure).

Because this touches a lot of drivers, I'm Cc'ing the whole thing to a couple of
relevant lists (mm, dri, rdma); sorry if you consider this spam.

Applies on top of today's linux-next tree. Please consider for v5.5.

Thanks!

[1] https://lore.kernel.org/lkml/CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com/
[2] https://lore.kernel.org/patchwork/patch/1114629/

Davidlohr Bueso (11):
  mm: introduce vma_interval_tree_foreach_stab()
  lib/interval-tree: add an equivalent tree with [a,b) intervals
  drm/amdgpu: convert amdgpu_vm_it to half closed intervals
  drm: convert drm_mm_interval_tree to half closed intervals
  IB/hfi1: convert __mmu_int_rb to half closed intervals
  IB,usnic: convert usnic_uiom_interval_tree to half closed intervals
  vhost: convert vhost_umem_interval_tree to half closed intervals
  mm: convert vma_interval_tree to half closed intervals
  lib/interval-tree: convert interval_tree to half closed intervals
  lib: drop interval_tree_generic.h
  x86/mm, pat: convert pat tree to generic interval tree

 arch/arm/mm/fault-armv.c                           |   2 +-
 arch/arm/mm/flush.c                                |   2 +-
 arch/nios2/mm/cacheflush.c                         |   2 +-
 arch/parisc/kernel/cache.c                         |   2 +-
 arch/x86/mm/pat.c                                  |  22 +--
 arch/x86/mm/pat_rbtree.c                           | 151 +++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |  18 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  47 ++++---
 drivers/gpu/drm/drm_mm.c                           |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   5 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |   2 +-
 drivers/gpu/drm/radeon/radeon_mn.c                 |  11 +-
 drivers/gpu/drm/radeon/radeon_trace.h              |   2 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |  26 ++--
 drivers/gpu/drm/selftests/test-drm_mm.c            |   2 +-
 drivers/infiniband/core/umem_odp.c                 |  21 +--
 drivers/infiniband/hw/hfi1/mmu_rb.c                |  15 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |   8 +-
 .../infiniband/hw/usnic/usnic_uiom_interval_tree.c |  26 ++--
 .../infiniband/hw/usnic/usnic_uiom_interval_tree.h |   2 +-
 drivers/iommu/virtio-iommu.c                       |   6 +-
 drivers/vhost/vhost.c                              |  19 ++-
 drivers/vhost/vhost.h                              |   4 +-
 fs/dax.c                                           |   2 +-
 include/drm/drm_mm.h                               |   6 +-
 include/linux/interval_tree.h                      |   2 +-
 ...interval_tree_generic.h => interval_tree_gen.h} |  72 +++++-----
 include/linux/mm.h                                 |   6 +
 include/rdma/ib_umem_odp.h                         |   4 +-
 kernel/events/uprobes.c                            |   2 +-
 lib/interval_tree.c                                |   6 +-
 mm/hugetlb.c                                       |   4 +-
 mm/interval_tree.c                                 |   4 +-
 mm/khugepaged.c                                    |   2 +-
 mm/memory-failure.c                                |   6 +-
 mm/memory.c                                        |   2 +-
 mm/nommu.c                                         |   2 +-
 mm/rmap.c                                          |   6 +-
 43 files changed, 217 insertions(+), 333 deletions(-)
 rename include/linux/{interval_tree_generic.h => interval_tree_gen.h} (72%)

-- 
2.16.4

