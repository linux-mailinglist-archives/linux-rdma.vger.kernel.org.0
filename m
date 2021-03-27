Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7242C34B619
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhC0K2Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Mar 2021 06:28:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14170 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC0K2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Mar 2021 06:28:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6w394jt2znZbS;
        Sat, 27 Mar 2021 18:25:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 18:28:04 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Updates about doorbell
Date:   Sat, 27 Mar 2021 18:25:36 +0800
Message-ID: <1616840738-7866-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains few changes about doorbell of HIP08/09, the first
patch adds support for normal doorbell, the second one just reorganizes
code about doorbell.

Yixian Liu (2):
  RDMA/hns: Support configuring doorbell mode of RQ and CQ
  RDMA/hns: Reorganize doorbell update interfaces for all queues

 drivers/infiniband/hw/hns/hns_roce_cq.c     |   6 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  12 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  24 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 195 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  56 ++++----
 drivers/infiniband/hw/hns/hns_roce_main.c   |   6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  16 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   2 +-
 8 files changed, 166 insertions(+), 151 deletions(-)

-- 
2.8.1

