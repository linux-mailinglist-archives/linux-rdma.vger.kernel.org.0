Return-Path: <linux-rdma+bounces-9079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC9A77BC4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE653A6FC9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C852036E5;
	Tue,  1 Apr 2025 13:10:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA51C2C6;
	Tue,  1 Apr 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513028; cv=none; b=JmOBBnkQfI9jFSMVaPVWfduLk0K/LueMPyZYZnf1joxvBuNLzKyK7G0pKQUBT4E1wy16NW7IeIM371uXPp9MbrAgrBqmXRHONMcByqqTLqPQ5iJMrzkqZ7sroHcCac5ucEbiKgM3eInRKgDE+3GhaKvAjfLx1lKaxnh6ul4yMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513028; c=relaxed/simple;
	bh=bZuhi5tp57vT1KrIZMO2TFV5Dty6u7hau5PtT9IEqvc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=AFWQfbI3JX2X5Y4Al3B7t+BIYXfQeZUfusBjPW/rFstkiM/eG3NldPVWRYK5hVxBZLcdbDJ1i23bua5jf3/iRUGqUrbn8RCeRc6GD0vbD74Y445rUcyBu7zw92/howFg6VHAWEiOr0tYxfH4V2IS7o3S3nEwA0N79xuYTWISLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZRpJW1cMZz501bv;
	Tue,  1 Apr 2025 21:10:19 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 531DABTE052557;
	Tue, 1 Apr 2025 21:10:11 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 21:10:15 +0800 (CST)
Date: Tue, 1 Apr 2025 21:10:15 +0800 (CST)
X-Zmail-TransId: 2af967ebe5b7478-18370
X-Mailer: Zmail v1.0
Message-ID: <20250401211015750qxOfU9XZ8QgKizM1Lcyq2@zte.com.cn>
In-Reply-To: <20250401210730615ULucEmQClX13Q7svZwHsD@zte.com.cn>
References: 20250401210730615ULucEmQClX13Q7svZwHsD@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <jgg@ziepe.ca>
Cc: <leon@kernel.org>, <li.haoran7@zte.com.cn>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <agoldberger@nvidia.com>, <cmeiohas@nvidia.com>,
        <msanalla@nvidia.com>, <dan.carpenter@linaro.org>,
        <mrgolin@amazon.com>, <phaddad@nvidia.com>, <ynachum@amazon.com>,
        <mgurtovoy@nvidia.com>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gUkRNQS9jb3JlOiBDb252ZXJ0IHRvIHVzZSBFUlJfQ0FTVCgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 531DABTE052557
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBE5BB.000/4ZRpJW1cMZz501bv

From: Li Haoran <li.haoran7@zte.com.cn>

As opposed to open-code, using the ERR_CAST macro clearly indicates that
this is a pointer to an error value and a type conversion was performed.

Signed-off-by: Li Haoran <li.haoran7@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c5e78bbefbd0..75fde0fe9989 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -572,7 +572,7 @@ struct ib_ah *rdma_create_ah(struct ib_pd *pd, struct rdma_ah_attr *ah_attr,
 					   GFP_KERNEL : GFP_ATOMIC);
 	if (IS_ERR(slave)) {
 		rdma_unfill_sgid_attr(ah_attr, old_sgid_attr);
-		return (void *)slave;
+		return ERR_CAST(slave);
 	}
 	ah = _rdma_create_ah(pd, ah_attr, flags, NULL, slave);
 	rdma_lag_put_ah_roce_slave(slave);
-- 
2.25.1

