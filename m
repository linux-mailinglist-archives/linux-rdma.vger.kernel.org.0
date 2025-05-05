Return-Path: <linux-rdma+bounces-9995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876CAAA5C1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6D23B4FBC
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96A314407;
	Mon,  5 May 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2RzG7gn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B003154FA;
	Mon,  5 May 2025 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484246; cv=none; b=Do/dtvjLZoekir+IB5aJx6Zr8OHYgOdRQssAk5RwWepVl8S5ONrKi6TaoTYdGiRLAnVELKjXq8ECjm2R9jKu8Ytd46VU9qxVzh7guGBssxvETlMD1jhnTxjXuX9tb+LaF8bqFiaV1oHjhfSF3QPQnFe/vyT9/9NhradkkosPu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484246; c=relaxed/simple;
	bh=8v8CA5CFRrj9L0R+232Ph7r3vMqa/L/o4arEehxHSWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxWi1sD8kWgYCOxX//A4Aq3vXeaCl81VZCWUaxzWV5s1VUlJPzXfBrpgmPogSD3SyhPD+Cf4Jfjq41uOnHq39GKsbRt0PlZKXKFgjUyKNYHMmVkI2EoBn5CXgHHSi2dFFQpx2YBEVsPSyGx898IDnEtq9wdJEpwIkyYEDp01MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2RzG7gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB44C4CEEF;
	Mon,  5 May 2025 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484245;
	bh=8v8CA5CFRrj9L0R+232Ph7r3vMqa/L/o4arEehxHSWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2RzG7gnheMRkOD0fnV9yes4cz39Iga3PRDOYCSFoefJLkjHLymkYMsOSJ1FkSC0F
	 sVFi1nHW2/VYxIaAHLRWIc2Rdtj6CUpe3Sn/gKVM2Hz5KlyEo+pu7SaCvXWrLos4Gy
	 6ZgvedZlM0Hy6B1Ov88C+9uE45o89mqfZEHRDLoJTx1FoCgDNqucrlLNPRvFjjvgwt
	 ddPz7CRBdnns4jv0EcPFWW4U1Gs8COncaGXOS2OyZ283PcHB63QyHfV4frIYx8ewVs
	 lnPr5UYLh3jO+T5zUFShO3NVFpvRfkE8QOcYisRn/6DNwnTFAMi1+nYAutPuzPzNzt
	 4TPwwLUmGL0MA==
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
Subject: [PATCH AUTOSEL 6.14 408/642] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 18:10:24 -0400
Message-Id: <20250505221419.2672473-408-sashal@kernel.org>
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


