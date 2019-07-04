Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22A5F8A4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGDM5s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 08:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfGDM5s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 08:57:48 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F7672189E;
        Thu,  4 Jul 2019 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245068;
        bh=L+505R5nN9hY0PrBl0VtyIfGZw+NiWTLqAURX5FrqhY=;
        h=From:To:Cc:Subject:Date:From;
        b=Th8RB/fQ+3BitA2a0wZpm5JXXbs8STdgfUMJVrj4N+DG06yoc0eecUA5JaNQNg8ty
         KE5/6FiTDCTXTcON6SlU3p+rw0+GBs1OmaMTNHxSKmsYmu2SxVPhZMxUH2agY7sVAm
         1+6NiX2qh/y3TKptH+0ZRFxX4g4EqsN+y2m8e4kE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH rdma-next v4 0/3] Use RDMA adaptive moderation library
Date:   Thu,  4 Jul 2019 15:57:40 +0300
Message-Id: <20190704125743.7814-1-leon@kernel.org>
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

Changes since v3:
 * Renamed dim_owner to be priv
 * Added Sagi's ROBs
 * Removed casting of void pointer.

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

