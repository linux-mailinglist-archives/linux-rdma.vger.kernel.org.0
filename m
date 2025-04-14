Return-Path: <linux-rdma+bounces-9396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BDDA87A50
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1E716D525
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D4264FB2;
	Mon, 14 Apr 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIrUb6Ka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b81luPP9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68C25E45C;
	Mon, 14 Apr 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619181; cv=none; b=ns4l/oqArD2oXvmAsoG81/HW55LioW5CZxlQgpDgesRV5n4pI7J67D9Sps6bN3cAH1oFfYO16Q0qOgmDGKLnQHc7Lc25L+UsAveWAI3Iajo2VVOuLhTabsVCUgmbwSX7c/bIo1JhTgsPcDrc82+tUhrk8UQJQJ6qo0YNzh+fWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619181; c=relaxed/simple;
	bh=WzJ/HmoEyIxMvJeEOlZ2czFzOQnDOjD3iHfVNkyBNQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0FHdT1sWeqkJgP105HkpBro/KduSth2eFueiYYQt2ReieJ+DuRXjmCJpBJ6hwz+RgzV9B8w0a9OtWogMyi4WjYgd8NNN6LucjObwRwk9fWbLW4Mb6pOuXKGiSGW9NwQCrqIDTTJSVZ+dqaVI+Yba8gsucTMrolz7CIe1jo9qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIrUb6Ka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b81luPP9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OyON1Yf1rr+8CzcSa4hkkYGRtID+dWFkGoiAoSKTwA=;
	b=TIrUb6KaLTcpHArLnyDrZ1/XzY6utlfmyG99ojUWp1bMSzIHF1Vgi08/TVQvWG4iM+opbL
	cWWo8YuQ2dBWBoxAayYDMVZlaw6Ioc86xZFPw3MD/rmV/AU9pxMCsjA3+1uR81ohZq6+Qa
	kPP1Z+VG90nbHrkaymmkH78gr4q3g3rRDaoSHgaX1aD1/LbBlPUf1ZuHGcTQI0vfjfPb6j
	ospQd6F5IkYTdO/VqmDmF2+V6Lnjo4B2Ga4yfmBs3b/EfvEMEgoz8I1fzPr6b5FZ1Lt53v
	XI3GSuhhqbNqKW3qpT3asL9boRf5663GPlGNpqyxXpj1DUZRhDg1b+shCLaklQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OyON1Yf1rr+8CzcSa4hkkYGRtID+dWFkGoiAoSKTwA=;
	b=b81luPP9nxBvVUYPxsolvoc8ilyKeEV88+u2tvl6LB2jk2uYlffGU4Xys4Y38dexezpnwV
	22324LRkDL8QYaBg==
Date: Mon, 14 Apr 2025 10:26:08 +0200
Subject: [PATCH net-next 7/7] net/mlx5: Don't use %pK through tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-7-12af0ce46cdd@linutronix.de>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=1640;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WzJ/HmoEyIxMvJeEOlZ2czFzOQnDOjD3iHfVNkyBNQ4=;
 b=Zuho2QqTEJS0pVHFp2MmyTiIbCDfOTyQV+4ybcxy4I85pU30LrHxUGib19TU2f1V/3c3/DFBC
 e7ly/4/qAorA4GYLUQdHhuDpswxVWNrCo2fL5St4/wIo6zWsIBOTgfx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through tracepoints. They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
index 0537de86f9817dc80bd897688c539135b1ad37ac..9b0f44253f332aa602a84a1f6d7532a500dd4f55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(mlx5_sf_dev_template,
 				   __entry->hw_fn_id = sfdev->fn_id;
 				   __entry->sfnum = sfdev->sfnum;
 		    ),
-		    TP_printk("(%s) sfdev=%pK aux_id=%d hw_id=0x%x sfnum=%u\n",
+		    TP_printk("(%s) sfdev=%p aux_id=%d hw_id=0x%x sfnum=%u\n",
 			      __get_str(devname), __entry->sfdev,
 			      __entry->aux_id, __entry->hw_fn_id,
 			      __entry->sfnum)

-- 
2.49.0


