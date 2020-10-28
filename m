Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5329D371
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 22:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgJ1VoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 17:44:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6659 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgJ1VoC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 17:44:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLnYy2zxDz15Lp6;
        Wed, 28 Oct 2020 20:14:30 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 28 Oct 2020
 20:14:24 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/siw: fix wrong judgment in siw_cm_work_handler
Date:   Wed, 28 Oct 2020 20:25:09 +0800
Message-ID: <20201028122509.47074-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rv cannot be 'EAGAIN' in the previous path, we
should use '-EAGAIN' to check it. For example:

Call trace:
->siw_cm_work_handler
	->siw_proc_mpareq
		->siw_recv_mpa_rr

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 66764f7ef072..1f9e15b71504 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1047,7 +1047,7 @@ static void siw_cm_work_handler(struct work_struct *w)
 					    cep->state);
 			}
 		}
-		if (rv && rv != EAGAIN)
+		if (rv && rv != -EAGAIN)
 			release_cep = 1;
 		break;
 
-- 
2.17.1

