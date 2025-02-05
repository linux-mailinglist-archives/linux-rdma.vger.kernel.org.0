Return-Path: <linux-rdma+bounces-7460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D81A298B5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E555168DF8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF1F1FE46C;
	Wed,  5 Feb 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYfe2IX4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180713D897;
	Wed,  5 Feb 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779658; cv=none; b=L0P+oT+Izra/YNnXMM9jPzQsq/Rxr8mewt+g3sOHpjh58ywWpnhgJ5Pfq94dXYcVMBlyY5woDN/Cs7o+eLBry2mllOaPsN/HqeK3Sw0kEDN1X0Ufk9gKo4wVaoU60u4ZrmEmDDmikWFmPJpyUIRn2KK1x+6W3xpQj0w6meRtIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779658; c=relaxed/simple;
	bh=r597A/mrJflwwdNJJ4+diLkn7fbJg1NeWa572JQU1lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUXezYm28VIRNSv5VIXofbfvOVqDjaS6CCY1AHSZmUuKTm+KT8eYtFO2lFqgez478T+LcAQ7oprSUOyy8UHLFh0caI0TP6oECtQnMy7Ixqy3RckYsT44ZUoZ8frottP8qVMnH1kFm+NjCIOqr3rMAdCyuMdrTNuD40JjhVhRNeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYfe2IX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B24C4CED1;
	Wed,  5 Feb 2025 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779657;
	bh=r597A/mrJflwwdNJJ4+diLkn7fbJg1NeWa572JQU1lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYfe2IX4HHbHPFfeTLqPwyEVtvpFDLtQ00dxIz1HjgifTX5I+ow4/9aoj5Q7bwSGw
	 mc+2+jPV2QpDJtcj6EPEFG4kTsO1y2HN5YfDVQ7ZdVuk3umAK0mpzO7VhPz1fVGnwl
	 UVG+SW389mHoZR649iKJxBV0xu2WinFdAIVeSj+EJeKtsANxOr2l0Vfsqqt670ttpK
	 f2OE6CNM6O/JsY9XrN6k/Ja0YWNwG7Lu1oNMZe4ITunBeFS77VdjchkrLXqSEOadJ7
	 eAuQ829nfbzkHAZu2M3RdiHZL5yoFzXOfDPrQfKsvy9P2/f1hYird3LIvLqhavDz+h
	 pYaCG+Vj3IFDQ==
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
Subject: [PATCH ipsec-next 3/5] xfrm: rely on XFRM offload
Date: Wed,  5 Feb 2025 20:20:22 +0200
Message-ID: <3de0445fa7bf53af388bb8d05faf60e3deb81dc2.1738778580.git.leon@kernel.org>
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

After change of initialization of x->type_offload pointer to be valid
only for offloaded SAs. There is no need to rely both on x->type_offload
and x->xso.type to determine if SA is offloaded or not.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index e01a7f5a4c75..c3c170953bf9 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -420,13 +420,11 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload ||
-	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
+	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-	    ((!dev || (dev == xfrm_dst_path(dst)->dev)) &&
-	     !xdst->child->xfrm)) {
+	    ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm)) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -438,8 +436,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
-	if (dev && dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_offload_ok)
-		return x->xso.dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
+	if (dev->xfrmdev_ops->xdo_dev_offload_ok)
+		return dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
 
 	return true;
 }
-- 
2.48.1


