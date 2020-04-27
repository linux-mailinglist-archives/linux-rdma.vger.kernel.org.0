Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4F1BA916
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgD0Psz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgD0Psy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD31206D9;
        Mon, 27 Apr 2020 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002534;
        bh=HY1XDZRcc1ZE0uomFZfYG27zwhU2MVYOfmctqwNMIHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuFUzuvz4lQyab2CyulX+kGdDcnsfJdugATvyb5Qwzho/FRkr9Z5DMr5eGa14Elvc
         aptH5WKmsEup4wSfILl0NHn1QL4mq600AnqS7cOIznPNExVSCP4SgzJMjkfcdrtDfB
         hXfdUvKgnLLBdUsYmnHz5xNomAuinSBS0Jh3IjuE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Aharon Landau <aharonl@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 36/36] RDMA/mlx5: Verify that QP is created with RQ or SQ
Date:   Mon, 27 Apr 2020 18:46:36 +0300
Message-Id: <20200427154636.381474-37-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@mellanox.com>

RAW packet QP and underlay QP must be created with either
RQ or SQ, check that.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Aharon Landau <aharonl@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 18c0a25da47a..14f4f0982e4e 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1482,6 +1482,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	u16 uid = to_mpd(pd)->uid;
 	u32 out[MLX5_ST_SZ_DW(create_tir_out)] = {};
 
+	if (!qp->sq.wqe_cnt && !qp->rq.wqe_cnt)
+		return -EINVAL;
 	if (qp->sq.wqe_cnt) {
 		err = create_raw_packet_qp_tis(dev, qp, sq, tdn, pd);
 		if (err)
-- 
2.25.3

