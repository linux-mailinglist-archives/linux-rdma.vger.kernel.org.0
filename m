Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFF45886D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 04:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhKVDpl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Nov 2021 22:45:41 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15846 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhKVDpl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Nov 2021 22:45:41 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HyCkn5sF6z919n;
        Mon, 22 Nov 2021 11:42:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 11:42:34 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 11:42:34 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v4 for-next 0/1] RDMA/hns: Support direct WQE of userspace
Date:   Mon, 22 Nov 2021 11:38:00 +0800
Message-ID: <20211122033801.30807-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 drivers/infiniband/hw/hns/hns_roce_main.c   | 38 ++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
 include/uapi/rdma/hns-abi.h                 |  2 +
 5 files changed, 94 insertions(+), 11 deletions(-)

--
2.33.0

