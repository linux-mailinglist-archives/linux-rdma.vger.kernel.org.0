Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41846FFD22
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfKRCi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 21:38:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfKRCi0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 21:38:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 725526BF89615D0A0118;
        Mon, 18 Nov 2019 10:38:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 10:38:13 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 0/4] RDMA/hns: Refactor codes of CQ
Date:   Mon, 18 Nov 2019 10:34:49 +0800
Message-ID: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series redefine/rename/remove some interfaces to improve readability
and maintainability of codes of CQ in hip08.

The 4th patch has conflict with "RDMA/hns: Add support for reporting wc
as software mode", will send a rebased one if any of them was applied.

Yixian Liu (4):
  RDMA/hns: Redefine interfaces used in creating cq
  RDMA/hns: Redefine the member of hns_roce_cq struct
  RDMA/hns: Rename the functions used inside creating cq
  RDMA/hns: Delete unnecessary callback functions for cq

 drivers/infiniband/hw/hns/hns_roce_cmd.h    |   4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 271 +++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  27 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  26 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  13 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |   4 +-
 6 files changed, 141 insertions(+), 204 deletions(-)

-- 
2.8.1

