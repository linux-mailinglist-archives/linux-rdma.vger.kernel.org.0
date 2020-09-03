Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA125C234
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgICOIt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:08:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729058AbgICOIl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:08:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE845A976337A76FBF4B;
        Thu,  3 Sep 2020 21:17:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 21:17:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 0/4] RDMA/hns: Extend some capabilities for HIP09
Date:   Thu, 3 Sep 2020 21:16:03 +0800
Message-ID: <1599138967-17621-1-git-send-email-liweihang@huawei.com>
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
- SCCC: 32B -> 64B

Previous discussions can be found at:
v2: https://patchwork.kernel.org/cover/11726269/
v1: https://patchwork.kernel.org/cover/11718143/

Changes since v2:
- Fix comments from Jason about passing cap_flags to the userspace and drop
  #1 from this series.
- Add a new patch to support SCCC in size of 64 Bytes.

Changes since v1:
- Fix comments from Lang Cheng about redundant comments and type of
  reserved fields in structure of eqe.
- Rename some variables.

Wenpeng Liang (3):
  RDMA/hns: Add support for EQE in size of 64 Bytes
  RDMA/hns: Add support for CQE in size of 64 Bytes
  RDMA/hns: Add support for QPC in size of 512 Bytes

Yangyang Li (1):
  RDMA/hns: Add support for SCCC in size of 64 Bytes

 drivers/infiniband/hw/hns/hns_roce_cq.c     |  19 +++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  27 +++--
 drivers/infiniband/hw/hns/hns_roce_hem.c    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  17 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 147 ++++++++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  38 +++++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  10 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   2 +-
 include/uapi/rdma/hns-abi.h                 |   4 +-
 10 files changed, 205 insertions(+), 65 deletions(-)

-- 
2.8.1

