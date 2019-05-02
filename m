Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1580C11485
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEBHsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHsV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:21 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5AB20873;
        Thu,  2 May 2019 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783300;
        bh=DklgHYR0bzhEVAF818HTFe7v4KvqFBXhVOfUKWFGXgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3Tpgz8Op56xFUySIptgvoxnvQHqBeBP/1cxZYCgLvJvh8grWrdld9Eca7ki6+Zhr
         KE9bLPzO/FpPTHNMI0vaAdKkgy4RBe4aUZ94oSlkGIRHVdgV5rWnGKk7MHbwDWimiX
         zpW6AobT8o69BWGHxG1GlCVcoD+3FUQBajCoJTEw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 2/7] IB/cm: Reduce dependency on gid attribute ndev check
Date:   Thu,  2 May 2019 10:48:02 +0300
Message-Id: <20190502074807.26566-3-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
References: <20190502074807.26566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

GID type to path record type conversion can be done directly
based on port type and gid attribute type.
There is no need to find out using indirect way by its GID attribute's
ndev field.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4df59f2b0f04..da10e6ccb43c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1985,11 +1985,12 @@ static int cm_req_handler(struct cm_work *work)
 	grh = rdma_ah_read_grh(&cm_id_priv->av.ah_attr);
 	gid_attr = grh->sgid_attr;
 
-	if (gid_attr && gid_attr->ndev) {
+	if (gid_attr &&
+	    rdma_protocol_roce(work->port->cm_dev->ib_device,
+			       work->port->port_num)) {
 		work->path[0].rec_type =
 			sa_conv_gid_to_pathrec_type(gid_attr->gid_type);
 	} else {
-		/* If no GID attribute or ndev is null, it is not RoCE. */
 		cm_path_set_rec_type(work->port->cm_dev->ib_device,
 				     work->port->port_num,
 				     &work->path[0],
-- 
2.20.1

