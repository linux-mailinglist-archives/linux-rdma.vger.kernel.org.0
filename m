Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92772238B
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjFEKdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFEKdi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5990EA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D772615D7
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67FC433D2;
        Mon,  5 Jun 2023 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961216;
        bh=k3vorM0ndnSZlBq4Lc14DAS+r+QOZZs+nS3B6729fCk=;
        h=From:To:Cc:Subject:Date:From;
        b=hPySnssZvIeUOHKJicjHVc89Fwr6oA6lxLRTA+c8pm/LK+ymmfVAnu8d8Dy2Jh4ja
         efA78F8iYPaKUVKCs0hTdhj0eeDtSD/3tTCR7ua4oU0oIQ1rgaVdArDynYYnMXtWPK
         MoaxaC2FPv0LxJo2nyfpREDP10JZQCOqMSH4q5yd9IS0r5KYWfR3GCxJNlLDvjvERM
         Ioi6CKYSZvp3INhQ1qSyrUuJszkEg5X1U2cpfD6ZrYd5i6DYlnmKo78DKA/W6G4rE/
         KFVxZXbsYOHPUI0ua7Sl0rIJrTORX2iBWpFZrpOcPHVkUh8yrgs2+atCRiMQjAJDf1
         4yEUJadRv6QHw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 00/10] Batch of uverbs and mlx5_ib fixes
Date:   Mon,  5 Jun 2023 13:33:16 +0300
Message-Id: <cover.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This is my collection of various fixes.

Thanks

Edward Srouji (1):
  RDMA/uverbs: Restrict usage of privileged QKEYs

Maher Sanalla (1):
  RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions

Mark Bloch (2):
  RDMA/mlx5: Create an indirect flow table for steering anchor
  RDMA/mlx5: Fix affinity assignment

Mark Zhang (1):
  RDMA/cma: Always set static rate to 0 for RoCE

Michael Guralnik (1):
  RDMA/mlx5: Fix mkey cache possible deadlock on cleanup

Patrisious Haddad (3):
  RDMA/mlx5: Fix Q-counters per vport allocation
  RDMA/mlx5: Remove vport Q-counters dependency on normal Q-counters
  RDMA/mlx5: Fix Q-counters query in LAG mode

Yishai Hadas (1):
  IB/uverbs: Fix to consider event queue closing also upon non-blocking
    mode

 drivers/infiniband/core/cma.c                 |   4 +-
 drivers/infiniband/core/uverbs_cmd.c          |   7 +-
 drivers/infiniband/core/uverbs_main.c         |  12 +-
 drivers/infiniband/hw/mlx5/counters.c         |  89 ++++--
 drivers/infiniband/hw/mlx5/fs.c               | 276 +++++++++++++++++-
 drivers/infiniband/hw/mlx5/fs.h               |  16 +
 drivers/infiniband/hw/mlx5/main.c             |   3 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  14 +
 drivers/infiniband/hw/mlx5/mr.c               |  10 +-
 drivers/infiniband/hw/mlx5/qp.c               |   3 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  12 -
 include/linux/mlx5/driver.h                   |  12 +
 include/rdma/ib_addr.h                        |  23 --
 13 files changed, 401 insertions(+), 80 deletions(-)

-- 
2.40.1

