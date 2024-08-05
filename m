Return-Path: <linux-rdma+bounces-4205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A29480F2
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 20:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C9EB23A65
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F916F8E8;
	Mon,  5 Aug 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8ONGOzX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6715FCFB;
	Mon,  5 Aug 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880629; cv=none; b=RCQZMH+d3it13C1QIvZjnIifW/2oZQdBxAD12p2THcWYoMQoAVNk3eNcggoSIaolSJXvKkygjBzDaOxaKXkBXfdwEm5h9BbI3ykqZhvNo8P/HYyV1/DLOJPLT4Ojdw46l1CZ95xoufGU5y78OeRsoJKPoijTVzqfFTN2b+34z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880629; c=relaxed/simple;
	bh=D/p/sm0X47naiWpZmPaylW7bn5QRjiP+yFSrDBMSf7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2mkzlvXu7Q1dds+Aa4nGFvw7IVfUql/0oHBrEn0rurhNO6ARJCu8OTdLizDw8KJUfVYFlWlcTlYrLsGdpB5SY4tmllqksdXmn0i/7nwZZE7Cb3aCeORV6K2cW79eQUZDmxw7ggWnhEFMigLO/8ww5mtjVlWXtziB7v805dCOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8ONGOzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F82C4AF0B;
	Mon,  5 Aug 2024 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880629;
	bh=D/p/sm0X47naiWpZmPaylW7bn5QRjiP+yFSrDBMSf7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8ONGOzXkZR58aPgjeCZ4AfCnTRFC7ZvdqgjiPTTc44RMeCrrLji4Teaj+5RWrELk
	 EkMNVhBCUb+9HSRshicYmVoXZxwsfXeSfcYOLJVaK1KMGJwG5KiXEnZM6d4hoEhGaQ
	 1usycOBxyPoxm9ksv5+amsQ0Qpr3S6J9qRKPtCuJTK7VUV14fCe7OWhXqRhMCm9YAU
	 cvQ9wx6tI+K5Zdfk7Mbs80X25vb8N5izIiQdxokKVKRJF9V3q8qYMnUZz8vSxSkUub
	 8F/k4PUX0fj0TY9UbEMoxdrhwFFe9nvgiJ6K10JDQXKkclzVtO+ILc60J1L9Gfr7Gm
	 HWh3EKPVl9kgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 15/16] net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule
Date: Mon,  5 Aug 2024 13:55:47 -0400
Message-ID: <20240805175618.3249561-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175618.3249561-1-sashal@kernel.org>
References: <20240805175618.3249561-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.3
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit 94a3ad6c081381fa9ee523781789802b4ed00faf ]

This patch reduces the size of hw_ste_arr_optimized array that is
allocated on stack from 640 bytes (5 match STEs + 5 action STES)
to 448 bytes (2 match STEs + 5 action STES).
This fixes the 'stack guard page was hit' issue, while still fitting
majority of the usecases (up to 2 match STEs).

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://patch.msgid.link/20240730061638.1831002-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
index 042ca03491243..d1db04baa1fa6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
@@ -7,7 +7,7 @@
 /* don't try to optimize STE allocation if the stack is too constaraining */
 #define DR_RULE_MAX_STES_OPTIMIZED 0
 #else
-#define DR_RULE_MAX_STES_OPTIMIZED 5
+#define DR_RULE_MAX_STES_OPTIMIZED 2
 #endif
 #define DR_RULE_MAX_STE_CHAIN_OPTIMIZED (DR_RULE_MAX_STES_OPTIMIZED + DR_ACTION_MAX_STES)
 
-- 
2.43.0


