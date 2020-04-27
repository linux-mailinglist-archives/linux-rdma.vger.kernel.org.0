Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DECC1BA84D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0Pqn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgD0Pqn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:46:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC4E92064C;
        Mon, 27 Apr 2020 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002402;
        bh=tc5OWjlRqM2rrO49I8iXuFIadw58S97c3aV2l7xUdzk=;
        h=From:To:Cc:Subject:Date:From;
        b=kwnUwgrJ4t3iTh8YEUEFLAHcItyItMFcq0e0I0OHjJLGrWydhNi6SFP0KayJEhRsi
         arjv2p9RN/1p1R+33ML7qDWIIg8m/AwhXY9BfwduiIhuPWOdjcHu3SQq/REaNppRKj
         WK46zHrY/lqc/o1F7bGJS0hWe6/11tp6QjSBsO/U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 00/36] Refactor mlx5_ib_create_qp
Date:   Mon, 27 Apr 2020 18:46:00 +0300
Message-Id: <20200427154636.381474-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog
v1: * Combined both series to easy apply
    * Rebsed on top of rdma-next + mlx5-next
    * Fixed create_qp flags check
v0: https://lore.kernel.org/lkml/20200420151105.282848-1-leon@kernel.org
    https://lore.kernel.org/lkml/20200423190303.12856-1-leon@kernel.org

-----------------------------------------------------------------------------

Hi,

This is first part of series which tries to return some sanity
to mlx5_ib_create_qp() function. Such refactoring is required
to make extension of that function with less worries of breaking
driver.

Extra goal of such refactoring is to ensure that QP is allocated
at the beginning of function and released at the end. It will allow
us to move QP allocation to be under IB/core responsibility.

It is based on previously sent [1] "[PATCH mlx5-next 00/24] Mass
conversion to light mlx5 command interface"

Thanks

[1]
https://lore.kernel.org/linux-rdma/20200420114136.264924-1-leon@kernel.org

Aharon Landau (1):
  RDMA/mlx5: Verify that QP is created with RQ or SQ

Leon Romanovsky (35):
  RDMA/mlx5: Organize QP types checks in one place
  RDMA/mlx5: Delete impossible GSI port check
  RDMA/mlx5: Perform check if QP creation flow is valid
  RDMA/mlx5: Prepare QP allocation for future removal
  RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
  RDMA/mlx5: Set QP subtype immediately when it is known
  RDMA/mlx5: Separate create QP flows to be based on type
  RDMA/mlx5: Split scatter CQE configuration for DCT QP
  RDMA/mlx5: Update all DRIVER QP places to use QP subtype
  RDMA/mlx5: Move DRIVER QP flags check into separate function
  RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
  RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
  RDMA/mlx5: Delete create QP flags obfuscation
  RDMA/mlx5: Process create QP flags in one place
  RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE
    signature
  RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
  RDMA/mlx5: Return all configured create flags through query QP
  RDMA/mlx5: Process all vendor flags in one place
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

 drivers/infiniband/hw/mlx5/devx.c    |    2 +-
 drivers/infiniband/hw/mlx5/flow.c    |    2 +-
 drivers/infiniband/hw/mlx5/gsi.c     |    9 -
 drivers/infiniband/hw/mlx5/main.c    |    6 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   46 +-
 drivers/infiniband/hw/mlx5/odp.c     |    5 +-
 drivers/infiniband/hw/mlx5/qp.c      | 1625 ++++++++++++++------------
 7 files changed, 905 insertions(+), 790 deletions(-)

--
2.25.3

