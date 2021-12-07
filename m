Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC146BBD5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhLGM5P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 07:57:15 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29158 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLGM5O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 07:57:14 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J7gCt2tFJzXdbN;
        Tue,  7 Dec 2021 20:51:38 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 20:53:43 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 20:53:42 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v6 for-next 0/1] RDMA/hns: Support direct WQE of userspace
Date:   Tue, 7 Dec 2021 20:49:00 +0800
Message-ID: <20211207124901.42123-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Direct wqe is a mechanism to fill wqe directly into the hardware. In the
case of light load, the wqe will be filled into pcie bar space of the
hardware, this will reduce one memory access operation and therefore reduce
the latency.

The user space parts is named "libhns: Add support for direct wqe".

Changes since v5:
* The direct wqe feature is enabled by default.
* Resolve the conflict with the patch of HNS_ROCE_MMAP_TYPE_DB.
  (https://patchwork.kernel.org/project/linux-rdma/patch/20211206133652.27476-1-liangwenpeng@huawei.com/)
* https://patchwork.kernel.org/project/linux-rdma/cover/20211130135740.4559-1-liangwenpeng@huawei.com/

Changes since v4:
* Add a comment to explain why direct WQE uses pgprot_device.
* https://patchwork.kernel.org/project/linux-rdma/cover/20211122033801.30807-1-liangwenpeng@huawei.com/

Changes since v3:
* Commit based on the latest code.
* Remove unused variable "ibdev" from alloc_qp_db.
* https://patchwork.kernel.org/project/linux-rdma/cover/20211116150400.23459-1-liangwenpeng@huawei.com/

Changes since v2:
* Direct wqe uses the new mmap scheme (https://patchwork.kernel.org/project/linux-rdma/patch/20211028105640.1056-1-liangwenpeng@huawei.com/).
* https://patchwork.kernel.org/project/linux-rdma/cover/1622705834-19353-1-git-send-email-liweihang@huawei.com/

Changes since v1:
* Remove 'inline' of two functions in #1.
* Enable direct wqe by default in #2.
* https://patchwork.kernel.org/project/linux-rdma/cover/1622193545-3281-1-git-send-email-liweihang@huawei.com/

Yixing Liu (1):
  RDMA/hns: Support direct wqe of userspace

 drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 36 +++++++++++---
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
 include/uapi/rdma/hns-abi.h                 |  2 +
 6 files changed, 94 insertions(+), 12 deletions(-)

--
2.33.0

