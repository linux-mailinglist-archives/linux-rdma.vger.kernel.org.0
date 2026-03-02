Return-Path: <linux-rdma+bounces-17408-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG9AOHYXpmkCKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17408-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:04:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E031E63ED
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D2E0302FE6A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEAA33E356;
	Mon,  2 Mar 2026 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9cQEyld"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761333E34B
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492534; cv=none; b=iaC2ZCcRfDjb98U7kgGPApAHuJt9TtlK9aND9MwMci2Okc6nNhO8D3GOE2vQKQGLaOHMSCH3OYPxp/TlkTdv1Uw6tlyDaiSX6BqgrRimBdLsU+xMCxtD4x8qznFvNoVZHD/FB9dC49QODskD3RmKiwfrH+ODMRW+jb+S8UAr8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492534; c=relaxed/simple;
	bh=wHA22cycksa6IDZI2mJjj3iKVXzbsLjK+WUo6mlt/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgmfXxYSFdXmcwFQfC74NfpSM7ivS3kAxC5cJ4v/xThh5DkQ8AfpbeYlukLQGAYxLIrsEXZnWyeUsyfw0j+3z0WK5Cjzb1bDrEvGy72eJlEh/wXMJ6K1EKgvFuZTrpVukrLqh9wBG5uVtnhkAMGai0ZxJbDc2FXJi23pKYjFfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9cQEyld; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so42176265e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 15:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772492532; x=1773097332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpu21j59crqNQYRnsgiGTYcfHJJE5cMtxeguSKrdFFk=;
        b=H9cQEyldBtPczwp2AdavCWGlmBP/JkbZrnAmbb1LdGDQbgsq9fQMI2OtVHtUvqCkQK
         HQwhxmZQyLPzGoQ2pgvpcO3EC5N87/Xygl2vkKJ2Na43BDXx2rrgkDH1sjDxoQTgs68C
         or38YMnYhaxGs8GhbEmoEcfL0GeFiPLGCmghOAiskDrCdJ5e8EQDWdnkx+8IsxBbNO4X
         RxF+9uD72/3FlzHvkXzQjhIY//GaEVpVoXb/tKobAS6I8S0Cf7sIJYAHKAu9oS4pN5rb
         /Tv0hVw5D/mcILMV5SLtNE/qo4hfg0bCtOVmJh/N/WYWSBd5v7AR+Dm8tp8gfp7Hw6+o
         Li6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772492532; x=1773097332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wpu21j59crqNQYRnsgiGTYcfHJJE5cMtxeguSKrdFFk=;
        b=a3nkE+BaEgbZFmCBLV5guH7OAne3/HbQADLtoxEj06iSMU59kacVdQdeooxLIwTdFn
         j7k1WeFHM4U8TDjjHJIZLtXRTi+x+uLGhSkmYKcRDs8RFPVxoi0055+et2fG7vzW9ksg
         1Ke0d7pCbYsCir8vCc/vOaQh3L6VvS6F1oc+Yf8hA9xow5/XE5KDQOFYRHKQbtEvY/4g
         PJVb72DWC5kaIlj03pD8PhhTj9FVMs4pvppghVrHPYYVxp3LH5LxzZl4rSjgghVU9y6e
         WuI7ilkAmjieLpF3saHe1fAs1qYttPBnrpBVck+Gic3TH4CjM4qf2s1SqAdZ1XM9bdUT
         2zmg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ydC6Lo82aAOHVnwXRuADiGp6qm+r6WaNpk9hiqFUfZVkMOsCkEXvbmFrbzFLuEWNAPOvjDPL8PtK@vger.kernel.org
X-Gm-Message-State: AOJu0Yybda2dAgK2qw4Kn6j6PkWwRa1Fip4l7NoACHn/xFxtKbfA/GVk
	yvV2zzyMahMKAhiK6vaCDVNRdIkcgNNHd6QPNqxlMg4lzvsLzAb78xPP
