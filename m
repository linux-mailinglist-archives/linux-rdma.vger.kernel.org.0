Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A347FCAD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Dec 2021 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhL0MiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Dec 2021 07:38:09 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45932 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233750AbhL0MiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Dec 2021 07:38:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V.vZrg7_1640608687;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V.vZrg7_1640608687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:38:07 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-next] RDMA/mlx5: print wc status on CQE error and dump needed
Date:   Mon, 27 Dec 2021 20:38:06 +0800
Message-Id: <20211227123806.47530-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

mlx5_handle_error_cqe() only dump the content of the CQE
which is raw hex data, and not straighforward for debug.
Print WC status message when we got CQE error and dump is
need.

Here is an example of how the dmesg log looks like with this:
[166755.330649] infiniband mlx5_0: mlx5_handle_error_cqe:333:(pid 0): WC error: 10, message: remote access error
[166755.332323] infiniband mlx5_0: dump_cqe:272:(pid 0): dump error cqe
[166755.332944] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[166755.333574] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[166755.334202] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[166755.334837] 00000030: 00 00 00 00 00 00 88 13 08 03 61 b3 1e a1 42 d3

Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index a190fb581591..66dfadb96c66 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -328,8 +328,11 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 	}
 
 	wc->vendor_err = cqe->vendor_err_synd;
-	if (dump)
+	if (dump) {
+		mlx5_ib_warn(dev, "WC error: %d, Message: %s\n",
+				wc->status, ib_wc_status_msg(wc->status));
 		dump_cqe(dev, cqe);
+	}
 }
 
 static void handle_atomics(struct mlx5_ib_qp *qp, struct mlx5_cqe64 *cqe64,
-- 
2.19.1.3.ge56e4f7

