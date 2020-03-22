Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2A18E7DA
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2020 10:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCVJay (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Mar 2020 05:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgCVJay (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Mar 2020 05:30:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8B720753;
        Sun, 22 Mar 2020 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584869454;
        bh=+FmQ6aOAWnTu0iUIFJ9wE9hTUI97RgQ8PWKcIoZ7gBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeLwL8lYq6ghNPNH+UYl4ONFHbjsAI1qM//csV760VUBxqHnqa3+SkLJIKRh135cb
         xyk20+5Stu3cEjkE79FIu6TZMyofvN+4scX90hV2L1smYs0woHQ2836vJUC7IQswoA
         HWifr6+jOEKQ4a6WfjrPrbHkfKCt3w3HQk/veIig=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 6/7] RDMA/cm: Set flow label of recv_wc based on primary flow label
Date:   Sun, 22 Mar 2020 11:30:30 +0200
Message-Id: <20200322093031.918447-7-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200322093031.918447-1-leon@kernel.org>
References: <20200322093031.918447-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

In the request handler of the response side, Set flow label of the
recv_wc if it is not net. It will be used for all messages sent
by the responder.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index bbbfa77dbce7..4ab2f71da522 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2039,6 +2039,7 @@ static int cm_req_handler(struct cm_work *work)
 	struct cm_req_msg *req_msg;
 	const struct ib_global_route *grh;
 	const struct ib_gid_attr *gid_attr;
+	struct ib_grh *ibgrh;
 	int ret;

 	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
@@ -2048,6 +2049,12 @@ static int cm_req_handler(struct cm_work *work)
 	if (IS_ERR(cm_id_priv))
 		return PTR_ERR(cm_id_priv);

+	ibgrh = work->mad_recv_wc->recv_buf.grh;
+	if (!(be32_to_cpu(ibgrh->version_tclass_flow) & IB_GRH_FLOWLABEL_MASK))
+		ibgrh->version_tclass_flow |=
+			cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL,
+					    req_msg));
+
 	cm_id_priv->id.remote_id =
 		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
 	cm_id_priv->id.service_id =
--
2.24.1

