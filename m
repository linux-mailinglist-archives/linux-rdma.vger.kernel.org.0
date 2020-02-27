Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919EA1717F0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgB0M5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgB0M5d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:57:33 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F4724693;
        Thu, 27 Feb 2020 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582808252;
        bh=UfetzACbPQyAeXKscXgyJl7VgTH5cwCSDXmNgQLJ9Iw=;
        h=From:To:Cc:Subject:Date:From;
        b=I07bDLFiTZ0gNhdBbJ24Wvb841zN8MnDl7A2mvItACNiSs5V25ANHPB+i2CJt8qwa
         Sc6w8r/nTZg3VILbk95fO8mR+4Fm/0u3616OjdIWM6lM8qIjFcF5fzTjWn4OOon3ci
         aX/J2EkdAXML0vvc1RfJyxBl/sNNivDQaBBhIf+A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in get_new_pps
Date:   Thu, 27 Feb 2020 14:57:28 +0200
Message-Id: <20200227125728.100551-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

When port is part of the modify mask, then we should take
it from the qp_attr and not from the old pps. Same for PKEY.

Cc: <stable@vger.kernel.org>
Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/security.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index b9a36ea244d4..2d5608315dc8 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -340,11 +340,15 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
 		return NULL;
 
 	if (qp_attr_mask & IB_QP_PORT)
-		new_pps->main.port_num =
-			(qp_pps) ? qp_pps->main.port_num : qp_attr->port_num;
+		new_pps->main.port_num = qp_attr->port_num;
+	else if (qp_pps)
+		new_pps->main.port_num = qp_pps->main.port_num;
+
 	if (qp_attr_mask & IB_QP_PKEY_INDEX)
-		new_pps->main.pkey_index = (qp_pps) ? qp_pps->main.pkey_index :
-						      qp_attr->pkey_index;
+		new_pps->main.pkey_index = qp_attr->pkey_index;
+	else if (qp_pps)
+		new_pps->main.pkey_index = qp_pps->main.pkey_index;
+
 	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
 		new_pps->main.state = IB_PORT_PKEY_VALID;
 
-- 
2.24.1

