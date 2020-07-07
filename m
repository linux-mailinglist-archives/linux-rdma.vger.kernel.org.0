Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E13216B0B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGGLGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 07:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGGLGS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 07:06:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2375020720;
        Tue,  7 Jul 2020 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594119977;
        bh=zwd3NEEYbFU0wri5CnUetQJdryTFlVzwn2bY04XZuyM=;
        h=From:To:Cc:Subject:Date:From;
        b=GVXjfuqMaKJ9Sxzn/Ujx+3ogR4J3TLPyiB6RQTsyO0BWpgHubxiEG1qWRUqukKs2F
         25n5l0Q0uAonn88pGVJsIv7LFCtFsfy4apxvj0ULHhyOu0GOnQWFlfZ97TsBRVsVLb
         ceZFm6BIkdTTm7UpajoaNwS9Pyy4JcRU1p+ivWBY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-rc 0/3] Fixes to mlx5_ib driver
Date:   Tue,  7 Jul 2020 14:06:09 +0300
Message-Id: <20200707110612.882962-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is patchset of independent fixes to mlx5_ib driver.

Thanks

Aya Levin (1):
  IB/mlx5: Fix 50G per lane indication

Leon Romanovsky (1):
  RDMA/mlx5: Set PD pointers for the error flow unwind

Maor Gottlieb (1):
  RDMA/mlx5: Use xa_lock_irqsave when access to SRQ table

 drivers/infiniband/hw/mlx5/main.c    |  2 +-
 drivers/infiniband/hw/mlx5/qp.c      |  3 ++-
 drivers/infiniband/hw/mlx5/srq_cmd.c | 10 ++++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

--
2.26.2

