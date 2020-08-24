Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1024FBC5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHXKon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHXKob (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CEE206B5;
        Mon, 24 Aug 2020 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265871;
        bh=45QZEKve0Ai8B9HTiLXRFf1nsLtNfPeYH7DDoNQnoTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yc7a2VDSwV/jmwJPMDhsa7mAjElFTtPC6oYkH2CWsam953/JLaEiMHaUAZOwHs4Rq
         GmFvt71f6oFvUsmMmA485DUyFP5BO4OiudV6lENojHaSx3v6TQpPR93jKZXdBe0Lis
         x6fYfvj36PnLKE7MY06j8B6rz4oZFbOGtIvUphw4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 01/14] RDMA/verbs: Assign port number of special QPs
Date:   Mon, 24 Aug 2020 13:44:02 +0300
Message-Id: <20200824104415.1090901-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824104415.1090901-1-leon@kernel.org>
References: <20200824104415.1090901-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Special QPs deliver the port number when they are created.
Keep the value in the ib_qp struct.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bab99f326cce..50042bf753f2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1241,6 +1241,9 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
 		return xrc_qp;
 	}
 
+	if (qp_init_attr->qp_type == IB_QPT_SMI ||
+	    qp_init_attr->qp_type == IB_QPT_GSI)
+		qp->port = qp_init_attr->port_num;
 	qp->event_handler = qp_init_attr->event_handler;
 	qp->qp_context = qp_init_attr->qp_context;
 	if (qp_init_attr->qp_type == IB_QPT_XRC_INI) {
-- 
2.26.2

