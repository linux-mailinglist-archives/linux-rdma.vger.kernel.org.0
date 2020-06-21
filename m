Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1F202A2E
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 13:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgFULAL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 07:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFULAG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 07:00:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD192489D;
        Sun, 21 Jun 2020 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592737206;
        bh=/YoThEFbqMBqdZ/ikVibUm5/aQUvKkYD2KZVRY0byEw=;
        h=From:To:Cc:Subject:Date:From;
        b=X+gbXxxfSJoeMi3amn/D6i8vBDTaaVj+5Nbi2u9qFb80sG47FeuMGwb0KId02Oe0A
         YsIssYFNwsmZeHUBROtOD9S7OPfBv/LqLgxbbp8ZEUYbbr4vKq3Yh5kVDFqNJzqJpK
         QoPmf3AxaY/ZJWUe/qYKS92yKOJ7E5awfQd4HCfc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Majd Dibbiny <majd@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/counter: Query a counter before release
Date:   Sun, 21 Jun 2020 14:00:00 +0300
Message-Id: <20200621110000.56059-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Query a dynamically-allocated counter before release it, to update it's
hwcounters and log all of them into history data. Otherwise all values
of these hwcounters will be lost.

Fixes: f34a55e497e8 ("RDMA/core: Get sum value of all counters when perform a sysfs stat read")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 2257d7f7810f..738d1faf4bba 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -202,7 +202,7 @@ static int __rdma_counter_unbind_qp(struct ib_qp *qp)
 	return ret;
 }
 
-static void counter_history_stat_update(const struct rdma_counter *counter)
+static void counter_history_stat_update(struct rdma_counter *counter)
 {
 	struct ib_device *dev = counter->device;
 	struct rdma_port_counter *port_counter;
@@ -212,6 +212,8 @@ static void counter_history_stat_update(const struct rdma_counter *counter)
 	if (!port_counter->hstats)
 		return;
 
+	rdma_counter_query_stats(counter);
+
 	for (i = 0; i < counter->stats->num_counters; i++)
 		port_counter->hstats->value[i] += counter->stats->value[i];
 }
-- 
2.26.2

