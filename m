Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396F7453533
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhKPPIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 10:08:50 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14752 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbhKPPI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Nov 2021 10:08:27 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Htq7B20hKzZd4Z;
        Tue, 16 Nov 2021 23:03:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:05:24 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 16 Nov 2021 23:05:24 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 0/2] libhns: Add support for direct wqe
Date:   Tue, 16 Nov 2021 23:03:14 +0800
Message-ID: <20211116150316.21925-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Direct wqe is a mechanism to fill wqe directly into the hardware. In the
case of light load, the wqe will be filled into pcie bar space of the
hardware, this will reduce one memory access operation and therefore reduce
the latency.

The kernel parts is named "RDMA/hns: Support direct WQE of userspace".

Changes since v1:
* Changed the mapping scheme of direct wqe.
* Use SIMD instructions to load and store dwqe data, and encapsulate instructions into macros.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622194379-59868-1-git-send-email-liweihang@huawei.com/

Wenpeng Liang (1):
  Update kernel headers

Yixing Liu (1):
  libhns: Add support for direct wqe

 kernel-headers/rdma/hns-abi.h       |  2 ++
 kernel-headers/rdma/rdma_netlink.h  |  5 ++++
 kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++--
 providers/hns/hns_roce_u.h          |  5 +++-
 providers/hns/hns_roce_u_hw_v2.c    | 44 +++++++++++++++++++++++------
 providers/hns/hns_roce_u_hw_v2.h    | 31 +++++++++++---------
 providers/hns/hns_roce_u_verbs.c    | 26 +++++++++++++++--
 util/mmio.h                         | 27 +++++++++++++++++-
 8 files changed, 125 insertions(+), 29 deletions(-)

--
2.33.0

