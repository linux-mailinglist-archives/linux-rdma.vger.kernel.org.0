Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE76DC8857
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfJBMZW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfJBMZW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 08:25:22 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CAFB21920;
        Wed,  2 Oct 2019 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570019122;
        bh=gokM79mW7tAcaJifLK0N7N8lojgTul34yJ6ggEj3e30=;
        h=From:To:Cc:Subject:Date:From;
        b=dJJT+Z/kxLWA1i/pyXjWcrQkAX4eP4ZZUU8ifnMThBdVMFh3lxFdKMya746h8U03b
         Dh6JdzSYFzZhrQsU4TA4vzkyogtp+lNkVb0J+HYohTutCJq0ns8f11K27eENU8kt4A
         OOX0E8uGzPFbzsoFYzK1Exw1BOtFaqI28TyrRdPQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 0/4] Unrelated code cleanups
Date:   Wed,  2 Oct 2019 15:25:13 +0300
Message-Id: <20191002122517.17721-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

Various code cleanups.

Thanks

Erez Alfasi (2):
  IB/mlx5: Remove unnecessary return statement
  IB/mlx5: Remove unnecessary else statement

Leon Romanovsky (1):
  RDMA/mlx5: Group boolean parameters to take less space

Parav Pandit (1):
  IB/cm: Use container_of() instead of typecast

 drivers/infiniband/core/cm.c         | 4 ++--
 drivers/infiniband/hw/mlx5/main.c    | 4 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 8 ++++----
 drivers/infiniband/hw/mlx5/odp.c     | 2 --
 4 files changed, 8 insertions(+), 10 deletions(-)

--
2.20.1

