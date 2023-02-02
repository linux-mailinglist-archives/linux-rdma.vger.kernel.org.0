Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9E687827
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 10:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjBBJDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 04:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjBBJDV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 04:03:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922D5B9F;
        Thu,  2 Feb 2023 01:03:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3075761A34;
        Thu,  2 Feb 2023 09:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11975C433D2;
        Thu,  2 Feb 2023 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675328592;
        bh=O5PxmLyogSKp6fm3zoyf+RnAlkhGjJZJBmZ6s0sTyks=;
        h=From:To:Cc:Subject:Date:From;
        b=AMSWvUgfqRblOJlRnxrkJF2OiQUhCtXBy5xsDiix9Uk49fz7EqjJUrrueNE2bwkLD
         BG0Wjdttt+5fY85Os6cDu6BB3dYy42Y5MLmZGGu0+mlemd7bchO+L1vOOYiGXms5Yd
         uq2D/GAYPNABSzFFo4vtxbT5QBdCJfpYkMwXH7WJ3Cs6w8TTzDrjhun85rRqtQ/j4M
         1PPGfzG22Rfg5wPpQi5ZZyQFAyauIg1AOBwe4zUIDv24Lw5uweDNjpk4RfF89WHOIg
         6qcx9wnYIxI7zcB+jRWjar/W/kJcT9mBb24XDqporfwneo/MHGdGIyxKpzNLk3TOaz
         JXHcC2LLkMSeQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 0/2] Two small fixes to MR cache series
Date:   Thu,  2 Feb 2023 11:03:05 +0200
Message-Id: <cover.1675328463.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
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

There are two small patches with fix and cleanup to previously accepted
MR cache series from Michael.

Thanks

Leon Romanovsky (2):
  RDMA/mlx5: Fix MR cache debugfs in switchdev mode
  RDMA/mlx5: Remove impossible check of mkey cache cleanup failure

 drivers/infiniband/hw/mlx5/main.c    |  7 +------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 10 ++++++----
 3 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.39.1

