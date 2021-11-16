Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA3453544
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhKPPJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 10:09:55 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14754 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbhKPPJI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Nov 2021 10:09:08 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Htq834ZPkzZd5b;
        Tue, 16 Nov 2021 23:03:47 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:06:09 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 16 Nov 2021 23:06:09 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 0/1] RDMA/hns: Support direct WQE of userspace
Date:   Tue, 16 Nov 2021 23:03:59 +0800
Message-ID: <20211116150400.23459-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
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
 drivers/infiniband/hw/hns/hns_roce_main.c   | 38 +++++++++++---
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 55 ++++++++++++++++++++-
 include/uapi/rdma/hns-abi.h                 |  2 +
 5 files changed, 95 insertions(+), 11 deletions(-)

--
2.33.0

