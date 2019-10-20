Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4168EDDD1B
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfJTGyd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfJTGyd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:54:33 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BD82190F;
        Sun, 20 Oct 2019 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571554472;
        bh=Iq4sff2f/GToego6Zwj4ApN5gqRaom4ECBdIAUGU3Ck=;
        h=From:To:Cc:Subject:Date:From;
        b=H+ouhYPfmHlJRahZxn0XizDoNHv9yv6XntcMh3yQm6Z1gwdRF32z8U51Wjw0gl51W
         QW3I4qUzgd0MYYKE5kAm9i2SlEnOhq+oHJfuM/hw9DjkfJ5Skit0dJ2CI/6jPQaG8a
         ic8d1j/XvcuXY7A0U/XSSpyhwBQOIdPEpUwuJSpE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 0/3] Let IB core distribute cache update events
Date:   Sun, 20 Oct 2019 09:54:24 +0300
Message-Id: <20191020065427.8772-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

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

Patch-1 fixes the race condition between GID users and GID cache update
Patch-2 eliminates single entry structure
Patch-3 simplifies the code to not generate the event for unregistered device

Parav Pandit (3):
  IB/core: Let IB core distribute cache update events
  IB/core: Cut down single member ib_cache structure
  IB/core: Do not notify GID change event of an unregistered device

 drivers/infiniband/core/cache.c     | 132 ++++++++++++++--------------
 drivers/infiniband/core/core_priv.h |   3 +
 drivers/infiniband/core/device.c    |  26 ++++--
 include/rdma/ib_verbs.h             |   8 +-
 4 files changed, 87 insertions(+), 82 deletions(-)

--
2.20.1

