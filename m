Return-Path: <linux-rdma+bounces-13886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE2BE31F1
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4A619C3F8E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3C31AF01;
	Thu, 16 Oct 2025 11:40:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200C31A815
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614858; cv=none; b=SfvjYMN1BkDSquWXtMf2Bhd/B4XfHC4UvocO7CN/bOkZfzoekTIqHs2HAvx5O2sibxIkAj/iZkjyy3yd+Zut/GxuraFvb/G3FP8aStyuslqITD0QyP0Tp20q9kfApPRj1VuIcAgsNdIlBa8EeYgvmSZq2t42wiZTizMhJWd6AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614858; c=relaxed/simple;
	bh=1p0SsG8xCPpBqiPyK//3kHOwx0DXWCi7ubAnsd7XQgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3kylhAhaThXfqA9otIH5ZLJJqxvosDXnvA9h7VbCZ6X/S3bs1d5tveI5OxIaHnnDUyKV4FVbf8zWmWreLlnvZxKnH97eQc3HqI2bAIW9s5rnMrhpVzczN7Fvz9nGaa7bCOI7d7l5qCh1sGLqetSkx6HgOAvaEHXHuIYYeKXfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cnQx33FQ9z1T4GB;
	Thu, 16 Oct 2025 19:40:07 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 77B2E140156;
	Thu, 16 Oct 2025 19:40:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 19:40:53 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 2/4] RDMA/hns: Fix the modification of max_send_sge
Date: Thu, 16 Oct 2025 19:40:49 +0800
Message-ID: <20251016114051.1963197-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
References: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

The actual sge number may exceed the value specified in init_attr->cap
when HW needs extra sge to enable inline feature. Since these extra
sges are not expected by ULP, return the user-specified value to ULP
instead of the expanded sge number.

Fixes: 0c5e259b06a8 ("RDMA/hns: Fix incorrect sge nums calculation")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6ff1b8ce580c..bdd879ac12dd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -662,7 +662,6 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 	hr_qp->sq.wqe_cnt = cnt;
-	cap->max_send_sge = hr_qp->sq.max_gs;
 
 	return 0;
 }
@@ -744,7 +743,6 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 
 	/* sync the parameters of kernel QP to user's configuration */
 	cap->max_send_wr = cnt;
-	cap->max_send_sge = hr_qp->sq.max_gs;
 
 	return 0;
 }
-- 
2.33.0


