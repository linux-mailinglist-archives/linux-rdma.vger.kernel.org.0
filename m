Return-Path: <linux-rdma+bounces-943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4B84C325
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 04:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BB31F288DD
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251A12B75;
	Wed,  7 Feb 2024 03:33:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C7101EE;
	Wed,  7 Feb 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276803; cv=none; b=TFFLh8Lp8nuBysk5/pZsIyx2nzRKdBsTqiVE2IFjncikSKiSp8LK+pxVTzGlcaITOtfE3j8qKfTfrNRxz6ZM6N84c+up2isHrMmEe9ChohIv+MwuaOMTD5fcSR40my1QmpDXFIvXyjM8GXe2Vj7A/4TEVoTIwyRLbfkCqFdAEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276803; c=relaxed/simple;
	bh=a8R6LGuNYwr/WkPzoupwUh+q6405b6cHBfwnhZrktio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guTr1/JQouJS/4YTaiUg0TLSkBhDOCK4zANHBimpKAlmJSgYyU1XUXijTIoTaqdmvg+9S3OtsWCVTk2ZDaztI4lIO9J+TEGiP79ipQtTihjfBfCxp9S6SLJ0Ym8+fkIbBUMq7/o2LJqCt9rvyl/dsKUZIl5w2jyLVNtS8csi/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TV5KY3Tztz1vt9V;
	Wed,  7 Feb 2024 11:32:49 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 76F7118001A;
	Wed,  7 Feb 2024 11:33:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 11:33:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 1/2] Revert "RDMA/hns: The UD mode can only be configured with DCQCN"
Date: Wed, 7 Feb 2024 11:29:09 +0800
Message-ID: <20240207032910.3959426-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
References: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Luoyouming <luoyouming@huawei.com>

This reverts commit 27c5fd271d8b8730fc0bb1b6cae953ad7808a874.

Commit 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured
with DCQCN") adds a check of congest control alorithm for UD. But
that patch causes a problem: hr_dev->caps.congest_type is global,
used by all QPs, so modifying this field to DCQCN for UD QPs causes
other QPs unable to use any other algorithm except DCQCN.

Revert that patch. The UD algorithm issue will be fixed in a
subsequent patch of this series.

Fixes: 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured with DCQCN")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index de56dc6e3226..8907c30598ab 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4739,9 +4739,6 @@ static int check_cong_type(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 
-	if (ibqp->qp_type == IB_QPT_UD)
-		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
-
 	/* different congestion types match different configurations */
 	switch (hr_dev->caps.cong_type) {
 	case CONG_TYPE_DCQCN:
-- 
2.30.0


