Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652DD7A7890
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjITKIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjITKIA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:08:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90CAC;
        Wed, 20 Sep 2023 03:07:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E4FC433C8;
        Wed, 20 Sep 2023 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204475;
        bh=xHsGR2O0tQHxvQN23PQQPYjCXrNniyRTCpGjvAtMTJU=;
        h=From:To:Cc:Subject:Date:From;
        b=QwV26ae0gkcbWwQ+VSZRv0o4tzyxQZdvjmrtm7NxNN9XJkTWqxwGILOcx1HKuf/Kr
         /uGR4EaEqpiPs7u635xm1JT5TCKugtIRROS3uJQ9BFHqEMseDUgSaJOIqXbZAwKK6N
         nuYksS3wK9d8cSxk4L9TgavM7QUuMlWlSci4kPyq4rYjG9zpbsBY5ZT9u1JHe6lUkg
         qo7rCUEOyk6ktSrwSGxONWhf8lQvsngmbJZ+waoEjtChJ+Z88hvF1giPZNaIwHjPFA
         K2p9JWOawoOnMv6hRoSC1EKVYavVxuRQ829PrzAFtEQwajE9kRubZyDYR/bMYTURZn
         QzaVNkO79VkdA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        netdev@vger.kernel.org, Or Har-Toov <ohartoov@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 0/6] Add 800Gb (XDR) speed support
Date:   Wed, 20 Sep 2023 13:07:39 +0300
Message-ID: <cover.1695204156.git.leon@kernel.org>
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

This series extends RDMA subsystem and mlx5_ib driver to support 800Gb
(XDR) speed which was added to IBTA v1.7 specification.

Thanks

Or Har-Toov (2):
  IB/core: Add support for XDR link speed
  IB/mlx5: Expose XDR speed through MAD

Patrisious Haddad (4):
  IB/mlx5: Add support for 800G_8X lane speed
  IB/mlx5: Rename 400G_8X speed to comply to naming convention
  IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
  RDMA/ipoib: Add support for XDR speed in ethtool

 drivers/infiniband/core/sysfs.c                   |  4 ++++
 drivers/infiniband/core/uverbs_std_types_device.c |  3 ++-
 drivers/infiniband/core/verbs.c                   |  3 +++
 drivers/infiniband/hw/mlx5/mad.c                  | 13 +++++++++++++
 drivers/infiniband/hw/mlx5/main.c                 |  6 +++++-
 drivers/infiniband/hw/mlx5/qp.c                   |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c      |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/port.c    |  3 ++-
 include/linux/mlx5/port.h                         |  3 ++-
 include/rdma/ib_mad.h                             |  2 ++
 include/rdma/ib_verbs.h                           |  2 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h           |  3 ++-
 12 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.41.0

