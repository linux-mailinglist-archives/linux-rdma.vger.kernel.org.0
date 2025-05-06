Return-Path: <linux-rdma+bounces-10006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27775AAAA2A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B8A1781FB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B69385377;
	Mon,  5 May 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3W+S9KB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1D28314A;
	Mon,  5 May 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485441; cv=none; b=HRP8SROMBZqIxP/zKFOVyYNfuEF+zKVKB7cKl0TXQdzgI/edT0WZvYFCURQyaJJRspi8bwDZXJm4iNnVR9uxGN2dmaeAjHRH64XAcBQeaFdKUVFm166PsL96bU44daaLY1ns5vy+a253IVwJmRaQeN05+UblhCCHYgtR6pm4MuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485441; c=relaxed/simple;
	bh=MdrJnSTl2GoD+ObNrqreZP6yMBRewaoB71vuYFeA3Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aa8sbpkLEdY7LDgOUSjFgebN4zFus8u9z6uAYX2a/bG5pv7+28Ih29D+Ly0R4jtxZt1xyMO9R+RkyXmpLVP6WtXwCCGocGcvbwB1U8xGx/gFU0b8ZHns/Sc15aLjb9fnkglHnlefxlNmcklzniFJUmqlPzJDNrtLu2ZDkBO7QS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3W+S9KB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56BCC4CEF3;
	Mon,  5 May 2025 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485439;
	bh=MdrJnSTl2GoD+ObNrqreZP6yMBRewaoB71vuYFeA3Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3W+S9KBYkK78Rb82uONFQbDCDbLKLLf0VUxUnHlL5QmELFFeDpBI6X7qAxSiQnF4
	 CCdsDeCULGQRsihsgraAmDWYwHnaPmbh9v9gY5+xFX6BZsYif5f8gsyjh1VtvkwLwC
	 gbfHiiBe6bmDYLdWp/3hKVHHZw88sBoASJYYgAxXQQ2jCTYD3au0eLCEVlg4KDyBaL
	 7sk4tze8qT/79DiRZtSRl1huz0qw1+4e8o3XT1aA92dTqVij/75kKeVVlRzKyKPPUy
	 mYlSxGmlWv0NnoBEwztnoB5Xctq+h9nuKhvqlF93A/u5bWKHmeRdjDhlC3dQRSc32h
	 zKEsYcZAmX6rQ==
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
Subject: [PATCH AUTOSEL 6.12 312/486] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Mon,  5 May 2025 18:36:28 -0400
Message-Id: <20250505223922.2682012-312-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 1ddb11cb25f91..6e077d202827a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -450,6 +450,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.39.5


