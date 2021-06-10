Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73D3A2AB8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFJLwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3942 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJLwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G12Jz60Zbz6xDX;
        Thu, 10 Jun 2021 19:47:31 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:36 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Use ida to manage index of some resources
Date:   Thu, 10 Jun 2021 19:50:08 +0800
Message-ID: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Index of some resources is managed by bitmap in driver, we first do some
cleanups on the bitmap functions, than replace them with ida interfaces.

Yangyang Li (6):
  RDMA/hns: Remove the unused hns_roce_bitmap_alloc_range function
  RDMA/hns: Remove the unused hns_roce_bitmap_free_range function
  RDMA/hns: Remove unused RR mechanism
  RDMA/hns: Use IDA interface to manage mtpt index
  RDMA/hns: Use IDA interface to manage pd index
  RDMA/hns: Use IDA interface to manage xrcd index

 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 63 ++-----------------
 drivers/infiniband/hw/hns/hns_roce_device.h | 32 ++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 32 +++-------
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 66 ++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 94 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  4 +-
 7 files changed, 100 insertions(+), 194 deletions(-)

-- 
2.7.4

