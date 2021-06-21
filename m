Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07933AE474
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUIDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:03:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7495 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhFUID3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 04:03:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G7hjK5PM9zZksW;
        Mon, 21 Jun 2021 15:58:13 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:13 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v5 for-next 0/9] RDMA/hns: Use new interfaces to write/read fields
Date:   Mon, 21 Jun 2021 16:00:34 +0800
Message-ID: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
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

hr_reg_*() is simpler than roce_set_*(), and the field/bit can be generated
automatically and accurately. This series first fixes two issues on
hr_reg_*(), then introduces hr_reg_write_bool() for 1 bit-width field, does
the replacement at last.

Changes since v4:
* Change the way to fix the sparse warning, we introduce
  hr_reg_write_bool() for 1 bit-width field.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1624010765-1029-1-git-send-email-liweihang@huawei.com/

Changes since v3:
* Use "val ? 1 : 0" instead of "!!val" for hr_reg_write to avoid sparse
  warnings.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1623915111-43630-1-git-send-email-liweihang@huawei.com/

Changes since v2:
* Add a patch to solve the gcc warnings about PREP_FIELD() by adding a
  check for mtu. Therefore only the parts which fix the sparse warning is
  reserved in #1.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622624265-44796-1-git-send-email-liweihang@huawei.com/

Changes since v1:
* Add a patch to fix gcc warnings about PREP_FIELD().
* Fix a typo in #5.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622281154-49867-1-git-send-email-liweihang@huawei.com/

Lang Cheng (3):
  RDMA/hns: Add hr_reg_write_bool()
  RDMA/hns: Use new interface to modify QP context
  RDMA/hns: Use new interface to get CQE fields

Weihang Li (2):
  RDMA/hns: Fix sparse warnings when calling hr_reg_write()
  RDMA/hns: Add a check to ensure integer mtu is positive

Xi Wang (1):
  RDMA/hns: Clean SRQC structure definition

Yixing Liu (3):
  RDMA/hns: Use new interface to write CQ context.
  RDMA/hns: Use new interface to write FRMR fields
  RDMA/hns: Use new interface to write DB related fields

 drivers/infiniband/hw/hns/hns_roce_common.h |    8 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 1124 ++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  862 +++++++-------------
 3 files changed, 679 insertions(+), 1315 deletions(-)

-- 
2.7.4

