Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47B084949
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfHGKS0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfHGKSZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:18:25 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ACF021E6E;
        Wed,  7 Aug 2019 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565173105;
        bh=qH1zoTg/SBAhUDI13tQifs6W/LHO9FAS/K+pSvgFUNg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZPfxaQniLc5ZHZrf3i+tZSopifwrMao4u12Z9SgZrRaYp/YpX3V2oKzot2Vigvhxg
         qsOU0esOO4h15BjjN8Mqw3PMybj4QxdArfkncjjjac/rIK+7G75aDQ08bFhMaWtLQN
         VyM83k8bTdFGIH/jYepq4DJ9Ju+UrB74sk5DrTBw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/counter: Prevent QP counter binding if counters unsupported
Date:   Wed,  7 Aug 2019 13:18:19 +0300
Message-Id: <20190807101819.7581-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

In case of rdma_counter_init() fails, counter allocation and QP bind
should not be allowed.

Fixes: 413d3347503b ("RDMA/counter: Add set/clear per-port auto mode support")
Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration support")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 45d5164e9574..b79890739a2c 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -38,6 +38,9 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
 	int ret;
 
 	port_counter = &dev->port_data[port].port_counter;
+	if (!port_counter->hstats)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&port_counter->lock);
 	if (on) {
 		ret = __counter_set_mode(&port_counter->mode,
@@ -509,6 +512,9 @@ int rdma_counter_bind_qpn_alloc(struct ib_device *dev, u8 port,
 	if (!rdma_is_port_valid(dev, port))
 		return -EINVAL;
 
+	if (!dev->port_data[port].port_counter.hstats)
+		return -EOPNOTSUPP;
+
 	qp = rdma_counter_get_qp(dev, qp_num);
 	if (!qp)
 		return -ENOENT;
-- 
2.20.1

