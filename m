Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668597CF324
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJSIrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjJSIrN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 04:47:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E610F
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 01:47:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3370C433C7;
        Thu, 19 Oct 2023 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697705231;
        bh=BeF75taP1PkFfsjkVSf4uHezd15FaNsIdu3Y0ko8I0M=;
        h=From:To:Cc:Subject:Date:From;
        b=m6g+pEbFU+Y/SyFXOTPLYAH4ucAmSzyJvzLCkMmY+2cOVlc2mQs9pAmuBP/b+HXE0
         Mi/iEyoFQ5NPgr20eeDE2Bcj0OjcUQ74oPf3t+8EMxKDJNuiFRIlfP3NOq1jKUVsZA
         1mFyX99Bwo4ilIEalujMLrqMdy5jSXJNFL38aX0Lt4lFIRQG36zAUYb8b3OmJuztbp
         JWTSJyICmX1G9hvRyhRWNmmht1+RfWkJ2p7jL4qAuHK8MqTeP5zTMi/jIgrkQ7+zyd
         jEG2eqIzUHOsmRk2KL3JFQUjUMNUB6DLgXvamRMkPKs2UirOMMokwkxIsnSbjkELFy
         7XAceEjidCZRw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Change the key being sent for MPV device affiliation
Date:   Thu, 19 Oct 2023 11:47:05 +0300
Message-ID: <ac7e66357d963fc68d7a419515180212c96d137d.1697705185.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Change the key that we send from IB driver to EN driver regarding the
MPV device affiliation, since at that stage the IB device is not yet
initialized, so its index would be zero for different IB devices and
cause wrong associations between unrelated master and slave devices.

Instead use a unique value from inside the core device which is already
initialized at this stage.

Fixes: 0d293714ac32 ("RDMA/mlx5: Send events from IB driver about device affiliation state")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 06967366920c..9276811af961 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3298,7 +3298,7 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	mlx5_ib_init_cong_debugfs(ibdev, port_num);
 
-	key = ibdev->ib_dev.index;
+	key = mpi->mdev->priv.adev_idx;
 	mlx5_core_mp_event_replay(mpi->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
-- 
2.41.0

