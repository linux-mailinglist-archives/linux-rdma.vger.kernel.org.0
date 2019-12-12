Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC30411CA1D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 11:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfLLKCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 05:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfLLKCl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 05:02:41 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4F020663;
        Thu, 12 Dec 2019 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576144961;
        bh=qxFIEp/M+mqXLdgKcV99QpnCoQm3KrhuGrcWL95L/a4=;
        h=From:To:Cc:Subject:Date:From;
        b=q2FRfX7dqWijuqdoPLaUUYde0nfYfLYIPI7ZoWjNVPogrCCWOWovgnVldcf4vgRZV
         xve/qsnqwIMr5DskNljaH2h2UwCaaY5O5rkjvd4OtgPPcFrtQCevGO9q/dKL9uuTbF
         aBo8pZRjAOwCuuhx/nDGHNZ33MH2pgNSTBtg0x70=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 0/2] Prevent device memory VA reuse
Date:   Thu, 12 Dec 2019 12:02:35 +0200
Message-Id: <20191212100237.330654-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is important fix, which I would like to be merged to 5.5.

It used new API call (syntax sugar), which anyway is going to be
used in rdma-next VAR patches, so first patch is introduction
of that API, while second one is actual fix.

Thanks

Yishai Hadas (2):
  IB/core: Introduce rdma_user_mmap_entry_insert_range() API
  IB/mlx5: Fix device memory flows

 drivers/infiniband/core/ib_core_uverbs.c |  48 +++++++--
 drivers/infiniband/hw/mlx5/cmd.c         |  16 ++-
 drivers/infiniband/hw/mlx5/cmd.h         |   2 +-
 drivers/infiniband/hw/mlx5/main.c        | 120 +++++++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  19 +++-
 include/rdma/ib_verbs.h                  |   5 +
 6 files changed, 149 insertions(+), 61 deletions(-)

--
2.20.1

