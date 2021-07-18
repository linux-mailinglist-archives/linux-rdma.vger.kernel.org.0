Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE73CC8AE
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGRLMQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 07:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhGRLMQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 07:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FAF561166;
        Sun, 18 Jul 2021 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626606558;
        bh=scysiXjyferckCGbthGvR8xqveehOph98QgmtZIcrec=;
        h=From:To:Cc:Subject:Date:From;
        b=XNrMJtjIYfhN0XTG3RHYKnxAldtmMPe3Fn0tYzrYyOc78jO/VZ7uH/sHudWjRpkiP
         yZLIgj8DXTnC15yOHZ62829FXeY2Ylj1hfLGbcahe50CKpZOaFEwF509uzrVf0XmQq
         zXSSnU+F418MiGnCpbYvqomVTOuZOYCSHVdOoXVHnz+VJQsymAScSGgGet+gdvGtU4
         SyhAgAPAtdBDP/5e0cts9gfcDq5FfYoxtiPFX7811Rm6Wue+ucosWfB3uyrtxjtEuD
         hXlJfssJ96pNrvx3E/7kuAe86zgezKeuERXXD3k0Q2LAAUYlEZRPDfirtPvTHrpCcT
         1K7JSLV5lg+zQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
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
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zack Rusin <zackr@vmware.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v2 0/2] SG fix together with update to RDMA umem
Date:   Sun, 18 Jul 2021 14:09:11 +0300
Message-Id: <cover.1626605893.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
 * Changed implementation of first patch, based on our discussion with Christoph.
   https://lore.kernel.org/lkml/YNwaVTT0qmQdxaZz@infradead.org/
v1: https://lore.kernel.org/lkml/cover.1624955710.git.leonro@nvidia.com/
 * Fixed sg_page with a _dma_ API in the umem.c
v0: https://lore.kernel.org/lkml/cover.1624361199.git.leonro@nvidia.com

Maor Gottlieb (2):
  lib/scatterlist: Fix wrong update of orig_nents
  RDMA: Use dma_map_sgtable for map umem pages

 drivers/gpu/drm/drm_prime.c                 |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  2 +-
 drivers/infiniband/core/umem.c              | 33 +++-----
 drivers/infiniband/core/umem_dmabuf.c       |  1 -
 drivers/infiniband/hw/mlx4/mr.c             |  4 +-
 drivers/infiniband/hw/mlx5/mr.c             |  3 +-
 drivers/infiniband/sw/rdmavt/mr.c           |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c          |  3 +-
 include/linux/scatterlist.h                 |  3 +-
 include/rdma/ib_umem.h                      |  6 +-
 include/rdma/ib_verbs.h                     | 28 +++++++
 lib/scatterlist.c                           | 88 ++++++++++++++-------
 tools/testing/scatterlist/main.c            | 15 +++-
 14 files changed, 128 insertions(+), 64 deletions(-)

-- 
2.31.1

