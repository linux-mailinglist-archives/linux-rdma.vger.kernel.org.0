Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA912379F4C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEKFtm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 01:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKFtl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 01:49:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D193615FF;
        Tue, 11 May 2021 05:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620712116;
        bh=PofQ2ARqc/7rSeSZyylNzT921llhB/4mlsoa+viT4Wg=;
        h=From:To:Cc:Subject:Date:From;
        b=XCEmctcGByFZ57SBvMouq9A5uckSD47Ci1rnAurAFD1nukNjlshlNckOXK1Q/K4ih
         4bZGaw70ueentuH32P1BVnt4ELyjidQr2Q913hF0sFYRjE2J8+7nSGb6UPNMs0jgZ/
         dxMOz4Ivp7mGr9D2IoBg+QhjU3PtJ2kJF+fvXABfjIraw9RMi+GU3xN+yRXl9ai8BN
         c1ZfhyxSlxIwiIBuAzjnrLoKCltQTEpo3tpTD1UUiWB3J9x/tFU4LVtyJpGsYhL0OY
         mxohNDd76RNzpXi9FVtzow/yY9KSvtPFzY8xOm6EUqVU+RXCETti08XaFRo8RhciyJ
         CnFYOcEcW1lrA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-rc 0/5] RDMA fixes
Date:   Tue, 11 May 2021 08:48:26 +0300
Message-Id: <cover.1620711734.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Batch of completely unrelated fixes.

Thanks

Leon Romanovsky (2):
  RDMA/core: Simplify addition of restrack object
  RDMA/rxe: Return CQE error if invalid lkey was supplied

Maor Gottlieb (2):
  RDMA/mlx5: Verify that DM operation is reasonable
  RDMA/mlx5: Recover from fatal event in dual port mode

Shay Drory (1):
  RDMA/core: Don't access cm_id after its destruction

 drivers/infiniband/core/cma.c        | 18 +++++++-----------
 drivers/infiniband/hw/mlx5/dm.c      |  3 +++
 drivers/infiniband/hw/mlx5/main.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 ++++++++++------
 4 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.31.1

