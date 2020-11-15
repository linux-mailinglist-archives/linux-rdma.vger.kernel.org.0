Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7312B34D1
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 13:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgKOMOb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 07:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgKOMOb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 07:14:31 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327E9222EC;
        Sun, 15 Nov 2020 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605442470;
        bh=tD8TNin26MKum6aEsZwqr40A3sJT+0ySR+1neHcfRqc=;
        h=From:To:Cc:Subject:Date:From;
        b=MaS8eVZpvfN2VrLOAy3QjCeb6b+iB1SfQkL2/zXUgPDfjL6UGIndHbxM2cUBZv+Ri
         bELToeMERGGy4ufW5vgyzPT8LZ4C/iLSv8IGlAdzuPo6poZt+pbssH0sMSXjitHOvu
         7pGgQIdqK8w6V7EfiN9PGxQmox4H0h+fXOaaNYN8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/2] Enable querying AH for XRC QP types
Date:   Sun, 15 Nov 2020 14:14:23 +0200
Message-Id: <20201115121425.139833-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Update mlx4 and mlx5 drivers to support querying AH for XRC QP types.

Thanks

Avihai Horon (2):
  RDMA/mlx5: Enable querying AH for XRC QP types
  RDMA/mlx4: Enable querying AH for XRC QP types

 drivers/infiniband/hw/mlx4/qp.c | 4 +++-
 drivers/infiniband/hw/mlx5/qp.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--
2.28.0

