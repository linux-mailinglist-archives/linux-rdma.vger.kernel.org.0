Return-Path: <linux-rdma+bounces-19244-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COK8MPnh2mnA6wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19244-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 02:06:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375C3E20C1
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 02:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAB5F3037C3C
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 00:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104D22D7B9;
	Sun, 12 Apr 2026 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syT+vB0s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A211A840A
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952289; cv=none; b=SjSixrD0bgTEaepgsWWG66WNQI1muBzflFJpL/B9GWLkuLVRhPQ1DIKICyDIGU+zOHVZBzdFZotyJOE/RBo+sWj0zoOzy4KKZCVsTMB/f/5b6U0jf+JULngz5idkIV3GKkWIL3ZrbSwmBxKrMTfeYxxF0fTHM+PTz0p8czGfzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952289; c=relaxed/simple;
	bh=QBK/RINE8I0qyXqKrQoDfDxVkFmB1WnivJRFhq24a5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0UP9UeHdIZ5Wga0y3IxtqdON3qt4KhpAQGItbOZ84+vykm8auW3EUrxjW6mVKzT3K5EjGAKcJQoAMPhHT30LwQ93Oh/Pf7uvlCiiddxZmYE54Hk1cFdG+L7U+Ms4MotLnB5AumCmm6uEaPhcozjkV/9Fhn/tl3OfvCN/gHJB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syT+vB0s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d03db7f87so2064566f8f.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775952283; x=1776557083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSvVMtxzXjPYe5WEdSEEP8xXV+mSZx/Y6/geHYnLhkU=;
        b=syT+vB0sYwnejruFcAFjvTObTmh4jIpirhIxJXy+a4NwkVZ68YIdQVnvfL3xaLMfc9
         J78E3gpZrPyT+BAMBk0RtpPkwjyEB5twRS8+xU9SMZ+4Von7lkfrKbI7D/gogGCpOAuW
         g1ElMIo3YP97zveHFXQVxY+MUFxoOAO2PiOzYGj1qjxinSTRmK5aYzA7YJKJRE3dZoYY
         CnVlVtNB/99d1B9y52Md+0xQHBloZ/fzvL2puZTW6NahdeLDxxy3y3N4/VN2JOQ33jDZ
         tId+/SvziNfuv1Q6fOnwjrOPJWPp33G+Ax+2l7/yHh1T6VCF+s54ADkHY9wtYUuP/IBY
         JsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775952283; x=1776557083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSvVMtxzXjPYe5WEdSEEP8xXV+mSZx/Y6/geHYnLhkU=;
        b=XKzMGiA2Yc2dpXIuxCO6Q/2ZqKQVLyzCnmIXAQnkmfNBVOx3YlHBpMK3gO/oLSfJFP
         Lrrbayc2G1iSk5SFUocWkBO8OzuQgnWmNnROaioTl8t6wuMrlDp0/13xrnQ/eTS/NN2T
         GJkmtWE4aD3p1KVyUWPQcaQ12fRi4dRoTKgu+SIrNsTVkqhCS/rPBWp6rpME8LMIuTtx
         rs1zSfXXcU7R6HZBPjx0sNkax+KxTSuOAPWggRS24QU9LL0CYjadXvkg24en8g31OAOI
         jMWBXnhrhAklUmGNUTd+Sr6RLdYF/G6k42cZrITBq2fO+eMAYuCQMNTc20iBCPrb1bjw
         cX2g==
X-Forwarded-Encrypted: i=1; AFNElJ/gWE6kaMS/4sicmVWxZEWs4PxrQTZ4uGoY2ZtSGLdJo+tUBBBXDIMnFdo2CuHweVwyvVE1ujBD47lT@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDtAevb2co+ZNzJv9Dj9kZ8VmMNSKI1pOR2G6buHaZuUKlEae
	PO3FfI2za8zYC9gXRsXqc6dqa8a+2nXC7OaNVelHCP2Sn6SHCShwzISa
X-Gm-Gg: AeBDievpXRj5+9vp3llcnpkgCsOOqM40plPmLdrMRbxcRbOLnpvufMsTe9bmR8o5is1
	UfbaIF268PrbbMYxQD50PFkPmfwS2/BvbHz9DfEZ8BjT/NBEnqhnmA7psUWaCU6y0AlSGDF1iVv
	96NB0vieS1x5AZE7/Teww/8Xmbltq5QezHFWGoUyrN69AUk6JGaRVN8MqYRsblGiEMVVfYwjDnr
	3QU2NqTd8zXwQBVH5MckqAuzv1igCSh8Ot7emtekKrqM/hbyNXfr5lf80CmWZE3c4+UL76DvEvL
	C49mTVZTC/Nwy2g21H0XLCnbaOsuiPYc+pb/BzY0EH43TCglom9Ylwk2JTAYf2FdqMZrKKmCmTi
	er9PDIwOS54E3jDrw81sHv2i/NLWJ0pZZlJlABr2gU3xSHgNsnay8zhvoHaG4GmVsJynHAZ6eqC
	3qu83Sv2TbIfykiy5zg8KrXazFGN0dupxZK/Pgd15Ak+NUKXPPQcJVXFSZtRKAg+tVVH/AnC5xf
	V0O5Ke2mjCWkQL99WQ+c9DwYXs0uMTHcIOQNeKPOQ==
X-Received: by 2002:a5d:64e6:0:b0:43d:c75:9479 with SMTP id ffacd0b85a97d-43d642b6965mr13228236f8f.31.1775952283220;
        Sat, 11 Apr 2026 17:04:43 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm20373377f8f.30.2026.04.11.17.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 17:04:41 -0700 (PDT)
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
Subject: [PATCH v4] net/mlx5: Fix OOB access and stack information leak in PTP event handling
Date: Sun, 12 Apr 2026 01:04:10 +0100
Message-ID: <20260412000418.8415-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19244-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4375C3E20C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_pps_event(), several critical issues were identified:

1. The 'pin' index from the hardware event was used without bounds
   checking to index 'pin_config' and 'pps_info->start'. Check against
   MAX_PIN_NUM to prevent out-of-bounds access.
2. 'ptp_event' was not zero-initialized, potentially leaking stack
   memory through the union.
3. A NULL 'pin_config' could be dereferenced if initialization failed.
4. 'clock->ptp' could be NULL if ptp_clock_register() failed.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
Suggested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v4:
- Validate pin index against MAX_PIN_NUM instead of n_pins [Carolina].
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
index bd4e042077af..ff03dfa12a67 100644
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
+	if (WARN_ON_ONCE(pin >= MAX_PIN_NUM))
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


