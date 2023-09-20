Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF567A7896
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjITKIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjITKIV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:08:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5BBAF
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA704C433C7;
        Wed, 20 Sep 2023 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204495;
        bh=nk9sUgWDYC5lpjFZ2LPWQ3HlWeTCNQ9xYNRq9k9Bbnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wm5c44I6MfX1bBfajxOD6q3Tef68IFN8FwnurRhWTeFcnucuF81VdADL1RIKUOICe
         tWfh28QwfKjuEEtEjWIgq9xSJ0MkRKt/uMoPmvgg3VSPRlDhP53orBw1b2nF6eaIwj
         BttVVwaznlnovPNaXQn531yFoxyWVxtwgx9t8E92ar+uqKR0Ed7ABUoKyLtB1iAooA
         znSHCWApt+cA4lZEVKPjPD70OrRq47f0lw0lafa4AOuYAu8zHVrhT+J5zUQHBtGN5z
         KXkCKl1Zwfw38PArAaoEYFgXCZBQ/Y5AMlfesTakEr7494pri2hjJxY5dRedDis+ne
         zPI17gs+GlFsA==
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
Subject: [PATCH rdma-next 6/6] RDMA/ipoib: Add support for XDR speed in ethtool
Date:   Wed, 20 Sep 2023 13:07:45 +0300
Message-ID: <ca252b79b7114af967de3d65f9a38992d4d87a14.1695204156.git.leon@kernel.org>
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

The IBTA specification 1.7 has new speed - XDR, supporting signaling
rate of 200Gb.

Ethtool support of IPoIB driver translates IB speed to signaling rate.
Added translation of XDR IB type to rate of 200Gb Ethernet speed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 8af99b18d361..7da94fb8d7fa 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -174,6 +174,8 @@ static inline int ib_speed_enum_to_int(int speed)
 		return SPEED_50000;
 	case IB_SPEED_NDR:
 		return SPEED_100000;
+	case IB_SPEED_XDR:
+		return SPEED_200000;
 	}
 
 	return SPEED_UNKNOWN;
-- 
2.41.0

