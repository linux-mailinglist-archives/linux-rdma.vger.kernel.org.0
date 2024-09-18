Return-Path: <linux-rdma+bounces-4987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505597BE6F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE9D1F22BB2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521081C8FB4;
	Wed, 18 Sep 2024 15:10:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E71C8FB9;
	Wed, 18 Sep 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672224; cv=none; b=XVJY1g1rvm6Z4Z7qaF4FOyWpZl+HByTLMqX+L8T2sgqvTfXFD+Y1zO+ZnGenBu8aoC+p1BSlkuPZLP6/7audKf6o9Zzz/3OYvwhZ8U+Ub9RyeA1KfNQrzFjAP7/K4xEYoarmURyYXpyvTrDecmiuDyRiLC2KGftAXQ/v7IVmPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672224; c=relaxed/simple;
	bh=SETbvgpfQhWvvj/rpJLcftlfCkN/B0G+Pg20KWtsF7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qalt3n0xLT1cY0lLOcO41lC4SU/LVi1uVC//R3hf+5CDIFkHBz+IoGYFbyoFEq8Q9VIsNqY4YCZQb8Pyf+3miibT17aZ531CTaDl+HoJ2Vv9XfI4M1S7Tp3C9Gl4TsPD8Tj2jvNuu3ac6p8ndIjO35/9yutpmv9gaQgLr+AKOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 18 Sep
 2024 18:10:16 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 18 Sep
 2024 18:10:16 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Steve Wise <swise@chelsio.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Doug Ledford
	<dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-patches@linuxtesting.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 4.19/5.4/5.10 1/1] RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()
Date: Wed, 18 Sep 2024 08:09:49 -0700
Message-ID: <20240918150949.7089-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918150949.7089-1-n.zhandarovich@fintech.ru>
References: <20240918150949.7089-1-n.zhandarovich@fintech.ru>
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


