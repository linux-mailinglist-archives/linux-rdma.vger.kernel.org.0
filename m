Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D24722390
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFEKdt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFEKds (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F97EA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB3136121E
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD865C433EF;
        Mon,  5 Jun 2023 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961227;
        bh=4nPWi1m1zyWeKstR86T0YCsDA7ksQ9Xx04R5YkTHyiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUSaG6AtpyN5xL1cCXJRVCIG1pZruPNHPvjLybvsp58HM8H6fSulJPSy83N9o/xKr
         6Y9BEtIOGudECXYfBJhWrKtP39dXU4EZDPqfxt6a4o3gvQ1GmweAxrMbkWURoRBaeV
         Q02qHDaUcgNj9geHNHGP2PpQpEPMiyU6ZIbW37qbX665lYBzYQmDcdgrVxA4kZoTQ4
         qEO/V0Svv6WX6HHZj7CHOAqKU2qcMwbe1XXM2DpEm9iDplynm3wx2eYCPAEDL6uKl3
         Ps87Z7l3GWZFbByJs2vQYhbtxqhtpblEhcLnhUilikZ3cgYGgp+Re1JdYyyTnNmnra
         u+UE36BlRQS9w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-rc 05/10] RDMA/mlx5: Fix Q-counters query in LAG mode
Date:   Mon,  5 Jun 2023 13:33:21 +0300
Message-Id: <778d7d7a24892348d0bdef17d2e5f9e044717e86.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Previously we used the core device associated to the IB device in order
to do the Q-counters query to the FW, but in LAG mode it is possible
that the core device isn't the one that created this VF.

Hence instead of using the core device to query the Q-counters
we use the ESW core device which is guaranteed to be that of the VF.

Fixes: d22467a71ebe ("RDMA/mlx5: Expand switchdev Q-counters to expose representor statistics")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index f40d9c61e30b..93257fa5aae8 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -330,6 +330,7 @@ static int mlx5_ib_query_q_counters_vport(struct mlx5_ib_dev *dev,
 {
 	u32 out[MLX5_ST_SZ_DW(query_q_counter_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(query_q_counter_in)] = {};
+	struct mlx5_core_dev *mdev;
 	__be32 val;
 	int ret, i;
 
@@ -337,12 +338,16 @@ static int mlx5_ib_query_q_counters_vport(struct mlx5_ib_dev *dev,
 	    dev->port[port_num].rep->vport == MLX5_VPORT_UPLINK)
 		return 0;
 
+	mdev = mlx5_eswitch_get_core_dev(dev->port[port_num].rep->esw);
+	if (!mdev)
+		return -EOPNOTSUPP;
+
 	MLX5_SET(query_q_counter_in, in, opcode, MLX5_CMD_OP_QUERY_Q_COUNTER);
 	MLX5_SET(query_q_counter_in, in, other_vport, 1);
 	MLX5_SET(query_q_counter_in, in, vport_number,
 		 dev->port[port_num].rep->vport);
 	MLX5_SET(query_q_counter_in, in, aggregate, 1);
-	ret = mlx5_cmd_exec_inout(dev->mdev, query_q_counter, in, out);
+	ret = mlx5_cmd_exec_inout(mdev, query_q_counter, in, out);
 	if (ret)
 		return ret;
 
-- 
2.40.1

