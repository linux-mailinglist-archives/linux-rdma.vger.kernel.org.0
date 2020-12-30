Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5A2E78C9
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 14:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgL3NCM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Dec 2020 08:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgL3NCL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 08:02:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 766532220B;
        Wed, 30 Dec 2020 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609333291;
        bh=WZjyLSeBQAY1IISjXHeD6vsNeoux46SL52n0LLrgDAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h74F/FHjzLiEgq09oz6hKlPQn3bVc7RcUDL9SeBmJSwBN8USnOwJuxogbAUigDO6J
         qkVADoI1DbU9TYRatX3Je/6iTo16J/2xx1dQyNqaVFOuR75BfMHzzQCWsxEmWc9D80
         R3YmqX+EfQT4nt0T/0vUO6uJ8xlOYDXPfTtRg5HOAHaO7iJjPsnPoEQ7KUx3BbxaoL
         gRwIpHEDeXg71CLlmNYW7WqHcGlWXgqcWxACvwBsCUF0UUca45U/93RRIO+fYEOKeT
         eTlwyqFgkVkC5egfXqviMlHMtoa/1DGY15Q4gT+F2dPISkGJ8E7g5KdIzbESRI+1m7
         GOcgYF/0CvEcw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 1/3] RDMA/mlx5: Use the correct obj_id upon DEVX TIR creation
Date:   Wed, 30 Dec 2020 15:01:19 +0200
Message-Id: <20201230130121.180350-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230130121.180350-1-leon@kernel.org>
References: <20201230130121.180350-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Use the correct obj_id upon DEVX TIR creation by strictly taking the
tirn 24 bits and not the general obj_id which is 32 bits.

Fixes: 7efce3691d33 ("IB/mlx5: Add obj create and destroy functionality")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index f8a23095c7c8..21a25f0c7640 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1064,7 +1064,9 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_RQT);
 		break;
 	case MLX5_CMD_OP_CREATE_TIR:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_TIR);
+		*obj_id = MLX5_GET(create_tir_out, out, tirn);
+		MLX5_SET(destroy_tir_in, din, opcode, MLX5_CMD_OP_DESTROY_TIR);
+		MLX5_SET(destroy_tir_in, din, tirn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_TIS:
 		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_TIS);
--
2.29.2

