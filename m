Return-Path: <linux-rdma+bounces-11831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE5AF59CB
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C5444DCA
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8D286D73;
	Wed,  2 Jul 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="CzThAC6a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EE284674;
	Wed,  2 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463530; cv=none; b=dLYhJyWEQpTCx4uSOwRqDti7BE3oMotAcrruRuIb9mIQXs8PzUGXbhqk8ztRbGy0Pc64m2m/8Ei4rw9TLkU0iClDXA2yyVvi5xx+Ha+vs4UZjTY7GPmzQX4W18WJH97FEkwV8odLgVSKfwtgbKhskewICmFO6XWWcDGsuOIbirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463530; c=relaxed/simple;
	bh=4eLuzgj8qf2LZev2QCAZV8vLiljlN4KMGlGZep1Hp+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBnvjh87tsT0jUqynnTFsWLzc4VIxhj0N32TqyQl/BHEtGyqF2tzBhKN5eLA6v4zw6oH6cTM0JYaOAadnuLB2mSrmYhFf1MX8J/dU8ldJmhZexXscneVPG0xqT767OzNF7O/L11Lxq04kH2WJs6UdatkQbDdHQEMC63WkXgSPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=CzThAC6a; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfX-00GcHN-OZ; Wed, 02 Jul 2025 15:38:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=tVBIAHVRa1NySUmQqjHQ9VogQkHm52MnGmsms6t9xMo=; b=CzThAC6a8leYxWNj+S+aNDZeuJ
	QbbNLOSvfrlowi/FYvdbHJ026K6XDtU+RsnGdmUsTFpsq0V5zXk0oMWC6KqYAodF/0IkhFX0vxccF
	kQavhrIkW9yt67fGGT/J2i1U1LUiMBH4osId+yeIah15IU6fApwaHLTgy4uqYGaZem1/uAm1dPaJv
	YjNsi0evghn9Kj/o5iABaiOEZfD6ifQ5Zq6WVh4C0ninfrB4sAG1GSjXgtApwRjAoX4TU+qTDLsop
	JwsCqcdf2TXnJ40xK+LeDyT8EdYe83Xc6sfrcDCtbOt0+7vySVTXivlTRYWXfMpsJ3yGD3tTl/rK0
	w4NJFYNw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfX-0006En-D4; Wed, 02 Jul 2025 15:38:35 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfH-009LCR-MU; Wed, 02 Jul 2025 15:38:19 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:12 +0200
Subject: [PATCH net-next v3 6/6] net: skbuff: Drop unused @skb
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-splice-drop-unused-v3-6-55f68b60d2b7@rbox.co>
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

Since its introduction in commit 6fa01ccd8830 ("skbuff: Add pskb_extract()
helper function"), pskb_carve_frag_list() never used the argument @skb.
Drop it and adapt the only caller.

No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4893350bc80a105e0a2870f0de03a687c1117217..277f7d0666691bd54d6e005c84a2166175455490 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6757,8 +6757,7 @@ static int pskb_carve(struct sk_buff *skb, const u32 off, gfp_t gfp);
 /* carve out the first eat bytes from skb's frag_list. May recurse into
  * pskb_carve()
  */
-static int pskb_carve_frag_list(struct sk_buff *skb,
-				struct skb_shared_info *shinfo, int eat,
+static int pskb_carve_frag_list(struct skb_shared_info *shinfo, int eat,
 				gfp_t gfp_mask)
 {
 	struct sk_buff *list = shinfo->frag_list;
@@ -6863,7 +6862,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_clone_fraglist(skb);
 
 	/* split line is in frag list */
-	if (k == 0 && pskb_carve_frag_list(skb, shinfo, off - pos, gfp_mask)) {
+	if (k == 0 && pskb_carve_frag_list(shinfo, off - pos, gfp_mask)) {
 		/* skb_frag_unref() is not needed here as shinfo->nr_frags = 0. */
 		if (skb_has_frag_list(skb))
 			kfree_skb_list(skb_shinfo(skb)->frag_list);

-- 
2.49.0


