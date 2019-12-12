Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E682111CC3B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfLLLad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLLLad (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:30:33 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE334227BF;
        Thu, 12 Dec 2019 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150232;
        bh=gzMFpMgBK22U6y2NLA+Zwd/faYjyP1hj0COmNAwZ7oc=;
        h=From:To:Cc:Subject:Date:From;
        b=tdtl4bs+WZ2Cb5lx8uvqXi4KmI0c96jsyjuSaSyOjW5jwazBfk5Zbej2wsBFVVCWT
         KybEjhfS1tFxHhQV858dcTQEyHW4Fsl8Vairbpv4ZW/3cUQFKo0DBEkfOr40YV5rxA
         yHDDD5/K02IcP7MYSt6xKzU23rMpK9mncVWjrzCE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 0/4] Let IB core distribute cache update events
Date:   Thu, 12 Dec 2019 13:30:20 +0200
Message-Id: <20191212113024.336702-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
---
v0->v1:
 - Address Jason's comment to split qp event handler lock with IB device event
 - Added patch that add qp_ prefix to reflect QP event operation

Note: Patch #1 can go to the -rc too, and is sent here because "fix" is
needed only if we are using those cache patches.
-------------------------------------------------------------------------
From Parav,

Currently when low level driver notifies Pkey, GID, port change
events, they are notified to the registered handlers in the order
they are registered.

IB core and other ULPs such as IPoIB are interested in GID, LID,
Pkey change events. Since all GID query done by ULPs is serviced by
IB core, IB core is yet to update the GID cache when IPoIB queries
the GID, resulting into not updating IPoIB address.

Hence, all events which require cache update are handled first by
the IB core. Once cache update work is completed, IB core distributes
the event to subscriber clients.

This is tested with opensm's /etc/rdma/opensm.conf subnet_prefix
configuration update where before the update

$ ip link show dev ib0

ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
    link/infiniband
80:00:01:07:fe:80:00:00:00:00:00:00:24:8a:07:03:00:b3:d1:12 brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff

And after the subnet prefix update:

ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
    link/infiniband
80:00:01:07:fe:80:00:00:00:00:00:02:24:8a:07:03:00:b3:d1:12 brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff

Thanks

Parav Pandit (4):
  IB/mlx5: Do reverse sequence during device removal
  IB/core: Let IB core distribute cache update events
  IB/core: Cut down single member ib_cache structure
  IB/core: Prefix qp to event_handler_lock

 drivers/infiniband/core/cache.c     | 151 +++++++++++++++++-----------
 drivers/infiniband/core/core_priv.h |   1 +
 drivers/infiniband/core/device.c    |  35 ++-----
 drivers/infiniband/core/verbs.c     |  12 +--
 drivers/infiniband/hw/mlx5/main.c   |   2 +
 include/rdma/ib_verbs.h             |  16 +--
 6 files changed, 118 insertions(+), 99 deletions(-)

--
2.20.1

