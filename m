Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18860265339
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIJVaM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgIJOCp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:02:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53784206BE;
        Thu, 10 Sep 2020 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746451;
        bh=NuAQLLVniMTiSvD3NX63hR8Ps+um5HbA+yYGRbERCBs=;
        h=From:To:Cc:Subject:Date:From;
        b=yEH2terUPqcySCZBBnx0Y3G3VIqdcs4YJwkjozcORo2pbdBF+K5w1y21JQDosuyP/
         QrQN4hg/IYGip/gdhoH/ctYL6c2c9p4nXXbZ94MEaczBUdlrXwsCHHN80KDpU8jeyN
         dH4Ubyx3F5KI623tIiGNT0mJ0TLEe3G3NxjZmASs=
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
Subject: [PATCH rdma-next 00/10] Prepare drivers to move QP allocation to ib_core
Date:   Thu, 10 Sep 2020 17:00:36 +0300
Message-Id: <20200910140046.1306341-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series mainly changes mlx4, mlx5, and mthca drivers to future
change of QP allocation scheme.

The rdmavt driver will be sent separately.

Thanks

Leon Romanovsky (10):
  RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
  RDMA/mlx5: Reuse existing fields in parent QP storage object
  RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
  RDMA/mlx5: Delete not needed GSI QP signature QP type
  RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
  RDMA/mlx4: Prepare QP allocation to remove from the driver
  RDMA/core: Align write and ioctl checks of QP types
  RDMA/drivers: Remove udata check from special QP
  RDMA/mthca: Combine special QP struct with mthca QP
  RDMA/i40iw: Remove intermediate pointer that points to the same struct

 drivers/infiniband/core/uverbs_cmd.c         |  17 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  57 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |   9 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.h    |   1 -
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |  25 +-
 drivers/infiniband/hw/mlx4/qp.c              | 285 ++++++++-----------
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
 16 files changed, 329 insertions(+), 419 deletions(-)

--
2.26.2

