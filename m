Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A811C94A0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGPQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 11:16:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57721 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgEGPQP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 May 2020 11:16:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jWiFu-00019X-VP; Thu, 07 May 2020 15:16:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/mlx5: remove duplicated assignment to variable rcqe_sz
Date:   Thu,  7 May 2020 16:16:10 +0100
Message-Id: <20200507151610.52636-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rcqe_sz is being unnecessarily assigned twice, fix this
by removing one of the duplicates.

Addresses-Coverity: ("Evaluation order violation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e5891d3da945..0d292d93f5e7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2043,8 +2043,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if ((qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) &&
 	    (init_attr->qp_type == IB_QPT_RC ||
 	     init_attr->qp_type == IB_QPT_UC)) {
-		int rcqe_sz = rcqe_sz =
-			mlx5_ib_get_cqe_size(init_attr->recv_cq);
+		int rcqe_sz = mlx5_ib_get_cqe_size(init_attr->recv_cq);
 
 		MLX5_SET(qpc, qpc, cs_res,
 			 rcqe_sz == 128 ? MLX5_RES_SCAT_DATA64_CQE :
-- 
2.25.1

