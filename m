Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917EB6576B3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiL1M4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 07:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiL1M4T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 07:56:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044D269
        for <linux-rdma@vger.kernel.org>; Wed, 28 Dec 2022 04:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB3D5B816A1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Dec 2022 12:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126DAC433D2;
        Wed, 28 Dec 2022 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672232175;
        bh=n+fyycl7q3JZP8vEqvA+f/JAa8f+JqJikGxr5VN6buQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mi15Tu7LDOHCuNg+pmiDCOHtycaATyQ8l64CMiP4Yzjw7bHWDFQJpwgeo1LB+BchV
         YunSyLqg2KCobBiZ6+QdmFeoDSAtXpveoxzFDlXyNQwLe/3XzuYxaxC6YjGIvduoF4
         8jLoD1sodF4Rfk6MX4lNTYbhWZbDF0AhvxT93Yv4eLCXhuZuNVx4jXJQz6aLfkVleu
         amStSpafuFdEWFA8dm3OgV1hzlTy5xCuJ6wJtrbySbfO8rAiD4faLxe+7Ets1OGV62
         SBTbhIApe6Syv6GB1AGwGxflhcNeMGfUDVNk+R4OOuHNmIoacWUYyDqt/8bDRP7faJ
         e3di+tBFmQaJw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH RESEND rdma-next 0/2] Two mlx5_ib fixes 
Date:   Wed, 28 Dec 2022 14:56:08 +0200
Message-Id: <cover.1672231736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This was already posted to ML, but too late to be included in last pull
request to Linus, so simply resending them.

Thanks

Maor Gottlieb (1):
  RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

Shay Drory (1):
  RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device

 drivers/infiniband/hw/mlx5/counters.c |  6 ++--
 drivers/infiniband/hw/mlx5/qp.c       | 49 +++++++++++++++++++--------
 2 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.38.1

