Return-Path: <linux-rdma+bounces-16661-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GRMAjSQhmlwOwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16661-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:07:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716B104693
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA61A3062C53
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071623C8A0;
	Sat,  7 Feb 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl5WQ7Mq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD022B8C5
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426351; cv=none; b=tlkPU7HCzW65cv8wG/ksrIMZy8ac3E0VAajYQgVDh+hOWh0kRqWXN93dWPvOioomvV0ielRcukrwrnzA6HjYUIT8KhxcSxegA3tslgLrt7uH0vFBsn4GsMqUDYyxuNGsVEbguLIm7XkbNo6cIIb0Ee3PUnP8cyVvFhiqvE4waeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426351; c=relaxed/simple;
	bh=S4lPJ+iQ6cr7r0HHk+6ImMlHSzuyYglfEyCilMTXMl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lecprdd02uvR+ZIRj9W/rzWU6OXya4GvrfglY69LWaWGkot0nRGRgvElriWGLWMMO4hVDQz3ngOO7FDwFvxHcdJHaIVQ0VXduqllSqSUaU77qKkoAYTeZGCRss33tHir/d16U3gA0NQ5WRD6QJSZJJqjniPJLKQapL1tH/GXuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl5WQ7Mq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so28263805e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 17:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426349; x=1771031149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WAb0jC5Pe9hgQVEU9ZMU3ZkVCoRfT6/PkrPXHX5Zeg=;
        b=hl5WQ7Mq5MDrXSz+/SPPMxikUJCCyaG1H6VYyH5tmbQ3xqdHXXL7+S49IDZxL1qfGA
         MtX2qZsht9EErFL9qilIwxnDI6cKe5yPwxECm0KrBQB/068M/AhP66rZUm/G+1dggfll
         RCAW0ptsMe5kU34Et7GDdT/C3mRue+mQBP7NZZQB8Ln+Qg5LBrEghG5sxmAKFEufrzvR
         zf/8HksQeslqaef+tw1jMUTQsjW+epSd1h7warqaqSuV+XPuRwkuh1L8ZrN0aER1B6GG
         oe0qgkc0x8SYdKvNqSqJrBGi9lc38HWUkOa7m1B5KQFmKkc7cX8cmhXjR6dCrFVibDuK
         RBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426349; x=1771031149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WAb0jC5Pe9hgQVEU9ZMU3ZkVCoRfT6/PkrPXHX5Zeg=;
        b=rvOk3NKxA3mhPQgHq4ncTknvob9I2NQE9xqbO8w13Nvl96nx+1WMiRTR0504jw+YGn
         vPuSt8848fSBhaB8ATyBE2tvX3Cq2okCx7gvjVLBVt9S1IJSW01YhWmN3UUx9ejLYd4X
         pOlxTUgkvgwqXPurFeQy61k0sNWWG4B/J5ztsI9ByqEYm3p5JgAb/u/A7vZGC/SJxKl9
         0f9Ct6hJLB3Y3agi1DQePisxd4NHYjYYdkgSFhxLMEOeHUykRBVZRQsows1ei751IN9b
         xRtePEVGHycjutXRUF584H2nsMznFpgiU8v49WWWnmQkiX6oF9+nYLmK4aBVxJSgSYIb
         Yczw==
X-Forwarded-Encrypted: i=1; AJvYcCXXwDujJuh++JL0pxdp2wyLwtWEeqPFr62rLZOV1JGlIcRmEbAvRR0q7RkZ1uQDWIASotFpgYjBAwm2@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDvHniQjk2fbWOz6vp0WOE6y2dpvu32JYe8dK0yFUYPJu6tu5
	BMeiCWUqed3oi9egYeK28wspMyyeozFqXlcSRDK92IGndo8/Emt4S+pW
X-Gm-Gg: AZuq6aKTZAKA++u6cRwErlcn8TA/fg7v/s3IZs0Mc1cLl/Ps55XWQKGASqiWNBQLndd
	Tr/rK4r1P6BXKvrOMGfwgoDyuI/280OxiJ4gIyvbWP9wNovtlXVjyqPrExNmOWpouSCSv54yqWf
	zj/CPQdnmqRfrfL4nwFuWBvi0S15IveM8qBue7DKifYNgzDmBQaO75jYJ4lKP7/MzvvDNpsmDMx
	zGP+NYhje5Y7MWO5qnf/MbzZ6niJKdF+yO2iaFRs1LbunIqtXDyzzvliUjcFQRiH/LhXxnnwWV6
	Bk7NwwaY4pIlc62JlqIbFMFKf4TMFAGA60sRPj3pHH3aQbn/4471GO2vGTNXshdMMrMfWixcrNf
	iZJ0O3j/xhqImKBR7TDCjOsLUsHJD+Go7hw5R1KdAFizk532ojById+OS8gBQpl9jmn+Y1qJ2Ir
	0CEywNhgBp
X-Received: by 2002:a05:600c:c4a7:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-48320231161mr57802305e9.23.1770426348870;
        Fri, 06 Feb 2026 17:05:48 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961505sm58442315e9.4.2026.02.06.17.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:48 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
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
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 5/5] eth: mlx5: Move pause storm errors to pause stats
Date: Fri,  6 Feb 2026 17:05:25 -0800
Message-ID: <20260207010525.3808842-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16661-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5716B104693
X-Rspamd-Action: no action

Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
the ethtool_pause_stats struct. This counter tracks pause storm error
events which indicate the NIC has been sending pause frames for an
extended period due to a stall.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a8af84fc9763..2fe779c164e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -916,6 +916,23 @@ static int mlx5e_stats_get_ieee(struct mlx5_core_dev *mdev,
 				    sz, MLX5_REG_PPCNT, 0, 0);
 }
 
+static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
+				    u32 *ppcnt_per_prio)
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
+	MLX5_SET(ppcnt_reg, in, prio_tc, 0);
+	return mlx5_core_access_reg(mdev, in, sz, ppcnt_per_prio, sz,
+				    MLX5_REG_PPCNT, 0, 0);
+}
+
 void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 			   struct ethtool_pause_stats *pause_stats)
 {
@@ -933,6 +950,14 @@ void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
 				      eth_802_3_cntrs_grp_data_layout,
 				      a_pause_mac_ctrl_frames_received);
+
+	if (mlx5e_stats_get_per_prio(mdev, ppcnt_ieee_802_3))
+		return;
+
+	pause_stats->tx_pause_storm_events =
+		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
+				      eth_per_prio_grp_data_layout,
+				      device_stall_critical_watermark_cnt);
 }
 
 void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,
-- 
2.47.3


