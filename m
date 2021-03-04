Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73AC32D37E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCDMqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhCDMqC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:46:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB4464F2B;
        Thu,  4 Mar 2021 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614861922;
        bh=4ZzAOaZx/nYIaR4h1dGLEx3eDAwTI6eNCwgfrcDOXLo=;
        h=From:To:Cc:Subject:Date:From;
        b=U5WV4IPmvuQCdsgdTeapXafxdqg0DXe7upmmlwM/qEN7oztYpv6/+HmnI6VutWsRJ
         dVRz1eA1es9rNFMDPlbSiKlymEBn4CEYdOGOvXOYzt8SR5Jy/9W87Gb4zGq2MoWpEs
         +BVzVJnOYvRIXTq3fncdQ3e/5Y+UP4pcQ3BlYDIwNZ6Kphmayz8gi0D30kY887DgNo
         +Zm1CQXlyAmFV8A2HkJqoH6hzGRUWVzRuvmxFBcb+Wt7n+0r6kmdlldO3LhB96YMEU
         aT0K/Vrl7pUeTWIU/sYXMDL+JbJJdyC9RO/c1Stgfb48EneTsFLmZexsVmzgH2FwX4
         exW4nOeRvBSmw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 0/3] Batch independent fixes to mlx5_ib
Date:   Thu,  4 Mar 2021 14:45:14 +0200
Message-Id: <20210304124517.1100608-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Completely independent fixes and improvements to mlx5_ib driver.

Maor Gottlieb (1):
  RDMA/mlx5: Fix query RoCE port

Mark Zhang (1):
  RDMA/mlx5: Fix mlx5 rates to IB rates map

Shay Drory (1):
  RDMA/mlx5: Create ODP EQ only when ODP MR is created

 drivers/infiniband/hw/mlx5/main.c    |  6 +++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  7 ++++++
 drivers/infiniband/hw/mlx5/mr.c      |  3 +++
 drivers/infiniband/hw/mlx5/odp.c     | 32 +++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/qp.c      | 15 ++++++++++++-
 include/linux/mlx5/driver.h          |  2 +-
 6 files changed, 50 insertions(+), 15 deletions(-)

--
2.29.2

