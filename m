Return-Path: <linux-rdma+bounces-10044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B5AAB682
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D713D1BA7EF6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018744222D3;
	Tue,  6 May 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nde6B3e6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AB2D5D0F;
	Mon,  5 May 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485679; cv=none; b=EJnZEN1Yzn7XE0OoA+Y02S1M0TL/DSV4iRjNjFqJCKfDf9cEeeriChbbBTx2jvE2bn6qpK8Jl5EmcEOV5Cva6Fuu/LsTsjIeponQusW60PEovDvZRGDM9Ki33dfCvQPP61kinRyCjlAuBwVzRj2vNvK4OXlZS4bgN4FgamSY2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485679; c=relaxed/simple;
	bh=l7jAxZOds+YpMtYaq2uWqkMKqPeBNVC/HpOgeEy1IPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HEDsK4u7tkj4lLw4UlbaLfzzfrHYm3jGc4TokFp4DImXbKlFsK6zOVHV8Fv6Knzipx9I16ZyC0G9aVcQhEb26MHBQfvM6+kfrqOvhRyOXr8ko99J8eWQGT//oqS9u3MSMBeN3NF9Wep2IhbDf5MKQF+uwN5ISudHKRZo7JDNgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nde6B3e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0FFC4CEED;
	Mon,  5 May 2025 22:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485678;
	bh=l7jAxZOds+YpMtYaq2uWqkMKqPeBNVC/HpOgeEy1IPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nde6B3e6jruh96jvrtCtNyWi4oJ2qbf5/7INFNVqs/83jI4OqZdbNzykiCLYtRBhE
	 yyhHe9/EF1OGLspWYbbgYETwWzjRxrLxQZlGBdyAs0sZ+pQ0SB0BTcnV40KjxYFnFi
	 9xUyQdOobscA4QzOiH7WO/7n6hJb6S/0DkN+ULMZqx5jgmwqcGowdpiy4ytD58FyWo
	 gydkosQzkmm7hI0aYWZjGi1/N8UjSaYk+5MheiklzoFPMJK9Pevoxm+oIT4339LU7o
	 bNc3A55xz7wMsJczdb1m5+WQBx2nxpsdwPbMiDUKDb9ABEQ6i5xbs04PB4r6+MK0iB
	 q3IQ/vocE7fNg==
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
Subject: [PATCH AUTOSEL 6.12 422/486] net/mlx5e: Avoid WARN_ON when configuring MQPRIO with HTB offload enabled
Date: Mon,  5 May 2025 18:38:18 -0400
Message-Id: <20250505223922.2682012-422-sashal@kernel.org>
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
index 15ec9750d4be0..36a2c935267b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3759,8 +3759,11 @@ static int mlx5e_setup_tc_mqprio(struct mlx5e_priv *priv,
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


