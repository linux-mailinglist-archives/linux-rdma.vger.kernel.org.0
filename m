Return-Path: <linux-rdma+bounces-11828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C28AF5997
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E12188930B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0228313F;
	Wed,  2 Jul 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IkbAyxGU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400F280A51;
	Wed,  2 Jul 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463527; cv=none; b=b8EPDpGr0VCbENwmjVIPEZq6HW89tnABAH2rwNvldJuGBCm5I55iFwLqbBzL8fiMtNq4xrLdp/+9JS0nq6MN4vsK3cO6FaZz1L/x5XkEzE4AIPkL8Zkg4QYOs2qkymsmaJ3BG15BmlL7deD84Z6YyneRJWrH5WriBpUsmQKdI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463527; c=relaxed/simple;
	bh=I5NwMU/UkVWamqyeUyAIs0m2ELLcQVTl3pqCth/6nic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrxnwqNgquYzjr3pLZOohQfl7zULSLezTUK4pEcr7tpDWiDC5Z7BOL+Ep9eTNl9krCGV6IVcerWFJT5kPg7ONGuw7SoJsS8qCa9XUEuiuTh5tGPw5amEeXl2berMmzVl/h5EofGbhQbN78nIbttBmwKAUT4f5rhQTSStN1Knfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IkbAyxGU; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfZ-00GxPT-Mj; Wed, 02 Jul 2025 15:38:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=PfnmbZl5iKr6rFeTS80a4NnfW2jlSVKr3NNDNbGzVI0=; b=IkbAyxGUjd7jXvlmFAItytXDdn
	s+jsvj17ly2lUQBwkk4zXoqkDzTfgSR19GLz+yiDd4I/o/7uEw9MjhjkKaIffz8N/hwqJhj+eHNGF
	LEkp1n3gObJXZZ64k6DMwXSuNCeY15c1drHNRb3r0IieqhKLDPea6D7+nK81bMGeNZEuVSwcjJuAd
	DBP6GcoQ9e0A3k9nflTPlvOmycqFKI7Cfxd1It79d3zCHLiRuBXbErXx7Dbb7j6EurC0+t6rN4CSv
	UbcyUNU6LtH8dl9E7bq8lDs+uYSTpbJN7534f/UWAvEg/F1bnR/L+cJbQZyMbfXXw4JR0GkRHA5xb
	oLq+IZ6g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfZ-0005H0-A7; Wed, 02 Jul 2025 15:38:37 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfD-009LCR-GI; Wed, 02 Jul 2025 15:38:15 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:07 +0200
Subject: [PATCH net-next v3 1/6] net: splice: Drop unused @pipe
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-splice-drop-unused-v3-1-55f68b60d2b7@rbox.co>
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

Since commit 41c73a0d44c9 ("net: speedup skb_splice_bits()"),
__splice_segment() and spd_fill_page() do not use the @pipe argument. Drop
it.

While adapting the callers, move one line to enforce reverse xmas tree
order.

No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d6420b74ea9c6a9c53a7c16634cce82a1cd1bbd3..ae0f1aae3c91d914020c64e0703732b9c6cd8511 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3060,10 +3060,8 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
 /*
  * Fill page/offset/length into spd, if it can hold more pages.
  */
-static bool spd_fill_page(struct splice_pipe_desc *spd,
-			  struct pipe_inode_info *pipe, struct page *page,
-			  unsigned int *len, unsigned int offset,
-			  bool linear,
+static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
+			  unsigned int *len, unsigned int offset, bool linear,
 			  struct sock *sk)
 {
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
@@ -3091,8 +3089,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 			     unsigned int plen, unsigned int *off,
 			     unsigned int *len,
 			     struct splice_pipe_desc *spd, bool linear,
-			     struct sock *sk,
-			     struct pipe_inode_info *pipe)
+			     struct sock *sk)
 {
 	if (!*len)
 		return true;
@@ -3111,8 +3108,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 	do {
 		unsigned int flen = min(*len, plen);
 
-		if (spd_fill_page(spd, pipe, page, &flen, poff,
-				  linear, sk))
+		if (spd_fill_page(spd, page, &flen, poff, linear, sk))
 			return true;
 		poff += flen;
 		plen -= flen;
@@ -3130,8 +3126,8 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			      unsigned int *offset, unsigned int *len,
 			      struct splice_pipe_desc *spd, struct sock *sk)
 {
-	int seg;
 	struct sk_buff *iter;
+	int seg;
 
 	/* map the linear part :
 	 * If skb->head_frag is set, this 'linear' part is backed by a
@@ -3143,7 +3139,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			     skb_headlen(skb),
 			     offset, len, spd,
 			     skb_head_is_locked(skb),
-			     sk, pipe))
+			     sk))
 		return true;
 
 	/*
@@ -3160,7 +3156,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
-				     offset, len, spd, false, sk, pipe))
+				     offset, len, spd, false, sk))
 			return true;
 	}
 

-- 
2.49.0


