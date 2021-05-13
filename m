Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2999737F692
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhEMLRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 07:17:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2474 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhEMLRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 07:17:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fgptx5RkDzBvCG;
        Thu, 13 May 2021 19:13:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 19:16:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Cleanups on CMDQ
Date:   Thu, 13 May 2021 19:16:15 +0800
Message-ID: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series first rename the CMDQ pointers to make it better
understandable, then remove some dead code.

Lang Cheng (3):
  RDMA/hns: Rename CMDQ head/tail pointer to PI/CI
  RDMA/hns: Remove Receive Queue of CMDQ
  RDMA/hns: Remove unused CMDQ member

 drivers/infiniband/hw/hns/hns_roce_common.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 101 ++++++++--------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   1 -
 4 files changed, 30 insertions(+), 77 deletions(-)

-- 
2.7.4

