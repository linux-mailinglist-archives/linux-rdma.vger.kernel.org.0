Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FB305FBC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhA0PfM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235506AbhA0PDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C6DC21D46;
        Wed, 27 Jan 2021 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759647;
        bh=Ns0R28BuxjNGn7xzXxWbGMHIvqUqKvMaXxI8ZL9jTNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=So9GfB03cFMVYF+rcAjYx3xlnHZwv11SJCqDbg/wyCKAD4YwsJjavFT3YHdlW1WHs
         0AcwdHNMEv8+ZYJU1SchsiZz5kZjx9mjVXu2Xu/OTmkl1XxLdDCMfg3pKkItj17fan
         Cbdd5vI95AE/ByyeASiBcKNTlXAcutgC8Y9rCIqHrRFaiMpPTCfgWrspdflqTpYpAO
         PYSZd3PMU0I+M9BjpDCS2qWv6iIOYm9ixIZqoYeViitWUqGEoRs1IjUXN435oE2RkS
         TvqCRjPSWT2oDbS/KPkCNDfrI70gHd9dSnqpGxNIrp1WumepG+YNrtge2T/dcyahAm
         FzWQMPfHuZmLg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 10/10] IB/core: Use valid port number to check link layer
Date:   Wed, 27 Jan 2021 17:00:10 +0200
Message-Id: <20210127150010.1876121-11-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

IB HCA port starts from 1. Use IB core provided port iterator API to
avoid any assumption with start port number.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 6fc6a5b41f86..d25695ad50de 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2281,7 +2281,7 @@ static bool is_valid_mcast_lid(struct ib_qp *qp, u16 lid)
 	struct ib_qp_init_attr init_attr = {};
 	struct ib_qp_attr attr = {};
 	int num_eth_ports = 0;
-	int port;
+	unsigned int port;
 
 	/* If QP state >= init, it is assigned to a port and we can check this
 	 * port only.
@@ -2296,7 +2296,7 @@ static bool is_valid_mcast_lid(struct ib_qp *qp, u16 lid)
 	}
 
 	/* Can't get a quick answer, iterate over all ports */
-	for (port = 0; port < qp->device->phys_port_cnt; port++)
+	rdma_for_each_port(qp->device, port)
 		if (rdma_port_get_link_layer(qp->device, port) !=
 		    IB_LINK_LAYER_INFINIBAND)
 			num_eth_ports++;
-- 
2.29.2

