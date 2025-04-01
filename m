Return-Path: <linux-rdma+bounces-9078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEDAA77BC1
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1681D7A2215
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343812036F0;
	Tue,  1 Apr 2025 13:09:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085F203711;
	Tue,  1 Apr 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512974; cv=none; b=mM19VQ4PjW0LdC1FttD0dtfMWz//j7CWmm12hTlXOm1O/nx6JJ72GF095r/GfCfvVQB5vkKTdpPJ6H+p/6nvgGkCjk4eeY0YCtjyVD+qouhet533ccnEUSM5JkzE9v9462QCKZMzrQCjn12NJirGf4iNhY22Cbs3I/ctKUd31vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512974; c=relaxed/simple;
	bh=YMnuogFThrQHE7n/MTT5sL09pZzfi6UQTqBGG6a+7zM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=VP7vZg+SjNy3dBPcMDCQOooHWVvLXNHHbZunaVUHP7HZnYZgXmcEr922w/j3p5Boam0+LGBaNAt79lXKciepGxNBXzTXr6PnxZIm8jPwfuLwh/W1Qcjir2H+/8w/CBfL5FL7mKLoy7bd1h3gRfekf2dYOa0pwn4uF98zCK6PT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZRpHV3Yh0z8R03x;
	Tue,  1 Apr 2025 21:09:26 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 531D9JMx051597;
	Tue, 1 Apr 2025 21:09:19 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 21:09:23 +0800 (CST)
Date: Tue, 1 Apr 2025 21:09:23 +0800 (CST)
X-Zmail-TransId: 2afc67ebe583ffffffffed1-12dcf
X-Mailer: Zmail v1.0
Message-ID: <202504012109233981_YPVbd4wQzmAzP3tA5IG@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIDIvM10gUkRNQS91dmVyYnM6IENvbnZlcnQgdG8gdXNlIEVSUl9DQVNUKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 531D9JMx051597
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBE586.000/4ZRpHV3Yh0z8R03x

From: Li Haoran <li.haoran7@zte.com.cn>

As opposed to open-code, using the ERR_CAST macro clearly indicates that
this is a pointer to an error value and a type conversion was performed.

Signed-off-by: Li Haoran <li.haoran7@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 3c3bb670c805..bc9fe3ceca4d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -193,7 +193,7 @@ _ib_uverbs_lookup_comp_file(s32 fd, struct uverbs_attr_bundle *attrs)
 					       fd, attrs);

 	if (IS_ERR(uobj))
-		return (void *)uobj;
+		return ERR_CAST(uobj);

 	uverbs_uobject_get(uobj);
 	uobj_put_read(uobj);
-- 
2.25.1

