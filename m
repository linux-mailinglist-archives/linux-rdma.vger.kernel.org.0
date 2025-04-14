Return-Path: <linux-rdma+bounces-9391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16324A87A42
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0993C188CCA1
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DF25A621;
	Mon, 14 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1zujVLG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2f0ZORhw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D590259CA7;
	Mon, 14 Apr 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619177; cv=none; b=kQ2S7BP0n5uh1d/KUfiRkkUk6txz1G9FM6DOgnb3vvIQU12XynWjR9Ay4OikrhOfnvHtzg+x6wrvCSBqFisW0IfY+Xo6kyQ1Pnnh3ZKU0kUKvaFW6KhvroM2GB54o98BXZVpNvY/qZjhJJSYRjTrvRkqdM3/995CyP5DInTlcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619177; c=relaxed/simple;
	bh=wCL19/j4oZD9OXQEwiK4h5ZQlR+8JRFqjWaTwz3M1O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeBvZyLNeuSJkOO9JxlugAu/DGGUtRfwNyH7+EfwUgDVbBfkPCPTUolQtvOyA8M81GmDKWOjPX+eBaCoiewlVGYwJ2v6EiplbFf48a1HsCJv25SXsuTtI/YdDIs2La6WLfpL5RmhNo6rG5PhfoWEARu2KbjJFhtQaAthT5MurV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1zujVLG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2f0ZORhw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJzaMCUEmfS88/pHV7S6utRVF0OcgJooEZ6khtDSVo8=;
	b=o1zujVLG2sQaTvMO6OACsI/499VzUxoEJUGqHj+qgv3E4KUgw4ysdGF3KRplnLfOHRVvHh
	C8sMrwd65T7vZGfCJrREE+bUEk9LL2vMgS0X0+RuJbIQeppjCp8fGV/UwnIp45VWxKazpm
	pPUUZ850J9Mwl2W2mFfVm4DBXwfC/tD/dqp1qpRBLw0A35yogM53wwW0qStrpoRhr/vxLu
	kWaPzO4nQZn6I8DkAoQHZ4cRPwtJiEENp07/CeSdtns4W9KJPsrCtCUM3iEx6YXuDwiAir
	0PyhOOCI6wQTQJQxGFU6nSJUCkG9l5cY6q/N9EpiaJdVTZ1mnhZtHJj1EeXsvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJzaMCUEmfS88/pHV7S6utRVF0OcgJooEZ6khtDSVo8=;
	b=2f0ZORhwJPNdlz9bEPHxT6ecUDp77xU2Mn7EJRnJRcfM4eIVe9A8P3Zm0rUrsQn+we0g90
	o6gNm/VzeLWiueAA==
Date: Mon, 14 Apr 2025 10:26:03 +0200
Subject: [PATCH net-next 2/7] wifi: ath11k: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-2-12af0ce46cdd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=1527;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wCL19/j4oZD9OXQEwiK4h5ZQlR+8JRFqjWaTwz3M1O0=;
 b=Mll02AJLlxEAfIM3sBZFqErnG63AQHi+l+lIgSrBUXhRrD8igpMkDkzAgCyX/kNgfweVtnVzf
 eq1XA46Yw0ZD7+inGUGlFx1MAdV8znRd+XlcYbJtcFA4dVo7Ec8CwHn
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
 drivers/net/wireless/ath/ath11k/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 9be1cd742339c95ffa74c09bee924f4eff15134a..a9751ea2a0b73009bfb600d51c3978200ce99114 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -107,7 +107,7 @@ static int ath11k_tm_process_event(struct ath11k_base *ab, u32 cmd_id,
 	u32 pdev_id;
 
 	ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
-		   "event wmi cmd_id %d ftm event msg %pK datalen %d\n",
+		   "event wmi cmd_id %d ftm event msg %p datalen %d\n",
 		   cmd_id, ftm_msg, length);
 	ath11k_dbg_dump(ab, ATH11K_DBG_TESTMODE, NULL, "", ftm_msg, length);
 	pdev_id = DP_HW2SW_MACID(ftm_msg->seg_hdr.pdev_id);

-- 
2.49.0


