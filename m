Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF881E139B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbgEYRon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRon (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 13:44:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56BBB207D8;
        Mon, 25 May 2020 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590428683;
        bh=5FBRlSAMNJ229oNYIFST38PkaK0/WfRuud3yRstm+yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdkyBIiGxa86NzijYvIT1h4MFhDOhw4yFFwBOqZ1toPhVbFDCcn/Cqpnsey/KQrKz
         qYq2l8rfuCRGwr98PQfcGucsLGTGRs3ZhyDOS9A8g5PPOFZRk8o9/Y/0WzxtZ37lAE
         rup17RGla2fweqT64XlwgTtJU9HQveQS0/10+A64=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 7/9] RDMA/mlx5: Advertise ECE support
Date:   Mon, 25 May 2020 20:43:59 +0300
Message-Id: <20200525174401.71152-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525174401.71152-1-leon@kernel.org>
References: <20200525174401.71152-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The ECE bits are configured through create_qp and modify_qp commands.
While the create_qp() can be easily extended, it is not an easy task
for the modify_qp().

The new bit in the comp_mask is needed to mark that kernel supports
ECE and can receive data instead of "reserved" field in the
struct mlx5_ib_modify_qp.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 include/uapi/rdma/mlx5-abi.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6094ab2f4cd7..570c519ca530 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1971,6 +1971,9 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.response_length += sizeof(resp.dump_fill_mkey);
 	}

+	if (MLX5_CAP_GEN(dev->mdev, ece_support))
+		resp.comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
+
 	err = ib_copy_to_udata(udata, &resp, resp.response_length);
 	if (err)
 		goto out_mdev;
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index bc9d9e3cb369..90ea1e5aa291 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -100,6 +100,7 @@ struct mlx5_ib_alloc_ucontext_req_v2 {
 enum mlx5_ib_alloc_ucontext_resp_mask {
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET = 1UL << 0,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY    = 1UL << 1,
+	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
 };

 enum mlx5_user_cmds_supp_uhw {
--
2.26.2

