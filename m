Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7A33A531
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Mar 2021 15:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhCNOfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Mar 2021 10:35:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62133 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhCNOeq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Mar 2021 10:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615732486; x=1647268486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bn0WWYEdpZY5YptoKqSC5qSNUjJGfPiTae6KVIF2xco=;
  b=PN7wPaDIiqX8FhkT7t4aMEhFc8qR8N+OBXb1K4jmKFLuhx+i+v6lcXc0
   ChNTx00nUgj2EdFDjfxtrgmDq6p7U1i5zYFPp1Fe+3suIS0ecL4BwjaPx
   qnA3DHcL7avF/EVvg35Z/qEcRsiNNLEUtxm5CKX+uS6f4C1gPMv5ClUh+
   g=;
IronPort-HdrOrdr: A9a23:0vYDNKANFqQIjcnlHejysceALOonbusQ8zAX/mp2TgFYddHdqt
 C2kJ0gpGbJoRsyeFVlo9CPP6GcXWjRnKQe3aA9NaqvNTOW3VeAA5pl6eLZsl/dMg34stVQzK
 JxN5V5YeeAbmRSqebfzE2GH807wN+BmZrIuc77w212RQ9nL4FMhj0JbjqzKUF9SAlYCZdRLv
 P1jfZvnDaudW8aac62HBA+P9TrncHBl57tfHc9dnkawTSJ5AnYjoLSIly32lM7XylUybkvtV
 LZmxH0j5/Oj9iLjjHb0WHX49B6uvvEjuFCCsuFl9QPJlzX5zqAVcBOXbuNuTxwmuWz8RIRls
 XWqRtIBatOwkKURW2+rRvz1wSI6lgT10M=
X-IronPort-AV: E=Sophos;i="5.81,248,1610409600"; 
   d="scan'208";a="120401969"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 Mar 2021 14:34:39 +0000
Received: from EX13D19EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 5F91DA1CDF;
        Sun, 14 Mar 2021 14:34:38 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 14 Mar 2021 14:34:36 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.18) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 14 Mar 2021 14:34:34 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/cma: Remove unused leftovers in cma code
Date:   Sun, 14 Mar 2021 16:34:27 +0200
Message-ID: <20210314143427.76101-1-galpress@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit ee1c60b1bff8 ("IB/SA: Modify SA to implicitly cache Class Port info")
removed the class_port_info_context struct usage, remove a couple of
leftovers.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/cma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 4fba08ed252f..532f2c09a53d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -43,7 +43,6 @@ MODULE_DESCRIPTION("Generic RDMA CM Agent");
 MODULE_LICENSE("Dual BSD/GPL");
 
 #define CMA_CM_RESPONSE_TIMEOUT 20
-#define CMA_QUERY_CLASSPORT_INFO_TIMEOUT 3000
 #define CMA_MAX_CM_RETRIES 15
 #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
 #define CMA_IBOE_PACKET_LIFETIME 18
@@ -219,14 +218,6 @@ struct rdma_bind_list {
 	unsigned short		port;
 };
 
-struct class_port_info_context {
-	struct ib_class_port_info	*class_port_info;
-	struct ib_device		*device;
-	struct completion		done;
-	struct ib_sa_query		*sa_query;
-	u8				port_num;
-};
-
 static int cma_ps_alloc(struct net *net, enum rdma_ucm_port_space ps,
 			struct rdma_bind_list *bind_list, int snum)
 {
-- 
2.30.2

