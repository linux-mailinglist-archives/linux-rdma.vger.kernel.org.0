Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7219EE803C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfJ2G1w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJ2G1w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:27:52 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E65020862;
        Tue, 29 Oct 2019 06:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330471;
        bh=C6GdiWP4hUIjqrMXlM6Lc4WNt5ioxACVCuzH9f32vJY=;
        h=From:To:Cc:Subject:Date:From;
        b=HQ8B/aDdxUSZ6qtLS0aa6+3f27O0xoiQdo3+40OaldTPy9LcDoQoIBboAGyNs6apH
         li8I7F0tvjgQQqvwMuoJIn98ce3XN7WrqTIUwfo4hGdLOubNtCoom1ylUpsBMtO0tc
         S52+p14d+dQBSQJrLubmh/KrccqcHGF+ia2Hf5Hk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 00/16] MAD cleanup
Date:   Tue, 29 Oct 2019 08:27:29 +0200
Message-Id: <20191029062745.7932-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Let's clean MAD code a little bit.

It is based on
https://lore.kernel.org/linux-rdma/20191027070621.11711-1-leon@kernel.org

Thanks

Leon Romanovsky (16):
  RDMA/mad: Delete never implemented functions
  RDMA/mad: Allocate zeroed MAD buffer
  RDMA/mlx4: Delete redundant zero memset
  RDMA/mlx5: Delete redundant zero memset
  RDMA/ocrdma: Clean MAD processing logic
  RDMA/qib: Delete redundant memset for MAD output buffer
  RDMA/hfi1: Delete unreachable code
  RDMA/mlx4: Delete unreachable code
  RDMA/mlx5: Delete unreachable code
  RDMA/mthca: Delete unreachable code
  RDMA/ocrdma: Simplify process_mad function
  RDMA/qib: Delete unreachable code
  RDMA/mlx5: Rewrite MAD processing logic to be readable
  RDMA/qib: Delete extra line
  RDMA/qib: Delete unused variable in process_cc call
  RDMA: Change MAD processing function to remove extra casting and
    parameter

 drivers/infiniband/core/mad.c               |  31 +----
 drivers/infiniband/core/sysfs.c             |  10 +-
 drivers/infiniband/hw/hfi1/mad.c            |  17 +--
 drivers/infiniband/hw/hfi1/verbs.h          |   5 +-
 drivers/infiniband/hw/mlx4/mad.c            |  30 ++---
 drivers/infiniband/hw/mlx4/mlx4_ib.h        |   7 +-
 drivers/infiniband/hw/mlx5/mad.c            | 124 +++++++++-----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h        |   5 +-
 drivers/infiniband/hw/mthca/mthca_dev.h     |  12 +-
 drivers/infiniband/hw/mthca/mthca_mad.c     |  74 +++++-------
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c    |  33 ++----
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h    |  11 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c |   5 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.h |   3 +-
 drivers/infiniband/hw/qedr/verbs.c          |  17 +--
 drivers/infiniband/hw/qedr/verbs.h          |   7 +-
 drivers/infiniband/hw/qib/qib_iba6120.c     |   1 -
 drivers/infiniband/hw/qib/qib_mad.c         |  38 +-----
 drivers/infiniband/hw/qib/qib_verbs.h       |   5 +-
 include/rdma/ib_mad.h                       |  40 -------
 include/rdma/ib_verbs.h                     |   7 +-
 21 files changed, 155 insertions(+), 327 deletions(-)

--
2.20.1

