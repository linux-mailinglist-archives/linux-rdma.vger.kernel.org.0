Return-Path: <linux-rdma+bounces-7458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E2A298AF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7671685E4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22AE1FCFF6;
	Wed,  5 Feb 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glcwH6V7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E51FC7D5;
	Wed,  5 Feb 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779650; cv=none; b=PbGMyesaoVAxMDKMNEi5mbdI0g9x6fG9OO6Vw7VUYigEjbNqHxGZHY9dmKYaKkPIX5000dhZmdZzScYDnGiavZmltQogECOaW3ivRBtRHVm5rAUxRXhH1TrpR2DJo8nc9AD2cw4XLaqHX36RFYg1Ozgu7f29t9/BD0s+AM8bLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779650; c=relaxed/simple;
	bh=y8ED1oiflhCBirydeBKMwNxM5q/PaxlenTyfj4e9oRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiJ31g3REUBARwvvm3dkw8d/0M4b7aDtdUmgCa3jOBgqdrfRafg/uTONf3YfPVks/j1g9AdxY1n8R/E2sY/tombbaupy/PNyC95iEVOAeAuEXwBj2F6zMJV2m/4nkT6S8alxCod2YxgBDYP2ToRnUaCE0X3RAHPjSfSt1G1tjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glcwH6V7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF866C4CED1;
	Wed,  5 Feb 2025 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779650;
	bh=y8ED1oiflhCBirydeBKMwNxM5q/PaxlenTyfj4e9oRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glcwH6V7RxNXLEw7NSXudPU0fQ5ZrFAb6jMheu+Tdkijfy04B6F4ud9vqRXl2v0Y5
	 ayog9xn9Zq3fR1vkemBM08aUDLpqKtvx2EmYv4oZNrFlBf95RENB+WYgn0YVdqfmKz
	 v5g8X0YYZel/QJrg/9zJU2p6IztM0TdOoYbheHll53h3PW50VwMvFeCxZVfjuyHD5D
	 qhOk4fhR34pGgjwLC3sLwGpE5pCtfDCSr8Ll9gmNyssxY6GRbIgXo9L+Xo/fUMst/D
	 GUwUO/4/c3DBgABkyU0c6pECzD1lT1vjS2+j2sFB+FBYRnunC0HhZfaT551QiZBPWX
	 8mrPMwszIwjJg==
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
Subject: [PATCH ipsec-next 4/5] xfrm: provide common xdo_dev_offload_ok callback implementation
Date: Wed,  5 Feb 2025 20:20:23 +0200
Message-ID: <d2aa8f840b0c81e33239e2a4b126730ae40864f1.1738778580.git.leon@kernel.org>
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

Almost all drivers except bond and nsim had same check if device
can perform XFRM offload on that specific packet. The check was that
packet doesn't have IPv4 options and IPv6 extensions.

In NIC drivers, the IPv4 HELEN comparison was slightly different, but
the intent was to check for the same conditions. So let's chose more
strict variant as a common base.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/networking/xfrm_device.rst      |  3 ++-
 drivers/net/bonding/bond_main.c               | 16 +++++---------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 21 -------------------
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 16 --------------
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 21 -------------------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 -------------------
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 15 -------------
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 16 --------------
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 ----------
 drivers/net/netdevsim/ipsec.c                 | 11 ----------
 drivers/net/netdevsim/netdevsim.h             |  1 -
 net/xfrm/xfrm_device.c                        | 15 +++++++++++++
 12 files changed, 22 insertions(+), 145 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 66f6e9a9b59a..39bb98939d1f 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -126,7 +126,8 @@ been setup for offload, it first calls into xdo_dev_offload_ok() with
 the skb and the intended offload state to ask the driver if the offload
 will serviceable.  This can check the packet information to be sure the
 offload can be supported (e.g. IPv4 or IPv6, no IPv4 options, etc) and
-return true of false to signify its support.
+return true of false to signify its support. In case driver doesn't implement
+this callback, the stack provides reasonable defaults.
 
 Crypto offload mode:
 When ready to send, the driver needs to inspect the Tx packet for the
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..bfb55c23380b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -676,22 +676,16 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	bool ok = false;
 
 	rcu_read_lock();
 	real_dev = bond_ipsec_dev(xs);
-	if (!real_dev)
-		goto out;
-
-	if (!real_dev->xfrmdev_ops ||
-	    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
-	    netif_is_bond_master(real_dev))
-		goto out;
+	if (!real_dev || netif_is_bond_master(real_dev)) {
+		rcu_read_unlock();
+		return false;
+	}
 
