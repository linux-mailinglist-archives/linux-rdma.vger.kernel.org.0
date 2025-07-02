Return-Path: <linux-rdma+bounces-11833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A61AF599B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917524E3CF1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E53288521;
	Wed,  2 Jul 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="RLG2HGSQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D3284B50;
	Wed,  2 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463531; cv=none; b=bA5NDjuzg2Bt9ktKBDsYXv9Adju6o6aD/rvezQNnyPx0sELyDQJskMOxdD/4gFqUiedXfN/xqq2QxFxAjO6OgBeW0aoSdSSMz+/k4hYg2qbx1ZQTz7PwhEGxrjGe4eVkETLiAQptGnSm97iOkhVWtCpzJq8JQh5cYL9MK8NIdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463531; c=relaxed/simple;
	bh=NtoEfjaZEuPCqmgqs0u5ddR2LNw9LS1q/CRzG1/Tg8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqgFvthSBy3vj/7fWO32hYdmkZkBz9PlOrsrQ1B8IFnRn2IYfD32MtO4z41+4G87dQjRN/bRRWIhCfPdpDxbzyHDM0SW67tRCC5rvEi2t9yhI5lhdmobcSTIiMVRosKRMldwHoRMojkBNng13F+L1mfZ9C+DDb3qeZkXnE4s2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=RLG2HGSQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfc-00GcL0-4M; Wed, 02 Jul 2025 15:38:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=T1VNZPfSFFoTbfg+4n7CjX3vldxe4ACI57UyodET+ps=; b=RLG2HGSQGDUF2RsA5TDKBPTW2B
	hrfgLhD+v5kLGXLjy9rCHTPc3Ftu9eylUo9PFfRpCzcOcy8b0MxkD94CGJJRVpKc37ObdCSAF5x1z
	AnV2P6UdnqCvxSbhhU4bK91GQDQqxyYNfQLHRINR8BNYUfSRXEYlPcAJGyw72iumMCCOxYVzExUzn
	cUMY0h6NNhfrWDr8NzF6YWTDMeXBK76ntCOxHswo7HRjmYz1ZnRxwKNZj/UD12oqrJJHwiwNLUoga
	egCCO+ADgyTSzrqAyFl+I0fAqNtgm9uBeKkvQnx/utqwwqYoQ9ql+80tlELdAvg6qMPO9gquQ4fiI
	S9a5wgcg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfb-0005H6-O6; Wed, 02 Jul 2025 15:38:39 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfE-009LCR-AX; Wed, 02 Jul 2025 15:38:16 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:08 +0200
Subject: [PATCH net-next v3 2/6] net: splice: Drop unused @gfp
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-splice-drop-unused-v3-2-55f68b60d2b7@rbox.co>
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
index 4f6dcb37bae8ada524a1e8f8de44c259cfac695b..b8b06e71b73ea3fb5210239f585f4ba714395fd7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5265,7 +5265,7 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 }
 
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
-			     ssize_t maxsize, gfp_t gfp);
+			     ssize_t maxsize);
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ae0f1aae3c91d914020c64e0703732b9c6cd8511..a34fe37cf7a508c8380e35522d9cde266aa440f9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7230,7 +7230,6 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * @skb: The buffer to add pages to
  * @iter: Iterator representing the pages to be added
  * @maxsize: Maximum amount of pages to be added
- * @gfp: Allocation flags
  *
  * This is a common helper function for supporting MSG_SPLICE_PAGES.  It
  * extracts pages from an iterator and adds them to the socket buffer if
@@ -7241,7 +7240,7 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
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
index 8a3c99246d2ed32ba45849b56830bf128e265763..039fffd7a594409a3a08546503c8c3d91a79b455 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1297,8 +1297,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
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
index 24aec295a51cf737912f1aefe81556bd9f23331e..a0be3896a9340c2a9120bb2692e9deec84d138c6 100644
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
index 564c970d97fffe9fd264e0d02c5670026314ac57..cd0d582bc7d48fbf9cd917c72e1fe4e88232916e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2388,8 +2388,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, size);
 			if (err < 0)
 				goto out_free;
 

-- 
2.49.0