X-Gm-Gg: ATEYQzwMK/axdVMl8orTqzurjhvcPRiE9Z2XfZw6BctQg952VEIVcTx2fim/D6pgb93
	iq0nRErq7o0vgJiGGLxiycTjJLzxt7LQd2aT7TzmCoAzqLrzY1vsqUlSTa4kp6CGVWEYs/34oXv
	7Ya+ocSC7F7GnpHhYNhRuZS28HCVY6kz5QIUwt827p5poBNqFQBqNvHWV4ZknYtM7DfXqPLB+IP
	B8k8Wp1kkYIHZnatYdu+bpAvzBQQIqZd2HMZ6Z4C2rLjL5S9nNTDiYrjKDc51fZvIc1NjBhzHbk
	HFezkRiaO9VqGLdqPCPwJytznA1koAI/TnHINVp4QGLwjI0sKofI5f61wVTmERFhghiozzt+mHf
	2CHMSu3qeRMU7QHltmcx+d10hoemugKxxPTz5e9Rvfu4xMkdDd8Fwp2JFbUNYocXo6sIS/Uu5eq
	uFvx3STDqYAMielCuEwjbl
X-Received: by 2002:a05:600c:3b02:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-483c9bedac6mr233724865e9.26.1772492528301;
        Mon, 02 Mar 2026 15:02:08 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:10::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b4a121sm303002795e9.8.2026.03.02.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:02:07 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [net-next V4 5/5] eth: mlx5: Move pause storm errors to pause stats
Date: Mon,  2 Mar 2026 15:01:49 -0800
Message-ID: <20260302230149.1580195-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8E031E63ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17408-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
the ethtool_pause_stats struct. This counter tracks pause storm error
events which indicate the NIC has been sending pause frames for an
extended period due to a stall.

The ethtool_pause_stats struct reports these stalls as a single value,
whereas the device supports tracking them per priority. Aggregate the
counter across all priority classes to capture stalls on all priorities.
Note that the stats are fetched from the device for each priority via
mlx5_core_access_reg().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a8af84fc9763..1a3ecf073913 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -916,11 +916,30 @@ static int mlx5e_stats_get_ieee(struct mlx5_core_dev *mdev,
 				    sz, MLX5_REG_PPCNT, 0, 0);
 }
 
+static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
+				    u32 *ppcnt_per_prio, int prio)
+{
+	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
+	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
+
+	if (!(MLX5_CAP_PCAM_FEATURE(mdev, pfcc_mask) &&
+	      MLX5_CAP_DEBUG(mdev, stall_detect)))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(ppcnt_reg, in, local_port, 1);
+	MLX5_SET(ppcnt_reg, in, grp, MLX5_PER_PRIORITY_COUNTERS_GROUP);
+	MLX5_SET(ppcnt_reg, in, prio_tc, prio);
+	return mlx5_core_access_reg(mdev, in, sz, ppcnt_per_prio, sz,
+				    MLX5_REG_PPCNT, 0, 0);
+}
+
 void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 			   struct ethtool_pause_stats *pause_stats)
 {
 	u32 ppcnt_ieee_802_3[MLX5_ST_SZ_DW(ppcnt_reg)];
 	struct mlx5_core_dev *mdev = priv->mdev;
+	u64 ps_stats = 0;
+	int prio;
 
 	if (mlx5e_stats_get_ieee(mdev, ppcnt_ieee_802_3))
 		return;
@@ -933,6 +952,17 @@ void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
 				      eth_802_3_cntrs_grp_data_layout,
 				      a_pause_mac_ctrl_frames_received);
+
+	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
+		if (mlx5e_stats_get_per_prio(mdev, ppcnt_ieee_802_3, prio))
+			return;
+
+		ps_stats += MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
+						  eth_per_prio_grp_data_layout,
+						  device_stall_critical_watermark_cnt);
+	}
+
+	pause_stats->tx_pause_storm_events = ps_stats;
 }
 
 void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,
-- 
2.47.3


