Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251A53B02F0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFVLmF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 07:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhFVLmE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 07:42:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76183611AF;
        Tue, 22 Jun 2021 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624361989;
        bh=Ms8lyqUk3raqor8hjWfiwFmQ9GUWGqntNvUxtIlUoBk=;
        h=From:To:Cc:Subject:Date:From;
        b=QGKgdajHmOt1Eq4z8HpBM0XQU1UBQhP+861j7wWVunMi51yDZ4o/+poYEOOL0TxCM
         Y5BTEhLY4yaPISgraXmAFUWbUXzmIYYvm65kuvQC/y8LBvC/YQ9dsBJm0nq2MwnRpl
         Y92cmi/0d7I82hvgEPnIfOhCFT9inmDM7yBEhJlbM+QbSyzBCSroGVdfuwHKxn9pGC
         Y4Iu+Hc422ho08xqL/LPnneetPa6tifj0+cm/0xdcosFvgUqfk7UmdzRl7/BrlflkY
         Lu5YF6smzc3ETrpWGNr25bggP+BsUrQ65VJq4Cyt6uxmpfQJSPLr3feohGlzQaRFkt
         6/nj4SScImw7g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 0/2] SG fix together with update to RDMA umem
Date:   Tue, 22 Jun 2021 14:39:40 +0300
Message-Id: <cover.1624361199.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Christoph, what do you think about first patch?

Thanks

Maor Gottlieb (2):
  lib/scatterlist: Fix wrong update of orig_nents
  RDMA: Use dma_map_sgtable for map umem pages

 drivers/infiniband/core/umem.c        | 29 +++++++++---------------
 drivers/infiniband/core/umem_dmabuf.c |  1 -
 drivers/infiniband/hw/mlx4/mr.c       |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c       |  3 ++-
 drivers/infiniband/sw/rdmavt/mr.c     |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  3 ++-
 include/linux/scatterlist.h           |  8 +++++--
 include/rdma/ib_umem.h                |  5 ++---
 include/rdma/ib_verbs.h               | 28 +++++++++++++++++++++++
 lib/scatterlist.c                     | 32 +++++++--------------------
 10 files changed, 62 insertions(+), 53 deletions(-)

-- 
2.31.1

