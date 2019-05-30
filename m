Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8902FF9B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfE3Pta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 11:49:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3Pta (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 11:49:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 388B49174808962389C6;
        Thu, 30 May 2019 23:49:27 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 30 May 2019 23:49:16 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 for-next 0/3] Add mix multihop addressing for supporting 32K
Date:   Thu, 30 May 2019 23:47:53 +0800
Message-ID: <1559231276-67517-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series mainly adds a mix multihop addressing for support the 32K
specification of send wqe from UM.

It adds the MTR (memory translate region) design for unified management of
MTT (memory translate table). The MTT design requires that the hopnum of
the address space must be the same and cannot meet the requirements of the
current max hopnum of the hip08. The hopnum of sqwqe up to 3 level and
the extend sge up to 1 level. As a result, we add an MTR based on mtt to
solve this problem.

The MTR allows a contiguous address space to use different hopnums, so that
the driver supports the mixed hop feature in UM.

Change from V2:
1. Remove building error.

Change from V1:
1. Use new API named rdma_for_each_block instead of for_each_sg from Jason
Gunthorpe's reviews.

Lijun Ou (3):
  RDMA/hns: Add mtr support for mixed multihop addressing
  RDMA/hns: Add a group interfaces for optimizing buffers getting flow
  RDMA/hns: Fix bug when wqe num is larger than 16K

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  99 ++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  59 ++++
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 467 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  14 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 118 ++++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 121 +++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 189 ++++++++---
 7 files changed, 984 insertions(+), 83 deletions(-)

-- 
1.9.1

