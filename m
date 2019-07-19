Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B4D6D856
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2019 03:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGSBYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 21:24:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfGSBYL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jul 2019 21:24:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0AB1B904D98FE21B46D7;
        Fri, 19 Jul 2019 09:24:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 19 Jul 2019 09:24:01 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] infiniband: siw: remove set but not used variables 'rv'
Date:   Fri, 19 Jul 2019 09:29:38 +0800
Message-ID: <20190719012938.100628-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/sw/siw/siw_cm.c: In function siw_cep_set_inuse:
drivers/infiniband/sw/siw/siw_cm.c:223:6: warning: variable rv set but not used [-Wunused-but-set-variable]

It is not used since commit 6c52fdc244b5("rdma/siw: connection management")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a7cde98..9ce8a1b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -220,13 +220,12 @@ static void siw_put_work(struct siw_cm_work *work)
 static void siw_cep_set_inuse(struct siw_cep *cep)
 {
 	unsigned long flags;
-	int rv;
 retry:
 	spin_lock_irqsave(&cep->lock, flags);
 
 	if (cep->in_use) {
 		spin_unlock_irqrestore(&cep->lock, flags);
-		rv = wait_event_interruptible(cep->waitq, !cep->in_use);
+		wait_event_interruptible(cep->waitq, !cep->in_use);
 		if (signal_pending(current))
 			flush_signals(current);
 		goto retry;
-- 
2.7.4

