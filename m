Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7E5AF89
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 11:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF3JLE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 05:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfF3JLD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jun 2019 05:11:03 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289572064A;
        Sun, 30 Jun 2019 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561885862;
        bh=g758ugTVuXfBcamC0qng5HmtyW+0SbT3eQzioY2iiVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=wMY+sJeZK5kPl5dOo8rJH8WIyyG7zjVZOxwCzD6lzTXt8fuF5HAMsNfpnEIIUstWx
         eX1ScSvL1ab2muIQzzVuCUjCsTKML5Z0q4LihbE8iuIHYwYH3y1uByKryc2XUg/U72
         3gKxAyapvGvuepI1N5+W9khaif11fnXLpq0Q8Pys=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>
Subject: [PATCH rdma-next v3 0/3] Use RDMA adaptive moderation library
Date:   Sun, 30 Jun 2019 12:10:54 +0300
Message-Id: <20190630091057.11507-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is RDMA part of previously sent DIM library improvements series
[1], which was pulled by Dave. It needs to be pulled to RDMA too as
a pre-requirements.

Changes since v2:
- renamed user-space knob from dim to adaptive-moderation (Sagi)
- some minor code clean ups (Sagi)
- Reordered patches to ensure that netlink expose is last in the series.
- Slightly cleaned commit messages
- Changed "bool use_cq_dim" flag to be bitwise to save space.

Changes since v1:
- added per ib device configuration knob for rdma-dim (Sagi)
- add NL directives for user-space / rdma tool to configure rdma dim
  (Sagi/Leon)
- use one header file for DIM implementations (Leon)
- various point changes in the rdma dim related code in the IB core
  (Leon)
- removed the RDMA specific patches form this pull request\

Thanks

[1] https://www.spinics.net/lists/netdev/msg581046.html

Yamin Friedman (3):
  linux/dim: Implement RDMA adaptive moderation (DIM)
  RDMA/core: Provide RDMA DIM support for ULPs
  RDMA/nldev: Added configuration of RDMA dynamic interrupt moderation
    to netlink

 drivers/infiniband/Kconfig          |   1 +
 drivers/infiniband/core/core_priv.h |   1 +
 drivers/infiniband/core/cq.c        |  45 ++++++++++++
 drivers/infiniband/core/device.c    |   9 +++
 drivers/infiniband/core/nldev.c     |  14 ++++
 drivers/infiniband/hw/mlx5/main.c   |   2 +
 include/linux/dim.h                 |  36 ++++++++++
 include/rdma/ib_verbs.h             |   4 ++
 include/uapi/rdma/rdma_netlink.h    |   5 ++
 lib/dim/Makefile                    |   6 +-
 lib/dim/rdma_dim.c                  | 108 ++++++++++++++++++++++++++++
 11 files changed, 227 insertions(+), 4 deletions(-)
 create mode 100644 lib/dim/rdma_dim.c

--
2.20.1

