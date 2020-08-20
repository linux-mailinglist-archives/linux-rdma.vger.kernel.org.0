Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98A624BE13
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHTNUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 09:20:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728712AbgHTNS6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Aug 2020 09:18:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86F8B9F811B29C1732A7;
        Thu, 20 Aug 2020 21:18:56 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 21:18:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/4] RDMA/hns: Extend some capabilities for HIP09
Date:   Thu, 20 Aug 2020 21:17:45 +0800
Message-ID: <1597929469-22674-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP09 supports larger entries/contexts to improve the performance of bus or
exchange more information with the hardware. The capbilities changes from
HIP08 to HIP09 is as follows:
- CEQE: 4B -> 64B
- AEQE: 16B -> 64B
- CQE: 32B -> 64B
- QPC: 256B -> 512B

Previous discussions can be found at:
v1: https://patchwork.kernel.org/cover/11718143/

Changes since v1:
- Fix comments from Lang Cheng about redundant comments and type of
  reserved fields in structure of eqe.
- Rename some variables.

Wenpeng Liang (3):
  RDMA/hns: Add support for EQE in size of 64 Bytes
  RDMA/hns: Add support for CQE in size of 64 Bytes
  RDMA/hns: Add support for QPC in size of 512 Bytes

Xi Wang (1):
  RDMA/hns: Export hardware capability flags to userspace

 drivers/infiniband/hw/hns/hns_roce_cq.c     | 19 ++++++-
 drivers/infiniband/hw/hns/hns_roce_device.h | 25 ++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 17 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 79 ++++++++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 18 ++++---
 drivers/infiniband/hw/hns/hns_roce_main.c   |  5 +-
 include/uapi/rdma/hns-abi.h                 |  4 ++
 8 files changed, 121 insertions(+), 50 deletions(-)

-- 
2.8.1

