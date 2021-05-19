Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92568388AEB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhESJp1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 05:45:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3027 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbhESJp1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 05:45:27 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlSXf3pKNzQppK;
        Wed, 19 May 2021 17:40:34 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:04 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:04 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] IB/hfi1: Remove the repeated declaration
Date:   Wed, 19 May 2021 17:43:35 +0800
Message-ID: <1621417415-3772-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Function 'init_credit_return' and 'sc_return_credits' are declared
twice, remove the repeated declaration.

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/infiniband/hw/hfi1/pio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.h b/drivers/infiniband/hw/hfi1/pio.h
index 0102262343c0..9e5f08d2b985 100644
--- a/drivers/infiniband/hw/hfi1/pio.h
+++ b/drivers/infiniband/hw/hfi1/pio.h
@@ -279,7 +279,6 @@ int init_credit_return(struct hfi1_devdata *dd);
 void free_credit_return(struct hfi1_devdata *dd);
 int init_sc_pools_and_sizes(struct hfi1_devdata *dd);
 int init_send_contexts(struct hfi1_devdata *dd);
-int init_credit_return(struct hfi1_devdata *dd);
 int init_pervl_scs(struct hfi1_devdata *dd);
 struct send_context *sc_alloc(struct hfi1_devdata *dd, int type,
 			      uint hdrqentsize, int numa);
@@ -294,7 +293,6 @@ void sc_stop(struct send_context *sc, int bit);
 struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
 				pio_release_cb cb, void *arg);
 void sc_release_update(struct send_context *sc);
-void sc_return_credits(struct send_context *sc);
 void sc_group_release_update(struct hfi1_devdata *dd, u32 hw_context);
 void sc_add_credit_return_intr(struct send_context *sc);
 void sc_del_credit_return_intr(struct send_context *sc);
-- 
2.7.4

