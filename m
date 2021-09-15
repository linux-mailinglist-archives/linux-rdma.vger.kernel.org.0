Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9328B40AA13
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhINJC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 05:02:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:33889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhINJC2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 05:02:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="282933067"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="282933067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 02:01:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="507770835"
Received: from unknown (HELO intel-173.bj.intel.com) ([10.238.154.173])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2021 02:01:10 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        leonro@nvidia.com
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH 1/1] RDMA/rxe: remove the redundant variable
Date:   Tue, 14 Sep 2021 21:24:56 -0400
Message-Id: <20210915012456.476728-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

The variable port is not necessary. So remove it.

Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 267b5a9c345d..586ef102986e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -29,13 +29,10 @@ static int rxe_query_port(struct ib_device *dev,
 			  u32 port_num, struct ib_port_attr *attr)
 {
 	struct rxe_dev *rxe = to_rdev(dev);
-	struct rxe_port *port;
 	int rc;
 
-	port = &rxe->port;
-
 	/* *attr being zeroed by the caller, avoid zeroing it here */
-	*attr = port->attr;
+	*attr = rxe->port.attr;
 
 	mutex_lock(&rxe->usdev_lock);
 	rc = ib_get_eth_speed(dev, port_num, &attr->active_speed,
-- 
2.27.0

