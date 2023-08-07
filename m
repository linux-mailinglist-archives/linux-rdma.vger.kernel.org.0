Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B764771E71
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHGKod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHGKoc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:44:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FDE70
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DFC617A0
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08FCC433C8;
        Mon,  7 Aug 2023 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405070;
        bh=NEJekxXMW9W3tGLBuEuCgnhY8jkalcmieVmJYUxZff4=;
        h=From:To:Cc:Subject:Date:From;
        b=mLvdtVDjSnMp4a940H0xtjVJ6F6ZYCGdgwhyEgNNBpm6JQyLLIah+ToAFGEL7/e1a
         8WNdx9zAgjq83Yam8E/Y572ymsQnQ7WlPIWznQPb7uHlFMuaZw2r7K1H486N/u/TBs
         zr+cjKo+6hDXObACweTbefHPuxEwXuRWIMzAxsBzFnCKHEvSEgY+Co9EnHbRrtEvNR
         8lxdRbRRtZDixUV9Pl8q5JDB4dAFFjE+DczUzI9aWdg0U05asaO0iY1a2OHW9GX9kq
         OZU/umY+ESb8JTHNv1MIEbGZQFY2eFr75KVDx4MQ9cuonvuFfvFqN78bZIDf1qFsKg
         z1BLiLMV+J9jw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 00/14] mlx5 MACsec RoCEv2 support
Date:   Mon,  7 Aug 2023 13:44:09 +0300
Message-ID: <cover.1691403485.git.leon@kernel.org>
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

From Patrisious:

This series extends previously added MACsec offload support
to cover RoCE traffic either.

In order to achieve that, we need configure MACsec with offload between
the two endpoints, like below:

REMOTE_MAC=10:70:fd:43:71:c0

* ip addr add 1.1.1.1/16 dev eth2
* ip link set dev eth2 up
* ip link add link eth2 macsec0 type macsec encrypt on
* ip macsec offload macsec0 mac
* ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
* ip macsec add macsec0 rx port 1 address $REMOTE_MAC
* ip macsec add macsec0 rx port 1 address $REMOTE_MAC sa 0 pn 1 on key 01 ead3664f508eb06c40ac7104cdae4ce5
* ip addr add 10.1.0.1/16 dev macsec0 
* ip link set dev macsec0 up

And in a similar manner on the other machine, while noting the keys order
would be reversed and the MAC address of the other machine.

RDMA traffic is separated through relevant GID entries and in case of IP ambiguity
issue - meaning we have a physical GIDs and a MACsec GIDs with the same IP/GID, we
disable our physical GID in order to force the user to only use the MACsec GID.

Thanks

Patrisious Haddad (14):
  macsec: add functions to get macsec real netdevice and check offload
  net/mlx5e: Move MACsec flow steering operations to be used as core
    library
  net/mlx5: Remove dependency of macsec flow steering on ethernet
  net/mlx5e: Rename MACsec flow steering functions/parameters to suit
    core naming style
  net/mlx5e: Move MACsec flow steering and statistics database from
    ethernet to core
  net/mlx5: Remove netdevice from MACsec steering
  net/mlx5: Maintain fs_id xarray per MACsec device inside macsec
    steering
  net/mlx5: Add MACsec priorities in RDMA namespaces
  net/mlx5: Configure MACsec steering for egress RoCEv2 traffic
  net/mlx5: Configure MACsec steering for ingress RoCEv2 traffic
  net/mlx5: Add RoCE MACsec steering infrastructure in core
  RDMA/mlx5: Implement MACsec gid addition and deletion
  IB/core: Reorder GID delete code for RoCE
  RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion

 drivers/infiniband/core/cache.c               |    6 +-
 drivers/infiniband/hw/mlx5/Makefile           |    1 +
 drivers/infiniband/hw/mlx5/macsec.c           |  364 +++
 drivers/infiniband/hw/mlx5/macsec.h           |   29 +
 drivers/infiniband/hw/mlx5/main.c             |   41 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   17 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |    2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |    4 +-
 .../mellanox/mlx5/core/en_accel/macsec.c      |  176 +-
 .../mellanox/mlx5/core/en_accel/macsec.h      |   26 +-
 .../mellanox/mlx5/core/en_accel/macsec_fs.c   | 1394 ----------
 .../mellanox/mlx5/core/en_accel/macsec_fs.h   |   47 -
 .../mlx5/core/en_accel/macsec_stats.c         |   22 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |    1 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   37 +-
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 2411 +++++++++++++++++
 .../mellanox/mlx5/core/lib/macsec_fs.h        |   64 +
 drivers/net/macsec.c                          |   15 +
 include/linux/mlx5/device.h                   |    2 +
 include/linux/mlx5/driver.h                   |   51 +
 include/linux/mlx5/fs.h                       |    2 +
 include/linux/mlx5/macsec.h                   |   32 +
 include/net/macsec.h                          |    2 +
 26 files changed, 3122 insertions(+), 1630 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.c
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.h
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
 create mode 100644 include/linux/mlx5/macsec.h

-- 
2.41.0

