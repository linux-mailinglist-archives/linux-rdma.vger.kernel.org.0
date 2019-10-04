Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97275CB850
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJDKcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 06:32:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729908AbfJDKcr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 06:32:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 441D47DD740AC8AA3348;
        Fri,  4 Oct 2019 18:32:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 18:32:36 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Add support of net device event reporting to ULP
Date:   Fri, 4 Oct 2019 18:29:12 +0800
Message-ID: <1570184954-21384-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When net link up/down, driver of hip08 will notify ULP.

Lang Cheng (2):
  {topost} RDMA/hns: Deliver net device event to ofed
  {topost} RDMA/hns: Add support for sending port down event quickly

 drivers/infiniband/hw/hns/hns_roce_device.h | 12 +++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 34 ++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 40 +++++++++++++++++++++--------
 3 files changed, 76 insertions(+), 10 deletions(-)

-- 
2.8.1

