Return-Path: <linux-rdma+bounces-11661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E60AE9870
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D84A23B3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD82BEFEF;
	Thu, 26 Jun 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Mc14B1Vy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5A2949F0;
	Thu, 26 Jun 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926871; cv=none; b=UKSRvfTCGbwwuNODJA8eCtXLFy9QLdKdrRvbhq68qGFDItvCZltzG5iHIM/J8V84yHeuLuV7hEO6omeYaAOG1JbSH9gyEBmTO3JX+Je5J6hYBGVhivdSGmeLguZRSas8PSrULKO+G/lcRypdce5iEVyEMWB+54+/ah5hqCsNnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926871; c=relaxed/simple;
	bh=I5NwMU/UkVWamqyeUyAIs0m2ELLcQVTl3pqCth/6nic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9RaNtugofte2SJBa78FuSR2sz487vrsYl5GFSEjjz52P/wCTZoNbahvSSrjlyI3IsKkvz1CXrjXYRpYIilM5lK+JTjRjtOMdNCPOzL7G7rRKUgua2JArsqobSQTd519tgCv06ypQp8nNewaWePLaX4D3Sff0QMcqoMXMMdlLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Mc14B1Vy; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3s-00GcGI-H0; Thu, 26 Jun 2025 10:34:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=PfnmbZl5iKr6rFeTS80a4NnfW2jlSVKr3NNDNbGzVI0=; b=Mc14B1Vyr3b42PbsywcyYWVoQD
	XSK/D+nCe5WuismACds54L4v9+VqnIY2ORtk0BHj9y/1QHMCZ/4oGBNYAUWhBDsSjTI0Rvnpuvp9P
	6i/eSBbxXl8n+GOeMDgAj0+lqkPsM3wwhCInKZO94s6M8gHqDaz5RQhwmeYKR3lfC3oDjlGNqjX3y
	ARo36zzKcEfG1JxKbIn5e0qhmcjgZbFSoruWNqWp6P1gtgJej5aAr/nfiMVdRGV/p1MR7jiNEYnco
	/XgxgJiBgoEn+sZd/v8TP4J+lsIUQNK3qsaGCaBOcwSVMSyDeWqUP6SAijZe2P14ClCVEsiVtRBKc
	TQT+ChgQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3s-0002Hs-1g; Thu, 26 Jun 2025 10:34:24 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3L-009Fh5-9r; Thu, 26 Jun 2025 10:33:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:34 +0200
Subject: [PATCH net-next v2 1/9] net: splice: Drop unused @pipe
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-1-3268fac1af89@rbox.co>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
In-Reply-To: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>
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


