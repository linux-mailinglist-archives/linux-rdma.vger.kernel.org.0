Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8B265368
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIJVeK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbgIJNuh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 09:50:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53FE20809;
        Thu, 10 Sep 2020 13:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599745385;
        bh=HS8wsmWliqw+vjJ423NAWe4CfnIUGKglNawk6e/Lpxc=;
        h=From:To:Cc:Subject:Date:From;
        b=v68CyWmYUwHBBsPt4GggNokqZGoCyVhYssoIlWXKk89FPtJaabSRsh9pjI+3fhDJ7
         W+177d2NwJl1JZZEtCOB7BZy0gQe/Q8hbhtfocsskQ4WlX8Drl4bywg1MoNnirjWxD
         NleEcOIZHybs7oeRQofnPYjrQ9jryVLrKXCzGT6Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     iChristoph Hellwig <hch@lst.de>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next v1 0/4] scatterlist: add sg_alloc_table_append function
Date:   Thu, 10 Sep 2020 16:42:55 +0300
Message-Id: <20200910134259.1304543-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
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

Maor Gottlieb (4):
  lib/scatterlist: Refactor sg_alloc_table_from_pages
  lib/scatterlist: Add support in dynamically allocation of SG entries
  lib/scatterlist: Add support in dynamic allocation of SG table from
    pages
  RDMA/umem: Move to allocate SG table from pages

 drivers/infiniband/Kconfig     |   1 +
 drivers/infiniband/core/umem.c |  90 ++--------
 include/linux/scatterlist.h    |  35 ++--
 lib/scatterlist.c              | 292 +++++++++++++++++++++++++--------
 4 files changed, 255 insertions(+), 163 deletions(-)

--
2.26.2

