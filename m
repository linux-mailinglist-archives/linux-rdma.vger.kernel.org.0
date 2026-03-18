Return-Path: <linux-rdma+bounces-18329-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNJpKanEumkNbwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18329-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:28:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C82BE318
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C08322A64B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FD3E5EE1;
	Wed, 18 Mar 2026 15:03:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643F3E4C90
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846202; cv=none; b=GyONUInl4GnPhOLjR8NmMHCsEM2gj1CUqMnW24t6Unoy0fcUBEXm42s4Jnu737txclV+yZLbeTpxztybMBHFWU6mVPgGU7MF5TTFlqWUETRyGlzQcC2rxJL7lxk5/QCzznvtH0U+O2cLuzWCeQQinCBxj4nJXyMj+ZV18NXPRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846202; c=relaxed/simple;
	bh=Ij7TGfORAQUP2IphsTU6e3s0rP33QZOjwA4GqRA7oq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2XOZ0oBeXLn3I9e6M5WIgLDrDXJt39wtykUVgJd6vZGcIabZQ5DhhcqigjyedfuIm9ek2T/+exrFPhuCgWnrOCNt/96gSxH7cKuSITT/Z7PMhbZmvuQL9xvMMN9f1zR7ILmyF+MhSeVw4dyHUZJ9kGIrJ3raaSRuQdO5KVtZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8345908eec.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846199; x=1774450999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ca+gBPWdaS3D9IVR2rmhybZb8dy4jn4+7E3W6do17GA=;
        b=nold80EW+m7p5vtD5FMzxwOajkOlSFxySSOI+mg5dfK716+DGtFrOU32Af0fUzpaZx
         gBKv2LIT5eUSr/Uswa2ypG2I9ZdDQVLTygNweCXV3DM0+879x8RLHsOGWyaSX+udnaDU
         QnsE4quyn5PE5awHlEqievRnjWpFoBHhmxoGm81RZxcaGsj0zbZoaLuJsb1uhzpmnXL8
         bOu9eA8avwDQ9jYFHoyF3q3rb2fOguq9jekB52RRV1bhYFanVqYg6JgzMsW31jbtuYSm
         N35nuAVjgn1Bwf9MMrjujCZoEu6VQ9jQQnuug115gJUuMPvysc1R3JFPg6tqTZMb6uoY
         Dkcw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZY5syn2B0muHRRU5O6yJQFZZgNkV3j2EVz7zU7yEhlpJSyybCbShho8L0d/JNpJr3d6gN9thLkaj@vger.kernel.org
X-Gm-Message-State: AOJu0YySb7dQYPhHc6oNqf3HH7/nmU1EZEd+IgBwzfQl2+GMhKGrGmjA
	4ys3f1exLouFV56hfUxMIMi2tAjIre18bBBfSYJuiq4nT46X4Da3oVU=
X-Gm-Gg: ATEYQzxXSHwqNxMqBhMcNlYBiJ0ZwyFqMwPGyiJNTaONfNrbF2GiZV/WCoIX0zjWDga
	MsEbDudL3zCIyLLtX4OEDbUA+uDfMQyixe4T/zR9tEiHteza2igc+ZTTPB0WT87RXEmpzhimYZ1
	vIZTZ0z6Fak2HRuFgnkwH2Qu4Ii5a4rz3t24tg+ReVR+HIeq2T/0RYZS2Eu4+i5lUx49mQpsFrt
	9BXbgwQzWXkK0cJrE7bEDJCOVe98o/972EZUIamF/GY1laTct+Z25g66oujdLgiBXvvWKqwVxFO
	Ju48s5/IIwvzCpOnc3dhGtzsR2PHa9x43mhv5NUYPKRhgUvb9xVGt2I3JGSKQzqn/ZsrfSK6OPU
	EdXHujcCK57a518LUjs6+eGskD6NCL6umEZMLby171dRJxw0RnRNJqnXhcMhvF67bgbULh5JXYc
	a+2c8yeUaJhDWQTicQVvuAoXIOMKruZrMchttRmx/DqV9EEGlcpeBe3+xDV50hbFUbC036aiWGZ
	WUY07yyHcf4qnex3A==
