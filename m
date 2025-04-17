Return-Path: <linux-rdma+bounces-9518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD5A91DE4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57497B206F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E954245029;
	Thu, 17 Apr 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+0jnMyA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4F18vwRC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD406242928;
	Thu, 17 Apr 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896271; cv=none; b=HnDJxgmFwIeZ1O08SqiHU/+K5KTIwwZzOlXhi0vch0CtClSCW/Xrwt/eBihAqwC3xEF/fRhwtzxed55QJ94aBR7i7BzLfadnbvGVtuGGHItKLjnEgJP16iI3WPVrQX+qidFTlipFw6Lk3xNeYvxZiIzhrI7C8qlTmX8+zJoRcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896271; c=relaxed/simple;
	bh=q5DT2URR0iIEIgICy/7GxHM8nUG2+FDbrbiNStsY9Yw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hAFe7AuL+MTZXRkrbnJSZSKgH2fqqPzEhDybp6/GEA0l/cbHS/v+7PQ9pF+1RlX1ChwcgacDGlrX8BUf5suYYvsLs3H8W4g2qzvSgHQfi1kPbHmL10TYO2tO6nE++iTg7wGWw1UdLR8Ty9OjnWSP3p8C4KHL/oM2swUfX3f3bOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b+0jnMyA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4F18vwRC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4LXHHM9pIIYS/FncXPzORV/LCy/Y/iy+i/1qQY0jvI=;
	b=b+0jnMyAUqQACm6y8lBp500HM5X/piD+c2TyCr8RU0raEUfvsvhCDW1huz0/iphE1MqsAY
	f47CKOB7KZzzcFlkp3w6dI3RBWxEet4TtR3GjHzBxO3XzS0mORQ49fTnVfdG4jNLHuch3L
	nCcaRk/Zns+AlF6Z5hesBmF5HKPFgzr33oxys0tN3hic7trhrxlCH9ajbl/B9sPvHmFn90
	CA7qskUDkY2O9pH/+YT0NMYnUDRRQnXb9cSCAR549ihIr01fVQv12yiWWVH5HB6CIqlH4a
	rh6ptcoE7Ssn9aDpwOAR564KGolJ+8LQGn1tYCeBRgMY80C7w5AEwJ4JKrGusA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4LXHHM9pIIYS/FncXPzORV/LCy/Y/iy+i/1qQY0jvI=;
	b=4F18vwRCjEGRayESMci2JVont349Cxglgm3zyTPojVGjNtVCsE6iYqrTJUM5uGH3TRHztP
	rGTxYINxZOmOz6AA==
Subject: [PATCH net-next v2 0/2] net: Don't use %pK through printk
Date: Thu, 17 Apr 2025 15:24:00 +0200
Message-Id: <20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPAAAWgC/3WNwQrCMBBEf6Xs2UgSWxFP/of0ULJbuyCbsoklU
 vrvxnr2OLyZNyskUqYE12YFpYUTR6nBHxoI0yAPMow1g7e+s61tjVLKyiETmjmyZNJkhLIZLgE
 R7Yk6dFDXs9LIZTff4VsQKhn6SiZOOep7v1zczn9299++OGON88NoA7Xn+nR7sryyRuFyRIJ+2
 7YPY+cLuMwAAAA=
X-Change-ID: 20250404-restricted-pointers-net-a8cddd03e5d1
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896267; l=1475;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=q5DT2URR0iIEIgICy/7GxHM8nUG2+FDbrbiNStsY9Yw=;
 b=X08p2lFA0ynS1mcdfvjxdH+ZL1KjMvP/BrAphh8RvW1oCW8Oz+ExDLOL0sHQ77+OvLraMX/lt
 /ey18iOGONmDpGlQAtBTi6GVmbSjXx7x12s4a/rI1lTDInlhQJZgtP3
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
base-commit: cfb2e2c57aef75a414c0f18445c7441df5bc13be
change-id: 20250404-restricted-pointers-net-a8cddd03e5d1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


