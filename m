Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7330900
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfEaGym (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 02:54:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfEaGyl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 May 2019 02:54:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E7A57FFFEEB3F8B3A6C;
        Fri, 31 May 2019 14:54:39 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 14:54:33 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V4 for-next 0/3] Add mix multihop addressing for supporting 32K
Date:   Fri, 31 May 2019 14:57:44 +0800
Message-ID: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
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

Change from V3:
1. Remove the simple wrapper around kernel functions from Leon Romanovsky's
reviews.

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
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 460 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  14 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 118 ++++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 121 ++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 189 +++++++++---
 7 files changed, 977 insertions(+), 83 deletions(-)

-- 
1.9.1