X-Received: by 2002:a05:7301:658a:b0:2ba:6978:2b4 with SMTP id 5a478bee46e88-2c0e519749fmr1615494eec.20.1773846195984;
        Wed, 18 Mar 2026 08:03:15 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ee672sm5054384eec.28.2026.03.18.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v2 06/13] mlx5: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:02:58 -0700
Message-ID: <20260318150305.123900-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18329-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	DMARC_NA(0.00)[fomichev.me];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.094];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 1D8C82BE318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
mlx5e_fs_set_rx_mode_work directly instead of queueing work.

mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

Fallback to netdev's uc/mc in a few places and grab addr lock.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 +++-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 30 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 16 +++++++---
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index c3408b3f7010..091b80a67189 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_nu
 void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
 int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_num);
 void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
-void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs, struct net_device *netdev);
+void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc);
 int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
 			     struct net_device *netdev,
 			     __be16 proto, u16 vid);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 9352e2183312..b6c6779f131c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -610,20 +610,26 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
 }
 
 static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
-				   struct net_device *netdev)
+				   struct net_device *netdev,
+				   struct netdev_hw_addr_list *uc,
+				   struct netdev_hw_addr_list *mc)
 {
 	struct netdev_hw_addr *ha;
 
-	netif_addr_lock_bh(netdev);
+	if (!uc || !mc) {
+		netif_addr_lock_bh(netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc, &netdev->mc);
+		netif_addr_unlock_bh(netdev);
+		return;
+	}
 
 	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
-	netdev_for_each_uc_addr(ha, netdev)
+
+	netdev_hw_addr_list_for_each(ha, uc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
 
-	netdev_for_each_mc_addr(ha, netdev)
+	netdev_hw_addr_list_for_each(ha, mc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
-
-	netif_addr_unlock_bh(netdev);
 }
 
 static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs, int list_type,
@@ -725,7 +731,9 @@ static void mlx5e_apply_netdev_addr(struct mlx5e_flow_steering *fs)
 }
 
 static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
-				     struct net_device *netdev)
+				     struct net_device *netdev,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_hash_node *hn;
 	struct hlist_node *tmp;
@@ -737,7 +745,7 @@ static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
 		hn->action = MLX5E_ACTION_DEL;
 
 	if (fs->state_destroy)
-		mlx5e_sync_netdev_addr(fs, netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
 
 	mlx5e_apply_netdev_addr(fs);
 }
@@ -821,7 +829,9 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 }
 
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
-			       struct net_device *netdev)
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_table *ea = &fs->l2;
 
@@ -851,7 +861,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	if (enable_broadcast)
 		mlx5e_add_l2_flow_rule(fs, &ea->broadcast, MLX5E_FULLMATCH);
 
-	mlx5e_handle_netdev_addr(fs, netdev);
+	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 
 	if (disable_broadcast)
 		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..e86cf1ee108d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4108,11 +4108,16 @@ static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
-static void mlx5e_set_rx_mode(struct net_device *dev)
+static void mlx5e_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	mlx5e_nic_set_rx_mode(priv);
+	if (mlx5e_is_uplink_rep(priv))
+		return; /* no rx mode for uplink rep */
+
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
 }
 
 static int mlx5e_set_mac(struct net_device *netdev, void *addr)
@@ -5287,7 +5292,7 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_setup_tc            = mlx5e_setup_tc,
 	.ndo_select_queue        = mlx5e_select_queue,
 	.ndo_get_stats64         = mlx5e_get_stats,
-	.ndo_set_rx_mode         = mlx5e_set_rx_mode,
+	.ndo_set_rx_mode_async   = mlx5e_set_rx_mode,
 	.ndo_set_mac_address     = mlx5e_set_mac,
 	.ndo_vlan_rx_add_vid     = mlx5e_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid    = mlx5e_vlan_rx_kill_vid,
@@ -6272,8 +6277,11 @@ void mlx5e_set_rx_mode_work(struct work_struct *work)
 {
 	struct mlx5e_priv *priv = container_of(work, struct mlx5e_priv,
 					       set_rx_mode_work);
+	struct net_device *dev = priv->netdev;
 
-	return mlx5e_fs_set_rx_mode_work(priv->fs, priv->netdev);
+	netdev_lock_ops(dev);
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, NULL, NULL);
+	netdev_unlock_ops(dev);
 }
 
 /* mlx5e generic netdev management API (move to en_common.c) */
-- 
2.53.0


