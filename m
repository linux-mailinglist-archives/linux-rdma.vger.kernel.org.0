Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0333E37B9EE
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELKHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 06:07:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2652 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhELKHD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 06:07:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg9Nb32HGzlcrq;
        Wed, 12 May 2021 18:03:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 18:05:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/2] RDMA/cm: Optimise rbtree searching
Date:   Wed, 12 May 2021 18:05:35 +0800
Message-ID: <20210512100537.6273-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v1 --> v2:
1. On the advice of Jason Gunthorpe, add patch 2
Rewrite the rbtree traversing in the normal pattern:
if (a < b)
    ..
else if (a > b)
    ..
else // a == b
    ..

Zhen Lei (2):
  RDMA/cm: Delete two redundant condition branches
  RDMA/cm: Optimise rbtree searching

 drivers/infiniband/core/cm.c | 54 +++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

-- 
2.26.0.106.g9fadedd


