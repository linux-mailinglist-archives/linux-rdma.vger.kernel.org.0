Return-Path: <linux-rdma+bounces-18925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJtWHOKvzWmgfwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 01:53:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E087D381CDF
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 01:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D66A6302DE01
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1263BD24D;
	Wed,  1 Apr 2026 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP/PB5i6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FED1E98FF
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087582; cv=none; b=VdS/dsChpRpu23jqGL49Dz7jTyaF/26SZpYHVUBYSqtZzN3vRII6byG5NEw3OhEcI+5p8Lo5udOCTMBdeHj6WJeluSE59jHSc32Toi/UOPAkiRCxh6yeccyNDLE6Suh0Xf1oIk7rHcDjnlGTJRqpnqdzmRVk3M2yHUjrForpE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087582; c=relaxed/simple;
	bh=FpfE5G/aiPXrSwvKAYsxHijMr5QmhOe0heWhhfXLC24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+gBoo29arVeXqBWjifcTaW4/hdXSUd0cAWs3yeXllhMVONc8bGqCzthyMpwR33JZmHdA83FsSHaihAH0ixs/wzeQZZfLxmU76irRwfvvgc14It5ROMz7LAOYavnwkVkRAIK4p1hJcoqCYq1nE/J1XOgvOiIyWyNqBDEt1z+qhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP/PB5i6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so1503445e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775087579; x=1775692379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ3m3gvWAxk1Tlyn4HV1OGvgOsTxc97XPaeHMTCg50Q=;
        b=RP/PB5i6x7f68TUaUIuk47g9XsOTVAHtYZj4ZKqonTQXvXGYrreQbleyFBJzAliUWe
         gL/gHpd2DplpxmzWkIpV2K7x82AoAwow5U7vcEmKNYBT5jVVG5SEuaKotLsTdLbUjEbT
         BcS9l2+fNH1ZbXWRkqsDdfQlebzDC91EVd+2Ym44wWwThxUJ37lep/oAi9fqVjhr0MpT
         PUSGlszjv2pZBi1iwfmX4xgnpR18FQJUb2mHVcKwwaDiTL2KPDEwKtBOkBoY6bRzwaNR
         0BY8RYBRscd66YIpdXDE2CMewGBvM8rtzYGviE8Wc7i9ygK896axPK/fey9Oqd9/oYtW
         liyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087579; x=1775692379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJ3m3gvWAxk1Tlyn4HV1OGvgOsTxc97XPaeHMTCg50Q=;
        b=gdvgo4Wu+cGwbArp9BJD7elqQSaKtuYdB6CQPMSL21coT7r+i/c+NtTqTm8wRWgzds
         RwFQEe21o9WPV8QNxNEKraanQwFMF8FMQH70EldYkGdLzHt6LbO5H9xlvBexcBx9GNdp
         BOeM0/9B3v756+emcuiv82Jj6iwGL/FBv+nqtXxL1Bb6dkEb8xVJbsA7G8FPD9MrfDMn
         +ARaFA04lcI4Y3vPBLXokxzknyrg1jsPuMiiaB9atZjUMzrWxydrRKZnSW+A6QZjFm/l
         vB45uVI12BnIE35kWT+2zCGcyyARmMqDMCZXPZS7DO2g82zfTiD3p42EN4iHrgiOtJm0
         PxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFPMwAc5q2HVBYriUpeMhU2ztn4Epvc5spzUKQrvkdrN6ObQDozX4v0vqEse1TsheLXO8DRs1rzK+s@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3w/wjJZEHQtAyqiIPf8Xvz4SGCZlcsRHkKaD6QJ2qEZ5bsq9
	h1bmfY1kJaEOtUEiTpz+b/CXBDmbopoQ559VZI7nScmvOUjCOaZtwTsQ
X-Gm-Gg: ATEYQzwKkQQpm2zo9WA8gHzj76tibhhjnjdWsAb1ONll42jwVKCdoulo0B8d94PGiRO
	+8+vG2opcAd6ufj9jcWpK4H0XAD+rFkqQnV3SlStiKFaiz+qh9wpix5M/2pBZg569Wbd6GD9QP7
	3XmBgOYStlNpO2JL3KNyUPPuke+IhgG1L5sdXPUGS7282ycNyTsFyAjEOHe3ZgMdndslFGyJ12n
	bnX1rinzpZevinu5Gb6XzWC38M5X46VG4A/OFEtgZf6tdzuSqr32J2ZoaIfFwiswzFmLS537Yeo
	fBnda8197ChDP/1WxqlgiJtF+EbpPooOiNNdwCb64q8wGBvtrA9l4tHsj5wAuYzboXFtDUhJqBI
	NmLHhidwQJ4RZqB/XYksx2OpuFgZVPT49dDgjdXIgQMSB+jNbx1BlecqX1K05FQnnR1j9LorTWI
	nM/AJheoymUPVjxwTZP9vZgWXMJLmeIYY1J0rEFdD1lZ+YIya3kdRYK/0bqfVtGQ8oVCqiuvN0x
	OZ4sXKrmZcNf2D1zmDs6MEzUPIG8fu4BAS6TSW3u8RPwrsa
X-Received: by 2002:a05:600c:45c5:b0:486:ffa3:584 with SMTP id 5b1f17b1804b1-48883591f7amr89950115e9.15.1775087578767;
        Wed, 01 Apr 2026 16:52:58 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a705f99sm27380715e9.11.2026.04.01.16.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:52:57 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: prathameshdeshpande7@gmail.com
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v4] IB/mlx5: Fix state corruption and resource leaks in loopback enablement
Date: Thu,  2 Apr 2026 00:52:32 +0100
Message-ID: <20260401235232.21155-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401223550.20040-1-prathameshdeshpande7@gmail.com>
References: <20260401223550.20040-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18925-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E087D381CDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ib_alloc_transport_domain(), an early success path was
returning 'err' (which is 0) instead of a literal 0.

Additionally, as identified by Sashiko, if mlx5_ib_enable_lb() fails
to update the hardware, it leaves the software state in an
inconsistent state where reference counters are incremented but the
hardware remains disabled. Fixing this in the caller created a race
window where the mutex was released between enablement and rollback.

Update mlx5_ib_enable_lb() to perform an atomic rollback of reference
counters and only set the 'enabled' flag if the hardware command
succeeds.

Also, add error handling in mlx5_ib_alloc_transport_domain() to
deallocate the transport domain (tdn) if loopback enablement fails.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v4:
- Moved rollback logic into mlx5_ib_enable_lb() to ensure atomicity
  within the mutex and prevent race conditions [Sashiko].
v3:
- Also call mlx5_ib_disable_lb() on failure to roll back software state/counters
  [Sashiko].
v2:
- Added deallocation of tdn if mlx5_ib_enable_lb() fails [Sashiko].
- Reworded commit message to reflect the functional fix and credit the tool.

 drivers/infiniband/hw/mlx5/main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..877b02e98033 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2022,7 +2022,14 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	    dev->lb.qps == 1) {
 		if (!dev->lb.enabled) {
 			err = mlx5_nic_vport_update_local_lb(dev->mdev, true);
-			dev->lb.enabled = true;
+			if (err) {
+				if (td)
+					dev->lb.user_td--;
+				if (qp)
+					dev->lb.qps--;
+			} else {
+				dev->lb.enabled = true;
+			}
 		}
 	}
 
@@ -2068,9 +2075,13 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
 
-	return mlx5_ib_enable_lb(dev, true, false);
+	err = mlx5_ib_enable_lb(dev, true, false);
+	if (err)
+		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
+
+	return err;
 }
 
 static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
-- 
2.43.0


