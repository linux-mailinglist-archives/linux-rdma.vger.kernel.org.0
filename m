Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB1189890
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCRJxU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCRJxU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:53:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7719B2076F;
        Wed, 18 Mar 2020 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525200;
        bh=20a3kIuVb/it9R3Z7nGFHZYYRFjLXOcFPd2M1HKaoZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfjU1xt/gD3kKxpFoxUFRZ79C6Rx3bJvkablyBenf6Z+MT4Yi5CG2h6cQYqP9jnIT
         ZlMo1jS0LpZueTrW23mEBkQ4GhFsIaUHZm3a3x27iaVhLAH8FjCJq00ufU7ntu7vKf
         hp4HzSCl45x94Tivd4DVu6flu07qdIriymhpoVAw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 5/6] RDMA/cm: Set flow label of recv_wc based on primary flow label
Date:   Wed, 18 Mar 2020 11:52:59 +0200
Message-Id: <20200318095300.45574-6-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318095300.45574-1-leon@kernel.org>
References: <20200318095300.45574-1-leon@kernel.org>
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

