Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CD3AADA5
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFQHea (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 03:34:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11049 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQHea (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Jun 2021 03:34:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5DFx1xkfzZfhw;
        Thu, 17 Jun 2021 15:29:25 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 15:32:21 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 15:32:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v3 for-next 0/8] RDMA/hns: Use new interfaces to write/read fields
Date:   Thu, 17 Jun 2021 15:31:43 +0800
Message-ID: <1623915111-43630-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hr_reg_*() is simpler than roce_set_*(), and the field/bit can be generated
automatically and accurately.

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
  RDMA/hns: Use temporary variables to fix warning about hr_reg_write()
  RDMA/hns: Use new interface to modify QP context
  RDMA/hns: Use new interface to get CQE fields

Weihang Li (1):
  RDMA/hns: Add a check to ensure integer mtu is positive

Xi Wang (1):
  RDMA/hns: Clean SRQC structure definition

Yixing Liu (3):
  RDMA/hns: Use new interface to write CQ context.
  RDMA/hns: Use new interface to write FRMR fields
  RDMA/hns: Use new interface to write DB related fields

 drivers/infiniband/hw/hns/hns_roce_common.h |    3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 1078 +++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  862 +++++++--------------
 3 files changed, 651 insertions(+), 1292 deletions(-)

-- 
2.7.4

