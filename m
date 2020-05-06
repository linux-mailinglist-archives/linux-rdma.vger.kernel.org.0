Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B556A1C69E2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgEFHQM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFHQM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:16:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879B920663;
        Wed,  6 May 2020 07:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588749372;
        bh=+tP79pSiszHTIuK4G5iOhAazWFdm5miopCCmnTQyiBs=;
        h=From:To:Cc:Subject:Date:From;
        b=0Wdm1s950b/JEI4L+AWccjg96e9YZ7qSM7yC/3Kocpt2pts4Gutxel1rnP2d8ABNL
         2TBh2qkh03iLhP4kCuohFqSRc01bWV7SrU28Jq9VYJRpFrYwWuLDj1jahJ7NdEEwbx
         /vPAAB1dHu304EHhYFf51M8LPJndq3Ei4t0FbrFE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 0/2] Limit to raw Ethernet QPs for raw ETH profile
Date:   Wed,  6 May 2020 10:16:00 +0300
Message-Id: <20200506071602.7177-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is a fix to restrict opening any other QP types except RAW_PACKET
if we are using raw ETH profile.

Thanks

Mark Bloch (2):
  RDMA/mlx5: Assign profile before calling stages
  RDMA/mlx5: Allow only raw Ethernet QPs when RoCE isn't enabled

 drivers/infiniband/hw/mlx5/ib_rep.h |  2 +-
 drivers/infiniband/hw/mlx5/main.c   |  3 ++-
 drivers/infiniband/hw/mlx5/qp.c     | 12 +++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

--
2.26.2

