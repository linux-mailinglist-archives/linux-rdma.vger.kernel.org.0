Return-Path: <linux-rdma+bounces-10061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C21AAB7BB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 08:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7173B5C56
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5D3464A0;
	Tue,  6 May 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGJqqAGu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7C284692;
	Mon,  5 May 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487014; cv=none; b=Ww2Akq6vlnk+kS+FJkmrpXWeIyIiOjHNKseasdLgMUj0u8XK1OOEdkdb6KUQ+jsqYDpsxPJD+2SHyX25k7Ev0lBG5Yn8OifOUGgVt9GLrGFf5Y+1HS1cVxuzdAQZ2AOU0d2AYcue06eMx62mxklpDIMht27uHakHYxsw1PwbFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487014; c=relaxed/simple;
	bh=luk1d5dvK5s4+w24BiCGoAm4BeBTHfKMzopG+08qbQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MiMvEfIxKSAQ61gvgtiTXAhwPYAIi/nq7LBJG68YgHGqR6Yx9Kl2IGOt4gKJfVp3DJh3AYzpkmKDyV18oCXstXnbChUHas82kexU2CDtpee1NxSXXqMPkqbw7JT9hWJT9sQQjvwDNktINXEsRpp/Jn8zZ2ELWDbLqejvY3Q33ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGJqqAGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E2AC4CEE4;
	Mon,  5 May 2025 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487013;
	bh=luk1d5dvK5s4+w24BiCGoAm4BeBTHfKMzopG+08qbQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGJqqAGud+f2IoXcaUOGCC7TM82ffcUKRZs5x8sqbJIb+VXebtI6Pta0mLa23Ms+d
	 EvqN1UfD+NYl3a5ozvggOg22MS8pZjmFBGNsGntgEu+EuPX43Shr07ddrOTjQ1T8cd
	 nl7dMmJCEqtei3YbwSuETEgoIqSr3T2P1nCJVO4nbMiR33fUEAOQnUDvVOcJwRgA0D
	 vYyOcfBbsZ4ljUyYO53/pLgIUGXVqSt0AOjOVg3dxK7icnOjQRV5Voz06jqFlQCVNC
	 h6JJzymGqxKTHzHRazhZPIltpgxVeRgYYJUjWauJXrh4wwKiDvygLLDyPPLPIDvPYe
	 2471rkZpfu/Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 107/153] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Mon,  5 May 2025 19:12:34 -0400
Message-Id: <20250505231320.2695319-107-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8fdeafd66edaf420ea0063a1f13442fe3470fe70 ]

mlx4 doesn't support ndo_xdp_xmit / XDP_REDIRECT and wasn't
using page pool until now, so it could run XDP completions
in netpoll (NAPI budget == 0) just fine. Page pool has calling
context requirements, make sure we don't try to call it from
what is potentially HW IRQ context.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250213010635.1354034-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index c56b9dba4c718..ed695f7443a83 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -445,6 +445,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.39.5


