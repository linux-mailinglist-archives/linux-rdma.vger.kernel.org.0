Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9725C2E711E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Dec 2020 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgL2Nws (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Dec 2020 08:52:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9947 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgL2Nwr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Dec 2020 08:52:47 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D4wn71FGbzhylk;
        Tue, 29 Dec 2020 21:51:23 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:51:52 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bharat@chelsio.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] iw_cxgb4: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:52:32 +0800
Message-ID: <20201229135232.23869-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/infiniband/hw/cxgb4/restrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index b32e6516d65f..ff645b955a08 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -209,7 +209,7 @@ int c4iw_fill_res_cm_id_entry(struct sk_buff *msg,
 	epcp = (struct c4iw_ep_common *)iw_cm_id->provider_data;
 	if (!epcp)
 		return 0;
-	uep = kcalloc(1, sizeof(*uep), GFP_KERNEL);
+	uep = kzalloc(sizeof(*uep), GFP_KERNEL);
 	if (!uep)
 		return 0;
 
-- 
2.22.0

