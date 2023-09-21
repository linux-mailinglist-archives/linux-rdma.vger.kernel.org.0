Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A80B7A970C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjIURLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIUREx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:04:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DAE1711
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:02:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14856C4E663;
        Thu, 21 Sep 2023 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298243;
        bh=3zUerJob8LTaLhGfDXM3f8fNe7+0Vp+OP7wcaT6sgF0=;
        h=From:To:Cc:Subject:Date:From;
        b=UEI4nhusOGx2X/DJ36lARYRKoo5KvubaseFamdvlR+YELv35D+Ps9pJ9pbXkq3OnP
         JoWgE04zwdU7oP0s1PH2F+4xjsh3PiJjUsrq95W2FniU4N4yefFdfCebjBlm14j656
         u5G9eI+SBC/Z/r6nu7TAKyJVraOnhpQqFHa2g08OpZVzghOvPdRAYMRzYaah/SWASA
         wTzkxCMPIWzbW08MAYVWW7qLf7qia5RLSpKl5wGXbsRprALAgoP09lmURY8WzuWeXb
         IW6qZpd0km/CXSqxWbJAPFHsjCt6yXB5Xg37vLYeukeIHr4Y/8Hr9Sr/D9cV8hLYPc
         6tE4GxhLaR64w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH mlx5-next 0/9] Support IPsec packet offload in multiport RoCE devices
Date:   Thu, 21 Sep 2023 15:10:26 +0300
Message-ID: <cover.1695296682.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
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

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series from Patrisious extends mlx5 to support IPsec packet offload
in multiport devices (MPV, see [1] for more details).

These devices have single flow steering logic and two netdev interfaces,
which require extra logic to manage IPsec configurations as they performed
on netdevs.

Thanks

[1] https://lore.kernel.org/linux-rdma/20180104152544.28919-1-leon@kernel.org/

Thanks

Patrisious Haddad (9):
  RDMA/mlx5: Send events from IB driver about device affiliation state
  net/mlx5: Register mlx5e priv to devcom in MPV mode
  net/mlx5: Store devcom pointer inside IPsec RoCE
  net/mlx5: Add alias flow table bits
  net/mlx5: Implement alias object allow and create functions
  net/mlx5: Add create alias flow table function to ipsec roce
  net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
  net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
  net/mlx5: Handle IPsec steering upon master unbind/bind

 drivers/infiniband/hw/mlx5/main.c             |  17 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  70 +++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   8 +
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   3 +-
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 122 +++-
 .../mlx5/core/en_accel/ipsec_offload.c        |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  63 ++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    | 542 +++++++++++++++++-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h    |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  22 +
 include/linux/mlx5/device.h                   |   2 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/mlx5_ifc.h                 |  56 +-
 17 files changed, 925 insertions(+), 41 deletions(-)

-- 
2.41.0

