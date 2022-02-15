Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766114B785F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiBORzv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:55:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiBORzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:55:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C1FEB34;
        Tue, 15 Feb 2022 09:55:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54090615F4;
        Tue, 15 Feb 2022 17:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1C9C340F0;
        Tue, 15 Feb 2022 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644947739;
        bh=8jqw1SbbN1bCwucftaezbFXbmtXyg3plJCA6mm8sWpc=;
        h=From:To:Cc:Subject:Date:From;
        b=Iog7V3Q55nsodj1YR+x5JFrg788GrUsIcXWdbldqIw/AojuJqivYIow/B6n4Tv5lQ
         c/oOp+MoXqQ/FIacA8H1eO+8EUZgH6cF1hesqpc7RcE8MhdX4wNDYj2ZKWySIwf8wi
         6LTGhs4ci0KIYsYIvU4vE8Sd029Y/e0PEN2KOmp0KSnN76M2NfmPj+WRwWC1x7X+rn
         2F2jlGw/61v4J1hM7TxT6Ch3KvGvfkJMzEo2KvO/BA3CTi87fmWrSOUDJFZokaRNR5
         CZTyF3sOSOHx0bSJIRG4Yk6nxyESzZnjmuN/xrooPZXbyIxBabWSBQ1O9HdQCfgGQd
         0kxoXVLrpQDUg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 0/5] MR cache enhancements
Date:   Tue, 15 Feb 2022 19:55:28 +0200
Message-Id: <cover.1644947594.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 * Susbset of previously sent patches
v1: https://lore.kernel.org/all/cover.1640862842.git.leonro@nvidia.com
 * Based on DM revert https://lore.kernel.org/all/20211222101312.1358616-1-maorg@nvidia.com
v0: https://lore.kernel.org/all/cover.1638781506.git.leonro@nvidia.com

---------------------------------------------------------
Hi,

This series from Aharon cleans a little bit MR logic.

Thanks

Aharon Landau (5):
  RDMA/mlx5: Remove redundant work in struct mlx5_cache_ent
  RDMA/mlx5: Fix the flow of a miss in the allocation of a cache ODP MR
  RDMA/mlx5: Merge similar flows of allocating MR from the cache
  RDMA/mlx5: Store ndescs instead of the translation table size
  RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()

 drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +-
 drivers/infiniband/hw/mlx5/mr.c      | 104 ++++++++++-----------------
 drivers/infiniband/hw/mlx5/odp.c     |  19 ++---
 3 files changed, 52 insertions(+), 77 deletions(-)

-- 
2.35.1

