Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7044ADBC
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 13:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbhKIMsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 07:48:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:30930 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbhKIMsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 07:48:25 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HpSJ859dlzcZxQ;
        Tue,  9 Nov 2021 20:40:40 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:29 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:29 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 0/7] libhns: Cleanup about removing redundant code and cleaning up static alarms
Date:   Tue, 9 Nov 2021 20:40:56 +0800
Message-ID: <20211109124103.54326-1-liangwenpeng@huawei.com>
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

Patch #1~#3: Remove redundant code.
Patch #4~#5: Fix wrong type of printf format, variables and fields.
Patch #6~#7: Other miscellaneous cleanup.

Lang Cheng (1):
  libhns: Remove unused macros

Wenpeng Liang (1):
  libhns: Remove unsupported QP type

Xinhao Liu (4):
  libhns: Fix wrong print format for unsigned type
  libhns: Fix wrong type of variables and fields
  libhns: The content of the header file should be protected with
    #define
  libhns: The function declaration should be the same as the definition

Yixing Liu (1):
  libhns: Remove redundant variable initialization

 providers/hns/hns_roce_u.c       |  3 ---
 providers/hns/hns_roce_u.h       | 10 +++++-----
 providers/hns/hns_roce_u_db.h    |  6 +++---
 providers/hns/hns_roce_u_hw_v1.c |  7 +++----
 providers/hns/hns_roce_u_hw_v2.c | 16 +++++++---------
 providers/hns/hns_roce_u_verbs.c |  2 +-
 6 files changed, 19 insertions(+), 25 deletions(-)

--
2.33.0

