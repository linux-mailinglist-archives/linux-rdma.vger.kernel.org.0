Return-Path: <linux-rdma+bounces-12301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91229B0A504
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC5189FDFA
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AA32DC332;
	Fri, 18 Jul 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/w5LVRb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7nloz6c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C042E370B;
	Fri, 18 Jul 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845031; cv=none; b=hRto10fcJLqR0eetwzOpbI4tPu383sd2Nu9ZCm4/dpb6kpxxqva5Jb9s85sgczPKgpstSqTVbjTzE15PjdHG6eJchjQ9j3kO9vmOkm7HVrF85TblwcwwONGJM/BJx1kNKOqH42FR1+uxuBWukiWnmgj9YnfsAvLVgd4UzCTIJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845031; c=relaxed/simple;
	bh=3Gj5w5HsItXOBNki2riEbc69tNDXQwN6DrDF+HRXaSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t/mSPtYy4FrZrKInjnCeWpCeojc4VvPeZwVu0RTDahsRtj4zUIt14lIOe6gY/8eJbphSzFFJ1fUsQPW2V4TFCZ98oz6JzTsZp7A/hlCuDNfoPbIrlDYXgh+2N+UfFMDOnGuXZ+jT1xOPDBz2osrj0rAvg9MlvIRQWApnlOQEL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/w5LVRb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7nloz6c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752845028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iE7hw9+bZACRqLCE5oK6anYds6V+tWE0n5Y1ZwoRR1M=;
	b=F/w5LVRbDSebIic/4Y0Fr0thO5Uv7WpT55/AIK/GzmnkxlvMy7c9ThpvuvCR64mGN35mj+
	IHqX0+BEuu+v8EXbUxLdoX9EmGvLQzjweRMIVX5JSWNWwx6UIqnakE47soxm3/zH10JFc+
	+j2mlAfwiQnb6+j5PgjNMPDXesocGEfQhqlY+WIa/jzBgTn40xVkb46SaixhyZonZPApYB
	qb+VNCOgfOi6a+/iNabXlFO0kgAJ9LxZGPcOIX21m0trgX8OhXTzjP2EVnMcmccEBjBZZw
	WfGlhV/Ejr2K/EMAS8oy4UGmTHp8JpC6mQApdvx32DqEywk4ghpGcOk/k5WY5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752845028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iE7hw9+bZACRqLCE5oK6anYds6V+tWE0n5Y1ZwoRR1M=;
	b=J7nloz6c1uwBPmOsvHuHIjNrJDgNV6BNkq7pz0gJXDOHjEQxUfHpCxKzjg9Si49GAqSnMf
	j7kah6zkbakXKdDw==
Subject: [PATCH net-next v4 0/2] net: Don't use %pK through printk
Date: Fri, 18 Jul 2025 15:23:41 +0200
Message-Id: <20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN5KemgC/3XNS47CMBAE0KsgrzHyLx9mNfdALBy7Ai0hB9kmC
 kK5OyYsQKPJslTdrx4sIRIS+9k8WMRIiYZQgtlumDvbcAInXzJTQlXCCMMjUo7kMjy/DhQyYuI
 BmdvWee+FRuUlK9/XiJ6mRT6w10HAlNmxNGdKeYj3ZXKUS//W5bo+Si64VLYXDqYuS78XCrcch
 0DTzmNxR/VtNeuWKtbeuL5B36K2+M/SH6uW7bqli6W7xlZaomq77q81z/MT130swGQBAAA=
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752845027; l=1796;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3Gj5w5HsItXOBNki2riEbc69tNDXQwN6DrDF+HRXaSQ=;
 b=DWaPcDFUr2/N2fYXMgVEmheOtBa9OQXB8VHbff97i8usZ/cxn4dmeEsP68M/YKkJiWq1Z+H1c
 FPEwYW7yHA9DIGq5iZK0JE0MCO7A8B3773+7aVeQ69bQMJjF6fLB3Te
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
Changes in v4:
- Pick up Review-by from Simon
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
      net/mlx5: Don't use %pK through printk or tracepoints

 drivers/net/ethernet/intel/ice/ice_main.c                      |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h                     | 10 +++++-----
 .../ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250404-restricted-pointers-net-a8cddd03e5d1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


