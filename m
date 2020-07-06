Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDA21572E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgGFM1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgGFM1W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:27:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6F4206E6;
        Mon,  6 Jul 2020 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594038442;
        bh=3NgDBAsTGnoQa6qhMue/dHhqsK40idYj8kGC1DVucWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oz/LggZ7DTTN0dWqUEsICZYinaSvPxjQihrTZ86oO5l+9H8mv14wixdXzXx04KDMd
         vQrd8S2nRLLROUBWGdMr9CztSAtgXJpwFoT4g2AiXF9clgoj3AcoFQOHkC3ZsD9SMQ
         4FPUD2KS6gUUVHpqhuqH9psgzb854wYc7NqrJeV8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v2 0/3] Convert XRC to use xarray
Date:   Mon,  6 Jul 2020 15:27:13 +0300
Message-Id: <20200706122716.647338-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
v2: Rewrote mlx5 part to avoid ib_xrcd allocation.
v1: https://lore.kernel.org/lkml/20200623111531.1227013-1-leon@kernel.org
Changed ib_dealloc_xrcd_user() do not iterate over tgt list, because
it is expected to be empty.
v0: https://lore.kernel.org/lkml/20200621104110.53509-1-leon@kernel.org
Two small patches to simplify and improve XRC logic.

Thanks

Leon Romanovsky (1):
  RDMA/mlx5: Get XRCD number directly for the internal use

Maor Gottlieb (2):
  RDMA/core: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
  RDMA/core: Optimize XRC target lookup

 drivers/infiniband/core/uverbs_cmd.c | 12 ++---
 drivers/infiniband/core/verbs.c      | 81 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/main.c    | 39 +++++---------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 +-
 drivers/infiniband/hw/mlx5/qp.c      | 10 ++--
 drivers/infiniband/hw/mlx5/srq.c     |  4 +-
 include/rdma/ib_verbs.h              | 23 ++------
 7 files changed, 70 insertions(+), 103 deletions(-)

--
2.26.2

