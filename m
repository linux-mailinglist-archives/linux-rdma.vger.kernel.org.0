Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88749B34DF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfIPGsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 02:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfIPGsY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 02:48:24 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E61E20890;
        Mon, 16 Sep 2019 06:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568616504;
        bh=ytMgmmCjZYWWk+LIGpYHyOBIct8DA8dSQxBNGE38Urc=;
        h=From:To:Cc:Subject:Date:From;
        b=rXDps4QjHGIQiM1miZ6RD+inwKLEDDzdvqKbbuIGdQXO7ooUeTPFFeky/79L0y1EN
         hFl/+W/6CM4A7f2xU2LD68j3Y7KgiAE6vDoGOT4vijG8UPlU9DowmOu5TNZPUMtIkE
         ykE1oqg2KYOc2T7gU9uHsD3oCCVDeUvqpWqd2+jM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH 0/2] Two fixes for this merge window
Date:   Mon, 16 Sep 2019 09:48:16 +0300
Message-Id: <20190916064818.19823-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

We are in merge window so I didn't know if I should put -next or -rc,
but they are better to go this cycle.

Thanks

Danit Goldberg (2):
  IB/mlx5: Free page from the beginning of the allocation
  IB/mlx5: Free mpi in mp_slave mode

 drivers/infiniband/hw/mlx5/main.c | 1 +
 drivers/infiniband/hw/mlx5/odp.c  | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

--
2.20.1

