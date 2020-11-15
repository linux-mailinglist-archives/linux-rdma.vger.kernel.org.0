Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCACC2B34D3
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 13:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKOMOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 07:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgKOMOf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 07:14:35 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317ED222EC;
        Sun, 15 Nov 2020 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605442474;
        bh=ZwHHNQoKPCD8nq3YYuv77KCBrTKCQZPLNsTYvUzg/hA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tl6Mck1H4SDSXkSOzntEScfMM9xWyiMHI6lmrXqJxEoGDLYOcjRzxA4+gPEV5xFAu
         n+OiqipKo43kwpMMWqSKn4UXKO/Yss23ByS+tW32OPNBwpPtjStNAFfgD+UkvGBZCY
         RSLh0OFrTdCfsLU4rp1dFUKAvSbzohIrVHUdhW8s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx4: Enable querying AH for XRC QP types
Date:   Sun, 15 Nov 2020 14:14:25 +0200
Message-Id: <20201115121425.139833-3-leon@kernel.org>
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
 drivers/infiniband/hw/mlx4/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 44534a12819a..651785bd57f2 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4015,7 +4015,9 @@ int mlx4_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr
 	qp_attr->qp_access_flags     =
 		to_ib_qp_access_flags(be32_to_cpu(context.params2));
 
-	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC) {
+	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC ||
+	    qp->ibqp.qp_type == IB_QPT_XRC_INI ||
+	    qp->ibqp.qp_type == IB_QPT_XRC_TGT) {
 		to_rdma_ah_attr(dev, &qp_attr->ah_attr, &context.pri_path);
 		to_rdma_ah_attr(dev, &qp_attr->alt_ah_attr, &context.alt_path);
 		qp_attr->alt_pkey_index = context.alt_path.pkey_index & 0x7f;
-- 
2.28.0

