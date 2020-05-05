Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBB1C5350
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 12:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEEKa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 06:30:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbgEEKa1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 May 2020 06:30:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8160AE93E29C83C7A54E;
        Tue,  5 May 2020 18:30:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 18:30:15 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Preparing for next generation of hip08
Date:   Tue, 5 May 2020 18:30:04 +0800
Message-ID: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Patch #1 add a macro HIP08_C for this new pci device, #2 and #3 adjust
codes about flags.

Lang Cheng (1):
  RDMA/hns: Combine enable flags of qp

Weihang Li (2):
  RDMA/hns: Add a macro for next generation of hip08
  RDMA/hns: Extend capability flags for HIP08_C

 drivers/infiniband/hw/hns/hns_roce_device.h | 12 +++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  5 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 22 +++++++++++-----------
 4 files changed, 23 insertions(+), 18 deletions(-)

-- 
2.8.1

