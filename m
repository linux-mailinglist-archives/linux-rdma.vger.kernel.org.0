Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9949740C
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiAWSDK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAWSDK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19A1C06173B;
        Sun, 23 Jan 2022 10:03:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3985FB80DDA;
        Sun, 23 Jan 2022 18:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E67C340E2;
        Sun, 23 Jan 2022 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642960986;
        bh=Xxp9NkpLTn9XkfjxrWrNTJOxpJ3+NyoF5pVciaxHLPg=;
        h=From:To:Cc:Subject:Date:From;
        b=VThQ0X/xnvNq/bQYqCSvz27urkifBIuMHXF+PyB0D6W/QhFW1hNsiyai766wgSWCW
         VU8kl9MUyareR1nB1gKilClOB816vl8JS7bBa1F3lqMkEUflblJ5trBCkP7VJQEu3W
         Z/Q2YPHOhO/BnvU8CzGkuV25pgwkGcGWwUwiRMBbqsneKnKcC99MXA//KmKoq8Bgdc
         LrjTXgZnYFiUg77eNb4q2m1tp1OhFcLjFDPjxIncvI5FhPANlFMyxQTCFVqDG/vD/x
         asZ3BGb6VTOBXQFTJQ40xNEPxq1T3gA9rO3A/+NU2ksW7p1GGzsH2YIT6rtF9UIGhK
         e1XUtanvZJSkw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 00/11] Delete useless module.h|moduleparam.h includes
Date:   Sun, 23 Jan 2022 20:02:49 +0200
Message-Id: <cover.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Nothing fancy, just delete module.h|moduleparam.h from files that don't
need these includes at all.

Thanks

Leon Romanovsky (11):
  RDMA/mlx5: Delete useless module.h include
  RDMA/core: Delete useless module.h include
  RDMA/hfi1: Delete useless module.h include
  RDMA/mlx4: Delete useless module.h include
  RDMA/mthca: Delete useless module.h include
  RDMA/qib: Delete useless module.h include
  RDMA/usnic: Delete useless module.h include
  RDMA/rxe: Delete useless module.h include
  RDMA/ipoib: Delete useless module.h include
  RDMA/iser: Delete useless module.h include
  RDMA/opa: Delete useless module.h include

 drivers/infiniband/core/addr.c                    | 1 -
 drivers/infiniband/core/cache.c                   | 1 -
 drivers/infiniband/core/cma_configfs.c            | 1 -
 drivers/infiniband/core/cq.c                      | 1 -
 drivers/infiniband/core/iwpm_util.h               | 1 -
 drivers/infiniband/core/sa_query.c                | 1 -
 drivers/infiniband/hw/hfi1/affinity.c             | 1 -
 drivers/infiniband/hw/hfi1/debugfs.c              | 1 -
 drivers/infiniband/hw/hfi1/device.c               | 1 -
 drivers/infiniband/hw/hfi1/fault.c                | 1 -
 drivers/infiniband/hw/hfi1/firmware.c             | 1 -
 drivers/infiniband/hw/mlx4/alias_GUID.c           | 1 -
 drivers/infiniband/hw/mlx5/ib_virt.c              | 1 -
 drivers/infiniband/hw/mlx5/mem.c                  | 1 -
 drivers/infiniband/hw/mlx5/qp.c                   | 1 -
 drivers/infiniband/hw/mlx5/srq.c                  | 1 -
 drivers/infiniband/hw/mthca/mthca_profile.c       | 2 --
 drivers/infiniband/hw/qib/qib_fs.c                | 1 -
 drivers/infiniband/hw/usnic/usnic_debugfs.c       | 1 -
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c     | 1 -
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c      | 1 -
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c      | 1 -
 drivers/infiniband/hw/usnic/usnic_transport.c     | 1 -
 drivers/infiniband/hw/usnic/usnic_vnic.c          | 1 -
 drivers/infiniband/sw/rxe/rxe.h                   | 1 -
 drivers/infiniband/sw/rxe/rxe_mmap.c              | 1 -
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c      | 1 -
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c         | 1 -
 drivers/infiniband/ulp/iser/iser_memory.c         | 1 -
 drivers/infiniband/ulp/iser/iser_verbs.c          | 1 -
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c | 1 -
 31 files changed, 32 deletions(-)

-- 
2.34.1

