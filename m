Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7766CDDD13
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfJTGoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfJTGoG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:44:06 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF8D222C2;
        Sun, 20 Oct 2019 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571553846;
        bh=pFCxgQeEIv1Lyn/8/r522zssIoFQGMp4Wo33A4Lca9A=;
        h=From:To:Cc:Subject:Date:From;
        b=ub7973IoGiR4AcJNnYGw/RBYLsSNgn4LNxO3Qh8bg05yPdHOTTV4fsQ69xYGjkLS0
         ooQTZ0WFsla0jjOQ1rDI2baFeeHMGfDXLyYEatNhre1IQthCeryLsFM/DpGs1ncaEj
         g/P1cBMuZLaJYixcAhmR9YMHJLkDR1sIwlQtHngo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next 0/2] Set BlueFlame size based on memory properties
Date:   Sun, 20 Oct 2019 09:43:58 +0300
Message-Id: <20191020064400.8344-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

Libmlx5 needs real knowledge of BlueFlame size to properly set data
path to leverage performance advantages of BF. However such advantage
is visible in systems which use WC memory. Unfortunately, user space
applications (and libmlx5) can't know if memory is WC or not, so
we rely on in-kernel test to set BF dynamically.

Thanks

Michael Guralnik (2):
  IB/mlx5: Align usage of QP1 create flags with rest of mlx5 defines
  IB/mlx5: Test write combining support

 drivers/infiniband/hw/mlx5/gsi.c     |   2 +-
 drivers/infiniband/hw/mlx5/main.c    |  15 +-
 drivers/infiniband/hw/mlx5/mem.c     | 200 +++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  13 +-
 drivers/infiniband/hw/mlx5/qp.c      |  12 +-
 5 files changed, 229 insertions(+), 13 deletions(-)

--
2.20.1

