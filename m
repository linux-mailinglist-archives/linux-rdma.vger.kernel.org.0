Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB82E282B7C
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgJDPnr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 11:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgJDPnr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 11:43:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CCDD206C1;
        Sun,  4 Oct 2020 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601826227;
        bh=7kcJRhYO8i8a8NUKH4udVbO1HkOL8u4Fb50Z6E77+LI=;
        h=From:To:Cc:Subject:Date:From;
        b=H+BZCGU5zKMw0E4CuPMwdOlui4sRFV1k6qd+Zztd0AqnYH/Uuu2wXnkFzbKmDPqUu
         oDmIYyWjMJMq+Nw0734D5+yiw04lOPVHCfc+9fooZPZZOOacYE4aBXO7i4rNT0a9Q7
         /AaNSm6AsTTkWa+263mOggATwZ5UYuk6iNawyyic=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: [PATCH rdma-next v5 0/4] Dynamicaly allocate SG table from the pages
Date:   Sun,  4 Oct 2020 18:43:36 +0300
Message-Id: <20201004154340.1080481-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v5:
 * Use sg_init_table to allocate table and avoid changes is __sg_alloc_table
 * Fix offset issue
v4: https://lore.kernel.org/lkml/20200927064647.3106737-1-leon@kernel.org
 * Fixed formatting in first patch.
 * Added fix (clear tmp_netnts) in first patch to fix i915 failure.
 * Added test patches
v3: https://lore.kernel.org/linux-rdma/20200922083958.2150803-1-leon@kernel.org/
 * Squashed Christopher's suggestion to avoid introduced new API, but extend existing one.
v2: https://lore.kernel.org/linux-rdma/20200916140726.839377-1-leon@kernel.org
 * Fixed indentations and comments
 * Deleted sg_alloc_next()
 * Squashed lib/scatterlist patches into one
v1: https://lore.kernel.org/lkml/20200910134259.1304543-1-leon@kernel.org
 * Changed _sg_chain to be __sg_chain
 * Added dependency on ARCH_NO_SG_CHAIN
 * Removed struct sg_append
v0:
 * https://lore.kernel.org/lkml/20200903121853.1145976-1-leon@kernel.org

--------------------------------------------------------------------------
From Maor:

This series extends __sg_alloc_table_from_pages to allow chaining of
new pages to already initialized SG table.

This allows for the drivers to utilize the optimization of merging contiguous
pages without a need to pre allocate all the pages and hold them in
a very large temporary buffer prior to the call to SG table initialization.

The second patch changes the Infiniband driver to use the new API. It
removes duplicate functionality from the code and benefits the
optimization of allocating dynamic SG table from pages.

In huge pages system of 2MB page size, without this change, the SG table
would contain x512 SG entries.
E.g. for 100GB memory registration:

             Number of entries      Size
    Before        26214400          600.0MB
    After            51200            1.2MB

Thanks

Maor Gottlieb (2):
  lib/scatterlist: Add support in dynamic allocation of SG table from
    pages
  RDMA/umem: Move to allocate SG table from pages

Tvrtko Ursulin (2):
  tools/testing/scatterlist: Rejuvenate bit-rotten test
  tools/testing/scatterlist: Show errors in human readable form

 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  15 ++-
 drivers/infiniband/core/umem.c              |  94 ++-------------
 include/linux/scatterlist.h                 |  38 +++---
 lib/scatterlist.c                           | 125 ++++++++++++++++----
 tools/testing/scatterlist/Makefile          |   3 +-
 tools/testing/scatterlist/linux/mm.h        |  35 ++++++
 tools/testing/scatterlist/main.c            |  53 ++++++---
 8 files changed, 225 insertions(+), 150 deletions(-)

--
2.26.2

