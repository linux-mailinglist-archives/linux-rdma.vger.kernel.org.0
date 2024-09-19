Return-Path: <linux-rdma+bounces-5007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF697CB1C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626C61F253D9
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA41A01B0;
	Thu, 19 Sep 2024 14:40:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8A1E517;
	Thu, 19 Sep 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756839; cv=none; b=g5jNh7+pGb0BpJfLnO8CljQgrUa5r/7FcdXf0S+XRz4Jnwpoc+ZJXoWH48MzAAfi7kMmh8QhXcWuDb7J/iV0+b0G6XAmM5dxUcUtf4VYJklVA+lxGrv7xQxRZGVUHdvC1B/AZBB8Zjh38rs53+ulcxq6po5fwuOfH2eqGQHg4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756839; c=relaxed/simple;
	bh=2+yuF2B/4DXESVhh4mawwfdhrfkH5m1Mn8PDe3KLjZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngOzchXY8fmnTTZl5oHjArHtu7gdDhLdmRjsIQPED+INt1fhfNXzu4HpVHryypCJMkitroiNPMGmeJ3z0sHuLcm8SSw5IM4y9A0iKQV2oF9Le0gU3/Z48bPbBamt5bLVT7rVUakjwSJxzpj7gyFpDQGsyVGC+pPYQ6coZZkyHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 19 Sep
 2024 17:40:35 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 19 Sep
 2024 17:40:35 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Steve Wise
	<swise@chelsio.com>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-patches@linuxtesting.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 4.19/5.4/5.10 1/1] RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()
Date: Thu, 19 Sep 2024 07:40:22 -0700
Message-ID: <20240919144022.14291-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919144022.14291-1-n.zhandarovich@fintech.ru>
References: <20240919144022.14291-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit 283861a4c52c1ea4df3dd1b6fc75a50796ce3524 upstream.

If get_ep_from_tid() fails to lookup non-NULL value for ep, ep is
dereferenced later regardless of whether it is empty.
This patch adds a simple sanity check to fix the issue.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 944661dd97f4 ("RDMA/iw_cxgb4: atomically lookup ep and get a reference")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/r/20230202184850.29882-1-n.zhandarovich@fintech.ru
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
v2: Add stable maintainers as patch recepients.

 drivers/infiniband/hw/cxgb4/cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index ea3ddf0d241142..ced615b5ea096e 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2676,6 +2676,9 @@ static int pass_establish(struct c4iw_dev *dev, struct sk_buff *skb)
 	u16 tcp_opt = ntohs(req->tcp_opt);
 
 	ep = get_ep_from_tid(dev, tid);
+	if (!ep)
+		return 0;
+
 	pr_debug("ep %p tid %u\n", ep, ep->hwtid);
 	ep->snd_seq = be32_to_cpu(req->snd_isn);
 	ep->rcv_seq = be32_to_cpu(req->rcv_isn);
-- 
cgit 1.2.3-korg


