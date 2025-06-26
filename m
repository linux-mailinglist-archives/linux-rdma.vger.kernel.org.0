Return-Path: <linux-rdma+bounces-11660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B88AE9871
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FDA3A2B5C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB162BD001;
	Thu, 26 Jun 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YLz891FW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEE293C73;
	Thu, 26 Jun 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926869; cv=none; b=ufCVW6608PWxyOcdDHtKX7wjbmWcwTt4jIdx795QX+Fd4A5rfeZcw0OUBpaXtLPXqopIUsdoZEoFMXBvTCzOzfyFxqSZCY6DxWRk6bzLsBn95j9bzh4CESOLnJ3+FT+x7gvyMjh32YVbFbTLNwyjYyze/fUPl7Y2RYm/JdYyf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926869; c=relaxed/simple;
	bh=Rnaj2PFCa68bxXv5wt1CtX7Z49GHdcxC1ZFTpzR5ZfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KI7+ftoEYaXTb0Pm1GZ7yYldnX+SuIeJSLPVPJDA5mMgh93wGdBYFvEX650c+28y4ja1eR5RAw3F5lHORzbrK1SDdE33YZhbVz1akd7nN459qWhfdZ0Im/3xulHgueqgRBUNgwt1vUtXdV9B0sS+Q4zyKeEtyCjwwnIR/jcbCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YLz891FW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3q-00GcFq-8R; Thu, 26 Jun 2025 10:34:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=w3M0ONjlTeiHEYSZyu+REn2BAtSk5b88mwbjWDKB3yg=; b=YLz891FWNU0bAgUpDo3sbxvp4Q
	L97fbhpuOBDZX/ibQDA1Sy1AtNKy5iFRiK46ZMId0sLOKl2O6/p+CSMBxbxlxvI5dDoeTyfTtxDMB
	M3BNDALwW5Y0SgUNhhgoA+ucNPSPTbdTTsN0N9XsoFT4cYUxgDBSuyItypFfAZqsXpFmifhztKG05
	SuByf7PljVmtG1REMnVyGbD+nMyWuIOwiEt9s4x/+bSv7mb+0KBPCJHfKvYANHBRJaKrzPvqzCPaC
	qo6Cs54nBHsYdB65o7xbiGBvB/hPzpnAuZ/uGZUM2tvP8ekZxfLKdv6w9So7AchJVoZJQqkBIofXA
	2dijDbBg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3p-0002He-Sv; Thu, 26 Jun 2025 10:34:22 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3P-009Fh5-9n; Thu, 26 Jun 2025 10:33:55 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:38 +0200
Subject: [PATCH net-next v2 5/9] net: splice: Drop unused @gfp
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-5-3268fac1af89@rbox.co>
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

Since its introduction in commit 2e910b95329c ("net: Add a function to
splice pages into an skbuff for MSG_SPLICE_PAGES"), skb_splice_from_iter()
never used the @gfp argument. Remove it and adapt callers.

No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c | 3 +--
 include/linux/skbuff.h                                      | 2 +-
 net/core/skbuff.c                                           | 3 +--
 net/ipv4/ip_output.c                                        | 3 +--
 net/ipv4/tcp.c                                              | 3 +--
 net/ipv6/ip6_output.c                                       | 3 +--
 net/kcm/kcmsock.c                                           | 3 +--
 net/unix/af_unix.c                                          | 3 +--
 8 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index d567e42e176011d42b9549d0cc6292a06126d61d..465fa807796439b90c949f54e203a798f06acf1f 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -1096,8 +1096,7 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = size;
 
 		if (msg->msg_flags & MSG_SPLICE_PAGES) {
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0) {
 				if (err == -EMSGSIZE)
 					goto new_buf;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5b6f460c69b277124e788cfa0599486522e62c9c..4952a6991c720a5001477a77d252567aa2c15ac2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5264,7 +5264,7 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 }
 
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
-			     ssize_t maxsize, gfp_t gfp);
+			     ssize_t maxsize);
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 02ead44a82bb71d30d294a6931943d07cf7c7177..c381a097aa6e087d1b5934f2d193a896a255bf83 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7229,7 +7229,6 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * @skb: The buffer to add pages to
  * @iter: Iterator representing the pages to be added
  * @maxsize: Maximum amount of pages to be added
- * @gfp: Allocation flags
  *
  * This is a common helper function for supporting MSG_SPLICE_PAGES.  It
  * extracts pages from an iterator and adds them to the socket buffer if
@@ -7240,7 +7239,7 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * insufficient space in the buffer to transfer anything.
  */
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
-			     ssize_t maxsize, gfp_t gfp)
+			     ssize_t maxsize)
 {
 	size_t frag_limit = READ_ONCE(net_hotdata.sysctl_max_skb_frags);
 	struct page *pages[8], **ppages = pages;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a2705d454fd645b442b2901833afa51b26512512..5d75d60efcf361ed9c3b34eaa982f6c667c716f6 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1222,8 +1222,7 @@ static int __ip_append_data(struct sock *sk,
 			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
 				goto error;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0)
 				goto error;
 			copy = err;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b6285fb1369d32541b9f7d660ca33389b7e4da61..9d41113e3a68455f3cc7e067d72f3aa2485a21f2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1295,8 +1295,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0) {
 				if (err == -EMSGSIZE) {
 					tcp_mark_push(tp, skb);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db8d74c79f50afa5c693231e0f82d5..618ed7d72b28f43ab6d7a02e5f8f53a4d22de87a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1760,8 +1760,7 @@ static int __ip6_append_data(struct sock *sk,
 			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
 				goto error;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0)
 				goto error;
 			copy = err;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 8140c9c9cc2cb7aa71eaceab8a019d882bc454aa..71fedf9cfac85b7cbcd8fd3dbacd74440fa556f4 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -835,8 +835,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0) {
 				if (err == -EMSGSIZE)
 					goto wait_for_memory;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1e3a4db1a96a57c84c199e30c164f66409b04be4..c2d1a547b14650b53d16c18f239aeb7c5f50cc96 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2377,8 +2377,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, size);
 			if (err < 0)
 				goto out_free;
 

-- 
2.49.0


