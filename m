Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4962C38A291
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhETJnQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 05:43:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4767 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhETJlP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 May 2021 05:41:15 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm4PL1ch6zqVFP;
        Thu, 20 May 2021 17:36:22 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 17:39:52 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 17:39:40 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <bharat@chelsio.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] RDMA/cxgb4: removing useless assignments
Date:   Thu, 20 May 2021 17:39:37 +0800
Message-ID: <1621503577-18093-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If go to the err label, abort will be assigned a value of 1, so there
is no need to assign a value of 1 here.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/infiniband/hw/cxgb4/qp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d109bb3..1b078d5 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1963,7 +1963,6 @@ int c4iw_modify_qp(struct c4iw_dev *rhp, struct c4iw_qp *qhp,
 			t4_set_wq_in_error(&qhp->wq, 0);
 			set_state(qhp, C4IW_QP_STATE_ERROR);
 			if (!internal) {
-				abort = 1;
 				disconnect = 1;
 				ep = qhp->ep;
 				c4iw_get_ep(&qhp->ep->com);
-- 
2.7.4

