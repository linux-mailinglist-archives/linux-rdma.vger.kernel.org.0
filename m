Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F36394002
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhE1Jeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:34:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2078 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE1Jeq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:34:46 -0400
Received: from dggeml760-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Frzrf2lNmzWpH4;
        Fri, 28 May 2021 17:28:34 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml760-chm.china.huawei.com (10.1.199.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 0/4] libhns: Add support for direct WQE
Date:   Fri, 28 May 2021 17:32:55 +0800
Message-ID: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
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

Direct wqe is a mechanism to fill wqe directly into the hardware. In the
case of light load, the wqe will be filled into pcie bar space of the
hardware, this will reduce one memory access operation and therefore
reduce the latency. 

This series first refactor current uar mmap process to add branch for
direct wqe, then fix an issue on interface to write doorbell, the feature
is enabled at last.

The kernel parts is named "RDMA/hns: Add support for userspace Direct WQE".

Lang Cheng (1):
  libhns: Fixes data type when writing doorbell

Weihang Li (1):
  Update kernel headers

Xi Wang (1):
  libhns: Refactor hns uar mmap flow

Yixing Liu (1):
  libhns: Add support for direct wqe

 kernel-headers/rdma/hns-abi.h    |  6 +++
 providers/hns/hns_roce_u.c       | 76 ++++++++++++++++++++++++--------------
 providers/hns/hns_roce_u.h       | 19 +++++++++-
 providers/hns/hns_roce_u_db.h    | 13 ++-----
 providers/hns/hns_roce_u_hw_v1.c | 17 +++++----
 providers/hns/hns_roce_u_hw_v2.c | 80 ++++++++++++++++++++++++++++++++--------
 providers/hns/hns_roce_u_hw_v2.h | 29 ++++++++-------
 providers/hns/hns_roce_u_verbs.c | 39 ++++++++++++++++++++
 8 files changed, 204 insertions(+), 75 deletions(-)

-- 
2.7.4