-	ok = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
-out:
 	rcu_read_unlock();
-	return ok;
+	return true;
 }
 
 /**
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2f0b3e389e62..551c279dc14b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6538,26 +6538,6 @@ static void cxgb4_xfrm_free_state(struct xfrm_state *x)
 	mutex_unlock(&uld_mutex);
 }
 
-static bool cxgb4_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
-{
-	struct adapter *adap = netdev2adap(x->xso.dev);
-	bool ret = false;
-
-	if (!mutex_trylock(&uld_mutex)) {
-		dev_dbg(adap->pdev_dev,
-			"crypto uld critical resource is under use\n");
-		return ret;
-	}
-	if (chcr_offload_state(adap, CXGB4_XFRMDEV_OPS))
-		goto out_unlock;
-
-	ret = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_offload_ok(skb, x);
-
-out_unlock:
-	mutex_unlock(&uld_mutex);
-	return ret;
-}
-
 static void cxgb4_advance_esn_state(struct xfrm_state *x)
 {
 	struct adapter *adap = netdev2adap(x->xso.dev);
@@ -6583,7 +6563,6 @@ static const struct xfrmdev_ops cxgb4_xfrmdev_ops = {
 	.xdo_dev_state_add      = cxgb4_xfrm_add_state,
 	.xdo_dev_state_delete   = cxgb4_xfrm_del_state,
 	.xdo_dev_state_free     = cxgb4_xfrm_free_state,
-	.xdo_dev_offload_ok     = cxgb4_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = cxgb4_advance_esn_state,
 };
 
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index c7338ac6a5bb..baba96883f48 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -71,7 +71,6 @@
 static LIST_HEAD(uld_ctx_list);
 static DEFINE_MUTEX(dev_mutex);
 
-static bool ch_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x);
 static int ch_ipsec_uld_state_change(void *handle, enum cxgb4_state new_state);
 static int ch_ipsec_xmit(struct sk_buff *skb, struct net_device *dev);
 static void *ch_ipsec_uld_add(const struct cxgb4_lld_info *infop);
@@ -85,7 +84,6 @@ static const struct xfrmdev_ops ch_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_add      = ch_ipsec_xfrm_add_state,
 	.xdo_dev_state_delete   = ch_ipsec_xfrm_del_state,
 	.xdo_dev_state_free     = ch_ipsec_xfrm_free_state,
-	.xdo_dev_offload_ok     = ch_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = ch_ipsec_advance_esn_state,
 };
 
@@ -323,20 +321,6 @@ static void ch_ipsec_xfrm_free_state(struct xfrm_state *x)
 	module_put(THIS_MODULE);
 }
 
-static bool ch_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
-{
-	if (x->props.family == AF_INET) {
-		/* Offload with IP options is not supported yet */
-		if (ip_hdr(skb)->ihl > 5)
-			return false;
-	} else {
-		/* Offload with IPv6 extension headers is not support yet */
-		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
-			return false;
-	}
-	return true;
-}
-
 static void ch_ipsec_advance_esn_state(struct xfrm_state *x)
 {
 	/* do nothing */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 866024f2b9ee..07ea1954a276 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -817,30 +817,9 @@ static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
 	}
 }
 
-/**
- * ixgbe_ipsec_offload_ok - can this packet use the xfrm hw offload
- * @skb: current data packet
- * @xs: pointer to transformer state struct
- **/
-static bool ixgbe_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
-{
-	if (xs->props.family == AF_INET) {
-		/* Offload with IPv4 options is not supported yet */
-		if (ip_hdr(skb)->ihl != 5)
-			return false;
-	} else {
-		/* Offload with IPv6 extension headers is not support yet */
-		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
-			return false;
-	}
-
-	return true;
-}
-
 static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
 	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
 	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
-	.xdo_dev_offload_ok = ixgbe_ipsec_offload_ok,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index f804b35d79c7..8ba037e3d9c2 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -428,30 +428,9 @@ static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
 	}
 }
 
