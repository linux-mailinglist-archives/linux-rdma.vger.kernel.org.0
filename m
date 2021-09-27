Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB944194B6
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhI0NBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 09:01:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:25945 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhI0NBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 09:01:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJ2gX0KGmzbmDF;
        Mon, 27 Sep 2021 20:55:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 21:00:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 21:00:06 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc 0/2] Bugfix or cleanup for CQE size
Date:   Mon, 27 Sep 2021 20:55:55 +0800
Message-ID: <20210927125557.15031-1-liangwenpeng@huawei.com>
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

Specify the size of CQE when copying CQE, and add the check of CQE size of
user space.

Wenpeng Liang (2):
  RDMA/hns: Fix the size setting error when copying CQE in clean_cq()
  RDMA/hns: Add the check of the CQE size of the user space

 drivers/infiniband/hw/hns/hns_roce_cq.c    | 31 +++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
 2 files changed, 23 insertions(+), 10 deletions(-)

--
2.33.0

