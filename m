Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97A1C697A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEFGz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 02:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgEFGz0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 02:55:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B08020714;
        Wed,  6 May 2020 06:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588748126;
        bh=riHfJCDSgqZ4JOW1s8kw7kfc1UX4YXs+Rj74HV1Xopg=;
        h=From:To:Cc:Subject:Date:From;
        b=J8Rejwfq9+x0WPcvTeDzka2cvkFXGh6B9rimBuJOYdcpmakeoxwwDcdBfPgmAkJGw
         exZmqgsrlhXgE1Hw+BQh2FYZ5bYZEb3KCXyNUbzMp3X8PuJyahy9pMEsiLkV9bVfaT
         HqE/uOB77YZKrYOZhy63rtfF1dyLhGWxgGqwy3bc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH rdma-next 0/3] mlx5 QP cleanup (cont.)
Date:   Wed,  6 May 2020 09:55:10 +0300
Message-Id: <20200506065513.4668-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This short series continue to cleanup qp.c file, which grew
to be completely unmaintainable.

Thanks

Leon Romanovsky (2):
  RDMA/mlx5: Update mlx5_ib to use new cmd interface
  RDMA/mlx5: Move all WR logic from qp.c to separate file

Max Gurtovoy (1):
  RDMA/mlx5: Refactor mlx5_post_send() to improve readability

 drivers/infiniband/hw/mlx5/Makefile  |    3 +-
 drivers/infiniband/hw/mlx5/cmd.c     |  114 +-
 drivers/infiniband/hw/mlx5/cmd.h     |    4 +-
 drivers/infiniband/hw/mlx5/cong.c    |    4 +-
 drivers/infiniband/hw/mlx5/main.c    |   10 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |    4 -
 drivers/infiniband/hw/mlx5/odp.c     |    5 +-
 drivers/infiniband/hw/mlx5/qp.c      | 1488 +------------------------
 drivers/infiniband/hw/mlx5/srq_cmd.c |  115 +-
 drivers/infiniband/hw/mlx5/wr.c      | 1504 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/wr.h      |   76 ++
 11 files changed, 1680 insertions(+), 1647 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/wr.c
 create mode 100644 drivers/infiniband/hw/mlx5/wr.h

--
2.26.2