-/**
- * ixgbevf_ipsec_offload_ok - can this packet use the xfrm hw offload
- * @skb: current data packet
- * @xs: pointer to transformer state struct
- **/
-static bool ixgbevf_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
-{
-	if (xs->props.family == AF_INET) {
-		/* Offload with IPv4 options is not supported yet */
-		if (ip_hdr(skb)->ihl != 5)
-			return false;
-	} else {
-		/* Offload with IPv6 extension headers is not support yet */
-		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
-			return false;
-	}
-
-	return true;
-}
-
 static const struct xfrmdev_ops ixgbevf_xfrmdev_ops = {
 	.xdo_dev_state_add = ixgbevf_ipsec_add_sa,
 	.xdo_dev_state_delete = ixgbevf_ipsec_del_sa,
-	.xdo_dev_offload_ok = ixgbevf_ipsec_offload_ok,
 };
 
 /**
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 09a5b5268205..fc59e50bafce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -744,24 +744,9 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
 		queue_work(pf->ipsec.sa_workq, &pf->ipsec.sa_work);
 }
 
-static bool cn10k_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
-{
-	if (x->props.family == AF_INET) {
-		/* Offload with IPv4 options is not supported yet */
-		if (ip_hdr(skb)->ihl > 5)
-			return false;
-	} else {
-		/* Offload with IPv6 extension headers is not support yet */
-		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
-			return false;
-	}
-	return true;
-}
-
 static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_add	= cn10k_ipsec_add_state,
 	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
-	.xdo_dev_offload_ok	= cn10k_ipsec_offload_ok,
 };
 
 static void cn10k_ipsec_sa_wq_handler(struct work_struct *work)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 501709ac310f..3b81e7b8ce23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -953,21 +953,6 @@ void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv)
 	priv->ipsec = NULL;
 }
 
-static bool mlx5e_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
-{
-	if (x->props.family == AF_INET) {
-		/* Offload with IPv4 options is not supported yet */
-		if (ip_hdr(skb)->ihl > 5)
-			return false;
-	} else {
-		/* Offload with IPv6 extension headers is not support yet */
-		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
-			return false;
-	}
-
-	return true;
-}
-
 static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
@@ -1196,7 +1181,6 @@ static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_add	= mlx5e_xfrm_add_state,
 	.xdo_dev_state_delete	= mlx5e_xfrm_del_state,
 	.xdo_dev_state_free	= mlx5e_xfrm_free_state,
-	.xdo_dev_offload_ok	= mlx5e_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = mlx5e_xfrm_advance_esn_state,
 
 	.xdo_dev_state_update_stats = mlx5e_xfrm_update_stats,
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index 515069d5637b..671af5d4c5d2 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -565,20 +565,9 @@ static void nfp_net_xfrm_del_state(struct xfrm_state *x)
 	xa_erase(&nn->xa_ipsec, x->xso.offload_handle - 1);
 }
 
-static bool nfp_net_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
-{
-	if (x->props.family == AF_INET)
-		/* Offload with IPv4 options is not supported yet */
-		return ip_hdr(skb)->ihl == 5;
-
-	/* Offload with IPv6 extension headers is not support yet */
-	return !(ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr));
-}
-
 static const struct xfrmdev_ops nfp_net_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_add = nfp_net_xfrm_add_state,
 	.xdo_dev_state_delete = nfp_net_xfrm_del_state,
-	.xdo_dev_offload_ok = nfp_net_ipsec_offload_ok,
 };
 
 void nfp_net_ipsec_init(struct nfp_net *nn)
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 88187dd4eb2d..d88bdb9a1717 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -217,20 +217,9 @@ static void nsim_ipsec_del_sa(struct xfrm_state *xs)
 	ipsec->count--;
 }
 
-static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
-{
-	struct netdevsim *ns = netdev_priv(xs->xso.real_dev);
-	struct nsim_ipsec *ipsec = &ns->ipsec;
-
-	ipsec->ok++;
-
-	return true;
-}
-
 static const struct xfrmdev_ops nsim_xfrmdev_ops = {
 	.xdo_dev_state_add	= nsim_ipsec_add_sa,
 	.xdo_dev_state_delete	= nsim_ipsec_del_sa,
-	.xdo_dev_offload_ok	= nsim_ipsec_offload_ok,
 };
 
 bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 96d54c08043d..ca8f1a620044 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -54,7 +54,6 @@ struct nsim_ipsec {
 	struct dentry *pfile;
 	u32 count;
 	u32 tx;
-	u32 ok;
 };
 
 #define NSIM_MACSEC_MAX_SECY_COUNT 3
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index c3c170953bf9..056df0e69d73 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -436,6 +436,21 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
+	switch (x->props.family) {
+	case AF_INET:
+		/* Check for IPv4 options */
+		if (ip_hdr(skb)->ihl != 5)
+			return false;
+		break;
+	case AF_INET6:
+		/* Check for IPv6 extensions */
+		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
+			return false;
+		break;
+	default:
+		break;
+	}
+
 	if (dev->xfrmdev_ops->xdo_dev_offload_ok)
 		return dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
 
-- 
2.48.1


