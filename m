Return-Path: <linux-rdma+bounces-10002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FFAAA729
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A7E1887F7A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 00:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526132BF999;
	Mon,  5 May 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twjuLkC9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0836B2BF98F;
	Mon,  5 May 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484578; cv=none; b=Wn0YTaVujXXAP4b8euZMSG29PyXQFojXnRE7ZGqVe1Qbxj/gIYb1jeFqFBVuJywnB540Lx3L8f9mf6eDCVg4EArygC78zI71WTJzL/vjX5X/3HviayjjRfo8hGPcI7mzhpNGOvQ/CdGwQyazfZy4xmvdJdP48Qf7pplso76t0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484578; c=relaxed/simple;
	bh=QkB+b5mGTo7m6+UdzHHDnAi54MYG+6gJTYSbnX3Ay0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sf1SA4i/s8hjOcgIHW8cDwovGkH8v8MxPpRf4i5UPCS0FdybGBzh8CaVOqjOVPHwVWbAGytv3a+vEFa736Ghvgz6t/BPq55kRSw7u4aoWGCWABWsXK1HPHB0jWIxDWSHgFVGcsAz8gyH63wfICz4jBrsP0cRzhOibLPxUTEIALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twjuLkC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35BCC4CEF1;
	Mon,  5 May 2025 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484577;
	bh=QkB+b5mGTo7m6+UdzHHDnAi54MYG+6gJTYSbnX3Ay0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twjuLkC9yvtYTjenE59Il6SmGpVcNC20g9RV1Vok0wyQjQ6+h2rxpXGmCIEGqLrqU
	 5ItIMSa1hClLC8rMM4Gkc0LebY8+PAPQKqAWdGz7iTCBZRwJHuLEzJi7IypS2t+Y+b
	 PWazyS+dR+rRy7iRL1V79v05Zg/QusMDhnV7ZRJk3xdbF3M034TlOMRWmMHaIBw04U
	 QhcMxHvvEExdNrBsyXEUQNU48E5DjBnWrL3cVPrhz5Hroon00wcmh8nC1qQEUoxyOY
	 vlpuZlqVnJ8deKS+P+PkrH2ph09doS1U/1W0Ps3iX9+VAGxuGenuYpBT75ud97fp1Y
	 8GfPW7g08OnKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Yael Chemla <ychemla@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 545/642] net/mlx5e: Avoid WARN_ON when configuring MQPRIO with HTB offload enabled
Date: Mon,  5 May 2025 18:12:41 -0400
Message-Id: <20250505221419.2672473-545-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit 689805dcc474c2accb5cffbbcea1c06ee4a54570 ]

When attempting to enable MQPRIO while HTB offload is already
configured, the driver currently returns `-EINVAL` and triggers a
`WARN_ON`, leading to an unnecessary call trace.

Update the code to handle this case more gracefully by returning
`-EOPNOTSUPP` instead, while also providing a helpful user message.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1ba133c53fbd9..18dc29ea3d34b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3787,8 +3787,11 @@ static int mlx5e_setup_tc_mqprio(struct mlx5e_priv *priv,
 	/* MQPRIO is another toplevel qdisc that can't be attached
 	 * simultaneously with the offloaded HTB.
 	 */
-	if (WARN_ON(mlx5e_selq_is_htb_enabled(&priv->selq)))
-		return -EINVAL;
+	if (mlx5e_selq_is_htb_enabled(&priv->selq)) {
+		NL_SET_ERR_MSG_MOD(mqprio->extack,
+				   "MQPRIO cannot be configured when HTB offload is enabled.");
+		return -EOPNOTSUPP;
+	}
 
 	switch (mqprio->mode) {
 	case TC_MQPRIO_MODE_DCB:
-- 
2.39.5


