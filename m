Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA4852236D
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2019 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfERL4H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 May 2019 07:56:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbfERL4H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 May 2019 07:56:07 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E069AD761C77399F5629;
        Sat, 18 May 2019 19:56:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 18 May 2019 19:55:58 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/4] Fixes for hns
Date:   Sat, 18 May 2019 19:54:56 +0800
Message-ID: <1558180500-93157-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are two fixes patches for hip08 and hip06 as well as
two updates for hip08. 

Lang Cheng (2):
  RDMA/hns: Move spin_lock_irqsave to the correct place
  RDMA/hns: Remove jiffies operation in disable interrupt context

Lijun Ou (1):
  RDMA/hns: Update CQE specifications

Yixian Liu (1):
  RDMA/hns: Remove unnecessary prompt message in aeq

 drivers/infiniband/hw/hns/hns_roce_hem.c   | 21 +++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 24 +++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c  | 10 ----------
 5 files changed, 27 insertions(+), 31 deletions(-)

-- 
1.9.1

