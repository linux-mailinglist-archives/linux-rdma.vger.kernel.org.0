Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADC571233
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfGWG6N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbfGWG6M (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:58:12 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1FD21911;
        Tue, 23 Jul 2019 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865091;
        bh=fBb9zgHly1mzoiGjXGLWgEOI98UuZ2y5yB3IBI2vFqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrr949UQYZf/oRU27C9nWhkrleguG4Cx0Zc5qtssLNXC1ROn2ZMBEM3z5Yf8rjMH3
         ngh7/19W/z7Gzb9rcGOnRBJM+1UMK+x1Sa8YG5mNMg1c0YxqVXp5Z2cpwVbB0zVnoX
         PritQETK9ncvSWzvWUK6fEAMypjriiek4Q8HZz/M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 09/10] IB/core: Fix querying total rdma stats
Date:   Tue, 23 Jul 2019 09:57:32 +0300
Message-Id: <20190723065733.4899-10-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

rdma_counter_init() may fail for a device. In such case while calculating
total sum, ignore NULL hstats.

This fixes below observed call trace.

BUG: kernel NULL pointer dereference, address: 00000000000000a0
PGD 8000001009b30067 P4D 8000001009b30067 PUD 10549c9067 PMD 0
Oops: 0000 [#1] SMP PTI
CPU: 55 PID: 20887 Comm: cat Kdump: loaded Not tainted 5.2.0-rc6-jdc+ #13
RIP: 0010:rdma_counter_get_hwstat_value+0xf2/0x150 [ib_core]
Call Trace:
 show_hw_stats+0x5e/0x130 [ib_core]
 dev_attr_show+0x15/0x50
 sysfs_kf_seq_show+0xc6/0x1a0
 seq_read+0x132/0x370
 vfs_read+0x89/0x140
 ksys_read+0x5c/0xd0
 do_syscall_64+0x5a/0x240
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: f34a55e497e81 ("RDMA/core: Get sum value of all counters when perform a sysfs stat read")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 01faef7bc061..c7d445635476 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -393,6 +393,9 @@ u64 rdma_counter_get_hwstat_value(struct ib_device *dev, u8 port, u32 index)
 	u64 sum;

 	port_counter = &dev->port_data[port].port_counter;
+	if (!port_counter->hstats)
+		return 0;
+
 	sum = get_running_counters_hwstat_sum(dev, port, index);
 	sum += port_counter->hstats->value[index];

--
2.20.1

