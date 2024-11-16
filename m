Return-Path: <linux-rdma+bounces-6012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83DD9CFDB8
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3890EB23CF6
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3119343E;
	Sat, 16 Nov 2024 09:58:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A663C;
	Sat, 16 Nov 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731751099; cv=none; b=Zq2sDnzHsvckHdItVxlkT88oX/5IEGZRRNM39Dp3oa0tSSbLyYKjuhaStYRjKvdtQwN5/ayZGBO7cFaZysxGGFpUJrssmIRfeqhqTb1I2sn6D1Xq5gcEaRT4N8emRej9fY2frC/a4dQnRziqf2eXeILkmPjW7/dhllL9EDoE77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731751099; c=relaxed/simple;
	bh=E6j9oslTtrd+6h5B0lvb2SEtDC8mDtkgt4cXNhvxTM8=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Qol6Js/1UzysJx5upOhAe8OVq63mT7SCrfUstr+ME+6t230IvOYvxaTxi25m1KwN/b/VgkMWtr7r+vNB/FWGCV5q9+lx760VblpYQX0l4c5jEQRQ/7TZWsqkXwyrXzHxH0l77TPtJewCkU8JfMmgU+OGSX8GKBf4PKbJHWq3Ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Xr8TX5nlfz5B1Gv;
	Sat, 16 Nov 2024 17:58:08 +0800 (CST)
Received: from njy2app01.zte.com.cn ([10.40.12.136])
	by mse-fl1.zte.com.cn with SMTP id 4AG9vjUp056776;
	Sat, 16 Nov 2024 17:57:45 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app08[null])
	by mapi (Zmail) with MAPI id mid204;
	Sat, 16 Nov 2024 17:57:48 +0800 (CST)
Date: Sat, 16 Nov 2024 17:57:48 +0800 (CST)
X-Zmail-TransId: 2b0067386c9c512-2065a
X-Mailer: Zmail v1.0
Message-ID: <20241116175748571awvOCFyR9lCLwe61IhOXL@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIFNUQUJMRSA1LjEwXSBSRE1BL3Jlc3RyYWNrOiBSZWxlYXNlIE1SL1FQIHJlc3RyYWNrIHdoZW4gZGVsZXRl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4AG9vjUp056776
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67386CB0.001/4Xr8TX5nlfz5B1Gv

From: tuqiang <tu.qiang35@zte.com.cn>

The MR/QP restrack also needs to be released when delete it, otherwise it
cause memory leak as the task struct won't be released.

This problem has been fixed by the commit <dac153f2802d>
("RDMA/restrack: Release MR restrack when delete"), but still exists in the
linux-5.10.y branch.

Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
Signed-off-by: tuqiang <tu.qiang35@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
Cc: stable@vger.kernel.org
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/core/restrack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index bbbbec5b1593..d5a69c4a1891 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -326,8 +326,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	rt = &dev->res[res->type];

 	old = xa_erase(&rt->xa, res->id);
-	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
-		return;
 	WARN_ON(old != res);
 	res->valid = false;

-- 
2.18.4

