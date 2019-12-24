Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32A129F02
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 09:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfLXIdE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 03:33:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbfLXIdE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 03:33:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7B65355FED47BDE59E39;
        Tue, 24 Dec 2019 16:33:01 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 16:32:51 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/5] RDMA: use true,false for bool variable
Date:   Tue, 24 Dec 2019 16:40:07 +0800
Message-ID: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

zhengbin (5):
  RDMA/siw: use true,false for bool variable
  IB/hfi1: use true,false for bool variable
  IB/iser: use true,false for bool variable
  RDMA/mlx4: use true,false for bool variable
  RDMA/mlx5: use true,false for bool variable

 drivers/infiniband/hw/hfi1/rc.c           | 2 +-
 drivers/infiniband/hw/mlx4/qp.c           | 4 ++--
 drivers/infiniband/hw/mlx5/mr.c           | 4 ++--
 drivers/infiniband/hw/mlx5/qp.c           | 2 +-
 drivers/infiniband/sw/siw/siw_cm.c        | 2 +-
 drivers/infiniband/ulp/iser/iser_memory.c | 2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c  | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

--
2.7.4

