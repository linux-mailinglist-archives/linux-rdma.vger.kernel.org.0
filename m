Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D315D3DF488
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhHCSUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238252AbhHCSUy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EE44600D4;
        Tue,  3 Aug 2021 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014843;
        bh=Uir00Adz+abdAaKzUw34aSm/pcaJjfCTlu2oMxRohCI=;
        h=From:To:Cc:Subject:Date:From;
        b=gttQ3Kv3zYcnc9o3uY77iX/cUVBXh7JN2hqXZJFbcCBeCcPf+bxGs6i6h2wWICEuG
         4PuYF7RbPwClp65fcYzxlJoY0lKUncrhENSbND6xyuFfsRnhYVX3Hu97h8dQPcdvrM
         XjgefwQAlS4QnXSsm5iBITiZmRipqnGF/bhu5xaAI60nUP20EoOp/ESuey0idIGi6S
         hdGQeuQ3R9p1WVoVNN5EZ4vI7lDTrumaXO2JPt9HmNgkPMDAlS3cMnd3rBTC7p1ytw
         yjpW53a1wxQe/iIV5H8tCpa8lMtJwn9F5uQOaQteR84neXcvhINIokbhSCcOhbg00F
         CiBZkbdghZvtQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 0/7] Separate user/kernel QP creation logic
Date:   Tue,  3 Aug 2021 21:20:31 +0300
Message-Id: <cover.1628014762.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
 * Resend
v1: https://lore.kernel.org/lkml/cover.1626857976.git.leonro@nvidia.com
 * Fixed typo: incline -> inline/
 * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
 * Moved kernel-doc to the actual ib_create_qp() function that users will use.
v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com

---------------------------------------------------------------------------
Hi,

The "QP allocation" series shows clearly how convoluted the create QP
flow and especially XRC_TGT flow, where it calls to kernel verb just
to pass some parameters as NULL to the user create QP verb.

This series is a small step to make clean XRC_TGT flow by providing
more clean user/kernel create QP verb separation.

It is based on the "QP allocation" series.

Thanks


Leon Romanovsky (7):
  RDMA/mlx5: Delete not-available udata check
  RDMA/core: Delete duplicated and unreachable code
  RDMA/core: Remove protection from wrong in-kernel API usage
  RDMA/core: Reorganize create QP low-level functions
  RDMA/core: Configure selinux QP during creation
  RDMA/core: Properly increment and decrement QP usecnts
  RDMA/core: Create clean QP creations interface for uverbs

 drivers/infiniband/core/core_priv.h           |  58 +----
 drivers/infiniband/core/uverbs_cmd.c          |  31 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  29 +--
 drivers/infiniband/core/verbs.c               | 207 +++++++++++-------
 drivers/infiniband/hw/mlx5/qp.c               |   3 -
 include/rdma/ib_verbs.h                       |  16 +-
 6 files changed, 156 insertions(+), 188 deletions(-)

-- 
2.31.1

