Return-Path: <linux-rdma+bounces-7459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5EA298B2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23F6168B16
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18141FDA89;
	Wed,  5 Feb 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to5PpIsp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882D1FDA6B;
	Wed,  5 Feb 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779655; cv=none; b=EVoz4vW24GooDbwKWi4ikGfkn+D+c5rblTqvCkujB0AYDlRnuQBwozE5wjH3zipziqHUEpK3s1Tu+/mUPWQrGslMEv9TXRxJq9BELTXGjTJg7WpkIpqcVCmqmORsZzxbUuPh2bYVo6Ged2TLlY2JE/veWlCz8oOkvM6QeH252VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779655; c=relaxed/simple;
	bh=XWEebm3WI7vXFVNcASUEqDCe9EUHasGgyoIgQYx2JWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8WEZlDJRIDbuCQaAeda0pO+DG96N6yNZVa+yiXH3nvj0qiZudqEPpLzHgEmZ5qS+RZlBs8S9Q5gr1qDP9osOCgy3G9FeLhYfVTva24AJBIRdDoaheRcPldMDhppX7pDlWOlUKnwv452A4wATJkRUI7Nn3hdaxOkiE5FxHxFQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to5PpIsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D03C4CED1;
	Wed,  5 Feb 2025 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779654;
	bh=XWEebm3WI7vXFVNcASUEqDCe9EUHasGgyoIgQYx2JWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=to5PpIspg6l0BZGxF394Z8tc372Ol38ly/jfw4xItz9pskI9iZjjuc5lfqWbTPVWf
	 AuHe/JZpcQ8XPAG0+nOU3Ej6ddS6lC6C3B67IKETJgMeFM7tGGtvDTT1j3QIgsOZfE
	 aIxCDHsadrAL95aSb7azh0CoULHdyCjPCc9/T2FvgHeYVc1H9h1v5UijVS1pgvguA7
	 /ItXzScQ8K/7MXakpwm131rMb6Z5ji5jfAAaMlWSgSdoT3T6orCqlybQj+EEHyXVCg
	 MQBR9JzbVHO7zB+cy336ODOXXqI7XPEKB/RNE/ZuYfPWw1S3as7+6yjwQL5Do1Zr/G
	 WL+ZscGmQyDMw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	intel-wired-lan@lists.osuosl.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Ilia Lin <ilia.lin@kernel.org>
Subject: [PATCH ipsec-next 5/5] xfrm: check for PMTU in tunnel mode for packet offload
Date: Wed,  5 Feb 2025 20:20:24 +0200
Message-ID: <557b6b8b1b8bfd594387793dd1729483a0975244.1738778580.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738778580.git.leon@kernel.org>
References: <cover.1738778580.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In tunnel mode, for the packet offload, there were no PMTU signaling
to the upper level about need to fragment the packet. As a solution,
call to already existing xfrm[4|6]_tunnel_check_size() to perform that.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     |  9 +++++++++
 net/xfrm/xfrm_device.c | 10 ++++++++--
 net/xfrm/xfrm_output.c |  6 ++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 58f8f7661ec4..519ab1209e4c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1782,6 +1782,15 @@ int xfrm_trans_queue(struct sk_buff *skb,
 				   struct sk_buff *));
 int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err);
 int xfrm_output(struct sock *sk, struct sk_buff *skb);
+int xfrm4_tunnel_check_size(struct sk_buff *skb);
+#if IS_ENABLED(CONFIG_IPV6)
+int xfrm6_tunnel_check_size(struct sk_buff *skb);
+#else
+static inline int xfrm6_tunnel_check_size(struct sk_buff *skb)
+{
+	return -EMSGSIZE;
+}
+#endif
 
 #if IS_ENABLED(CONFIG_NET_PKTGEN)
 int pktgen_xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 056df0e69d73..9ad1f85b0a27 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -419,12 +419,12 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct dst_entry *dst = skb_dst(skb);
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
+	bool check_tunnel_size;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
 		return false;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-	    ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm)) {
+	if ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -436,16 +436,22 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
+	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
+			    x->props.mode == XFRM_MODE_TUNNEL;
 	switch (x->props.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
 			return false;
+		if (check_tunnel_size && xfrm4_tunnel_check_size(skb))
+			return false;
 		break;
 	case AF_INET6:
 		/* Check for IPv6 extensions */
 		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
 			return false;
+		if (check_tunnel_size && xfrm6_tunnel_check_size(skb))
+			return false;
 		break;
 	default:
 		break;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f7abd42c077d..34c8e266641c 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -786,7 +786,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(xfrm_output);
 
-static int xfrm4_tunnel_check_size(struct sk_buff *skb)
+int xfrm4_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 
@@ -812,6 +812,7 @@ static int xfrm4_tunnel_check_size(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xfrm4_tunnel_check_size);
 
 static int xfrm4_extract_output(struct xfrm_state *x, struct sk_buff *skb)
 {
@@ -834,7 +835,7 @@ static int xfrm4_extract_output(struct xfrm_state *x, struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int xfrm6_tunnel_check_size(struct sk_buff *skb)
+int xfrm6_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 	struct dst_entry *dst = skb_dst(skb);
@@ -864,6 +865,7 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xfrm6_tunnel_check_size);
 #endif
 
 static int xfrm6_extract_output(struct xfrm_state *x, struct sk_buff *skb)
-- 
2.48.1


