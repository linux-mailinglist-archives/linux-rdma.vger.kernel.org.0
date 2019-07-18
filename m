Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA56CBC5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 11:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbfGRJVi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 05:21:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbfGRJVi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jul 2019 05:21:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B26A67D8B5E5106D9814;
        Thu, 18 Jul 2019 17:21:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 18 Jul 2019 17:21:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH] RDMA/siw: fix error return code in siw_init_module()
Date:   Thu, 18 Jul 2019 09:27:10 +0000
Message-ID: <20190718092710.85709-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index fd2552a9091d..9040692f83d7 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -614,6 +614,7 @@ static __init int siw_init_module(void)
 
 	if (!siw_create_tx_threads()) {
 		pr_info("siw: Could not start any TX thread\n");
+		rv = -ENOMEM;
 		goto out_error;
 	}
 	/*



