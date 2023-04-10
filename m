Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE46DC728
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDJNMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDJNMO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 09:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7F8689;
        Mon, 10 Apr 2023 06:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3209161BF8;
        Mon, 10 Apr 2023 13:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10413C433EF;
        Mon, 10 Apr 2023 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681132332;
        bh=r4fppen4LWYEubzBxRMswtNfHdHoMxt1Js6dgbpC9CA=;
        h=From:To:Cc:Subject:Date:From;
        b=b8oxKMJFXHjFDL6z0b6m+tH9dx3sQHN0PrMBdIOmZga5ikJ2kIIC0b/xyY9CE6edO
         DgnNcqkWjoC1WwOgc4c9JNxcngSGbnf7j8GtTg9Q/FrtNTHzphb4A/mPHqR8bd8yRn
         UgDHRYx7BdCWzK3soC5+YCVzuCq3H8ekgT/453VVYaa6ZJRYn2vY0iakCaoC+b+iaS
         YVIPDtZIptFcnaGDpUD3DYwG8zbsbSRA8rULIS7OBJ1gyWhwi3IBMq0o3siN3dlYZ9
         m4Ygtg7aAZkqTmlBXgOy2kpbRLnQUQSx9/1Zw1BDdDmibTBaSgt4IzA3KUDhcQDMU1
         jWUgKtBcAgjEw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 0/2] Query IBoE speed directly
Date:   Mon, 10 Apr 2023 16:12:05 +0300
Message-Id: <cover.1681132096.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Mark,

This series adds a new driver API to query the IBoE link speed, as well
as the mlx5 implementation.

Currently the ethtool API is used, which must be protected with the rtnl
lock. This becomes a bottleneck when try to create many rdma-cm
connections at the same time, especially with multiple processes.

With this new API we can get rid of the rtnl lock and ethtool operation.
Test result shows clear improvement, An example below (the time needed
for a process to create all connections):

        One process with    One process with     Eight processes, each
	1,000 connections   10,000 connections   with 1,000 connections
old:         10330ms             106107ms            47723ms
new:         7937ms              80108ms             19446ms
Improvement: 23.2%                24.5%               59.3%

Thanks

Mark Zhang (2):
  IB/core: Query IBoE link speed with a new driver API
  IB/mlx5: Implement query_iboe_speed driver API

 drivers/infiniband/core/cma.c                |  6 ++-
 drivers/infiniband/core/device.c             |  1 +
 drivers/infiniband/hw/mlx5/main.c            | 41 ++++++++++++++++++++
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 24 ------------
 include/rdma/ib_addr.h                       | 31 +++++++++------
 include/rdma/ib_verbs.h                      | 26 +++++++++++++
 6 files changed, 92 insertions(+), 37 deletions(-)

-- 
2.39.2

