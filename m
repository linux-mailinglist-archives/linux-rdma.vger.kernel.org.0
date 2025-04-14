Return-Path: <linux-rdma+bounces-9393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B598A87A45
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F78F3B19C2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCC25D546;
	Mon, 14 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ofLbcum+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8G1LC3n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A05259CA9;
	Mon, 14 Apr 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619178; cv=none; b=pG0kH5D3IAbVKtvWG9fC+7GZ0ocmRq4LuRcKeQQBPKXuULRU7WnBW7fChBuV8mc3TF0iwa2fJp8Xmgxdd0x7DjWbqhZaiClSkPticRjXyptDphO+usvKfCuoLU7egfOHd/Qah5p01YDTeDTu7xM0l3be92gNY6wdzx3OdE1WsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619178; c=relaxed/simple;
	bh=Mog1fUxDWxYnW9KpoZ7DzBFzkRO6Ky21p9XzMNb3Vf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5e8Z3oVG5/tG+SSl9AqcvGjJ9/d3xA6BvtexiXAhxPVPSci0t7QyvEEyTFW/no9OrpONB01jSlU7UFCBXEMceepCnPSGl5ytb7YQWlJqoCWiRcjRmdSnzKq16Y1c8L2BQDRPZV9LsuLqtyMhojxCiLE9Y0AEcUOqjjjDOqCg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ofLbcum+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R8G1LC3n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+p3ZZ8m+P6MBwg+X0cWHrVyngWhZc3MgIiUJosTjVM=;
	b=ofLbcum+e5ES97JZNHgUn4eizYkDbWnLe7xsM+Zdmxa5+24Dx7P2aGHM7z3O141w/4Rr+k
	WRveEv8SYrJCfpnOWdRe0Lrhgax34JsFWwZTghEZ5yEiNmWu6LJq8IoexKOIoS9JwGMj1U
	S4w3rdfc484lB0AX/t1LFVhunaQKaxEszKarS5CJczq3PXzEjlrWASNsfBbYVIl4/NbegK
	ySYcWod+zpWWxlHAn/FkiejzfE4POH5aygMEbC5tcYMs8Peb/Qj9iPW0Q1uyrh/mjAD2S0
	9q0+XyXre1y2vy0I+hqySM0tWoAVSXGqdyLIy8qXEkZlH8mWo+xn53pyczg7DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+p3ZZ8m+P6MBwg+X0cWHrVyngWhZc3MgIiUJosTjVM=;
	b=R8G1LC3nTq9auZ80K7wKWRdWZ5AzwlgcChsPmwJreInP145Kb0TjPt+6wFT5D5ZCsiLixI
	icD4Mn52YWhoOcBw==
Date: Mon, 14 Apr 2025 10:26:04 +0200
Subject: [PATCH net-next 3/7] wifi: ath12k: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-3-12af0ce46cdd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=2012;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Mog1fUxDWxYnW9KpoZ7DzBFzkRO6Ky21p9XzMNb3Vf8=;
 b=b/us2xNbwh8znqfnzh9E4Av2oMff6qZufNEzIm5QnYwVPSQtCv4hVANkyEXwMgwxfZZXMClBq
 TRKDFzK5g7kCqMlmFJDdqt8wzmcZOLvplpYQXCfNLJTM+XlGTzlWrnQ
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
 drivers/net/wireless/ath/ath12k/testmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
index 18d56a976dc74c4f6eab87e358c14d4faea648e2..fb6af7ccf71f44ae4bd01cde53fba3527eed0d2d 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -97,7 +97,7 @@ void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
 	u8 const *buf_pos;
 
 	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
-		   "testmode event wmi cmd_id %d ftm event msg %pK datalen %d\n",
+		   "testmode event wmi cmd_id %d ftm event msg %p datalen %d\n",
 		   cmd_id, ftm_msg, length);
 	ath12k_dbg_dump(ab, ATH12K_DBG_TESTMODE, NULL, "", ftm_msg, length);
 	pdev_id = DP_HW2SW_MACID(le32_to_cpu(ftm_msg->seg_hdr.pdev_id));
@@ -227,7 +227,7 @@ static int ath12k_tm_cmd_process_ftm(struct ath12k *ar, struct nlattr *tb[])
 	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
 	cmd_id = WMI_PDEV_UTF_CMDID;
 	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
-		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
+		   "testmode cmd wmi cmd_id %d buf %p buf_len %d\n",
 		   cmd_id, buf, buf_len);
 	ath12k_dbg_dump(ar->ab, ATH12K_DBG_TESTMODE, NULL, "", buf, buf_len);
 	bufpos = buf;

-- 
2.49.0


