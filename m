Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F6649343
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Dec 2022 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLKJMB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Dec 2022 04:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLKJMA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Dec 2022 04:12:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58612DF42;
        Sun, 11 Dec 2022 01:11:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB4E60D3F;
        Sun, 11 Dec 2022 09:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5B0C433F0;
        Sun, 11 Dec 2022 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670749918;
        bh=zoeFkryKyy4XLlkSB3eZK2KAqK0VFeBeFjL6/uHCJZU=;
        h=From:To:Cc:Subject:Date:From;
        b=hdpkfopzNOJuxJmmQvQNpV3Fv4Yi9hqkmbJvAoZFZS673KLLAQHtVw3WxK59Chtyj
         o6UA5qGghG0gADOazQcACxoc3xN9oJdMZZSr0Tshq/Gpjd9i0qQCfNQnzvjsYlZHwu
         a22Hpf6kI61+nJkTwhVuFBuSx/B8vGcS5u9aej0U2KpIY6yu375keP0K/E+Ops9J9b
         9jcXyY0X9XJa61hVO7qoEIZ3dqA14I0/k7VxKAKfTr0JQZUdK2CQPpuF8Nd6Y2ruan
         K3yNH3yyf7b7pHyz0MzSy1UwQ29kDRpwzDOwTDU2n0NBb+ekVBQOkJhWCyFV2TUL4q
         9LZ5frpcQMWzQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/2] Two last minute mlx5 fixes
Date:   Sun, 11 Dec 2022 11:11:50 +0200
Message-Id: <cover.1670749789.git.leonro@nvidia.com>
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

Please find two last minute mlx5 fixes.

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

