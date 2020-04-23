Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773561B5A36
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgDWLQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 07:16:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbgDWLQD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 07:16:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FE085674411E32F1BB8;
        Thu, 23 Apr 2020 19:16:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 19:15:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/5] RDMA/hns: Refactor process of buffer allocation and calculation
Date:   Thu, 23 Apr 2020 19:15:45 +0800
Message-ID: <1587640550-16777-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Patch #1 and #2 aim to use MTR interfaces for PBL buffer instead of MTT,
and after this, MTT can be removed completely. Patch #3 and #5 refactor
buffer size calculation process for WQE and SRQ. #4 can be considered as a
preparation for #5, which just moves code of SRQ together to a more
suitable place.

This series looks huge, but most of the modification is to replace and
remove old interfaces, and patch #4 also contribute a lot. Actually, the
original logic is not changed so much.

Xi Wang (4):
  RDMA/hns: Optimize PBL buffer allocation process
  RDMA/hns: Remove unused MTT functions
  RDMA/hns: Optimize WQE buffer size calculating process
  RDMA/hns: Optimize SRQ buffer size calculating process

Yixian Liu (1):
  RDMA/hns: Move SRQ code to the reasonable place

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   43 -
 drivers/infiniband/hw/hns/hns_roce_device.h |  119 +--
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  105 ---
 drivers/infiniband/hw/hns/hns_roce_hem.h    |    6 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   45 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  941 ++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_main.c   |   70 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 1250 +++------------------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  313 +++----
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   16 +-
 10 files changed, 777 insertions(+), 2131 deletions(-)

-- 
2.8.1

