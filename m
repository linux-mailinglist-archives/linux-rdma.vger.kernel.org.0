Return-Path: <linux-rdma+bounces-11834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61CAF59BA
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF9188C52E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FC27A139;
	Wed,  2 Jul 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OaZXxfJu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FD280309;
	Wed,  2 Jul 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463532; cv=none; b=uIWxXOzePsr+rgues2wKO+Ke6HmD+WIkj93PFEFESjzzFR8E8iL6tK0CsFNysu8RrCJpo1JC2YLMERGubLWyISe9W2seCEGe9lakZbYUX71FL1Q5zbpbCM+0X3LUgpzwMrmSTjoph7hpXDs0DE+Wy7WE8NVRfD8kcfSLS55qGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463532; c=relaxed/simple;
	bh=0eezVt/aGVbqRb2X6TVgbQGZVA1y28V3T+nWy0kU7RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbKm/cFRGbpCCdh3tnpDmCCDdCubmzmfDo35Zejvr+MQJE5dJLVwZmgRnGmAJB3hn5voGOugDoSN5hHYnXdZVgyDEDIgX7AblR5JvtwDAyKmO2nJozpZvF1wuUF2QZWs6XKNPg1L5P31gzyixv7q1S4GkwfdXkMKJbbvKzJ5LO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OaZXxfJu; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfe-00GxQR-Cc; Wed, 02 Jul 2025 15:38:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=vFYjW9Cjsjs34VZC5pCoDTbgDzAbHmFDVo/jHajaWgU=; b=OaZXxfJufB9Re57GF6OfRUFJYE
	cHLRqSG8ebIGp0OWlyLO15x8WJs4IHYH7DlJ91CNAPvLpPis1+hVEfHukB3uk7K5IHhMchwkyi9Kc
	ZVZwAavLkdRTlb/6Dg0713WqGimY9eb5RQlOi7e7IHOX3ARjl9nWqPa3SZ7GVr0eUZ1jC39gtKtbb
	+ILBpSUw1t4+GsimtLdkARBgeWoJBo8Mh6xa1uQ9xBzmqwFv2nm1d8Fcki99ZA05Lo3XtJn62JIxM
	F202h89xIhAJ73qHD105U1Fh+/lTdj4w1gba4barFxLtgYa6Qe68WG94xK7yuXOjXTfUsK9iIeFdW
	Htei6tjw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfd-0006FI-Ov; Wed, 02 Jul 2025 15:38:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfF-009LCR-5B; Wed, 02 Jul 2025 15:38:17 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:09 +0200
Subject: [PATCH net-next v3 3/6] net: splice: Drop nr_pages_max
 initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-splice-drop-unused-v3-3-55f68b60d2b7@rbox.co>
References: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
In-Reply-To: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

splice_pipe_desc::nr_pages_max was initialized unnecessarily in commit
41c73a0d44c9 ("net: speedup skb_splice_bits()"). spd_fill_page() compares
spd->nr_pages against a constant MAX_SKB_FRAGS, which makes setting
nr_pages_max redundant.

Remove the assignment. No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a34fe37cf7a508c8380e35522d9cde266aa440f9..3041f7a3560d58270dffdf923825758f274c8511 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3189,7 +3189,6 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 	struct splice_pipe_desc spd = {
 		.pages = pages,
 		.partial = partial,
-		.nr_pages_max = MAX_SKB_FRAGS,
 		.ops = &nosteal_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};

-- 
2.49.0


