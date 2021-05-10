Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1614437813A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhEJKYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 06:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhEJKYu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 06:24:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 304C361139;
        Mon, 10 May 2021 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642225;
        bh=wrXthlhobvL70q/D82JhNg73huCOwgFOIF0LF4tDLLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CA0pPiniTCGD1VABULj2bkh7f/k5ipAOLqVOcXpZod3ie6o7/f7oZqWDF5rSuCN8B
         n/LubmUaOuCTg+D3TewZnMM8R1XhMqZ56UZhhSGoHwqLfS3D3W02UimJRP+sxpR39y
         BJ8aQcu3GQJFzttgmqBenHaH8/ZrD7uflNNIxYCY9Mzt0VOq4jMjY5TwJ+P+y9Bzjb
         yQ4XgbEYSH7KsASI82Tty5oh3qtO5GztH2Tyb/vlaRLh6bvGslcbIz4I8PM9XliVe7
         dhFc63tf0zu/5GaFOrA4dA5NE7S7k6h00xwHKvLyOSAs+Y42ulCGUd7HMfM4jReLq8
         oJQV9tEbu/H2A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sergey Gorenko <sergeygo@nvidia.com>,
        Evgenii Kochetov <evgeniik@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Add SQD2RTS bit to the alloc ucontext response
Date:   Mon, 10 May 2021 13:23:33 +0300
Message-Id: <7ce705fedac1b2b8e3a2f4013e04244dc5946344.1620641808.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620641808.git.leonro@nvidia.com>
References: <cover.1620641808.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sergey Gorenko <sergeygo@nvidia.com>

The new bit in the comp_mask is needed to mark that kernel supports
SQD2RTS transition for the modify QP command.

Reviewed-by: Evgenii Kochetov <evgeniik@nvidia.com>
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++++
 include/uapi/rdma/mlx5-abi.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6d1dd09a4388..312aa731860d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1817,6 +1817,10 @@ static int set_ucontext_resp(struct ib_ucontext *uctx,
 		resp->comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
 
 	resp->num_dyn_bfregs = bfregi->num_dyn_bfregs;
+
+	if (MLX5_CAP_GEN(dev->mdev, drain_sigerr))
+		resp->comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_SQD2RTS;
+
 	return 0;
 }
 
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 27905a0268c9..995faf8f44bd 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -101,6 +101,7 @@ enum mlx5_ib_alloc_ucontext_resp_mask {
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET = 1UL << 0,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY    = 1UL << 1,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
+	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_SQD2RTS           = 1UL << 3,
 };
 
 enum mlx5_user_cmds_supp_uhw {
-- 
2.31.1

