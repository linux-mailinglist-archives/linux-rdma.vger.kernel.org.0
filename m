Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650A61B6421
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgDWTDL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 15:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDWTDK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 15:03:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2E520728;
        Thu, 23 Apr 2020 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668590;
        bh=fV4hS5vC5zAI09G1v+Nac9F6wR9rmXGc8WgEFUdyEHk=;
        h=From:To:Cc:Subject:Date:From;
        b=KuxzHIxoHvSqGwqSK42KIinZ/xNucnGpXM/0nXMSKR7VcYYfKmlLN5XrfHHNYd28X
         BEX5gqUsKCVLSqyC1Ok2nD97OxbaMiEiXyKLphYkbdxkPSlAsCHaQnr1Tnfu8FmkcH
         zccM8QeLoqhdD67U5oNC0x0y/Hb1Dda+lNsdUCko=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>
Subject: [PATCH rdma-next 00/18] Refactor mlx5_ib_create_qp (Part II)
Date:   Thu, 23 Apr 2020 22:02:45 +0300
Message-Id: <20200423190303.12856-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is second part of refactor mlx5_ib_create_qp() series [1] with one
extra fix from Aharon.

It is based on [1].

Thanks

[1] https://lore.kernel.org/lkml/20200420151105.282848-1-leon@kernel.org

Aharon Landau (1):
  RDMA/mlx5: Verify that QP is created with RQ or SQ

Leon Romanovsky (17):
  RDMA/mlx5: Delete unsupported QP types
  RDMA/mlx5: Store QP type in the vendor QP structure
  RDMA/mlx5: Promote RSS RAW QP attribute check in higher level
  RDMA/mlx5: Combine copy of create QP command in RSS RAW QP
  RDMA/mlx5: Remove second user copy in create_user_qp
  RDMA/mlx5: Rely on existence of udata to separate kernel/user flows
  RDMA/mlx5: Delete impossible inlen check
  RDMA/mlx5: Globally parse DEVX UID
  RDMA/mlx5: Separate XRC_TGT QP creation from common flow
  RDMA/mlx5: Separate to user/kernel create QP flows
  RDMA/mlx5: Reduce amount of duplication in QP destroy
  RDMA/mlx5: Group all create QP parameters to simplify in-kernel
    interfaces
  RDMA/mlx5: Promote RSS RAW QP flags check to higher level
  RDMA/mlx5: Handle udate outlen checks in one place
  RDMA/mlx5: Copy response to the user in one place
  RDMA/mlx5: Remove redundant destroy QP call
  RDMA/mlx5: Consolidate into special function all create QP calls

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  22 +-
 drivers/infiniband/hw/mlx5/odp.c     |   3 +-
 drivers/infiniband/hw/mlx5/qp.c      | 989 ++++++++++++++++-----------
 3 files changed, 586 insertions(+), 428 deletions(-)

--
2.25.3

