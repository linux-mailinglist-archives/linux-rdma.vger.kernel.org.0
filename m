Return-Path: <linux-rdma+bounces-11830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D993FAF59A0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CEF188DC89
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5B284695;
	Wed,  2 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HKhubmMf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5428030C;
	Wed,  2 Jul 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463528; cv=none; b=gRxfcSajwxoY862aW/mgXtwI7urpzxD6Lq0i99dkDZ/mrL+4gOm8rV4FjWb1JbjAgkA4qYQ2jaxU4vliDgrqSqFcGHuF+5ItB0Z4GcZdefBUMm0Bth4hemQdHcthNVLP1VUWw9r3Rjk1OzFcJwYeV1SSJB4A42rSDiAIpSIKKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463528; c=relaxed/simple;
	bh=6JXOJDpQtNZ8zItGvQx8hpOPdmVU4HwAecRO1928Ajg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epl7fZTgZuEBEYWfYsCqyRupzZYQ0llSmL/jJBSEF2/tz0sShDLvBBB+ENX2Yv5MmSnOrihnKTRWjomqIAgrsBJx+/9nfX7zMCS/vf51kCgxQ1nde+LOSYuINqu1opx2BKFcRDjDx4Hyk881s8DbKag2yo5YMr4QkvROx2r6S14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HKhubmMf; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfW-00GcGn-RV; Wed, 02 Jul 2025 15:38:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=sM+ZIkYQgoYjSyImGT5nQfsb+zR5DT3P9YWgOgmGZQE=; b=HKhubmMfKL7U9cqp0dMh0WOd9s
	RWjfsza+e4mH8JywvaeQzPnYVqQv3dzd/wQyvfxWx2eJWqQP6SEX2oUDPXy6XtBzo+MqsXlwwBCxV
	dpgvUlCS9GN6zAZVn1VQqEdhuAcbCYCXfUPgGCh6FMO/J28BhIRNxOcCaXPQ+3cbRVnPuu7BYD4UL
	2dJZaZoVXuDxga3x1L+GsliVxqc+shcoLiKq92ud65zbkoJH2blEU7juEnomvDgE0xVlmGO6E0yMh
	HVy7/0x998XfTHqTdOuCKMa9zs5lWqYOpw5ymTGfaPX3Lx243ga6KKqTE0f5RsXpjEjsJTfWyRdev
	Yv3/dGtg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfW-0005Gl-8M; Wed, 02 Jul 2025 15:38:34 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfG-009LCR-SI; Wed, 02 Jul 2025 15:38:18 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:11 +0200
Subject: [PATCH net-next v3 5/6] net: skbuff: Drop unused @skb
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-splice-drop-unused-v3-5-55f68b60d2b7@rbox.co>
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

Since its introduction in commit ce098da1497c ("skbuff: Introduce
slab_build_skb()"), __slab_build_skb() never used the @skb argument. Remove
it and adapt both callers.

No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3041f7a3560d58270dffdf923825758f274c8511..4893350bc80a105e0a2870f0de03a687c1117217 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -384,8 +384,7 @@ static inline void __finalize_skb_around(struct sk_buff *skb, void *data,
 	skb_set_kcov_handle(skb, kcov_common_handle());
 }
 
-static inline void *__slab_build_skb(struct sk_buff *skb, void *data,
-				     unsigned int *size)
+static inline void *__slab_build_skb(void *data, unsigned int *size)
 {
 	void *resized;
 
@@ -418,7 +417,7 @@ struct sk_buff *slab_build_skb(void *data)
 		return NULL;
 
 	memset(skb, 0, offsetof(struct sk_buff, tail));
-	data = __slab_build_skb(skb, data, &size);
+	data = __slab_build_skb(data, &size);
 	__finalize_skb_around(skb, data, size);
 
 	return skb;
@@ -435,7 +434,7 @@ static void __build_skb_around(struct sk_buff *skb, void *data,
 	 * using slab buffer should use slab_build_skb() instead.
 	 */
 	if (WARN_ONCE(size == 0, "Use slab_build_skb() instead"))
-		data = __slab_build_skb(skb, data, &size);
+		data = __slab_build_skb(data, &size);
 
 	__finalize_skb_around(skb, data, size);
 }

-- 
2.49.0


