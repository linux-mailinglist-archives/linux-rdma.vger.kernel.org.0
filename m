Return-Path: <linux-rdma+bounces-17455-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XAkLHjOzp2k6jQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17455-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 05:21:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC61FAA8F
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 05:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 310473028F4E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 04:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F98D37F72F;
	Wed,  4 Mar 2026 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpFP9Yf8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584036495D
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598064; cv=none; b=AI5AzlU+GbEv4ge9Gxssvb0n51V+MtIJHZmNCOE1E0OQY6PttC1c3F6DlZoUIr3xURfzGrIWBHvnpoaZcYkRsP5QLyAenfhzEsiz+rQzPUx0MgKdnSKot0gtsveRwQ/9ciNW1Ja83vgI8bOu/XGtDP/FRFGwG+iKiX5ol1xvIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598064; c=relaxed/simple;
	bh=l4d6DC1THpFUrIjFAa1Siu6xdoT9cwAm9vhDbhIMKAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Drw0hSU2AVZeBN+KurCKpF8qESLuiMBPonbz0NWNhAWI7iAlIQGfYQkPPEsUFmIznuAm6MAAPqhev37uRoqmxchCl5qPLZUQPdExGunV7Zky9qL/7tcQClIm1fnzctxGp5xvpba+5hZvJDtZWbzSb0PwXgjSGnb/nZork3X9tU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpFP9Yf8; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79860421382so60587427b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2026 20:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772598062; x=1773202862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDy+kbw/8FC9faqHBjNSlqyFx7RPOn5A/oMrwXHhttk=;
        b=OpFP9Yf8fpmgqKTOYN+yj5TSXKFpKBtr6lH2dIDnQzgiZg+NSIl6HG3k2s08TdCqYL
         dPMSiXd+Vt1ulF8zoYeLo5Gd2lJVJfzkZlwL/RoRm0ojWgbxO9lA31HLWuqmgcDOxOJw
         lXUW4MJRdLXjkf3bqtpFnSPo1a5M1H+iRLDrZyu8zQAI6h2wOCD3kufG+g/n2YvTmVNa
         lWoE6jzBMUtXLPl/5OwP7wYHsYP19z8naUq28kdS1yLKRy5rL1PctfV4XBY3byKfHj2Y
         TAPeQ5h2Vr1rQa9sBvgswyzhgPZ4OChRY1t4KXonTouleazGPKLdwrooqri2AXQB1CXD
         7qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772598062; x=1773202862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDy+kbw/8FC9faqHBjNSlqyFx7RPOn5A/oMrwXHhttk=;
        b=vyuiTp8LX3BNvYXvAo1+0tXSg9kHPsZG4hODypheiXZMyvA+hbzcOZEcUfzMxQtUox
         l7LwXbTIe7HT6OgwzWd0F9DHPtDPcRXfhB9sOVrr9DAB1f1TnO0u3+SoyAx/42dcnLsp
         TYH5d3lRMFzjJPN2xZ5Mk/lZwFhympKrvHtZbTOwu5kLEW1c6swJL977/Vj0MHaTtjEN
         XbP8US/oiUpzMP1tFhCZL1J72XFPmRUem5lgttf4XEorJiPLqA53c76B9hUOC5KnA/qE
         Czx0bgKC498x2DwWDfPhiWv2kc7SgKyG4c6Zs2UHIU0zNsZH0ppnghBjxy5CSZHlRdfz
         Owjw==
X-Forwarded-Encrypted: i=1; AJvYcCXgVSRHnU8qA3BgdW6/MLiIv6C5yFhjZX1Ogj96Cxc09PywDv5kzp03Rf3qpZ0l0bTRgb+GRmuWbGLG@vger.kernel.org
X-Gm-Message-State: AOJu0YycyJt13kB0i2+sUsdcP5zaed+ugeOhkCPj/3zicHSA1n9plWiI
	KI69ETVBHnv7GwjzSHm6x5UfMcMXRY+368HPqThj4OJ/V1GS4D+I94bP
X-Gm-Gg: ATEYQzzRZpYrM716qKMD5Cu4HcgoezMORk7V/fdt6h0MD5R8e0NC8jxrELOLz9L6zAU
	g40TYjRLH9ungzQkSNUj7I56dgFiKQqtA6gqo2iT1QNvlHNmbCFLPu9Saw0TZYnpViT0VG6vvuj
	iT3EOsS8Dm/fB9dcBXoHBsGQ7NaQeyPUkeKC0E5xDsa6yo5G0pczW8K4IrR/CqYkI+WN1BU57Cx
	GturFAJVJFWqmS6SDTPjm0u+XP4I5YIIjkROhUnmiGVsinu8kTxib92VFm0a22BcmGd8EDTpH+A
	tly6Ia5oCSO9kiy4KST1PGGm3Bbkyonp26O1Z1n1Ym0Q6TdkA67c0cfx28+nSQDBSc1Fllkb2vO
	A9Vhm2IJKCWcEbB+7cM5vbP0VCb5RNVDlEDLpag+Oijbdcase96SiFNQONrgT5Rb4ULj4TB7/k8
	gD8Gql6ibMbRyIwb53/tLHDyISci58RrXNg8l5G7bdVqYRMysuAg+TSg==
X-Received: by 2002:a05:690c:c223:b0:798:77bd:109e with SMTP id 00721157ae682-798c6d00ffcmr5204187b3.63.1772598061681;
        Tue, 03 Mar 2026 20:21:01 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf9270sm69852817b3.32.2026.03.03.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:21:01 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/mlx5e: use flex array for rqns
Date: Tue,  3 Mar 2026 20:20:42 -0800
Message-ID: <20260304042042.7822-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6BC61FAA8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17455-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simplifies allocation. Separate kcalloc and kfree not needed anymore.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 92974b11ec75..fc71dd72938c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -16,7 +16,6 @@ struct mlx5e_rx_res {
 
 	struct mlx5e_rss *rss[MLX5E_MAX_NUM_RSS];
 	bool rss_active;
-	u32 *rss_rqns;
 	u32 *rss_vhca_ids;
 	unsigned int rss_nch;
 
@@ -29,6 +28,8 @@ struct mlx5e_rx_res {
 		struct mlx5e_rqt rqt;
 		struct mlx5e_tir tir;
 	} ptp;
+
+	u32 rss_rqns[];
 };
 
 /* API for rx_res_rss_* */
@@ -316,7 +317,6 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
 static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
 {
 	kvfree(res->rss_vhca_ids);
-	kvfree(res->rss_rqns);
 	kvfree(res);
 }
 
@@ -325,20 +325,13 @@ static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsig
 {
 	struct mlx5e_rx_res *rx_res;
 
-	rx_res = kvzalloc_obj(*rx_res);
+	rx_res = kvzalloc_flex(*rx_res, rss_rqns, max_nch, GFP_KERNEL);
 	if (!rx_res)
 		return NULL;
 
-	rx_res->rss_rqns = kvcalloc(max_nch, sizeof(*rx_res->rss_rqns), GFP_KERNEL);
-	if (!rx_res->rss_rqns) {
-		kvfree(rx_res);
-		return NULL;
-	}
-
 	if (multi_vhca) {
 		rx_res->rss_vhca_ids = kvcalloc(max_nch, sizeof(*rx_res->rss_vhca_ids), GFP_KERNEL);
 		if (!rx_res->rss_vhca_ids) {
-			kvfree(rx_res->rss_rqns);
 			kvfree(rx_res);
 			return NULL;
 		}
-- 
2.53.0


