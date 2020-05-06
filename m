Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E841C6A53
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgEFHrO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgEFHrO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C14206D5;
        Wed,  6 May 2020 07:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751233;
        bh=oCofSS/9LskLNMujdH5QWMXMLcRY0a2CjGnDsVGnETo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvIplHTG02E1JiQiMd5QTil+bA/A9Ey1nyI3CTH9oAx1LOruvUicgyJwJTR7H2TUU
         16CiG2g0gYbWlRowyYavZv65QpQdHyaq0I0SOgGYWnUWgc3THvhIsnSHVpNQ9r7vUr
         tbHVjz+m0e3/YdCpvBOEA/VDUNAg19rSSl3/dveY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 01/10] RDMA/addr: Mark addr_resolve as might_sleep()
Date:   Wed,  6 May 2020 10:46:52 +0300
Message-Id: <20200506074701.9775-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Under one path through ib_nl_fetch_ha() this calls nlmsg_new(GFP_KERNEL)
which is a sleeping call. This is a very rare path, so mark fetch_ha() and
the module external entry point that conditionally calls through to
fetch_ha() as might_sleep().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 1753a9801b70..3a98439bba83 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -371,6 +371,8 @@ static int fetch_ha(const struct dst_entry *dst, struct rdma_dev_addr *dev_addr,
 		(const void *)&dst_in6->sin6_addr;
 	sa_family_t family = dst_in->sa_family;
 
+	might_sleep();
+
 	/* If we have a gateway in IB mode then it must be an IB network */
 	if (has_gateway(dst, family) && dev_addr->network == RDMA_NETWORK_IB)
 		return ib_nl_fetch_ha(dev_addr, daddr, seq, family);
@@ -727,6 +729,8 @@ int roce_resolve_route_from_path(struct sa_path_rec *rec,
 	struct rdma_dev_addr dev_addr = {};
 	int ret;
 
+	might_sleep();
+
 	if (rec->roce.route_resolved)
 		return 0;
 
-- 
2.26.2

