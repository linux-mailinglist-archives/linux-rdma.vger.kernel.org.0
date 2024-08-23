Return-Path: <linux-rdma+bounces-4509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F05695CA28
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF42B21910
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0018734B;
	Fri, 23 Aug 2024 10:11:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89099187336;
	Fri, 23 Aug 2024 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407870; cv=none; b=rUTBwgRzZfp9jRqLeKIU1CBXwQAsZwJLoFLRMsdFPqFkmMuSjr1pLoSdNN8F9KRB+kxlDblliWdpnP8AkUIVBsib9g6as7Tlbh6RA604e5PVZQvowavLto7gkhBCyFThrM2MD4nZ0bYAxKUR+OuvUrsoh6F1X2OpH4H52eXAcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407870; c=relaxed/simple;
	bh=h/AazrWmZsd+04c2JA+GE80Us8GNjjPLIeJI6Rfcnic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roC78Pd6axYZ6OEJgmwDBK6iGF1gTGL5J1W2G4sKnyx3WtET2IS7Fjl2OeBTu+l7OzY4p35ToLuzR3a/cXXEkIQm48v6aRaVEx/nAsmvxKYia1nERlDxf+LZjx3MKElD9SXAM2hqGf2xpgfThA+wuDXTWEoWeS7wBxt0mYdBGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqwnF4dlgzyR94;
	Fri, 23 Aug 2024 18:10:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EC58140390;
	Fri, 23 Aug 2024 18:11:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 18:11:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bvanassche@acm.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/4] RDMA/qib: Simplify an alloc_ordered_workqueue() invocation
Date: Fri, 23 Aug 2024 18:18:37 +0800
Message-ID: <20240823101840.515398-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823101840.515398-1-ruanjinjie@huawei.com>
References: <20240823101840.515398-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Let alloc_ordered_workqueue() format the workqueue name instead of
calling snprintf() explicitly.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/infiniband/hw/qib/qib_init.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index db3b25c8433a..4100656fe9a3 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -581,12 +581,9 @@ static int qib_create_workqueues(struct qib_devdata *dd)
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
 		if (!ppd->qib_wq) {
-			char wq_name[23];
-
-			snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
-				dd->unit, pidx);
-			ppd->qib_wq = alloc_ordered_workqueue(wq_name,
-							      WQ_MEM_RECLAIM);
+			ppd->qib_wq = alloc_ordered_workqueue("qib%d_%d",
+							      WQ_MEM_RECLAIM,
+							      dd->unit, pidx);
 			if (!ppd->qib_wq)
 				goto wq_error;
 		}
-- 
2.34.1


