Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3891BA8AD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgD0Pr6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbgD0Pr5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8042064C;
        Mon, 27 Apr 2020 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002477;
        bh=GPTW75LjRKlWLOqhmRFai8HVJqHeGEdTIc2AB7OGqF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6pQBKrWyGLn8NvPZ9EDYgladRnztzGNisiLhLmlTez2fGsmZApviYL+d/M20xf9O
         UJD9Y/Y+PgrYMJANvIkOSwYIDn0ybl9D/v3uW7T9pUBS/yK74+oBqODtJjyiE5pJjO
         uAZTpCYulSUcF+jLTcfGREBVFJltdkWRztUXvTQI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 21/36] RDMA/mlx5: Promote RSS RAW QP attribute check in higher level
Date:   Mon, 27 Apr 2020 18:46:21 +0300
Message-Id: <20200427154636.381474-22-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Perform check of attributes of RAW PACKET QP in separate function.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0d3f4bafe448..454433a18b97 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1645,9 +1645,6 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	size_t required_cmd_sz;
 	u8 lb_flag = 0;
 
-	if (init_attr->send_cq)
-		return -EINVAL;
-
 	min_resp_len = offsetof(typeof(resp), bfreg_index) + sizeof(resp.bfreg_index);
 	if (udata->outlen < min_resp_len)
 		return -EINVAL;
@@ -2693,6 +2690,9 @@ static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			      -EINVAL :
 			      0;
 		break;
+	case IB_QPT_RAW_PACKET:
+		ret = (attr->rwq_ind_tbl && attr->send_cq) ? -EINVAL : 0;
+		break;
 	default:
 		break;
 	}
-- 
2.25.3

