Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB9246699
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgHQMqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 08:46:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbgHQMqx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Aug 2020 08:46:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 35FABC16A6F979696DAA;
        Mon, 17 Aug 2020 20:46:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 20:46:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/4] RDMA/hns: Extend some capabilities for HIP09
Date:   Mon, 17 Aug 2020 20:45:40 +0800
Message-ID: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
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

Wenpeng Liang (3):
  RDMA/hns: Add support for EQE in size of 64 Bytes
  RDMA/hns: Add support for CQE in size of 64 Bytes
  RDMA/hns: Add support for QPC in size of 512 Bytes

Xi Wang (1):
  RDMA/hns: Export hardware capability flags to userspace

 drivers/infiniband/hw/hns/hns_roce_cq.c     | 19 ++++++-
 drivers/infiniband/hw/hns/hns_roce_device.h | 22 ++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 12 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 79 ++++++++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 16 ++++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  5 +-
 include/uapi/rdma/hns-abi.h                 |  4 ++
 8 files changed, 116 insertions(+), 43 deletions(-)

-- 
2.8.1

