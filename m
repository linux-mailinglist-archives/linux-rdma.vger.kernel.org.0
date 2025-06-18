Return-Path: <linux-rdma+bounces-11420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BEDADE446
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 09:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418AB17B00F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D7F27E1AC;
	Wed, 18 Jun 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I2EZxJXs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbgFDKDY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632E27816E;
	Wed, 18 Jun 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750230500; cv=none; b=ekNVla0Zo7NcqlIKiZYLJ9FQAijI5gh7bxej/MA15XfAs5w94qBaOgTj6YG2nVRuWEQtLVeBbMLyHDIesnYmdVovTRWGyENylRGKTi0b2YHQgr2CkAJopkuLgjt7OLXVfMxRB18+EX6ag87dZf0surpZV9UimSd3zDESySE4IEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750230500; c=relaxed/simple;
	bh=HQUhUUMz1hwkIw0H+WnoEWZYfkvGVKwDKzojTFzI74U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UdjKcgBirfvUfRmRS4w32XIcPJhtWW5X3X41jZeAPVnFPP1S7R9TCBVFWSOxUEwBHhvNVFWfp3feF7lVyY/BaYH/qKTiMf5B3jRmXEYySm3mqy0kUqzUo7AdOi9u5uQWvK11OuuVhOT2jBb8nfI3Wj39J3vpzuHfeSh8d0n2Wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I2EZxJXs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbgFDKDY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750230496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AthrdE03eMT6iyFsW/vA3bdClID4lHYN+YmePk1prAg=;
	b=I2EZxJXsMG2CTO7g5gZZf1qltdHNLqFjmsBKmGggS50/UZiRsCFPdz5DhOb9RGxWls8eHc
	bYP7KbbfUGQmtJ+Ee8tXBgYXe1lQVNuX15Uf2dX3uS+JM41tqXajUfALR7RqZvU689ESES
	sma/nVhg/68/CO3nsc42B36La6pHvxaHub9NC5pkh/nwRcUhvxnuZFRwECywBr0I2pCYb6
	Em7GDPpRqTjKla2tOiCnr1m3gzHky/MkqTz6qqck8DKGjyEffqZvt6pNnhzAIOYKM4MbKy
	icNyrZ3X8jBpzLnamNQ3388eI438j5sNT0JP7DL31r166XhFFWFTGy4iKB3x7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750230496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AthrdE03eMT6iyFsW/vA3bdClID4lHYN+YmePk1prAg=;
	b=BbgFDKDY3M2uyykrupOKp2zK1iwQwdxSS5saBGNgSDiVEZPEd+V2WAEzhndjPyjbxNOD1t
	ipt47VuIseiY7GDA==
Subject: [PATCH net-next v3 0/2] net: Don't use %pK through printk
Date: Wed, 18 Jun 2025 09:08:05 +0200
Message-Id: <20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANVlUmgC/3XNTQ7CIBAF4Ks0rMUApT+68h7GBYHBTmKgASQ1T
 e8u4saYdPnyZr63kggBIZJzs5IAGSN6V0J7aIielLsDRVMyEUx0TDJJA8QUUCcwdPboEoRIHSS
 qRm2MYS10hpPyPQewuFT5Sj4HDpZEbqWZMCYfXnUy89p/db6vZ04Z5UJZpkH2ZenyQPdMwTtcj
 gaqm8WvNexbolgnqe0AdoRewb+1bdsbHhNJuxgBAAA=
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750230493; l=1640;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HQUhUUMz1hwkIw0H+WnoEWZYfkvGVKwDKzojTFzI74U=;
 b=QlTPnkpsoB7IxMXFtb6EQuaKpoYFy/ecQsJwnFfe1wgZEQyKZKKJ6NznpDduSF+m9engtl6GI
 i8njRl6iDk7CynbKVDiatPcDnpR0+yna592iCmay7YDBYaG/O14khee
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
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250404-restricted-pointers-net-a8cddd03e5d1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


