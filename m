Return-Path: <linux-rdma+bounces-12664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA440B20408
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC943B4B34
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA32DE6E0;
	Mon, 11 Aug 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwHk0GWp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pb1pNvSd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CD2DCF6C;
	Mon, 11 Aug 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905410; cv=none; b=jfCyLClq0UpO2h15iximCTe+fWY4fFFnEOtARi/w9YU4NOMIRXjWbDe0Z5RrTjQB3sg3YvMFj+WOVqToxJqj8xuxhj99CUx+KaeFX6eY+hthImDoqP7/7XZ3quQ0NucPAYIDo/25qJ7OIw/cT7NTmEhW9xPH4na5gaqMFoNe/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905410; c=relaxed/simple;
	bh=L8xlTdbV68sRk5Mq8IoevADaEzgZ+a6EIL6L9IxI4bQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cyMXNWF7OdrWLMLRSvjI0uXzn0yVLiWXsNzLUVZBLsmifoeLuYRLIuFMtbhN+V0hdob2wfMxmvETVOdVwY8BMd4u7n44EcD8YVQpzrU+2rLUa29MtqGc9ushQoG9eCoE5CcV+CJu/EDL8L8iBNHpqaiXLXyKCJ6a1ImnH8emugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwHk0GWp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pb1pNvSd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754905407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0423Apn/yDdM75Hzc5wqjfCAct86GXaSdLhTu73vbY=;
	b=WwHk0GWpQylBlDPLOvp+4jJT31NqMeZNolN80ZjVuMFaTaFFTDcbpwJ/ppwV2YoSLJjwlP
	SEXCqIMdUhQYxNFXRf5hMlM0iKBLEiPHSPFb5K+8nXmfqSB7NYk4OxyPqc8kdb85dCAAl6
	2tc28DbOSxxq9swMqTOLU9Gkr8ktWN5g8/qa1L+UkFqO4+7hnxoHIwRdg+T3dh+xEZdCY6
	zScyVPDSYhQ7iRpJU3blIzFH+JKgxiTRWXJsjIStXVRm4g44cLB1aMk5uKGdMl85auGIb0
	uv1ogSsUa4u8qS8tQxROXpqm99pDmvL4hob3PnM6VUCb41YyILHOVfTiWcDfEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754905407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0423Apn/yDdM75Hzc5wqjfCAct86GXaSdLhTu73vbY=;
	b=pb1pNvSdSSE86gdlMRearVcFmTxP+TDEd2qJYBnnHGL/kRSfzoBuej/rw2QyxxUcmCmrEe
	ycajX09I9JyPSXAg==
Subject: [PATCH net-next v5 0/2] net: Don't use %pK through printk or
 tracepoints
Date: Mon, 11 Aug 2025 11:43:17 +0200
Message-Id: <20250811-restricted-pointers-net-v5-0-2e2fdc7d3f2c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADW7mWgC/33NTW7DIBAF4KtErEvEz4BpVrlH1AWGcTNShSMgl
 qPIdy91F4mquMunN/O9OyuYCQs77O4s40SFxtSCeduxcPbpEznFlpkSyggQwDOWmilUjPwyUqq
 YC09YuXchxig0mihZ+75kHGhe5RP7OUg4V/bRmjOVOubbOjnJtf/V5bY+SS64VH4QAcG2peMXp
 WvNY6J5H3F1J/VsdduWatY7hKHDwaH1+MrSD8tKt23pZum+80ZLNK7vX1nwsLr/LGgW9N5bQBD
 WuL/WsizfPCy4dLABAAA=
X-Change-ID: 20250404-restricted-pointers-net-a8cddd03e5d1
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754905404; l=1968;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L8xlTdbV68sRk5Mq8IoevADaEzgZ+a6EIL6L9IxI4bQ=;
 b=rSJrXaszfDDrt8hU0fUQBJsibudoaXOy7MMpFvOV2l/6IRnujeE+95Jis4SetZdmM92vI7QRM
 S8mPnXGv4ASAjo9fuPA5/Q+dBrqBK0nVGLmwt7QBPukJ5c455TuXRmd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v5:
- Rebase on v6.17-rc1
- Bick up Reviewed-by from Paul
- Link to v4: https://lore.kernel.org/r/20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de

Changes in v4:
- Pick up Reviewed-by from Simon
- Link to v3: https://lore.kernel.org/r/20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de

Changes in v3:
- Fix typo in commit messages
- Link to v2: https://lore.kernel.org/r/20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de

Changes in v2:
- Drop wifi/ath patches, they are submitted on their own now
- Link to v1: https://lore.kernel.org/r/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de

---
Thomas Weißschuh (2):
      ice: Don't use %pK through printk or tracepoints
      net/mlx5: Don't use %pK through tracepoints

 drivers/net/ethernet/intel/ice/ice_main.c                      |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h                     | 10 +++++-----
 .../ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250404-restricted-pointers-net-a8cddd03e5d1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


