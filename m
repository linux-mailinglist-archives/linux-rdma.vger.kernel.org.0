Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA313D310
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAPEOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:14:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbgAPEOm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 23:14:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 88557689B42A153BECEA;
        Thu, 16 Jan 2020 12:14:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 12:14:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <shiraz.saleem@intel.com>, <aditr@vmware.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH RFC for-next 0/6] ofed support to send ib port link event
Date:   Thu, 16 Jan 2020 12:10:41 +0800
Message-ID: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some provider's driver has supported to send port link event to ofed, but
this function is implemented separately by each manufacturer.

This series provides a solution in ib core, and remove the relevant codes
of some manufacturers, supports reporting port active time during device
registration and sending port error events when device is deregistered.

The key point is how to shield the port event of the backup port in the ib
bonding scenario. Since the active-backup control is judged by the vendor
driver, so the ops.query_port of vendor would determine the port role. And
there is no relevant data structure in ib_core, so modify struct
ib_port_cache to store this information.

Lang Cheng (6):
  RDMA/core: support deliver net device event
  RDMA/mlx5: remove deliver net device event
  RDMA/i40iw: remove deliver net device event
  RDMA/qedr: remove deliver net device event
  RDMA/vmw_pvrdma: remove deliver net device event
  qede: remove invalid notify operation

 drivers/infiniband/core/cache.c                |  21 ++++-
 drivers/infiniband/core/device.c               | 123 +++++++++++++++++++++++++
 drivers/infiniband/hw/i40iw/i40iw_main.c       |   6 --
 drivers/infiniband/hw/i40iw/i40iw_utils.c      |  44 ---------
 drivers/infiniband/hw/mlx5/main.c              |  95 ++-----------------
 drivers/infiniband/hw/qedr/main.c              |  19 ----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |   5 -
 drivers/net/ethernet/qlogic/qede/qede_rdma.c   |   4 -
 include/rdma/ib_cache.h                        |  13 +++
 include/rdma/ib_verbs.h                        |   8 ++
 10 files changed, 173 insertions(+), 165 deletions(-)

-- 
2.8.1

