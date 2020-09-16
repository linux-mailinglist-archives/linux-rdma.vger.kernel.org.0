Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399026C557
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIPQvS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 12:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgIPQd2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24120223B0;
        Wed, 16 Sep 2020 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600265251;
        bh=cII9mj55pmXgShjlkZ7NshJrxR6bjr/Y2XBOt6tt+L0=;
        h=From:To:Cc:Subject:Date:From;
        b=I5t17Wk9nz5gXWUtqZyE6pMaVL7bUEPljSp6M6mUKW0RUDT1yQ05WG3TTXYvOteyT
         87hyeAoWfwPDVH/5GViawou33yG5yAj0VeZlxvT4+y+exAN3D9SJzKY0PSM50963Q0
         axTnarEAu03VKe7q3qjKkRU2s0gMoxkTuSuGceyw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next v2 0/2] scatterlist: add sg_alloc_table_append function
Date:   Wed, 16 Sep 2020 17:07:24 +0300
Message-Id: <20200916140726.839377-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
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

This series adds a new constructor for a scatter gather table. Like
sg_alloc_table_from_pages function, this function merges all contiguous
chunks of the pages a into single scatter gather entry.

In contrast to sg_alloc_table_from_pages, the new API allows chaining of
new pages to already initialized SG table.

This allows drivers to utilize the optimization of merging contiguous
pages without a need to pre allocate all the pages and hold them in
a very large temporary buffer prior to the call to SG table initialization.

The first two patches refactor the code of sg_alloc_table_from_pages
in order to have code sharing and add sg_alloc_next function to allow
dynamic allocation of more entries in the SG table.

The third patch introduces the new API.

The last patch changes the Infiniband driver to use the new API. It
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

 drivers/infiniband/core/umem.c |  90 ++---------
 include/linux/scatterlist.h    |  34 ++--
 lib/scatterlist.c              | 273 ++++++++++++++++++++++++---------
 3 files changed, 234 insertions(+), 163 deletions(-)

--
2.26.2

