Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B958287673
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406116AbfHIJp2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730233AbfHIJp2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C30FCC30398AB0DA68AE;
        Fri,  9 Aug 2019 17:45:26 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:19 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/9] Bugfixes for 5.3-rc2
Date:   Fri, 9 Aug 2019 17:40:57 +0800
Message-ID: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here fixes some bugs for hip08

Lang Cheng (1):
  RDMA/hns: Remove unuseful member

Lijun Ou (2):
  RDMA/hns: Bugfix for creating qp attached to srq
  RDMA/hns: Copy some information of AV to user

Weihang Li (1):
  RDMA/hns: Logic optimization of wc_flags

Xi Wang (2):
  RDMA/hns: Bugfix for slab-out-of-bounds when unloading hip08 driver
  RDMA/hns: bugfix for slab-out-of-bounds when loading hip08 driver

Yangyang Li (3):
  RDMA/hns: Completely release qp resources when hw err
  RDMA/hns: Modify pi vlaue when cq overflows
  RDMA/hns: Kernel notify usr space to stop ring db

 drivers/infiniband/hw/hns/hns_roce_ah.c     | 22 ++++++--
 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  1 -
 drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++-
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 19 ++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 78 +++++++++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 29 +++++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 25 ++++++---
 include/uapi/rdma/hns-abi.h                 |  7 +++
 9 files changed, 148 insertions(+), 45 deletions(-)

-- 
1.9.1

