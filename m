Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56C2388997
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbhESIm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 04:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245627AbhESIm5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 04:42:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A64D60C3D;
        Wed, 19 May 2021 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621413698;
        bh=NHzva1BedRTQo1ZiYTLnCiPM+iMIZVRQCHVWgn+Qbcc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ql7y2bn4qw1rsWiv5Yi4fr6ZOknDNpCuPHlvIBxASQZgF3AF8Klb50z1jHQ+6Tyze
         qAHiv00NHCIE1QFMjyTI801rjj+/EPg/Uy3hPjr6YDWkWLdkTBCmHiALmkG6goZAMR
         oJSIXltBbsbh3pRB71xD1VDgFklffzv7SUACTLSuGn6U0LyL9EsPkeJWWdvsax0+SM
         TvP0ELY4bfT8ncXxWmM18Fckwd1km69f5P6ZxroWontEuuKDDza/UZYTQndYjxvmoJ
         itRIavZFsyHw328I4fu6YPQSMV8MRTbNEDlUIRILuWNPgpiobyA+6N+zn3uKIQJLE5
         VgOwI+2UJiPig==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix query DCT via DEVX
Date:   Wed, 19 May 2021 11:41:32 +0300
Message-Id: <6eee15d63f09bb70787488e0cf96216e2957f5aa.1621413654.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

When executing DEVX command to query QP object, we need to take
the QP type from the mlx5_ib_qp struct which hold the driver specific
QP types as well, such as DC.

Fixes: 34613eb1d2ad ("IB/mlx5: Enable modify and query verbs objects via DEVX")
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 72a0828388de..53dc67e16d03 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -630,9 +630,8 @@ static bool devx_is_valid_obj_id(struct uverbs_attr_bundle *attrs,
 	case UVERBS_OBJECT_QP:
 	{
 		struct mlx5_ib_qp *qp = to_mqp(uobj->object);
-		enum ib_qp_type	qp_type = qp->ibqp.qp_type;
 
-		if (qp_type == IB_QPT_RAW_PACKET ||
+		if (qp->type == IB_QPT_RAW_PACKET ||
 		    (qp->flags & IB_QP_CREATE_SOURCE_QPN)) {
 			struct mlx5_ib_raw_packet_qp *raw_packet_qp =
 							 &qp->raw_packet_qp;
@@ -649,10 +648,9 @@ static bool devx_is_valid_obj_id(struct uverbs_attr_bundle *attrs,
 					       sq->tisn) == obj_id);
 		}
 
-		if (qp_type == MLX5_IB_QPT_DCT)
+		if (qp->type == MLX5_IB_QPT_DCT)
 			return get_enc_obj_id(MLX5_CMD_OP_CREATE_DCT,
 					      qp->dct.mdct.mqp.qpn) == obj_id;
-
 		return get_enc_obj_id(MLX5_CMD_OP_CREATE_QP,
 				      qp->ibqp.qp_num) == obj_id;
 	}
-- 
2.31.1

