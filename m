Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2649133EC5A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 10:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCQJMX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 05:12:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13950 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhCQJMM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Mar 2021 05:12:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0ks73BvyzkbLQ;
        Wed, 17 Mar 2021 17:10:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:12:05 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 0/5] RDMA/hns: Refactor and reorganization
Date:   Wed, 17 Mar 2021 17:09:38 +0800
Message-ID: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactor the process of polling CQ and several control paths in the hns
driver.

Weihang Li (1):
  RDMA/hns: Refactor hns_roce_v2_poll_one()

Xi Wang (3):
  RDMA/hns: Refactor reset state checking flow
  RDMA/hns: Reorganize process of setting HEM
  RDMA/hns: Simplify command fields for HEM base address configuration

Yixing Liu (1):
  RDMA/hns: Reorganize hns_roce_create_cq()

 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  35 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  87 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  11 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 971 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 116 ++--
 6 files changed, 626 insertions(+), 596 deletions(-)

-- 
2.8.1

