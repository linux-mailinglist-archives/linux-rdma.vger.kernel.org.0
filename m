Return-Path: <linux-rdma+bounces-10038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87344AAB665
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9936B3ABFE9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7522D1111;
	Tue,  6 May 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tteym7N9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91742D110B;
	Mon,  5 May 2025 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485458; cv=none; b=fEaIb1zzm+/cTK5a+66bIErsWbplZh7JaeCnS86rk7nomJr57qH6XaW+QAeGor5FaQ2xSUBZEXcFjN/Q0fO/f53/KhMwHgZklwDxT8EZBf1GfLgJ6C1FEQX6N8MxsF4whcaLNbw6VxexjAn1yKtSjqja1OB/z9Qv0p+CbOViwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485458; c=relaxed/simple;
	bh=8v8CA5CFRrj9L0R+232Ph7r3vMqa/L/o4arEehxHSWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0izkN3UOkSY8HshEAtsfy8ua25Oxo0CrJJz+20F5n4SHk4esfd6/eLUlIOwm+n3+O/8+LyNMjKOrVoPaxnmxUrfCSeQAymVWlkKIo22Ti8dv9hVCHZY7Ob1vYCfwD+jVgd8OiTx7LmqoaGEdPus3Pvyn7Dn3Exdd9r8sHSAH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tteym7N9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0D2C4CEEE;
	Mon,  5 May 2025 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485458;
	bh=8v8CA5CFRrj9L0R+232Ph7r3vMqa/L/o4arEehxHSWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tteym7N9ZjAYrcaVZ1EIywO2SJ9RKuNJBJorYJKd2kLsz+SXZQ4dRHvqFR7nFyH3k
	 O5ivzlUlzRxf0vvJ76QDMU6A8+g29EZjgPIso87/EcFcnJq98ozb4NxeH9u/nu9SxR
	 id6NLynhFc8uB/jabtUED4xh5hJvOmsaBtVYnKWd405rEeet21zyMySqo7eNNuYp6Z
	 olspWIaJGaEko4x+pinyburaW6x741DWQP/qfYrcXX0TGYxYuVKeDns7k++KSs4rhr
	 qAgZ/hPhQOQt0l/HXB1MEdKmurgOEsinaAAkeSWsygj2rshN42E5fI+kacVk17v2MM
	 N0839nbnhUyFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 322/486] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 18:36:38 -0400
Message-Id: <20250505223922.2682012-322-sashal@kernel.org>
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

From: Shahar Shitrit <shshitrit@nvidia.com>

[ Upstream commit 9dd3d5d258aceb37bdf09c8b91fa448f58ea81f0 ]

Wrap the high temperature warning in a temperature event with
a call to net_ratelimit() to prevent flooding the kernel log
with repeated warning messages when temperature exceeds the
threshold multiple times within a short duration.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Link: https://patch.msgid.link/20250213094641.226501-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index cd8d107f7d9e3..fc6e56305cbbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -169,9 +169,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	mlx5_core_warn(events->dev,
-		       "High temperature on sensors with bit set %llx %llx",
-		       value_msb, value_lsb);
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %llx %llx",
+			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
 }
-- 
2.39.5


