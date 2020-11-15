Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C9B2B34D4
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 13:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKOMOj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 07:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgKOMOi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 07:14:38 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3B4222EC;
        Sun, 15 Nov 2020 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605442478;
        bh=FJhE/yf6+0+WXoMqsYpivLtFQuVp3MO55TFp6A2OSVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Opl5dVpjScBm9IADJlb7DYXH+M6hVubZXvk4aF9wM4nNNyJ3QMWMMS89DhpgSLn6x
         iqIAEpdVQHe/YXzzxSY4eXE9Aw7DvzAW+y9pN+yzx+BqvYiBlNd0wgO3N5YXVigOND
         JSuFdwDw6bT2BxbPW/xDWhEsMCH0L5G14pKPW6po=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Enable querying AH for XRC QP types
Date:   Sun, 15 Nov 2020 14:14:24 +0200
Message-Id: <20201115121425.139833-2-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115121425.139833-1-leon@kernel.org>
References: <20201115121425.139833-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Address handle is set for connected QP types such as RC and UC, and
thus can also be queried.

Since XRC QP types INI and TGT are connected, it should be possible
to query their address handle as well.

Until now it was not the case, and although the firmware supported
it, the driver allowed querying the address handle only for RC and UC.

Hence, we enable it now for INI and TGT QPs as well.

Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8b1c4f509248..c053a790fc60 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4555,7 +4555,9 @@ static int query_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	pri_path = MLX5_ADDR_OF(qpc, qpc, primary_address_path);
 	alt_path = MLX5_ADDR_OF(qpc, qpc, secondary_address_path);
 
-	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC) {
+	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC ||
+	    qp->ibqp.qp_type == IB_QPT_XRC_INI ||
+	    qp->ibqp.qp_type == IB_QPT_XRC_TGT) {
 		to_rdma_ah_attr(dev, &qp_attr->ah_attr, pri_path);
 		to_rdma_ah_attr(dev, &qp_attr->alt_ah_attr, alt_path);
 		qp_attr->alt_pkey_index = MLX5_GET(ads, alt_path, pkey_index);
-- 
2.28.0

