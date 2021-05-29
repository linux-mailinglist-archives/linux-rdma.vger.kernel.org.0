Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506A7394B61
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE2JlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 May 2021 05:41:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2532 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE2JlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 May 2021 05:41:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fsbzd1qmNzYr7s;
        Sat, 29 May 2021 17:36:45 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:39:26 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 17:39:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Use new interfaces to write/read fields
Date:   Sat, 29 May 2021 17:39:08 +0800
Message-ID: <1622281154-49867-1-git-send-email-liweihang@huawei.com>
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

hr_reg_*() is simpler than roce_set_*(), and the field/bit can be generated
automatically and accurately.

Lang Cheng (2):
  RDMA/hns: Use new interface to modify QP context
  RDMA/hns: Use new interface to get CQE fields

Xi Wang (1):
  RDMA/hns: Clean SRQC structure definition

Yixing Liu (3):
  RDMA/hns: Use new interface to write CQ context.
  RDMA/hns: Use new interface to write FRMR fields
  RDMA/hns: Use new interface to write DB related fields

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1065 ++++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  862 ++++++++--------------
 2 files changed, 640 insertions(+), 1287 deletions(-)

-- 
2.7.4

