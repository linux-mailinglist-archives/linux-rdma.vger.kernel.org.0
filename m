Return-Path: <linux-rdma+bounces-9077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367DA77BB6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DCD16B85A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0F52036E3;
	Tue,  1 Apr 2025 13:08:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD21DEFE1;
	Tue,  1 Apr 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512925; cv=none; b=Hd+AEF4mztIw8jccfBvJQASKVPay2hLAKiCh0OmHTYWuMVMZSgoCzC90I7ZoLSsnptE22mewUUYHpeEFwhJDrG+HycdLrVuX0soPFJYkTgIDuMPS5CvlRhg2cViEVicCEbQXAQ/zkgRsZ4mu1bwMkVypl0i5V30e4T84RrQaR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512925; c=relaxed/simple;
	bh=S+agUJgSrUzpGrHcbOgJHhEsC/kJDDEKzWcSrxXuDEg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=VNs/q3bpld0LdNK79XKpJTEiLubcRotYWeXjkaiLFXq3SQI8eOv/nFNNmPYZA9T0W66YsLVoj1X6AEqwDAuLK7oTW26iV7uV/5D4TJZu8psylvZLYr5Xv1+KO4ajYH0Juk4+n+DwpXig3s545yPeumEGSxfmk5HCCL5bfiqPh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZRpGY23Wkz8R046;
	Tue,  1 Apr 2025 21:08:37 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 531D8aVx051287;
	Tue, 1 Apr 2025 21:08:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 21:08:40 +0800 (CST)
Date: Tue, 1 Apr 2025 21:08:40 +0800 (CST)
X-Zmail-TransId: 2afa67ebe558030-12f2d
X-Mailer: Zmail v1.0
Message-ID: <20250401210840146_IyrV3zlejzz3eAnDmMSB@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIDEvM10gUkRNQS9jb3JlOiBDb252ZXJ0IHRvIHVzZSBFUlJfQ0FTVCgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 531D8aVx051287
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBE555.001/4ZRpGY23Wkz8R046

From: Li Haoran <li.haoran7@zte.com.cn>

As opposed to open-code, using the ERR_CAST macro clearly indicates that
this is a pointer to an error value and a type conversion was performed.

Signed-off-by: Li Haoran <li.haoran7@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/infiniband/core/mad_rmpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 8af0619a39cd..b4b10e8a6495 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -158,7 +158,7 @@ static struct ib_mad_send_buf *alloc_response_msg(struct ib_mad_agent *agent,
 	ah = ib_create_ah_from_wc(agent->qp->pd, recv_wc->wc,
 				  recv_wc->recv_buf.grh, agent->port_num);
 	if (IS_ERR(ah))
-		return (void *) ah;
+		return ERR_CAST(ah);

 	hdr_len = ib_get_mad_data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
 	msg = ib_create_send_mad(agent, recv_wc->wc->src_qp,
-- 
2.25.1

