Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCE13121C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFMZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 07:25:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbgAFMZH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 07:25:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8BD17F300172EA8AECC4;
        Mon,  6 Jan 2020 20:25:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 20:24:58 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/7] RDMA/hns: Various cleanups
Date:   Mon, 6 Jan 2020 20:21:09 +0800
Message-ID: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No logic of code was changed by these patches, all of them are tiny
cleanups.

By the way, this series has nothing to do with the series I sent a PR to
rdma-core recently.

Lijun Ou (4):
  RDMA/hns: Remove unused function hns_roce_init_eq_table()
  RDMA/hns: Update the value of qp type
  RDMA/hns: Delete unnessary parameters in hns_roce_v2_qp_modify()
  RDMA/hns: Fix coding style issues

Wenpeng Liang (2):
  RDMA/hns: Avoid printing address of mtt page
  RDMA/hns: Replace custom macros HNS_ROCE_ALIGN_UP

Yixing Liu (1):
  RDMA/hns: Remove redundant print information

 drivers/infiniband/hw/hns/hns_roce_device.h |  15 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 172 ++++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  56 +++++----
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  44 ++++---
 5 files changed, 116 insertions(+), 175 deletions(-)

-- 
2.8.1

