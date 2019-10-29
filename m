Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD37E8780
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 12:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfJ2Lxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 07:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfJ2Lxf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 07:53:35 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD7021D56;
        Tue, 29 Oct 2019 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572350014;
        bh=D6HUM7IYlSh7YEkjS2faHysVLs134NJeXakN2M59r20=;
        h=From:To:Cc:Subject:Date:From;
        b=dCXdNfp9n95Y3y3C/S3ZJGDWmFPVsYejwxzvfuEA7jYlGJwu36TFxF5/xfczK8HBP
         oBkYfjc8F9dep3vfawyp904eMGX+vsONeFhjrbsBOwOvJz/cLCbIJOfgdPFavkPLGs
         3hEz/WsQD12KaczzqPG58aI9lcvA8bm/yleFWSsU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 0/2] Let IB core distribute cache update events
Date:   Tue, 29 Oct 2019 13:53:25 +0200
Message-Id: <20191029115327.16589-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
v0->v1: https://lore.kernel.org/linux-rdma/20191020065427.8772-1-leon@kernel.org
 - Instead of conditionally notifying event in wq, always use WQ
   This will allow to simplify the IB core and ULPs to get rid of
   additional work.
 - Updated kdoc comment to reflect the notifier execution context.

--------------------------------------------------------------------------------------
From Parav,

Currently when low level driver notifies Pkey, GID, port change
events, they are notified to the registered handlers in the order
they are registered.

IB core and other ULPs such as IPoIB are interested in GID, LID,
Pkey change events. Since all GID query done by ULPs is serviced
by IB core, IB core is yet to update the GID cache when IPoIB
queries the GID, resulting into not updating IPoIB address.
Detailed flow is shown in the patch-1.

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


Parav Pandit (2):
  IB/core: Let IB core distribute cache update events
  IB/core: Cut down single member ib_cache structure

 drivers/infiniband/core/cache.c     | 114 +++++++++++++---------------
 drivers/infiniband/core/core_priv.h |   2 +
 drivers/infiniband/core/device.c    |  27 ++++---
 include/rdma/ib_verbs.h             |   8 +-
 4 files changed, 74 insertions(+), 77 deletions(-)

--
2.20.1

