Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE384458944
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 07:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhKVGVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 01:21:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14968 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhKVGVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 01:21:46 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HyH8T1rBMzZd7T;
        Mon, 22 Nov 2021 14:16:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 14:18:38 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 14:18:38 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3 rdma-core 0/2] libhns: Add support for direct wqe
Date:   Mon, 22 Nov 2021 14:14:03 +0800
Message-ID: <20211122061405.39621-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Changes since v2:
* Only updated kernel-headers.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/20211116150316.21925-1-liangwenpeng@huawei.com/

Changes since v1:
* Changed the mapping scheme of direct wqe.
* Use SIMD instructions to load and store dwqe data, and encapsulate instructions into macros.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622194379-59868-1-git-send-email-liweihang@huawei.com/

Wenpeng Liang (1):
  Update kernel headers

Yixing Liu (1):
  libhns: Add support for direct wqe

 kernel-headers/rdma/hns-abi.h    |  2 ++
 providers/hns/hns_roce_u.h       |  5 +++-
 providers/hns/hns_roce_u_hw_v2.c | 44 +++++++++++++++++++++++++-------
 providers/hns/hns_roce_u_hw_v2.h | 31 ++++++++++++----------
 providers/hns/hns_roce_u_verbs.c | 26 +++++++++++++++++--
 util/mmio.h                      | 27 +++++++++++++++++++-
 6 files changed, 109 insertions(+), 26 deletions(-)

--
2.33.0

