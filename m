Return-Path: <linux-rdma+bounces-5072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F419848FF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CC428194D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF281AB53E;
	Tue, 24 Sep 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OLUyMW7o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5C1B85D5;
	Tue, 24 Sep 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193683; cv=none; b=pQQsmwv4m7n5PysbGgp5lKi6S7bnyLQ/F+kcbA1lHOEsp1ej3J4xcVZkV6qVbhz0DLcsDQOSShX0kcrkJig8qWPRQ5ARgOc6zEy9wX7h5oYRrpVEOy0Dlboa4gKcGxhUCTyZwwAzha5m8Wsr0Ot44GsGo+z9RyXtp+/IDdWg9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193683; c=relaxed/simple;
	bh=hD77i1qmsqCOqCdwoO9P7aWucJQShux9Q1rT0/FLwz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMUcePcmUtLUxftnFlVsudSePYQRQUBnlPD5PpdT/mKhkI7uRbmIMMBgYdNbiIrSNtQ9UcldoMQcSlhnZVBnbzqpw78bBPpAuxE1jlyJMfxE3tZXbhj5vCwdD+xYwzjpZOxDeEbWrgiJs/jx/2RAzhLYWWhajAjOhV+zV9MjRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=OLUyMW7o; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [195.9.103.206])
	by mail.ispras.ru (Postfix) with ESMTPSA id A9A5A40B1E7C;
	Tue, 24 Sep 2024 16:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A9A5A40B1E7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727193670;
	bh=wYtq+9qAKmUShueTvigCc5x0uxAhM9J8lX3RiU38r4k=;
	h=From:To:Cc:Subject:Date:From;
	b=OLUyMW7oMCvy1K2pqgtwwnKMSdjj30yE3qhj6yO4HvRfMPkBoeV6BLkS+St6/XPFG
	 rSS1IY0ruTZc44BLaeOa66WDrMvWLxHSP8t0t/wjful/AQ78BYJOvwj2CzsZG8DUkT
	 uOWT4yQ04UYceMVdmfp4HUzGZVNASDImjfr2A85Q=
From: Elena Salomatkina <esalomatkina@ispras.ru>
To: "Сc:lvc-project"@linuxtesting.org,
	Saeed Mahameed <saeedm@nvidia.com>
Cc: Elena Salomatkina <esalomatkina@ispras.ru>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxim Mikityanskiy <maximmi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Maor Dickman <maord@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()
Date: Tue, 24 Sep 2024 19:00:18 +0300
Message-Id: <20240924160018.29049-1-esalomatkina@ispras.ru>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
which is dereferenced on the next line in a reference
to the modify field.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
---
v2: Fix tab, add blank line

 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index d4239e3b3c88..11f724ad90db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -23,6 +23,9 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
 	struct mlx5e_tir_builder *builder;
 
 	builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
+	if (!builder)
+		return NULL;
+
 	builder->modify = modify;
 
 	return builder;
-- 
2.33.0


