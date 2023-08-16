Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F677DAB6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbjHPGwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbjHPGwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 02:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBED219A1;
        Tue, 15 Aug 2023 23:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80FB364D91;
        Wed, 16 Aug 2023 06:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE55C433C8;
        Wed, 16 Aug 2023 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692168751;
        bh=9x6XYCIJfZswqP71VF9xof0678DuoczWTBVfmmHFNoE=;
        h=From:To:Cc:Subject:Date:From;
        b=Qk2/Mu80XH2lI/JVifFwYdyM/VWRmEtd3lxhgLl3D4U4WZZd//hMvjsf27IRvMF11
         5CnW8cqLPskd5tnXDQcbSEe9VZRQhQsK8zTeuyiggL+syP8A7DUZGtSiebjdCtYPrJ
         Pc0jJcDBbsD/NsIt4zs2/b+Ij7VZsNpTUwAywbSvHdLdIAdrcL0KD+Jm9OPh31FQ0D
         NpMiGJTOrSzM/aaWbqQOeDbKJoBkaK8N7wKrwunNH+b0efvnGQzuJ456UUCluwLQrx
         NNWLrA3YXqoK3YOFkZ1BN/czm0drz43Ke0ub81Zkz8Vx98WkUSNwvvwg9+rtdEUYmS
         4n8OJPb9mt3yA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 0/2] mlx5 RDMA LAG fixes
Date:   Wed, 16 Aug 2023 09:52:22 +0300
Message-ID: <cover.1692168533.git.leon@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

These two not urgent fixes to mlx5 RDMA LAG logic.

Thanks

Mark Bloch (2):
  RDMA/mlx5: Get upper device only if device is lagged
  RDMA/mlx5: Send correct port events

 drivers/infiniband/hw/mlx5/main.c             | 57 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 29 ++++++++++
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 75 insertions(+), 13 deletions(-)

-- 
2.41.0

