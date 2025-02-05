Return-Path: <linux-rdma+bounces-7456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FD8A298A6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A707B16860C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657C1FDA6F;
	Wed,  5 Feb 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld9JbwwK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93E1779AE;
	Wed,  5 Feb 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779643; cv=none; b=EvtJoqRHRUQye5zCTbkFi+7FufwYm3M/5cH5KW8Mnd68Y1cqa53Wgm8wGQJXLJvP6GZJoiOfSXz9FJmIcrtxZ5Wg2Mu+coeo5UC10DuQBv54QIKA2cC177iIGxxAIK7gM4Kiohu0xPgmy3WMd1hDc/VnMrUFNGTXVfWVKzWXcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779643; c=relaxed/simple;
	bh=+WzVacljqHxj5GBlQNM3bFZCFWBWaUCVOUNxhX10Fg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAxdROcs5tGswuKvzrNWAnzfENEBCsSSjlHPwZ77TTWGs74+uW0BTG7PwAXJAPuzlIy2bQVMHEpy6yfrMVvagLxt7/gsGO8jjz5uHE2R4sV8lFUTih/8zXGbwICmQBVA843ijvZz+eSM0A/ykVje774VdqLd+gmDEsDlZp21BU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld9JbwwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E33AC4CED1;
	Wed,  5 Feb 2025 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779643;
	bh=+WzVacljqHxj5GBlQNM3bFZCFWBWaUCVOUNxhX10Fg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld9JbwwK/vcqJUGUReuMAgzHgwpJ13/ZE82uf/9a1y2Y/UL8cyaMRTS2hsHHF8bqD
	 ABtlq8JwsyVjx2EqrcLErmAt29hA/CfOn63ZFEJdDsVslQVSEud8yb9QXkV+vWHNKy
	 ytyk8NQ5QrkNdq/3siAYlUvTeK5y8W1f1MU2XC0Z4Y9/2xySyuOimQCjjqav9s1ULN
	 fL2AFK0eM3nEtxLwHn/7sQ7L46NtaPYyIipD3NHp+0OdIuA/RC7/1/LfaZtbZ1fY7L
	 +nn374ByaDDzoviPuhnJ2TIJEqvHCru/HZY41lnH6r9U7cvY8w+G7B07rH7hkGHvjb
	 Y7HuKCL2a8Yqw==
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
Subject: [PATCH ipsec-next 1/5] xfrm: delay initialization of offload path till its actually requested
Date: Wed,  5 Feb 2025 20:20:20 +0200
Message-ID: <e536ca28cd1686dfbb613de7ccfc01fbe5a734e4.1738778580.git.leon@kernel.org>
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

XFRM offload path is probed even if offload isn't needed at all. Let's
make sure that x->type_offload pointer stays NULL for such path to
reduce ambiguity.

Fixes: 9d389d7f84bb ("xfrm: Add a xfrm type offload.")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     | 12 +++++++++++-
 net/xfrm/xfrm_device.c | 14 +++++++++-----
 net/xfrm/xfrm_state.c  | 22 +++++++++-------------
 net/xfrm/xfrm_user.c   |  2 +-
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77..28355a5be5b9 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -464,6 +464,16 @@ struct xfrm_type_offload {
 
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
+const struct xfrm_type_offload *xfrm_get_type_offload(u8 proto,
+						      unsigned short family);
+static inline void xfrm_put_type_offload(const struct xfrm_type_offload *type)
+{
+	if (!type)
+		return;
+
+	module_put(type->owner);
+}
+
 
 /**
  * struct xfrm_mode_cbs - XFRM mode callbacks
@@ -1760,7 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
+int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 		      struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d1fa94e52cea..e01a7f5a4c75 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -244,11 +244,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	xfrm_address_t *daddr;
 	bool is_packet_offload;
 
-	if (!x->type_offload) {
-		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
-		return -EINVAL;
-	}
-
 	if (xuo->flags &
 	    ~(XFRM_OFFLOAD_IPV6 | XFRM_OFFLOAD_INBOUND | XFRM_OFFLOAD_PACKET)) {
 		NL_SET_ERR_MSG(extack, "Unrecognized flags in offload request");
@@ -310,6 +305,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
+	x->type_offload = xfrm_get_type_offload(x->id.proto, x->props.family);
+	if (!x->type_offload) {
+		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
+		dev_put(dev);
+		return -EINVAL;
+	}
+
 	xso->dev = dev;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 	xso->real_dev = dev;
@@ -332,6 +334,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		netdev_put(dev, &xso->dev_tracker);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 
+		xfrm_put_type_offload(x->type_offload);
+		x->type_offload = NULL;
 		/* User explicitly requested packet offload mode and configured
 		 * policy in addition to the XFRM state. So be civil to users,
 		 * and return an error instead of taking fallback path.
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f3..568fe8df7741 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,11 +424,12 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);
 
-static const struct xfrm_type_offload *
-xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
+const struct xfrm_type_offload *xfrm_get_type_offload(u8 proto,
+						      unsigned short family)
 {
 	const struct xfrm_type_offload *type = NULL;
 	struct xfrm_state_afinfo *afinfo;
+	bool try_load = true;
 
 retry:
 	afinfo = xfrm_state_get_afinfo(family);
@@ -456,11 +457,7 @@ xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
 
 	return type;
 }
-
-static void xfrm_put_type_offload(const struct xfrm_type_offload *type)
-{
-	module_put(type->owner);
-}
+EXPORT_SYMBOL(xfrm_get_type_offload);
 
 static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
 	[XFRM_MODE_BEET] = {
@@ -609,8 +606,6 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	kfree(x->coaddr);
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
-	if (x->type_offload)
-		xfrm_put_type_offload(x->type_offload);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -784,6 +779,9 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = READ_ONCE(xso->dev);
 
+	xfrm_put_type_offload(x->type_offload);
+	x->type_offload = NULL;
+
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
@@ -3122,7 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
+int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 		      struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
@@ -3178,8 +3176,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
 		goto error;
 	}
 
-	x->type_offload = xfrm_get_type_offload(x->id.proto, family, offload);
-
 	err = x->type->init_state(x, extack);
 	if (err)
 		goto error;
@@ -3229,7 +3225,7 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, false, NULL);
+	err = __xfrm_init_state(x, true, NULL);
 	if (!err)
 		x->km.state = XFRM_STATE_VALID;
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..82a768500999 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
+	err = __xfrm_init_state(x, false, extack);
 	if (err)
 		goto error;
 
-- 
2.48.1


