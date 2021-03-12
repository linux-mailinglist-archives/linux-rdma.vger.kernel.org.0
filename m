Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9A33893B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhCLJvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 04:51:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhCLJux (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 04:50:53 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DxgxF49cNzMgYZ;
        Fri, 12 Mar 2021 17:48:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 17:50:46 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 0/2] RDMA/hns: Support to select congestion control algorithm
Date:   Fri, 12 Mar 2021 17:48:25 +0800
Message-ID: <1615542507-40018-1-git-send-email-liweihang@huawei.com>
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

Wei Xu (1):
  RDMA/hns: Support query information of functions from FW

Yangyang Li (1):
  RDMA/hns: Support congestion control type selection according to the
    FW

 drivers/infiniband/hw/hns/hns_roce_device.h |  11 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 192 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  34 ++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |   2 +
 4 files changed, 236 insertions(+), 3 deletions(-)

-- 
2.8.1

