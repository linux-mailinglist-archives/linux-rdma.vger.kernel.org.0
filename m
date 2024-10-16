Return-Path: <linux-rdma+bounces-5428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D778E9A05D1
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 11:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157D31C20D07
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC5206964;
	Wed, 16 Oct 2024 09:41:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9810205E35;
	Wed, 16 Oct 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071702; cv=none; b=TwmIBWTn+OD/LRbtoeTQnzSxKaQwA/euFnL1JPrhUm3aJdgHH979x/XagzbH/5u8Ej0hFoe2kMqTs0H0JdoGWDuVkUdiTUJ9SlPLOX8adpDzj8R7R4xoivqpOTGzHSfN58wwXPOSm6EGgCpJtkP6Ti943XwAgobpcdu3ahEFVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071702; c=relaxed/simple;
	bh=gqR0uJIVTlZsI3+1S0rqvu4BJdP6x2Da03BQmJFgk28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdQjvOH922gxOB91cn9SLq0Nr4jOgPFr5rcd8ojvZB4R814LSVSY1sWIYGRguAT2SplRQJSfgsP367j14t8EDP/U2mn+BcMWfKBv7YcuUp+s+U1B0b4krURIR+MZX2O2nnWXmXmjPxMdPcWvovr+nRGpa0g90LOgjfhW1E9JdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XT5YK69T8z1SCjK;
	Wed, 16 Oct 2024 17:40:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 95E61140361;
	Wed, 16 Oct 2024 17:41:36 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 17:41:36 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <larrystevenwise@gmail.com>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH iproute2-rc] rdma: Fix help information of 'rdma resource'
Date: Wed, 16 Oct 2024 17:35:26 +0800
Message-ID: <20241016093526.2106051-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

'rdma resource show cq' supports object 'dev' but not 'link', and
doesn't support device name with port.

Fixes: b0b8e32cbf6e ("rdma: Add CQ resource tracking information")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 rdma/res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rdma/res.c b/rdma/res.c
index c311513a..7e7de042 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -16,8 +16,8 @@ static int res_help(struct rd *rd)
 	pr_out("          resource show qp link [DEV/PORT] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show cm_id link [DEV/PORT]\n");
 	pr_out("          resource show cm_id link [DEV/PORT] [FILTER-NAME FILTER-VALUE]\n");
-	pr_out("          resource show cq link [DEV/PORT]\n");
-	pr_out("          resource show cq link [DEV/PORT] [FILTER-NAME FILTER-VALUE]\n");
+	pr_out("          resource show cq dev [DEV]\n");
+	pr_out("          resource show cq dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show pd dev [DEV]\n");
 	pr_out("          resource show pd dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show mr dev [DEV]\n");
-- 
2.33.0


