Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D83433E5D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhJSS2q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 14:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJSS2o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 14:28:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7F8C6139D;
        Tue, 19 Oct 2021 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634667991;
        bh=cWmMkUsoxDnPbXZ8vZv9bC1ND0vbVJNVJ5q3JlCdkys=;
        h=From:To:Cc:Subject:Date:From;
        b=pkBT8eDHhpQgEtDW5OL+xZf/5VCsd0O6BWtxVRJ3tMs1EePcVwc0M20f5WG9RlqlN
         t44msgoJ5+efgULECikZqmj8tmeakR/epbCqWUikF9MoLftpeIkotfZWAlbgsTaxpG
         e0AUNzjCwqWpa1VlUd5PK3JEhWtlyPC97O4F3uEtjOYVk6BH5SbpDpux9IFdp+dRUW
         zz13nVekwWNUaa/xn78X3RWwOQ6HSQbfl8phbsL092bLu/YR969lkCqwWMViGE28q8
         kkxylGhodRceRtFALHNHCA3hCThijjmzi8QU+3luxGnMuVX+CZTEa+GUHbJG5lSyly
         fpeJwDHb6POzw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH rdma-next 0/3] rdma: prepare for const netdev->dev_addr
Date:   Tue, 19 Oct 2021 11:26:01 -0700
Message-Id: <20211019182604.1441387-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi!

These are RDMA changes needed to make netdev->dev_addr const.
These can go via rdma-next.

Jakub Kicinski (3):
  ipoib: use dev_addr_mod()
  mlx5: use dev_addr_mod()
  RDMA: constify netdev->dev_addr accesses

 drivers/infiniband/hw/bnxt_re/qplib_res.c       |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h       |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c        |  6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.h        |  5 +++--
 drivers/infiniband/hw/hfi1/ipoib_main.c         |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h     |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c      | 10 +++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c      |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_main.c       |  3 ++-
 drivers/infiniband/hw/irdma/cm.h                |  4 ++--
 drivers/infiniband/hw/irdma/hw.c                |  7 ++++---
 drivers/infiniband/hw/irdma/main.h              |  5 +++--
 drivers/infiniband/hw/irdma/trace_cm.h          |  8 +++++---
 drivers/infiniband/hw/irdma/utils.c             |  4 ++--
 drivers/infiniband/hw/irdma/verbs.c             |  2 +-
 drivers/infiniband/hw/usnic/usnic_fwd.c         |  2 +-
 drivers/infiniband/hw/usnic/usnic_fwd.h         |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c         |  4 +++-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c         |  9 ++++-----
 drivers/infiniband/ulp/ipoib/ipoib_main.c       | 17 +++++++++--------
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c   |  8 +++++---
 21 files changed, 61 insertions(+), 50 deletions(-)

-- 
2.31.1

