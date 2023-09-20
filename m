Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C791F7A787A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjITKCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjITKCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:02:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F68AB
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:02:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13F7C433C7;
        Wed, 20 Sep 2023 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204131;
        bh=kdzITnPQosr+sXTvv79I2LWIDuZmV9izbT6R8EGKHrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ea0GF+/15tmWDDA+uonkU9yq0Ga+868pO8Z9v6TXhkCnUKlzgXe4O7I0ckjLijHDt
         BCqAsOJlqpQs2Gw2quRjF0T/k9fXAAzZrxlRLAJT41HLggYlMQpkHQ5gf02pq9z1vc
         f/RX9peRTvGva3scag0Cjl9F8mQkuCh3Yg4gAzg2h3xDStPlBFlWI59zIP5b+wCnTI
         adbcnVVYlhny3tPwvZ9dRabeue2FoCk3YbxWoRCMCoXrQQ0rwD7xyG60b2DLOoF50b
         bTklHODPodvR2W8nUWuh2APPPIiilOkKYoeZ95AEGJp4Xy3j9fAdmV62upMHKZ1SwQ
         +/LaJ2ovcboQA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Hamdan Igbaria <hamdani@nvidia.com>,
        Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc 2/3] RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation
Date:   Wed, 20 Sep 2023 13:01:55 +0300
Message-ID: <1244a69d783da997c0af0b827c622eb00495492e.1695203958.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695203958.git.leonro@nvidia.com>
References: <cover.1695203958.git.leonro@nvidia.com>
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

From: Hamdan Igbaria <hamdani@nvidia.com>

The mutex was not unlocked on some of the error flows.
Moved the unlock location to include all the error flow scenarios.

Fixes: e1f4a52ac171 ("RDMA/mlx5: Create an indirect flow table for steering anchor")
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 1e419e080b53..520034acf73a 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2470,8 +2470,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 	mlx5_steering_anchor_destroy_res(ft_prio);
 put_flow_table:
 	put_flow_table(dev, ft_prio, true);
-	mutex_unlock(&dev->flow_db->lock);
 free_obj:
+	mutex_unlock(&dev->flow_db->lock);
 	kfree(obj);
 
 	return err;
-- 
2.41.0

