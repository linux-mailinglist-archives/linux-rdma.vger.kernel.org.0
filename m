Return-Path: <linux-rdma+bounces-18929-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFpPFdq4zWm5gAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18929-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:31:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E9382018
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0823014C19
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DA1DF26E;
	Thu,  2 Apr 2026 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoECNvID"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAD1514E4
	for <linux-rdma@vger.kernel.org>; Thu,  2 Apr 2026 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089874; cv=none; b=ssw+QOsoJN+0eLnDx5Vre/jYNdUeevjLDjc52yIS+5CPvb3QjIdXKcxNZo1kIVQtY9EhvVDLSCBawkunWG54k6rnxbQ8UfQkpkwDepw0bkjuVW10JTzFYRYRChZY43/lcKxHTs+rF8AZSbrs4K0XW0mF1MJgfVZfQ/sBymMP0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089874; c=relaxed/simple;
	bh=2iwCLWZ4VLKRtnQx7QyjpjFIZKV8KdDMkRsHy/Rus6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgjkIbtiIidfFFsMFa6NNq8p5ndEogkWBjz/NIFQ8XPyGA0zt8VdNe32XWS6hcBUWqSgOKVlxfn02EFG1OrILUGtzvKPl+fuko8JUG0zUyXYOeCPkkozcOuGY+aMEnXW/dfMN7V/K3Ibp8SdzHL8C02vUQfnXQINEW0IgHKj7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoECNvID; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so1612205e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089871; x=1775694671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckU4tVP2UGswkeqkYvSpP/w2XpfG0QEws3yAc9wqFaE=;
        b=BoECNvID+w47/y6zjgdCe06a/b3Q6psOasUsGZVhmopVeJxcdyH4JzlYT/vT8r89x1
         3PZfTKqQ92tAbS7lysNtm2Av17qDoCNnOb1cV1IOIQRuEPcBYVfb8DoI3DRt1f90rQs3
         cFC3Jyy9i3tw21u0yjDc+7OcDnojjG8zDJp6J5g8E6hBLashVL8lJrKp0O1l5bEnybvn
         k3tXRyVxCzFI02h6/7Rop7SBmQPmesZ5jyP1CwoK+AMZ5SdFSXAHLKmY9ITsWW23BuHI
         YWgaRcNYuVIKvd1ZLZ4LekkwunMNTv5UHu03+nJbt12MXdfWCV2ufthlYHpDU3+Q73Mf
         3zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089871; x=1775694671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckU4tVP2UGswkeqkYvSpP/w2XpfG0QEws3yAc9wqFaE=;
        b=FhlYL3siCNKX3jj/gDS8l9lOjWaz9w0aBWOHP0HTQxPtW/YfwvKzRRwYDTo0WoN5gx
         STrRitl2oOpeB0s4JIWgDKZ2RjrZ21VNuDoj7BvfqsK7FavnQNCHA7ParnoH61zIAwSl
         A7ETXykqGsDOso3Ig2gWe08N2B5RCUsePJqGVmd7sXJcBRhQJEW3CdVCOaOJ3wTNEzMP
         +qIJ4dA5Hu9OTdzrHiycjssh8GK2P9QuodO4FyIShI1sQQkTCalBoBNxxlYvwKihE5vp
         eu1x9SWMNrYFspfQRXOJPqKWtM7Vox+Kk2HA6onceIN/cmBFu7UgCqwVQNvP4NScYwSX
         19Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUChct5wI6xgqfp7UADtX5ljLogGQu8S8qk1u8DtWKrBSjOTfLEQkQyH9EVJxf4Acc5BW4hWKlWMN2Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqaIfJYh+sOcDEy0B9dTKAE6Sck9Og01oXpwpaycu+377TRTS
	lhIvWuQMuYy7MkoERKMfQFEeyLWGY+pbl7jq7xokV0gMim/VivwZcXCC
X-Gm-Gg: ATEYQzzqqdIRb2l47nJVLG3CJbjGS5cySphbTBINe503VeG8sBZad0OF6tC8dlPI4LS
	owpLllJqaINZTVbeSILJ75JuD/ndZq1H+dSyvEE/RiBhdd6hMhNEETSJ1hP8oExs/2nHv3+0k99
	Aou1eqRkDZZcBoJJRIhPAtZ1tj9D68rRCwHHqt1BMQcUDzP8A/BivmTqJqST2w/bJSXuUut4iHH
	1XtHqbrVrcLhAvtBpCBwwLZq4VB55nItoMM/pF59Qm8RWG5nTGsb6RNXNOHiPab88ZZ8kBxJAtm
	qpI3wYCv8mFAFoME9G0uZaEF9Vv7SAwh+ZCT9TVnYAJgJf+/W6mw6DbliJGLz7SRh35SdmYsp48
	7apecknYlwhnl7Dn+8xyyYteOO2sVJWM+yS12QZyar9hQ7pHE3xl4Y64fD7l98FABjhoDSB/FIF
	BK9sy2/75+2KFrvMU0eJm3NagjrSpZPaQnpiU6KN3RJnua6ugduoBLvZ6RDm0XuzrqaDweMcflc
	cQTbtVN7z5RkMA4QXiFt+mFVsu/YVo0PfyHYy6g5QsQB6rt
X-Received: by 2002:a05:600c:c056:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488835b30a7mr64106445e9.23.1775089871151;
        Wed, 01 Apr 2026 17:31:11 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm31433565e9.6.2026.04.01.17.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:31:10 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: prathameshdeshpande7@gmail.com
Cc: leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v2] net/mlx5: Fix OOB access and stack information leak in PTP event handling
Date: Thu,  2 Apr 2026 01:30:47 +0100
Message-ID: <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
References: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18929-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC3E9382018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_pps_event(), several critical issues were identified during
review by Sashiko:

1. The 'pin' index from the hardware event was used without bounds
   checking to index 'pin_config' and 'pps_info->start', leading to
   potential out-of-bounds memory access.
2. 'ptp_event' was not zero-initialized. Since it contains a union,
   assigning a timestamp partially leaves the 'ts_raw' field with
   uninitialized stack memory, which can leak kernel data or
   corrupt time sync logic in hardpps().
3. A NULL 'pin_config' could be dereferenced if initialization failed.
4. 'clock->ptp' could be NULL if ptp_clock_register() failed.

Fix these by zero-initializing the event struct, adding a bounds
check against MAX_PIN_NUM, and adding appropriate NULL guards.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v2:
- Zero-initialize ptp_event to prevent stack information leak [Sashiko].
- Add bounds check for hardware pin index to prevent OOB access [Sashiko].
- Add NULL guard for pin_config to handle initialization failures [Sashiko].
- Add NULL check for clock->ptp as originally intended.

 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..a4d8c5c39abc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1164,12 +1164,18 @@ static int mlx5_pps_event(struct notifier_block *nb,
 							       pps_nb);
 	struct mlx5_core_dev *mdev = clock_state->mdev;
 	struct mlx5_clock *clock = mdev->clock;
-	struct ptp_clock_event ptp_event;
+	struct ptp_clock_event ptp_event = {};
 	struct mlx5_eqe *eqe = data;
 	int pin = eqe->data.pps.pin;
 	unsigned long flags;
 	u64 ns;
 
+	if (!clock->ptp_info.pin_config)
+		return NOTIFY_OK;
+
+	if (pin < 0 || pin >= MAX_PIN_NUM)
+		return NOTIFY_OK;
+
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
 		ptp_event.index = pin;
@@ -1185,8 +1191,8 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		} else {
 			ptp_event.type = PTP_CLOCK_EXTTS;
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


