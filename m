Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D83D089F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhGUFce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhGUFce (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19AD761007;
        Wed, 21 Jul 2021 06:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626847991;
        bh=qyuJ/Pm4Y6kbn5Ux8VS9eXZoNl/MNbn/y0CNK17o4uY=;
        h=From:To:Cc:Subject:Date:From;
        b=raRW2tDWA+OxotJ/HaLx0ZZxa3KtUIz3h/bzd1b1H2L2K16vx1uFC0w7t/VvhTaUU
         ZQsWIYLIjk6RAm9rdQv6jZF6BTQYeXpDJoX0pM95a2ord8+sVSESWHiO2LnmCeGH6+
         USvYVcO1Z2oj7BOEGZpY9xh99uvaWl583xJilE0m5bZkZ2pTTtXb3hL8UF8GD8DU1c
         BFJnmay4vFEgohz73xPAG+Q6oTeJB0a3sPTW3kIjGppHHzNb6ZT4y/MPhOtGX7mdXL
         ZGgV27NzDbvJR5xU6fERDXxxMYJtofvONkhhx6+v46jNUHm/z77p17G/HpVV7fedqX
         0OX7Ksk2DCbDg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 0/7] Separate user/kernel QP creation logic
Date:   Wed, 21 Jul 2021 09:12:59 +0300
Message-Id: <cover.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

The "QP allocation" series shows clearly how convoluted the create QP
flow and especially in XRC_TGT flows, where it called to kernel verb
just to pass some parameters as NULL to the user create QP verb.

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

 drivers/infiniband/core/core_priv.h           |  67 ++----
 drivers/infiniband/core/uverbs_cmd.c          |  30 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  28 +--
 drivers/infiniband/core/verbs.c               | 216 ++++++++++++------
 drivers/infiniband/hw/mlx5/qp.c               |   3 -
 include/rdma/ib_verbs.h                       |   8 +-
 6 files changed, 166 insertions(+), 186 deletions(-)

-- 
2.31.1

