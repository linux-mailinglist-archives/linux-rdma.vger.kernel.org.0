Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEED72231F
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjFEKOT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjFEKOR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20DEE;
        Mon,  5 Jun 2023 03:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60236123F;
        Mon,  5 Jun 2023 10:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CC4C433EF;
        Mon,  5 Jun 2023 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685960052;
        bh=Zy7F8g5Z2TeY0mKknBJU4ExG8y5dcguFh9LlLAlh+Pk=;
        h=From:To:Cc:Subject:Date:From;
        b=XSO0HxdFSe0laVAjCG6+Bc+fRWM38yXCxIYJtou5sPcLKjdPnj6OjbwftGpmIXezL
         wHJN3eQln4Zg+3ZP68eLM5jQrd2hKdhmW4jHKAsM7kQicrKorXcItrj0S6EBp1Ljs8
         0Z3opamSxw6u2X9DW2MJwrfeu0rLYa1vv1xio+Cv0zRtU5/HNR6jBgZu32ZGYqocIo
         j/5tSqgjXlteQEVbalAF7W4gfm18rc3I096RqhzP0ZmaEQy3HMEpMdRjIPm/KZqNrl
         5olqyoDRByLUy9+CGBZoBs2bPVNJsVFAC/D//5sIKTQBkkpZStzZJ0b7x+iOqrYYtF
         jEvLJVr5N1jzA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next v2 0/4] Handle FW failures to destroy QP/RQ objects
Date:   Mon,  5 Jun 2023 13:14:03 +0300
Message-Id: <cover.1685953497.git.leon@kernel.org>
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

Changelog:
v2:
 * Reworked DCT patch
v1: https://lore.kernel.org/all/cover.1678973858.git.leon@kernel.org
 * Dropped EQ changes
v0: https://lore.kernel.org/all/cover.1649139915.git.leonro@nvidia.com
-----------------------------------------------------------------------

Hi,

This series from Patrisious extends mlx5 driver to convey FW failures
back to the upper layers and allow retry to delete these hardware
resources.

Thanks

Leon Romanovsky (1):
  RDMA/mlx5: Reduce QP table exposure

Patrisious Haddad (3):
  net/mlx5: Nullify qp->dbg pointer post destruction
  RDMA/mlx5: Handle DCT QP logic separately from low level QP interface
  RDMA/mlx5: Return the firmware result upon destroying QP/RQ

 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  1 +
 drivers/infiniband/hw/mlx5/qp.h               | 12 ++-
 drivers/infiniband/hw/mlx5/qpc.c              | 93 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  6 +-
 include/linux/mlx5/driver.h                   | 10 --
 5 files changed, 69 insertions(+), 53 deletions(-)

-- 
2.40.1

