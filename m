Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E9482329
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhLaKNK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 05:13:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15994 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLaKNJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Dec 2021 05:13:09 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JQLV33x8fzZdvB;
        Fri, 31 Dec 2021 18:09:47 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 18:13:08 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 18:13:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/2] Bugfix or cleanup related to hns hardware version
Date:   Fri, 31 Dec 2021 18:13:39 +0800
Message-ID: <20211231101341.45759-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix potential memory leaks, and modify the hop num of HIP09's EQ.

Wenpeng Liang (2):
  RDMA/hns: Fix potential memory leak in free_dip_list
  RDMA/hns: Modify the hop num of HIP09 EQ to 1

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

--
2.33.0

