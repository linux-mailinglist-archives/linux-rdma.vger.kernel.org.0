Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADE365C34
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhDTP3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 11:29:09 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:24699 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhDTP3I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Apr 2021 11:29:08 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d56 with ME
        id v3Ua2400k21Fzsu033UboS; Tue, 20 Apr 2021 17:28:36 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Apr 2021 17:28:36 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     yishaih@nvidia.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/mlx4: remove an unused variable
Date:   Tue, 20 Apr 2021 17:28:33 +0200
Message-Id: <413dc6e2ea9d85bda1131bbd6a730b7620839eab.1618932283.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'in6' is unused. It is just declared and filled-in.
It can be removed.

This is a left over from commit 5ea8bbfc4929
("mlx4: Implement IP based gids support for RoCE/SRIOV")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/mlx4/qp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 651785bd57f2..92ddbcc00eb2 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3135,7 +3135,6 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
 	}
 
 	if (is_eth) {
-		struct in6_addr in6;
 		u16 ether_type;
 		u16 pcp = (be32_to_cpu(ah->av.ib.sl_tclass_flowlabel) >> 29) << 13;
 
@@ -3148,8 +3147,6 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
 		memcpy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac, 6);
 		memcpy(&ctrl->srcrb_flags16[0], ah->av.eth.mac, 2);
 		memcpy(&ctrl->imm, ah->av.eth.mac + 2, 4);
-		memcpy(&in6, sgid.raw, sizeof(in6));
-
 
 		if (!memcmp(sqp->ud_header.eth.smac_h, sqp->ud_header.eth.dmac_h, 6))
 			mlx->flags |= cpu_to_be32(MLX4_WQE_CTRL_FORCE_LOOPBACK);
-- 
2.27.0

