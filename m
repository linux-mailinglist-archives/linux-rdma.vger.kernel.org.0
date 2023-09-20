Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017F77A7895
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjITKIU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjITKIS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:08:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E680AF5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:08:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3B8C433C7;
        Wed, 20 Sep 2023 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204491;
        bh=EQUlJG44rV9id9Ip0kx1re+czxiANtcpuKWCnMLeOqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/CisvHYBZ98ttIfqJuA2H76sDpjlyu1M+lJf2dta+bFc7nG2+e0vY+DTZJcXgLjY
         Vn7YWpPlJYKxaaXtVw8XkIn2voCys0kbzZCFkEY7z/L2J7t2gNLIkGHmqDKvG5JmOP
         BSTDBOF9AQjYN18VrJz/J+wlaTYtbpkfsvaGURIvE6Qltd61f0NWiIcTnNiiiyxQqh
         TVdbrD0+sCJR3xpxE0liaZxAJQKv0lEfO77GjXQF8IWmjvnU/DDIQhufIahaDEQKC9
         48j2nQGchRl9jZ/xv2iIqX/eO3CgfW6Jv2tPXWBqALssn3/xgoZHIRfMSpy3M5ESLs
         3vyNKt6xnnSZA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Or Har-Toov <ohartoov@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 5/6] IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
Date:   Wed, 20 Sep 2023 13:07:44 +0300
Message-ID: <301c803d8486b0df8aefad3fb3cc10dc58671985.1695204156.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Adjust mlx5 function which maps the speed rate from IB spec values
to internal driver values to be able to handle speeds up to 800Gb.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9261df5328a4..c047c5d66737 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3438,7 +3438,7 @@ static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
 	if (rate == IB_RATE_PORT_CURRENT)
 		return 0;
 
-	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_600_GBPS)
+	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
 		return -EINVAL;
 
 	stat_rate_support = MLX5_CAP_GEN(dev->mdev, stat_rate_support);
-- 
2.41.0

