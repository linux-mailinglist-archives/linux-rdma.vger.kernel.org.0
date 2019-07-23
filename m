Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548A9712E7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfGWHbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 03:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfGWHbX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 03:31:23 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3B021911;
        Tue, 23 Jul 2019 07:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563867082;
        bh=uXlrTG3xafiwlkXfkJZJyQnWZ+BGRN3LOSfrIAnNGWU=;
        h=From:To:Cc:Subject:Date:From;
        b=gTLaqhXqtbfzjAJ9lNeshQJyw1aiAavIVdC5FNprVbop4JhQvJl6zi3Apz47AaMC+
         rx/2dHSxXfc5VcquVaJqjwixWUcP6tt3svtTOABDbQ0cKG0IHjq2IqaQ3lP5OjfmGG
         cQWB5MyRzLGI5Lk5wcSMCZ1qhnuZw19Q5CXrBJQQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 0/2] Add per-device Q counters support
Date:   Tue, 23 Jul 2019 10:31:15 +0300
Message-Id: <20190723073117.7175-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This series is based on top -rc series [1] and may be considered
to be part of it, but can go to -next too.

Thanks

[1] https://lore.kernel.org/linux-rdma/20190723065733.4899-1-leon@kernel.org

Parav Pandit (2):
  IB/mlx5: Refactor code for counters allocation
  IB/mlx5: Support per device q counters in switchdev mode

 drivers/infiniband/hw/mlx5/main.c    | 107 ++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 +
 drivers/infiniband/hw/mlx5/qp.c      |  25 ++++---
 3 files changed, 85 insertions(+), 48 deletions(-)

--
2.20.1

