Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93203DA05C
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhG2JjW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 05:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhG2JjW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 05:39:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E4EA61057;
        Thu, 29 Jul 2021 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627551559;
        bh=bDAURyhadET89IRU1m1b8zk8bNFLICeWHLbOoJ7WmYI=;
        h=From:To:Cc:Subject:Date:From;
        b=JiGwE20En/csSY5rJ9StWSWNMk4nXmxRvbwXOpwRCibBpFSieTZqVtDbSVMOq3aVz
         HJaCMMSPrtSkJioS4ITSdcoK6LF4SDnrdBUqfnTPNq85XB1Nwo9Z874djamC7d+7WW
         AtyMIPr5+D4q92ipsIJRkwgr02zhklDX4GgkMOsT4iRLG9X/ezE1yW/+jVykbIDbf7
         5r1JuKggLh/CQYUryjfjA8JBU3F6/27LUJ1fkC7YP/3UqohDhoVV6hVXz3WTNTQVgZ
         dEDA+4t/Skp30e8obvwLSchw289W3Tyyn6mMi4e9R3shob/TwLmFHVa1SFrL8JwBhM
         FMF6MQ6wLR+Xg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zack Rusin <zackr@vmware.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v3 0/3] SG fix together with update to RDMA umem
Date:   Thu, 29 Jul 2021 12:39:10 +0300
Message-Id: <cover.1627551226.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
 * Rewrote to new API suggestion
 * Split for more patches
v2: https://lore.kernel.org/lkml/cover.1626605893.git.leonro@nvidia.com
 * Changed implementation of first patch, based on our discussion with Christoph.
   https://lore.kernel.org/lkml/YNwaVTT0qmQdxaZz@infradead.org/
v1: https://lore.kernel.org/lkml/cover.1624955710.git.leonro@nvidia.com/
 * Fixed sg_page with a _dma_ API in the umem.c
v0: https://lore.kernel.org/lkml/cover.1624361199.git.leonro@nvidia.com


Maor Gottlieb (3):
  lib/scatterlist: Provide a dedicated function to support table append
  lib/scatterlist: Fix wrong update of orig_nents
  RDMA: Use the sg_table directly and remove the opencoded version from
    umem

 drivers/gpu/drm/drm_prime.c                 |  13 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  14 +-
 drivers/infiniband/core/umem.c              |  56 +++---
 drivers/infiniband/core/umem_dmabuf.c       |   5 +-
 drivers/infiniband/hw/hns/hns_roce_db.c     |   4 +-
 drivers/infiniband/hw/irdma/verbs.c         |   2 +-
 drivers/infiniband/hw/mlx4/doorbell.c       |   3 +-
 drivers/infiniband/hw/mlx4/mr.c             |   4 +-
 drivers/infiniband/hw/mlx5/doorbell.c       |   3 +-
 drivers/infiniband/hw/mlx5/mr.c             |   3 +-
 drivers/infiniband/hw/qedr/verbs.c          |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c           |   2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c          |   2 +-
 include/linux/scatterlist.h                 |  54 +++++-
 include/rdma/ib_umem.h                      |  11 +-
 include/rdma/ib_verbs.h                     |  28 +++
 lib/scatterlist.c                           | 189 ++++++++++++--------
 tools/testing/scatterlist/main.c            |  38 ++--
 19 files changed, 275 insertions(+), 169 deletions(-)

-- 
2.31.1

