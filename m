Return-Path: <linux-rdma+bounces-19358-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM7vKvPL3mnnIQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19358-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 01:21:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78C3FF005
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7A0303BB3B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6394E396B63;
	Tue, 14 Apr 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEgrMzpl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB331358367
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208838; cv=none; b=Eq0awQJTw6U1zaqKcv9pNbpjt0vivOTvrfGH4wsuHDBiu+CRPGDTZ3RzpGPjdgJRJsZHi1dP00HM1yOD0AiKaKegob0+F2XzE6D0bt57TTAYZkbxSWKvA5a/QURsSuK/yC+rFWK2EtsZ5Pfnbx4Elk6aInTuEpFeNNqU40bgaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208838; c=relaxed/simple;
	bh=sXWSjkI2x2ulkH+O8/Qc+zL1CHMbazjbAzl27srzbVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9ZiI/1p5tYtWyYcwmVoyjgV2HWib09K5P2cCGiPJhmksLHjAHsEE81Hv7tiTXy7+0MmQW8GKgK8cHnAHWtIxghL9gyCJcf2o0Cy8tBwoS3vczh2tqKenBQiZ4JfW+6hHM/X+qN0xPTITmwqXfdjsMLOEAT8melaEKN/jnRkFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEgrMzpl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a29e6110so66426105e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776208835; x=1776813635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Lf8VBeYUO7ZSYpV41igFLgwMtvvclZ9hr/Y+OcW/Y=;
        b=IEgrMzplJ4P8mJnsEU3l2m0Upk0HLaWgsQoAj65WUD+Z0JUYynk+7RaEVsiG31jzsj
         qt3kJ2vtkrV5lTPHOl16h9UWvkmxUEK0h4yMCDTWtWo+CIi30UUrbqj2Ce+EEjXT7gaR
         svP6xrQy5BrhW6DliPXK6+TL+n5yTorZ+mXkY26q90X3jZSk2hMGerHelDqg4sTFAduH
         OSPfr8Fm2Q1k5NhJ5DXBHru+hr7If/Rcjqobr2Aa61ioqujMox+iHNyolgIMcsD4JrJR
         Dx8rIwRBoaUSSc/3JJLHE4ysm8HsvAUUo7T+VT2o3/PUQ9J4hyIbPYrdwgyttXADZNgi
         U9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208835; x=1776813635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Lf8VBeYUO7ZSYpV41igFLgwMtvvclZ9hr/Y+OcW/Y=;
        b=q6XOcFSkKz9It27yfhYWgfKHeOLfdsYeQAg2EKAkGYXpCSCe55ZYINwrl0vGHKf8KM
         KL7ANfuvShIGNVQUtKbJemgWuqfp386nQvs6OfXLihEXspG83wYNTJnbTVg//dD2vcsi
         WthxnG486QSwn/3xzrRLg+lzfdWIw5HDfww4KyJm24xsUlIHjv1tb4ROPmA40CTn7Wlx
         n+vFEm8UebuIf82DvqhlW8J7KJ9iPZq7E4G9Br/aiD//5Xg/PrCRgugTk++W4AJLeR5T
         kCOcOmrapjZ/Zsv85Nc6IWc6/Hq5L03QBB2MQDy6GX+HXjzkumjsMm88jc84rrpnsPmR
         M3sQ==
X-Forwarded-Encrypted: i=1; AFNElJ/II3cdLub1Jxl2KDxuDbcie92x4MWXY6+8N1RvqOWczj+w671rY+tQz/AQe3nBGOuiRE2zD50O36HR@vger.kernel.org
X-Gm-Message-State: AOJu0YyziWhcaB2rR7AB8odM9zsWY27RmkP1SjPbV2xrwJEu9uNJhAXk
	XU9lVOejRFkO840vRjmyotM3IcDVr5flfn9ttk96pyNke9cR5R+FetZg
