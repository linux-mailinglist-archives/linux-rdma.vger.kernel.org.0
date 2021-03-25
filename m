Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F40349329
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCYNgq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 09:36:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14542 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCYNgf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 09:36:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5mKH2HC6zPlJ9;
        Thu, 25 Mar 2021 21:33:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 21:36:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/2] RDMA/hns: Support to select congestion control algorithm
Date:   Thu, 25 Mar 2021 21:33:54 +0800
Message-ID: <1616679236-7795-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The configuration of congestion control algorithm is recorded in the
firmware, the driver queries it and then sets it to the hardware.

Changes since v1:
- Use union to parse information got from firmware instead of force
  casting.
- https://patchwork.kernel.org/project/linux-rdma/cover/1615542507-40018-1-git-send-email-liweihang@huawei.com/

Wei Xu (1):
  RDMA/hns: Support query information of functions from FW

Yangyang Li (1):
  RDMA/hns: Support congestion control type selection according to the
    FW

 drivers/infiniband/hw/hns/hns_roce_device.h |  11 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 190 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  38 +++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |   2 +
 4 files changed, 237 insertions(+), 4 deletions(-)

-- 
2.8.1

