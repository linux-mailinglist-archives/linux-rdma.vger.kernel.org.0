Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAD423A93
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhJFJdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 05:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhJFJdu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 05:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D0E61027;
        Wed,  6 Oct 2021 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633512718;
        bh=wkPh8VPQX3uKN6sbRN2T/KwlSV3P42KzsuLogBDgxuA=;
        h=From:To:Cc:Subject:Date:From;
        b=asQ2kD/QiLooDpu9ujQKmLTzuM9TLPt/Ezy9YJyR3azj7ll/+cSnBSGzOwQu/+l93
         f282E2jr7DFxOEMsM+DV1Plpaer9+kSv8Yil4Nm7xi6EQ8Jey3nymjm6/h9Ee/GZjE
         6S0sSZXIsLGyQsBBTEDJxz95nMQ52JVtPSZAMzl4llWy0iJbwwTVI5u8FoDzv9XPZC
         TvFsGyF974obK7IF0eId0Zd5v4tx8A/BfFQkFHCYVhZ+5cdkoynN2wzJOQk6u/SSG0
         a8idtF2Bp8owaWznJxxLXo8TAvNmP9Ccl/wKVB051hcnxGcdamK+EoK9JsOzWPMjRH
         JQIZnG8gO90+w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Moni Shoua <monis@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Set user priority for DCT
Date:   Wed,  6 Oct 2021 12:31:53 +0300
Message-Id: <5fd2d94a13f5742d8803c218927322257d53205c.1633512672.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Currently, the driver doesn't set the PCP-based priority for DCT,
hence DCT response packets are transmitted without user priority.

Fix it by setting user provided priority in the eth_prio field
in the DCT context, which in turn sets the value in the transmitted packet.

Fixes: 776a3906b692 ("IB/mlx5: Add support for DC target QP")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index b2fca110346c..e5abbcfc1d57 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4458,6 +4458,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		MLX5_SET(dctc, dctc, mtu, attr->path_mtu);
 		MLX5_SET(dctc, dctc, my_addr_index, attr->ah_attr.grh.sgid_index);
 		MLX5_SET(dctc, dctc, hop_limit, attr->ah_attr.grh.hop_limit);
+		if (attr->ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE)
+			MLX5_SET(dctc, dctc, eth_prio, attr->ah_attr.sl & 0x7);
 
 		err = mlx5_core_create_dct(dev, &qp->dct.mdct, qp->dct.in,
 					   MLX5_ST_SZ_BYTES(create_dct_in), out,
-- 
2.31.1

