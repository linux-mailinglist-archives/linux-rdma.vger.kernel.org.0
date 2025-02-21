Return-Path: <linux-rdma+bounces-7949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2AFA3F35E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D719C1711
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACBF209F26;
	Fri, 21 Feb 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cp5zPfN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0JsdDxVr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B71209681;
	Fri, 21 Feb 2025 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138746; cv=none; b=qL16i77KzyR7m8Lcl6P1LcMXr/E43rtKe7uUSOfgFuLN2rEcCiNLA14Nuixn5e/2nwcGd3hagPcI/+ip8XZHyk1epTgWg87rzt14uit/+VXlf9Q6Kxbpif4GS1V0GqZtlTpyDzAkHRAy6YrMCuOIkuQGq2he13q0Kazo4uYZPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138746; c=relaxed/simple;
	bh=skTq8v46i33/n7jiSOO6gDliigjNOXLxMEJHCcPRx+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5ybjLwKjScV0nXR3HLgIgI/immWY9huN1dMHVHmWBomGIKaaHE23VivOPeSgkMnTRYZFRHe7gVYM/rjobF/GUfZFGLCCzsX/OzKH/OSAMctJQMs8f+xrRqT2U2D4vv6xY8HoFVbTMpdYj4c6IrdYFp9NuAsQAEI/SJlXCzxdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cp5zPfN1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0JsdDxVr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740138743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FnyOGTGILqtoyxYF47Rnj+ZtDSyzv0taY1OiVXpZQ/c=;
	b=cp5zPfN1l4+/22KuDevrLwmKAiSApYTsP7IoGEeaNW24Ws+J21/eTCpTIERoc+vH0fN4bp
	+5kBpo6GIcl30Mo3xBwZ2AxCOgT5ybBaYFAM3816by635m6H51zIHy2VXxRv7rusnPNRK8
	HxwxSNigngM3JAotqARDG3qMf88weq5B3SXQnqfsl8qxkBlGZAA5o/qO/wIcwpn3kM1D6W
	aoPHyLNPZG9/V+02fnlza298u8Ea8IE0aMfd0/pNXyXl3cAzxpygUnQLS6o4tWBjLZRLIY
	Z3xXavKGOYflcqC/IEmDQXv3axhBDPg/4Ab8QjhHMbFY8qJZN3kyyPr4HG9MRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740138743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FnyOGTGILqtoyxYF47Rnj+ZtDSyzv0taY1OiVXpZQ/c=;
	b=0JsdDxVrRO4NXURl/jBEdu1ov5yDgiur/dbDSm2qLPhmGP9biERnG1U4Epx6+tXRigxSBg
	KdUIAtqrAp+13bBw==
To: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 0/2] page_pool: Convert stats to u64_stats_t.
Date: Fri, 21 Feb 2025 12:52:19 +0100
Message-ID: <20250221115221.291006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a follow-up on
	https://lore.kernel.org/all/20250213093925.x_ggH1aj@linutronix.de/

to convert the page_pool statistics to u64_stats_t to avoid u64 related
problems on 32bit architectures.
While looking over it, the comment for recycle_stat_inc() says that it
is safe to use in preemptible context. The 32bit update is split into
two 32bit writes and if we get preempted in the middle and another one
makes an update then the value gets inconsistent and the previous update
can overwrite the following. (Rare but still).
I don't know if it is ensured that only *one* update can happen because
the stats are per-CPU and per NAPI device. But there will be now a
warning on 32bit if this is really attempted in preemptible context.

Sebastian Andrzej Siewior (2):
  page_pool: Convert page_pool_recycle_stats to u64_stats_t.
  page_pool: Convert page_pool_alloc_stats to u64_stats_t.

 Documentation/networking/page_pool.rst        |  4 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 24 ++---
 include/linux/u64_stats_sync.h                |  5 +
 include/net/page_pool/types.h                 | 27 +++---
 net/core/page_pool.c                          | 95 +++++++++++++------
 net/core/page_pool_user.c                     | 22 ++---
 6 files changed, 113 insertions(+), 64 deletions(-)

--=20
2.47.2


