Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6499C2A3CC
	for <lists+linux-rdma@lfdr.de>; Sat, 25 May 2019 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEYJv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 May 2019 05:51:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbfEYJv3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 May 2019 05:51:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 571B4375C0B90C19CAA8;
        Sat, 25 May 2019 17:51:27 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 17:51:19 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/3] Add mix multihop addressing for supporting 32K
Date:   Sat, 25 May 2019 17:50:05 +0800
Message-ID: <1558777808-93864-1-git-send-email-oulijun@huawei.com>
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

This patch will depend on the patch("[PATCH for-next] RDMA/hns: Clear magic number")

Lijun Ou (3):
  RDMA/hns: Add mtr support for mixed multihop addressing
  RDMA/hns: add a group interfaces for optimizing buffers getting flow
  RDMA/hns: Fix bug when wqe num is larger than 16K

 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 131 ++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  59 ++++
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 467 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  14 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 118 ++++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 121 +++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 189 ++++++++---
 7 files changed, 1016 insertions(+), 83 deletions(-)

-- 
1.9.1

