Return-Path: <linux-rdma+bounces-5973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA23F9C8180
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 04:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AFB22C01
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 03:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD03FBA5;
	Thu, 14 Nov 2024 03:35:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D12309B8
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731555323; cv=none; b=g8E0T3A4KxQOhZPdyIrfmQCG5RnjDepIN479/9quOEEekofxe03rSLcclORmqCClMozACHSa7xLF7b4h5AT73Fd9KSu+zApyhe8anLYzwEZsxMV6YlvZa4f7JvS6floi5yaPjd/o1t++BaLSb5GbNIDGjZUnVCYomcbyJyhlEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731555323; c=relaxed/simple;
	bh=a7+Fdx37DgKjPK5F8i0k+Sc14PVBkVJbMUGLdFlxgRY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=q6hu+fjZ0Zz9MiqRfxNeND2kCWMHvsLwhPHE9Ls/yVgQVRsfUplofnNilGi/NFkKXYr/eSQN/zcUnzlmkU98rpwG0TuWLnFco9ub1GSobzMeYP8ZypjLqqZGFuAUZgoevLulU8jCN7QKwQ+enQBwvu78hB9gbRoKjqfmIb25C1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4XpltZ5VW7zKjV
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 11:26:30 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4XpltS1Pccz5Bv23
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 11:26:24 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4XpltH1Vp8z5B1FB
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 11:26:15 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Xplt50s0Cz4x5rC;
	Thu, 14 Nov 2024 11:26:05 +0800 (CST)
Received: from njy2app03.zte.com.cn ([10.40.13.14])
	by mse-fl1.zte.com.cn with SMTP id 4AE3Pvbq041459;
	Thu, 14 Nov 2024 11:25:58 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Thu, 14 Nov 2024 11:25:59 +0800 (CST)
Date: Thu, 14 Nov 2024 11:25:59 +0800 (CST)
X-Zmail-TransId: 2afb67356dc7ffffffffcf9-c3eac
X-Mailer: Zmail v1.0
Message-ID: <202411141125595650lBfwAV8PE5HVMxAr96yl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IDUuMTBdIFJETUEvcmVzdHJhY2s6IFJlbGVhc2UgTVIvUVAgcmVzdHJhY2sgd2hlbiBkZWxldGU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4AE3Pvbq041459
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67356DE5.001/4XpltZ5VW7zKjV

From: tuqiang <tu.qiang35@zte.com.cn>

The MR/QP restrack also needs to be released when delete it, otherwise it
cause memory leak as the task struct won't be released.

Refer to commit dac153f2802d ("RDMA/restrack: Release MR restrack when delete").

Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
Signed-off-by: tuqiang <tu.qiang35@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
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

