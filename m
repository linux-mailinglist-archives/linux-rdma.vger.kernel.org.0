Return-Path: <linux-rdma+bounces-3794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31B92D317
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A6EB233DD
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B71193066;
	Wed, 10 Jul 2024 13:42:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDD192B88;
	Wed, 10 Jul 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618949; cv=none; b=pouNG+5qEW0+58Hszr79KGR8fhV6Xjpb/QThIkDG6uzbEK+6I9HBsMwEhwBRXbO80UhGs8tC+QFezHW4dhjzjsb4mqT85o8R5bGlZfIaBe6gzUDQc7pfFK8ywxxihJ7kFBBckKjc+iFJGcsBXdrnuC+lQ2H4yvF9Nrsx9+/vIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618949; c=relaxed/simple;
	bh=IxBtV6nqUj65HpN3G6WZfLsFkOvYTXrL2fLPYWJmyDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnlhwQ1m2m1gi3nDjPvJVtXwez+6DhA3/OXgfztz1zmrGMvJd2biSTl9N9RZAeTmj0rTU0+IG4wGEfKWwaUyRCHqi5VjSQ0vMYVlEkCO/I2EsswPYBVvyZIE/AmZZhUYGypr9lCyLqs2b9CLv8KlslK7LfgFmrfE92Yes0UHV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJzSY53jYzxVww;
	Wed, 10 Jul 2024 21:37:49 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 083C5140257;
	Wed, 10 Jul 2024 21:42:25 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:24 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 6/8] RDMA/hns: Fix undifined behavior caused by invalid max_sge
Date: Wed, 10 Jul 2024 21:37:03 +0800
Message-ID: <20240710133705.896445-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
References: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

If max_sge has been set to 0, roundup_pow_of_two() in
set_srq_basic_param() may have undefined behavior.

Fixes: 9dd052474a26 ("RDMA/hns: Allocate one more recv SGE for HIP08")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index f1997abc97ca..c9b8233f4b05 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -297,7 +297,7 @@ static int set_srq_basic_param(struct hns_roce_srq *srq,
 
 	max_sge = proc_srq_sge(hr_dev, srq, !!udata);
 	if (attr->max_wr > hr_dev->caps.max_srq_wrs ||
-	    attr->max_sge > max_sge) {
+	    attr->max_sge > max_sge || !attr->max_sge) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "invalid SRQ attr, depth = %u, sge = %u.\n",
 			  attr->max_wr, attr->max_sge);
-- 
2.33.0


