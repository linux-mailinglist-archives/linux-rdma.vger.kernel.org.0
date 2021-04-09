Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA893599A1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhDIJny (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Apr 2021 05:43:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16121 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhDIJnr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Apr 2021 05:43:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGtS01sKxz19Jvy;
        Fri,  9 Apr 2021 17:41:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:22 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] i40iw: Use DEFINE_SPINLOCK() for spinlock
Date:   Fri, 9 Apr 2021 17:51:47 +0800
Message-ID: <20210409095147.2294269-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 2ebcbb1ddaa2..b496f30ce066 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -78,7 +78,7 @@ static struct i40e_client i40iw_client;
 static char i40iw_client_name[I40E_CLIENT_STR_LENGTH] = "i40iw";
 
 static LIST_HEAD(i40iw_handlers);
-static spinlock_t i40iw_handler_lock;
+static DEFINE_SPINLOCK(i40iw_handler_lock);
 
 static enum i40iw_status_code i40iw_virtchnl_send(struct i40iw_sc_dev *dev,
 						  u32 vf_id, u8 *msg, u16 len);
@@ -2043,7 +2043,6 @@ static int __init i40iw_init_module(void)
 	i40iw_client.ops = &i40e_ops;
 	memcpy(i40iw_client.name, i40iw_client_name, I40E_CLIENT_STR_LENGTH);
 	i40iw_client.type = I40E_CLIENT_IWARP;
-	spin_lock_init(&i40iw_handler_lock);
 	ret = i40e_register_client(&i40iw_client);
 	i40iw_register_notifiers();
 

