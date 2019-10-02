Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4EEC87BE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfJBMCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfJBMCt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:49 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593ED21929;
        Wed,  2 Oct 2019 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570017768;
        bh=ocV04J050uWr0dkUV67D3c0ASvLF/FU/G6094X4aHCs=;
        h=From:To:Cc:Subject:Date:From;
        b=anOY6Wxud7N0XszrqM5XEwEUKR1owh+2Dh8/1+WQaOWTG7ZCpXNQG4WjrSV/9Ps6O
         AXVvnmoW0B2VRaahzpjdL/IgjxJrR5z1N4eYWvMnzXnPtcIyUg4UabUSbGLpEIRoiy
         fz2xfKjfgV1LtlSt36P+lXyt0f0zOwIiQ9DwUsrU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Rafi Wiener <rafiw@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Oleg Kuporosov <olegk@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Clear old rate limit when closing QP
Date:   Wed,  2 Oct 2019 15:02:43 +0300
Message-Id: <20191002120243.16971-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rafi Wiener <rafiw@mellanox.com>

Before QP is closed it changes to ERROR state, when this happens
the QP was left with old rate limit that was already removed from
the table.

Fixes: 7d29f349a4b9 ("IB/mlx5: Properly adjust rate limit on QP state transitions")
Signed-off-by: Rafi Wiener <rafiw@mellanox.com>
Signed-off-by: Oleg Kuporosov <olegk@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8937d72ddcf6..5fd071c05944 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3249,10 +3249,12 @@ static int modify_raw_packet_qp_sq(
 	}
 
 	/* Only remove the old rate after new rate was set */
-	if ((old_rl.rate &&
-	     !mlx5_rl_are_equal(&old_rl, &new_rl)) ||
-	    (new_state != MLX5_SQC_STATE_RDY))
+	if ((old_rl.rate && !mlx5_rl_are_equal(&old_rl, &new_rl)) ||
+	    (new_state != MLX5_SQC_STATE_RDY)) {
 		mlx5_rl_remove_rate(dev, &old_rl);
+		if (new_state != MLX5_SQC_STATE_RDY)
+			memset(&new_rl, 0, sizeof(new_rl));
+	}
 
 	ibqp->rl = new_rl;
 	sq->state = new_state;
-- 
2.20.1

