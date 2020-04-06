Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE01519FBB7
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgDFRfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgDFRfr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Apr 2020 13:35:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FD2206C0;
        Mon,  6 Apr 2020 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586194547;
        bh=tq3v2w0mhXlmrDdStTyBk1PZSD5fE8jBsSw0NOGUYjs=;
        h=From:To:Cc:Subject:Date:From;
        b=UdJuTG/ksp62+VR7FeLk6mZLloqcCFbXphGku9+0bd8o4Cffli0FQlxuT+Jonv0NE
         W6icidHPYru72fgol8ndxhhA8aRWeczvFUlJlX0z9tzmFnDzfqFviSDAo/Q6s/GpQf
         04KWZiUODFWlbmZACbHBZ6J6wtrPwzNxLT6Hj+Lo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, Eli Cohen <eli@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix udata response upon SRQ creation
Date:   Mon,  6 Apr 2020 20:35:40 +0300
Message-Id: <20200406173540.1466477-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Fix udata response upon SRQ creation to use the UAPI structure (i.e.
mlx5_ib_create_srq_resp).

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/srq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index b1a8a9175040..3c2a84c362bb 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -310,12 +310,17 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 	srq->msrq.event = mlx5_ib_srq_event;
 	srq->ibsrq.ext.xrc.srq_num = srq->msrq.srqn;

-	if (udata)
-		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof(__u32))) {
+	if (udata) {
+		struct mlx5_ib_create_srq_resp resp = {};
+
+		resp.srqn = srq->msrq.srqn;
+		if (ib_copy_to_udata(udata, &resp, min(udata->outlen,
+				     sizeof(resp)))) {
 			mlx5_ib_dbg(dev, "copy to user failed\n");
 			err = -EFAULT;
 			goto err_core;
 		}
+	}

 	init_attr->attr.max_wr = srq->msrq.max - 1;

--
2.25.1

