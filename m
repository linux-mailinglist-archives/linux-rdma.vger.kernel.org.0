Return-Path: <linux-rdma+bounces-7457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7FEA298AB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1FF168518
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CCC1779AE;
	Wed,  5 Feb 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1iuvS49"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5571FCD1F;
	Wed,  5 Feb 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779647; cv=none; b=HzgY+Q/gDyQAgkrp4VdGohx7pCx9YX8SmYtkgl0xlSozMzscDRy36PmOyJGdQZu1bB+2gcrStTW35hAijEFKqPdDVUHF2GoDmDBgk1e8i+ucLK2Uq6AYgvmske/EGROpDMyrXccZ+8LMkijK9PqrVTOyUb2fnddyiWhoOW7U/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779647; c=relaxed/simple;
	bh=SCHohVyocop9U+D74KyFZpzTnEVgZWU7PjsASmySSzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USEEMeZhC2Y35faEe8wL3mXOTOKNaYw/geIS7KaE/eSBW7UgRb0Wk1YD6JCjnxVwUzZ7pyIoHk5KB8D/Pooi3LuI6QqifyUEQoxsVDD4oUpvxqi6XBCX6SjKViQasENTWZjj70iskrFxKqRdppljRqBjuUEtf3gUaLs3mf+tYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1iuvS49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225E0C4CED1;
	Wed,  5 Feb 2025 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779646;
	bh=SCHohVyocop9U+D74KyFZpzTnEVgZWU7PjsASmySSzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1iuvS49G1SDbHxveO9HoPx5m3rmJtLOJdGmWJMQ9/21Hexh7fVrleuNrcgZ432uI
	 YJEcoV8QE/Pp+pkCnfkcWIkEwojbWPXglG3/X2sRYOIqqIuEpiIgaUqrnDi5Iw9IRU
	 29O/kwkv4enT7RceufiDOKsIKMqVOb7ruuTCK4UsMS5FpUZeB/Ug9fdqePEljqpTSe
	 QGDaiAQUIffTuRcIUOuutEjTBpu3TTAXjEwx6ck1mX1iwCXGt7adTwgjPcUlrbZcCC
	 j89PhLZE+CsL0cTzDa0PbRD8HzC3YvH8YXjXhwBYgupCGHXDd1GKGlXrF6wOA6sp9U
	 5RRHAAYTvalNg==
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
Subject: [PATCH ipsec-next 2/5] xfrm: simplify SA initialization routine
Date: Wed,  5 Feb 2025 20:20:21 +0200
Message-ID: <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
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

SA replay mode is initialized differently for user-space and
kernel-space users, but the call to xfrm_init_replay() existed in
common path with boolean protection. That caused to situation where
we have two different function orders.

So let's rewrite the SA initialization flow to have same order for
both in-kernel and user-space callers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h    |  3 +--
 net/xfrm/xfrm_state.c | 22 ++++++++++------------
 net/xfrm/xfrm_user.c  |  2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 28355a5be5b9..58f8f7661ec4 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1770,8 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack);
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 568fe8df7741..42799b0946a3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack)
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
 	const struct xfrm_mode *outer_mode;
@@ -3188,12 +3187,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 	}
 
 	x->outer_mode = *outer_mode;
-	if (init_replay) {
-		err = xfrm_init_replay(x, extack);
-		if (err)
-			goto error;
-	}
-
 	if (x->nat_keepalive_interval) {
 		if (x->dir != XFRM_SA_DIR_OUT) {
 			NL_SET_ERR_MSG(extack, "NAT keepalive is only supported for outbound SAs");
@@ -3225,11 +3218,16 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, NULL);
-	if (!err)
-		x->km.state = XFRM_STATE_VALID;
+	err = __xfrm_init_state(x, NULL);
+	if (err)
+		return err;
 
-	return err;
+	err = xfrm_init_replay(x, NULL);
+	if (err)
+		return err;
+
+	x->km.state = XFRM_STATE_VALID;
+	return 0;
 }
 
 EXPORT_SYMBOL(xfrm_init_state);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 82a768500999..d1d422f68978 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, extack);
+	err = __xfrm_init_state(x, extack);
 	if (err)
 		goto error;
 
-- 
2.48.1


