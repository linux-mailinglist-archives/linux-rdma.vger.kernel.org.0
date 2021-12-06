Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7846920E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 10:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbhLFJOb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 04:14:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40064 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhLFJOa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 04:14:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A872CB81059
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 09:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7034BC341C2;
        Mon,  6 Dec 2021 09:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638781860;
        bh=j72Y/jPa81C8OV+m2+QVMINd6K1kfK3bRhkSq0fYW6c=;
        h=From:To:Cc:Subject:Date:From;
        b=gb7ozNh5sFNpATzUDnq0i4aTqwwoAJLIkyKptp5M0F1ye6eVFvQmUKlKlVR94rqJI
         omIn5QAcUZ9o2haBaPjcUmkowZhxeSscKPqibvLDHAmB2O2mEPYjyLYa8lD77cu899
         4fCDg0TFIZGRFI7EniZGzWWk1tEy4lxyRvNsOudjLdaQVHP4ZC5bf/Fgoerjed9g5T
         OSlIAhvwhrgaK12ExalBylyQh2RvKYT7hefOAZ7+JfbaYT0MTr8F/9tH8Hh2X4W8ke
         nQKoec+ndvT9w6NmgmQw3BD+rEk7HnalQpOokZP7IP3OtxeGu9pUMKNMiTJqYbpmNi
         obXyHktOqySBA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 0/7] MR cache enhancement
Date:   Mon,  6 Dec 2021 11:10:45 +0200
Message-Id: <cover.1638781506.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series from Aharon refactors mlx5 MR cache management logic to
speedup deregistration significantly.

Thanks

Aharon Landau (7):
  RDMA/mlx5: Merge similar flows of allocating MR from the cache
  RDMA/mlx5: Replace cache list with Xarray
  RDMA/mlx5: Store in the cache mkeys instead of mrs
  RDMA/mlx5: Change the cache structure to an RB-tree
  RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()
  RDMA/mlx5: Delay the deregistration of a non-cache mkey
  RDMA/mlx5: Rename the mkey cache variables and functions

 drivers/infiniband/hw/mlx5/main.c    |   4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  78 +--
 drivers/infiniband/hw/mlx5/mr.c      | 930 +++++++++++++++++----------
 drivers/infiniband/hw/mlx5/odp.c     |  72 ++-
 include/linux/mlx5/driver.h          |   7 +-
 5 files changed, 673 insertions(+), 418 deletions(-)

-- 
2.33.1

