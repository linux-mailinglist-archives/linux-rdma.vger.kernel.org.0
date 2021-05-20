Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF95389C29
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 05:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhETD4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 23:56:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4551 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhETD4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 23:56:04 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Flwlv6Q7VzkYC9;
        Thu, 20 May 2021 11:51:55 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:54:42 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 11:54:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 0/3] RDMA/hns: Cleanups on CMDQ
Date:   Thu, 20 May 2021 11:54:33 +0800
Message-ID: <1621482876-35780-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series first rename the CMDQ pointers to make it better
understandable, then remove some dead code.

Changes since v1:
* Remove the print in hns_roce_alloc_cmq_desc() in #2 because the caller
  already has a print.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620904578-29829-1-git-send-email-liweihang@huawei.com/

Lang Cheng (3):
  RDMA/hns: Rename CMDQ head/tail pointer to PI/CI
  RDMA/hns: Remove Receive Queue of CMDQ
  RDMA/hns: Remove unused CMDQ member

 drivers/infiniband/hw/hns/hns_roce_common.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 103 ++++++++--------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   1 -
 4 files changed, 30 insertions(+), 79 deletions(-)

-- 
2.7.4

