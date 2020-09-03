Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9025C48F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgICPMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgICMTH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 08:19:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5F520678;
        Thu,  3 Sep 2020 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599135539;
        bh=wCOPLXlmHEGYn5CATKOPZbt394577U8KrrxC4c41eGA=;
        h=From:To:Cc:Subject:Date:From;
        b=Fwb9EwN5Nzx6MGZlSGn75Jjszvk/sKs+LWYm2mNw0CKoIQX3PcEW2/ZEUsiuQHZqD
         BZUaqwPL+2JIfkDHpiZZb5mzQUws6OhsDURmHS7gI79QytxmvWn6Zv22AmHJDf4JjS
         FG1+i/GKoOZ2fYyn5RGLBq/7MNgDBZn++tI9tCMc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next 0/4] scatterlist: add sg_alloc_table_append function
Date:   Thu,  3 Sep 2020 15:18:49 +0300
Message-Id: <20200903121853.1145976-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

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

 drivers/infiniband/core/umem.c |  93 ++--------
 include/linux/scatterlist.h    |  39 +++--
 lib/scatterlist.c              | 302 +++++++++++++++++++++++++--------
 3 files changed, 271 insertions(+), 163 deletions(-)

--
2.26.2

