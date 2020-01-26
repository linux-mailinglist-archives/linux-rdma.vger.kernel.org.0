Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A202149B0A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgAZO1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgAZO1E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:04 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABFD920708;
        Sun, 26 Jan 2020 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048823;
        bh=VyFxSYDzsR8fZATyBKhQcLhkG9qdJtlaGEW4C7qMsNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GO9/iLv1ANzQjX4Qmj8GPEaA+RI9fBprVBmFHtOjm63BPAhxzkfb24/CaIzsKwV4j
         7TbLedLsQdmbkWEVmSDoyzpznjWMfLwHD3Fm8D8OTcMrlO2AYuejZisxU6CRWOY7xB
         dFIboYLp5Q9fdtsT/9hNkbRj0oHdVWYdUhdLfFUc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 3/7] RDMA/cma: Use RDMA device port iterator
Date:   Sun, 26 Jan 2020 16:26:48 +0200
Message-Id: <20200126142652.104803-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126142652.104803-1-leon@kernel.org>
References: <20200126142652.104803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Use RDMA device port iterator and avoid open coding.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 8f16ebb413c2..34c62eae08d8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -728,8 +728,8 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 	struct cma_device *cma_dev;
 	enum ib_gid_type gid_type;
 	int ret = -ENODEV;
+	unsigned int port;
 	union ib_gid gid;
-	u8 port;
 
 	if (dev_addr->dev_type != ARPHRD_INFINIBAND &&
 	    id_priv->id.ps == RDMA_PS_IPOIB)
@@ -753,7 +753,8 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 	}
 
 	list_for_each_entry(cma_dev, &dev_list, list) {
-		for (port = 1; port <= cma_dev->device->phys_port_cnt; ++port) {
+		rdma_for_each_port (cma_dev->device, port) {
+
 			if (listen_id_priv->cma_dev == cma_dev &&
 			    listen_id_priv->id.port_num == port)
 				continue;
@@ -786,8 +787,8 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	struct cma_device *cma_dev, *cur_dev;
 	struct sockaddr_ib *addr;
 	union ib_gid gid, sgid, *dgid;
+	unsigned int p;
 	u16 pkey, index;
-	u8 p;
 	enum ib_port_state port_state;
 	int i;
 
@@ -798,7 +799,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 	mutex_lock(&lock);
 	list_for_each_entry(cur_dev, &dev_list, list) {
-		for (p = 1; p <= cur_dev->device->phys_port_cnt; ++p) {
+		rdma_for_each_port (cur_dev->device, p) {
 			if (!rdma_cap_af_ib(cur_dev->device, p))
 				continue;
 
@@ -3029,9 +3030,9 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 	struct cma_device *cma_dev, *cur_dev;
 	union ib_gid gid;
 	enum ib_port_state port_state;
+	unsigned int p;
 	u16 pkey;
 	int ret;
-	u8 p;
 
 	cma_dev = NULL;
 	mutex_lock(&lock);
@@ -3043,7 +3044,7 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 		if (!cma_dev)
 			cma_dev = cur_dev;
 
-		for (p = 1; p <= cur_dev->device->phys_port_cnt; ++p) {
+		rdma_for_each_port (cur_dev->device, p) {
 			if (!ib_get_cached_port_state(cur_dev->device, p, &port_state) &&
 			    port_state == IB_PORT_ACTIVE) {
 				cma_dev = cur_dev;
-- 
2.24.1