X-Gm-Gg: AeBDievpE2GIivYM84VHPAXybCbNcJ6iYeJuddj6FRcZLFmftmco2rzWQ1tiSn6EFty
	6kYvqmzKDvMplt0sPgLeVkD5dN7MkPZbYqFKoElGOmfDoX30ix061GgwQMR39qZz97/dF749j1R
	2EwhClcZy/ZXYgQM/tBhVHa8hcPG0dHnCJYpvEmwbmF4yfW+3F04voj/CfjgduXUP+dJABmWBT+
	fgDwi84AXCynLBd7zz9elILVPYaHVwP5pwCGHExER6r+DvHLo5EL7EEvKxjvF6XETRC/9EyuPQJ
	MSNphlUf5ORije3XThrpFV2Y0h5Y0/D8cQmWhnr+DZmg6rVD9kj+67EScvYJFv5qa/MoEij8hG3
	qyDE+LcRlUmINW4Q6ZEgNqU3xNfCRx93PI52jkpgi4bBWI1K4uzICi4BrXLBe9QPgdNf3vKmO+0
	rdm1R0ariYmuBVacgixl9IxiUfcMy8HbCdHk/GV7Oz3L6OzXdM3kUs1xDgCGLyV5pVatTnX3qo9
	ynph0L+mnLNu9oahEaAdbHlNHHLxjGByb7fBhRhxQ==
X-Received: by 2002:a05:600c:5306:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488d68c3385mr261389455e9.27.1776208835113;
        Tue, 14 Apr 2026 16:20:35 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm138321825e9.6.2026.04.14.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:20:34 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v5] net/mlx5: Fix PTP event stack info leak and NULL ptp_clock use
Date: Wed, 15 Apr 2026 00:19:20 +0100
Message-ID: <20260414232001.21875-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19358-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A78C3FF005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_pps_event(), ptp_event is not zero-initialized. Since it contains
a union, partial assignment can leave stale stack data in unused members.

Also, clock->ptp may be NULL if ptp_clock_register() fails.

Fix by zero-initializing ptp_event, using a local timestamp variable for
event data assignment, and guarding ptp_clock_event() with a NULL check.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v5:
- Drop MAX_PIN_NUM check per review.
- Drop pin_config local guard to keep this revision narrowly scoped.
v4:
- Validate pin index against MAX_PIN_NUM instead of n_pins.
v3:
- Fix union corruption by using a local timestamp variable.
- Validate pin index against n_pins with WARN_ON_ONCE.
- Remove redundant pin < 0 check and cleanup TODO comment.
v2:
- Zero-initialize ptp_event to prevent stack information leak.
- Add bounds check for hardware pin index to prevent OOB access.
- Add NULL guard for pin_config to handle initialization failures.
- Add NULL check for clock->ptp as originally intended.

 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..77d7b81a0a25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1164,7 +1164,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 							       pps_nb);
 	struct mlx5_core_dev *mdev = clock_state->mdev;
 	struct mlx5_clock *clock = mdev->clock;
-	struct ptp_clock_event ptp_event;
+	struct ptp_clock_event ptp_event = {};
 	struct mlx5_eqe *eqe = data;
 	int pin = eqe->data.pps.pin;
 	unsigned long flags;
@@ -1173,7 +1173,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
 		ptp_event.index = pin;
-		ptp_event.timestamp = mlx5_real_time_mode(mdev) ?
+		ns = mlx5_real_time_mode(mdev) ?
 			mlx5_real_time_cyc2time(clock,
 						be64_to_cpu(eqe->data.pps.time_stamp)) :
 			mlx5_timecounter_cyc2time(clock,
@@ -1181,12 +1181,13 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		if (clock->pps_info.enabled) {
 			ptp_event.type = PTP_CLOCK_PPSUSR;
 			ptp_event.pps_times.ts_real =
-					ns_to_timespec64(ptp_event.timestamp);
+					ns_to_timespec64(ns);
 		} else {
 			ptp_event.type = PTP_CLOCK_EXTTS;
+			ptp_event.timestamp = ns;
 		}
-		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
-		ptp_clock_event(clock->ptp, &ptp_event);
+		if (clock->ptp)
+			ptp_clock_event(clock->ptp, &ptp_event);
 		break;
 	case PTP_PF_PEROUT:
 		if (clock->shared) {
-- 
2.43.0


