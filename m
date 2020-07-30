Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B5232DC2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgG3IOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbgG3IMl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C93A2070B;
        Thu, 30 Jul 2020 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096761;
        bh=cmEqU1bGUNPQcUFL7GEjx1L5i4iXsnrWVDSfgB4pOsc=;
        h=From:To:Cc:Subject:Date:From;
        b=Hty62YjefzOMEoCIPSpXhoFygO0SlCJRJ320vM8i79KeRtMdms5i+MKoBG6OyIKxr
         EiqaX2asONCp3crKFSSsdRtD7PNzc3WKNT9lrx7WlXmEBsP8Gdb1UX22Zy/UGFTIUN
         lzlAVoj8FAkDYiqqMq7YJAnXj8kCQEDLvT17x0Wc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/3] Cleanups to flow creation paths
Date:   Thu, 30 Jul 2020 11:12:32 +0300
Message-Id: <20200730081235.1581127-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Very straightforward cleanup.

Thanks

Leon Romanovsky (3):
  RDMA/mlx5: Simplify multiple else-if cases with switch keyword
  RDMA/mlx5: Replace open-coded offsetofend() macro
  RDMA: Remove constant domain argument from flow creation call

 drivers/infiniband/core/uverbs_cmd.c |   4 +-
 drivers/infiniband/hw/mlx4/main.c    |  31 ++----
 drivers/infiniband/hw/mlx5/ah.c      |   4 +-
 drivers/infiniband/hw/mlx5/fs.c      | 145 +++++++++++++++------------
 drivers/infiniband/hw/mlx5/mr.c      |   4 +-
 drivers/infiniband/hw/mlx5/qp.c      |  20 ++--
 include/rdma/ib_verbs.h              |  13 +--
 7 files changed, 108 insertions(+), 113 deletions(-)

--
2.26.2

