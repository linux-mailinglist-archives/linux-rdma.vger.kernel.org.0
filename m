Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B2279853
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZKY4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKY4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:24:56 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A08238E2;
        Sat, 26 Sep 2020 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115896;
        bh=KYXM1fu+/JLJFhTLi6HBtGnx/721FDXBXemH/oBHzYU=;
        h=From:To:Cc:Subject:Date:From;
        b=aEFH4OTBYJ93BNMNW/tidwxcG7g3zg5EwESREUg3gXbdYWcBMicHkCTAyMsS8LlPN
         wpjtcER52xi3NiN0QdhEtwt+78qMuRYEip+k7KUR07y6DbvygYNFCWDXhqGwmIkYN3
         MOhKf712k8YaV42ZB6oFIg3eDPaqds7y8Nvxwqp8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 00/10] Prepare drivers to move QP allocation to ib_core
Date:   Sat, 26 Sep 2020 13:24:40 +0300
Message-Id: <20200926102450.2966017-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Rebased
 * Fixed commit messages.
 * Changed "fallthrough" to be "break".
v0: https://lore.kernel.org/lkml/20200910140046.1306341-1-leon@kernel.org
-------------------------------------------------------------------------

Hi,

This series mainly changes mlx4, mlx5, and mthca drivers to future
change of QP allocation scheme.

The rdmavt driver will be sent separately.

Thanks

Leon Romanovsky (10):
  RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
  RDMA/mlx5: Reuse existing fields in parent QP storage object
  RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
  RDMA/mlx5: Delete not needed GSI QP signal QP type
  RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
  RDMA/mlx4: Prepare QP allocation to remove from the driver
  RDMA/core: Align write and ioctl checks of QP types
  RDMA/drivers: Remove udata check from special QP
  RDMA/mthca: Combine special QP struct with mthca QP
  RDMA/i40iw: Remove intermediate pointer that points to the same struct

 drivers/infiniband/core/uverbs_cmd.c         |  17 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  57 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |   9 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |  25 +-
 drivers/infiniband/hw/mlx4/qp.c              | 299 ++++++++-----------
 drivers/infiniband/hw/mlx5/gsi.c             | 138 +++------
 drivers/infiniband/hw/mlx5/main.c            |   6 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  28 +-
 drivers/infiniband/hw/mlx5/qp.c              |  50 ++--
 drivers/infiniband/hw/mthca/mthca_dev.h      |   2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c |  17 +-
 drivers/infiniband/hw/mthca/mthca_provider.h |  27 +-
 drivers/infiniband/hw/mthca/mthca_qp.c       |  75 +++--
 drivers/infiniband/hw/qedr/verbs.c           |   8 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |   3 +-
 15 files changed, 336 insertions(+), 425 deletions(-)

--
2.26.2

