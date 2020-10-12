Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB61628AD65
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 06:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJLE4I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 00:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJLE4I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 00:56:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0BE2076C;
        Mon, 12 Oct 2020 04:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602478567;
        bh=kPt9XZJOp0Cbqt+/5wIeYXokd4ZA7ROyGHIfA+eHTu0=;
        h=From:To:Cc:Subject:Date:From;
        b=aDaxTK9X5WbLET8rI6AA3MnX4GEqSTtFtlBDYq6Hcf5PuP0nfXATqogQXe3VMSjUi
         DL3gFl8zoyyYVdPQg401vXQYvKpcrK76jm0VhKEf4+vIeUtphK2qd4JJ4EhWS01hvl
         6MQgNp5LI/GHWIha8yJn2xWcA3Wduz2RKR0F199A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 0/3] Fixes to coming PR
Date:   Mon, 12 Oct 2020 07:55:57 +0300
Message-Id: <20201012045600.418271-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Leon Romanovsky (2):
  RDMA/core: Postpone uobject cleanup on failure till FD close
  RDMA/core: Make FD destroy callback void

Maor Gottlieb (1):
  RDMA/ucma: Fix use after free in destroy id flow

 drivers/infiniband/core/rdma_core.c           | 45 ++++++++-----------
 drivers/infiniband/core/ucma.c                | 11 ++---
 drivers/infiniband/core/uverbs_cmd.c          |  5 +--
 drivers/infiniband/core/uverbs_std_types.c    | 18 +++-----
 .../core/uverbs_std_types_async_fd.c          |  5 +--
 .../core/uverbs_std_types_counters.c          |  5 +--
 drivers/infiniband/core/uverbs_std_types_cq.c |  4 +-
 drivers/infiniband/core/uverbs_std_types_dm.c |  6 +--
 .../core/uverbs_std_types_flow_action.c       |  6 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  4 +-
 .../infiniband/core/uverbs_std_types_srq.c    |  4 +-
 drivers/infiniband/core/uverbs_std_types_wq.c |  4 +-
 drivers/infiniband/hw/mlx5/devx.c             | 14 +++---
 drivers/infiniband/hw/mlx5/fs.c               |  6 +--
 include/rdma/ib_verbs.h                       | 42 -----------------
 include/rdma/uverbs_types.h                   |  4 +-
 16 files changed, 59 insertions(+), 124 deletions(-)

--
2.26.2

