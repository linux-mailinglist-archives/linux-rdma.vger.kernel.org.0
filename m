Return-Path: <linux-rdma+bounces-19202-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKTPIFJY2GkvcQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19202-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 03:54:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489F3D13D8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 03:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64635300F7A2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41431691C;
	Fri, 10 Apr 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAWbWJ/G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B72BE641
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786060; cv=none; b=ifwbWThXbqnjHjpvt1BWOxdtGmRPVpP5CKwxPcSUDoTAMYAAXwruF3w6mPNSIxIjj7HxS1Vh+JoRDcnDn7GSvfesxdElA7X2xGaZ0slm2+1HVnWU48v1g+JxNUA14scIPlL3Z/i3i6MKq+WyUOrNYfuLkvhZC2R9XCSMTdtPbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786060; c=relaxed/simple;
	bh=9n9e7BOpD0JJg+GvMEUM4/CCjFhf8fyYpDSfLRwJ4kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVgWYVw19uLKVP2GMY6fChWx5RuNzCgqmqnX3OS5+idIDyB1kmISfbbb0Iv5rR1bsbEMoSRKIprkyQT5Vw0QvnBDZotNoNssx9Zel7c2IHAZWBgjV1gG9BF89dS6Kqa4v196K/baBp5tEdy51Jfn9P5fTcjLKEIoZy81vG57Rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAWbWJ/G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so14276375e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 18:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775786057; x=1776390857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFt/ccalP4guf4oXhpfkftFkSiO5srQjmAfQqO3hweU=;
        b=KAWbWJ/G9bphNHHEW+KC3m1EYOjiBgIPeZL+pvMe1LyMojiqUHYesR3ARV7VoHUPQe
         y0yDY9g+XouaX4D0KBaQecmTBX3a1bdWgfwhomLo0wrJTwpQMY6R3TF/kyr9w4sTlidJ
         X/O5/+utIWFRpYTR8CqX9BiS8XzoPAb+b6I30bb/m7c9j66Qf25dOFj039ZHbr9+EKhJ
         wGBmS3eyYFVMHGBaFU6ILkkyJgM0mUhIaHK/cCiL91R/kwY50m4stMcbhMd/o28E/YRY
         mPlaM8/mE+8XUHUP176IJ3wBLYmHPFm5cNsoD9pAsrjLSGCFjWMweMww2dO03wQc6qSm
         Svag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775786057; x=1776390857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFt/ccalP4guf4oXhpfkftFkSiO5srQjmAfQqO3hweU=;
        b=HiGxmkQDRmgDxj4eW/HxZK30OTxXThoY4/j81Of95Mb/eHAxjJwAmsmmsKz3H+0AXJ
         btoh+jM3mgbl8jLXppNEI1982kR8+I5T9V3RSheAsj6s4LLHAVMBs6AZFuttd4lnFpLw
         H/Xu8L9Z/UgpbJMgwngC87RbBES9gfHM5TmT3bDANENU5P2dgWRdllgEYEEA9rHffiIu
         dBtGVaK5//YdwJO9qO+hnra5CbeeXF0GeBIKYX0Xg/G+Z2OI4ONDeAnBRfntzxxZwJN7
         37yjt/W+g/qRbUdZcE/3GNUHSgk6F8YOhxLvL6gY5EK1omLUZOCr+q8hDu25n0VzqwUZ
         TdsA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHQhhaFcvqAwveZ+2+PyCaAabo4/W9othxA957PdYXdqsSNDBTu77mQ+Zzl/Rh77w9eh6rUaq0rQf@vger.kernel.org
X-Gm-Message-State: AOJu0YwELTkdHpTFwcnAJyV2vD16hUzxtmfC4NKf4RYTvFVR/AuC+q5m
	nxpcxiqPZPFEyoVdYtzqjGygsOF9nTiE0B8nE4qOzgqJRASW6CcGoiv+
X-Gm-Gg: AeBDieuE1uFgH9/gbfuhtuS5RaYQIuqUKB8MSlo8DqY1kguU+MyxCNno0W1TqGL25pZ
	bq4L83/88b6bN2rwoJFy3Edp49uLI5xuH0cTHcuQHscHoubrXj/MJcS3oWgBEoiyNvI5MkOeMY1
	kkHi8jxDa2K1vL4GVv4gV068l8OdDhn9Qf8agz10LWJVhp949kjlBntG3CNTq/MgQtVnjPP+r6p
	Y76LY//hvGVaEjJsiNLR26IZs+cj98WNRBI19dJ8NN+42WbYBw1XbJv2/lgmZL3HHvkXCi83BNI
	aF4Zfxol3d8HWJQ50/H1nOeV20VESqSk/qia0XcFd/VvAxwgdlXow50/PPwVOYba9g5+ZLWZUww
	KjaOG+XilcvkKsPAqwEmud+XrZohuAaTBeJyCOr9Ben3cqp599i6hsvIFXVOH/Sh5EOAT3TFwrI
	GtPQ9pzVOlO1Yy/C7ep+utidVPDMKUi7SfNVBDOKGJiqWb1c38f3Dln63dvIyzLa99AJZ4G596h
	EiaBzcLb0eiX3wH1vhPVUbjb7FGlQ5MyfGrXpObxmdcumG3
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id 5b1f17b1804b1-488d6836508mr8227665e9.15.1775786057077;
        Thu, 09 Apr 2026 18:54:17 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d533e596sm39254295e9.6.2026.04.09.18.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:54:16 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Carolina Jubran <cjubran@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v3] net/mlx5: Fix OOB access and stack information leak in PTP event handling
Date: Fri, 10 Apr 2026 02:53:36 +0100
Message-ID: <20260410015336.7353-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19202-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Queue-Id: 8489F3D13D8
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
check against n_pins, and adding appropriate NULL guards.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
Suggested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v3:
- Fix union corruption by using a local timestamp variable [Sashiko].
- Validate pin index against n_pins with WARN_ON_ONCE [Carolina].
- Remove redundant pin < 0 check and cleanup TODO comment.
v2:
- Zero-initialize ptp_event to prevent stack information leak [Sashiko].
- Add bounds check for hardware pin index to prevent OOB access [Sashiko].
- Add NULL guard for pin_config to handle initialization failures [Sashiko].
- Add NULL check for clock->ptp as originally intended.

 .../net/ethernet/mellanox/mlx5/core/lib/clock.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..674dd048a6b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1164,16 +1164,22 @@ static int mlx5_pps_event(struct notifier_block *nb,
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
+	if (WARN_ON_ONCE(pin >= clock->ptp_info.n_pins))
+		return NOTIFY_OK;
+
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
 		ptp_event.index = pin;
-		ptp_event.timestamp = mlx5_real_time_mode(mdev) ?
+		ns = mlx5_real_time_mode(mdev) ?
 			mlx5_real_time_cyc2time(clock,
 						be64_to_cpu(eqe->data.pps.time_stamp)) :
 			mlx5_timecounter_cyc2time(clock,
@@ -1181,12 +1187,13 @@ static int mlx5_pps_event(struct notifier_block *nb,
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


