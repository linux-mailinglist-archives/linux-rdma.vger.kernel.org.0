Return-Path: <linux-rdma+bounces-9395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92DA87A4E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4660B16D1D6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15881262804;
	Mon, 14 Apr 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oXHvZS2X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BW7eyc5n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560F25DCFA;
	Mon, 14 Apr 2025 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619180; cv=none; b=D9vlQ+OEVHRRv8m67/SPpop0y65Jx56W6xxl2nq5LYnTBiv0EXH9tzSefbzIhg9IObG1d5VrL+wn7s0sghhVjEVBSc4xag39ifX/77KFJ6xIYkbJ1NYr0MqoaqcjRn9FBL+TSL7+29M9qKEhe7gnEVCU2PTyWHK9NuKQTEYkzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619180; c=relaxed/simple;
	bh=61F6yS3SeLiDBJeFobz+nPKysOXCT5pH1Ry4x0mEWwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lItHX4C3rpv2nqrnxzJUsoO5DogyTlXXaY5p0o/jjdOlCH/emkasPN8xjJo9OGRRkprocTFyHBhPKu4XJWWnA1+PqiltSTi/jnvPLvQUBQll7rNuuCiNS9jx8tAieUDwZDTIEnI4gtGsIR3GBomg9eXxVfems0SRDz2/sG8uHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oXHvZS2X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BW7eyc5n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/VnYhVD1SCgZYyfaXiiv1axKyoVwiXgocwEv4oE1Ko=;
	b=oXHvZS2XoGF1OUDHETEpesHyXLq7OFuBkAoXwt+6oCKMZrrFFF7uAwyKIDqzJqoXyqoqMx
	YfMGx/Wq/+MNteZfIoJ/sv1izi7t6HJy44wVg2hqGx0ck5MT8UTT10/XExG98CKxAN//+G
	OusqYZlGizraLiAQZfjQ1cDm7BhQ2SwbOYT7Ir2X/9itY/sZWkuig3cgmYDSu9N5UAd2we
	4DXfe2USWh11pvXMgy16WHeMjzegIHTAOIk2/I6NBfxU/jAKvND/ARkjDKzYATCwovn5na
	lAdIxHxyggXJgXvs29oqrL2p0PIPjlmvFObHVwm+/ndrprruazh3PRaU8SKhHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/VnYhVD1SCgZYyfaXiiv1axKyoVwiXgocwEv4oE1Ko=;
	b=BW7eyc5nmNTm4BrUjTKiQcxtNBwCiX+GSkj3s651FAkykMV6ELiCFt5lY/bvAC3YEtdm8y
	c90pAWGVmstytfDg==
Date: Mon, 14 Apr 2025 10:26:05 +0200
Subject: [PATCH net-next 4/7] wifi: wcn36xx: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-4-12af0ce46cdd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=1466;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=61F6yS3SeLiDBJeFobz+nPKysOXCT5pH1Ry4x0mEWwk=;
 b=x/NwFZLAfuFMn6Tuwkaaozs8DHU3CODeWCFL2e9Z5eSwidQOwOcFXmSdTvN9+ChrWvdguO2cn
 UysC7tAl9ggC5QE/fMdSdsC5X2A9PqW1zeBD1+dBhqDiAkkT9kN1N/c
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/net/wireless/ath/wcn36xx/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/testmode.c b/drivers/net/wireless/ath/wcn36xx/testmode.c
index e5142c052985ddf629b93d7b9687e6ba63a48e8b..d7a2a483cbc486308032709a99bba9a52ed0ff59 100644
--- a/drivers/net/wireless/ath/wcn36xx/testmode.c
+++ b/drivers/net/wireless/ath/wcn36xx/testmode.c
@@ -56,7 +56,7 @@ static int wcn36xx_tm_cmd_ptt(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	msg = buf;
 
 	wcn36xx_dbg(WCN36XX_DBG_TESTMODE,
-		    "testmode cmd wmi msg_id 0x%04X msg_len %d buf %pK buf_len %d\n",
+		    "testmode cmd wmi msg_id 0x%04X msg_len %d buf %p buf_len %d\n",
 		   msg->msg_id, msg->msg_body_length,
 		   buf, buf_len);
 

-- 
2.49.0


