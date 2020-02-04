Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21631516FE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgBDIYm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:24:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbgBDIYm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 03:24:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C4A22DA8F5A82DD651B;
        Tue,  4 Feb 2020 16:24:39 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.46.14.205) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 16:24:29 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH RFC v2 for-next 0/7] ib core support to send ib port link event
Date:   Tue, 4 Feb 2020 16:24:01 +0800
Message-ID: <20200204082408.18728-1-liweihang@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.46.14.205]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Some provider driver has realized this function, but these code are
implemented separately by each manufacturer. This series provides an
solution in ib_core, and remove the relevant codes of some manufacturers.

The key point is how to shield the port event of the backup port in the ib
bonding scenario. Since the active-backup control is judged by the vendor
driver, so the ops.query_port of vendor would determine the port role. And
there is no relevant data structure in ib_core, so modify struct
ib_port_cache to store this information.

Supports reporting port active time during device registration and sending
port error events when device is deregistered.

The previous discussion can be found at:
https://patchwork.kernel.org/cover/11335999/

Changes since v1:
- Fix comments from Leon and Jason.

- Move event processing flow into global notifier instead of one notifier
  per device.

Lang Cheng (7):
  RDMA/core: add inactive attribute of ib_port_cache
  RDMA/mlx5: remove deliver net device event
  qede: remove invalid notify operation
  RDMA/qedr: remove deliver net device event
  RDMA/vmw_pvrdma: remove deliver net device event
  RDMA/core: support send port event
  RDMA/core: report link status when register and deregister ib device

 drivers/infiniband/core/cache.c                | 16 ++++-
 drivers/infiniband/core/device.c               | 45 ++++++++++++
 drivers/infiniband/core/roce_gid_mgmt.c        | 45 ++++++++++++
 drivers/infiniband/hw/mlx5/main.c              | 95 +++-----------------------
 drivers/infiniband/hw/qedr/main.c              | 19 ------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  5 --
 drivers/net/ethernet/qlogic/qede/qede_rdma.c   |  4 --
 include/rdma/ib_cache.h                        | 10 +++
 include/rdma/ib_verbs.h                        |  2 +
 9 files changed, 126 insertions(+), 115 deletions(-)

-- 
2.8.1


