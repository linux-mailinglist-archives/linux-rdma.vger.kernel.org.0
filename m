Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4E3F3A0F
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhHUJ55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:57:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14406 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhHUJ54 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:57:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GsDN84YDxzdcLf;
        Sat, 21 Aug 2021 17:53:28 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:57:15 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:57:15 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/3] Enable or remove hardware features
Date:   Sat, 21 Aug 2021 17:53:24 +0800
Message-ID: <1629539607-33217-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No bugs occur, just enable features or remove redundant flags.

Lang Cheng (2):
  RDMA/hns: Remove unsupport cmdq mode
  RDMA/hns: Ownerbit mode add control field

Yixing Liu (1):
  RDMA/hns: Enable stash feature of HIP09

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 +++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 20 +++++++-------------
 2 files changed, 18 insertions(+), 27 deletions(-)

--
2.8.1

