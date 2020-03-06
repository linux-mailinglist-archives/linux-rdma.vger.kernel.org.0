Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B917B4A2
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2020 03:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFCsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 21:48:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgCFCsm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 21:48:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 315CFB8778C2DE59DCC8;
        Fri,  6 Mar 2020 10:48:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 10:48:31 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/5] RDMA/hns: Refactor wqe related codes
Date:   Fri, 6 Mar 2020 10:44:49 +0800
Message-ID: <1583462694-43908-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Process of wqe is hard to understand and maintain in hns, this series
refactor wqe related code, especially in hns_roce_v2_post_send().

Previous discussion could be found at:
https://patchwork.kernel.org/cover/11415395/

Changes since v1:
- Fix comments from Leon about the inplementation of to_hr_opcode() in
  patch 3/5.
- Patch 4/5 couldn't be applied. Just do a rebase.

Xi Wang (5):
  RDMA/hns: Rename wqe buffer related functions
  RDMA/hns: Optimize wqe buffer filling process for post send
  RDMA/hns: Optimize the wr opcode conversion from ib to hns
  RDMA/hns: Optimize base address table config flow for qp buffer
  RDMA/hns: Optimize wqe buffer set flow for post send

 drivers/infiniband/hw/hns/hns_roce_device.h |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  16 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 588 ++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  48 +--
 5 files changed, 319 insertions(+), 352 deletions(-)

-- 
2.8.1

