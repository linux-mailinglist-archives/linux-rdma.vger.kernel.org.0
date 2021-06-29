Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46B3B6F91
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhF2Img (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 04:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232479AbhF2Img (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 04:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1081461DBA;
        Tue, 29 Jun 2021 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624956009;
        bh=lV0B4f7t9GgGdPJd59c4wuaJ0d1zIi57xoXYvv9sV0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=homUkNeO8hxXRXHmwOx7Tj8ymm3HlTx3AAC6Jy5+xguHhvV7Z1XXgJorlfwonmHsR
         u+wTOy7HJVdox5smLutLNgIO60VPMKfVaxbdtdj0aHnqd/12Lno94PWWdbdmP8byTh
         mnEreMxK8nIHt5mEs5YQAsNZ3rfD2e+ctHEWuZ/9dNEML8OCX4DknYsGgLnP59BfD9
         zRazy/3KLn/Y5gnnLdr+RihqdrBKE0WTcGATiRoE5UI+Mya7MtHp+dVgbpVec+SfBX
         USsSkJMaGhCKT2cUBxVHGC1a2oVMZ94a1WmDx5rfEFNL5aamDAW7rUXUV+dUv8Knxm
         j5yDCYHbLnOaQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 0/2] SG fix together with update to RDMA umem
Date:   Tue, 29 Jun 2021 11:40:00 +0300
Message-Id: <cover.1624955710.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Fixed sg_page with a _dma_ API in the umem.c
v0: https://lore.kernel.org/lkml/cover.1624361199.git.leonro@nvidia.com

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

