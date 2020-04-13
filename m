Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC46C1A618B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgDMCfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Apr 2020 22:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgDMCfx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Apr 2020 22:35:53 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A7C0A3BE0;
        Sun, 12 Apr 2020 19:35:54 -0700 (PDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F5E2A423606824BB29A;
        Mon, 13 Apr 2020 10:35:51 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 10:35:41 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <dennis.dalessandro@intel.com>, <mike.marciniszyn@intel.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] IB/qib: remove unused variable ret
Date:   Mon, 13 Apr 2020 10:42:04 +0800
Message-ID: <1586745724-107477-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch fixes below warnings reported by coccicheck

drivers/infiniband/hw/qib/qib_iba7322.c:6878:8-11:
Unneeded variable: "ret". Return "0" on line 6907
drivers/infiniband/hw/qib/qib_iba7322.c:2378:5-8:
Unneeded variable: "ret". Return "0" on line 2513

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/infiniband/hw/qib/qib_iba7322.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 91d64dd..8bcbc88 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -2375,7 +2375,6 @@ static int qib_7322_bringup_serdes(struct qib_pportdata *ppd)
 	struct qib_devdata *dd = ppd->dd;
 	u64 val, guid, ibc;
 	unsigned long flags;
-	int ret = 0;
 
 	/*
 	 * SerDes model not in Pd, but still need to
@@ -2510,7 +2509,7 @@ static int qib_7322_bringup_serdes(struct qib_pportdata *ppd)
 		val | ERR_MASK_N(IBStatusChanged));
 
 	/* Always zero until we start messing with SerDes for real */
-	return ret;
+	return 0;
 }
 
 /**
@@ -6875,7 +6874,7 @@ static int init_sdma_7322_regs(struct qib_pportdata *ppd)
 	struct qib_devdata *dd = ppd->dd;
 	unsigned lastbuf, erstbuf;
 	u64 senddmabufmask[3] = { 0 };
-	int n, ret = 0;
+	int n;
 
 	qib_write_kreg_port(ppd, krp_senddmabase, ppd->sdma_descq_phys);
 	qib_sdma_7322_setlengen(ppd);
@@ -6904,7 +6903,7 @@ static int init_sdma_7322_regs(struct qib_pportdata *ppd)
 	qib_write_kreg_port(ppd, krp_senddmabufmask0, senddmabufmask[0]);
 	qib_write_kreg_port(ppd, krp_senddmabufmask1, senddmabufmask[1]);
 	qib_write_kreg_port(ppd, krp_senddmabufmask2, senddmabufmask[2]);
-	return ret;
+	return 0;
 }
 
 /* sdma_lock must be held */
-- 
2.6.2

