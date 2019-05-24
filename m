Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08754291CA
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbfEXHco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389029AbfEXHco (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 70F14C8873111E1BB077;
        Fri, 24 May 2019 15:32:41 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 15:32:31 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 0/4] Fixes for hns
Date:   Fri, 24 May 2019 15:31:19 +0800
Message-ID: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
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

