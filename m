Return-Path: <linux-rdma+bounces-10067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781CAAB7C9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 08:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8E25010AE
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F034308A;
	Tue,  6 May 2025 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1shxVit"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3052EC2B8;
	Mon,  5 May 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487411; cv=none; b=SsD79tcPdTw4QlSTwq0Bu+j3LirSlFinrmuo0W+cLt6QtnwocQ66zk1j1ejsVs+3GIXJhs1tSe0VqumSfvao39qpUHVdL4brltPib5Dly0o43lNL1xiHiaS4y02SslHIe4vitm+0iLZ92L7vJacxh5rMCBNa9LtRew0RhGFXG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487411; c=relaxed/simple;
	bh=KAi3PVFthWgF+EyVstfDrRkdy5yp485XR2TZzmWYyZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGj220RIfk3ouovxYo2WHJtsebEEYmj/IFkqPTa/rpTjDtVxfQRmCU/eItTKwTRtgR6f2ns6MmZx1XGZettpZf9iXqcvTo5j6EoTE+0ANXPEaJb8PlVmy6ZdZDPNmlbqEDt0CPAOqHN7dgBWCwJTwpN28MM8IcWgS4yhpK5mXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1shxVit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC385C4CEED;
	Mon,  5 May 2025 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487410;
	bh=KAi3PVFthWgF+EyVstfDrRkdy5yp485XR2TZzmWYyZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1shxVit5MRYVk1tya7tPr2sPaYj04j+SKx8HVCgTcOc043pzdMa1X4AsCy2fLWeG
	 iqsL8wmW0YmTV4Qn95vq9cjuzS9+OTgV4VR+a2Bg+l0ZPmfxRr8b63gg8YgkZSepTt
	 Bq9M4dEgjFL53rIyUpy7gS5Yko1Xs3/n2F0YifKsVRLZfirnLYD5RmrMTjLax1XMBU
	 6IvAxJtYId1dyFJHt9yiHnYRelpzklMw2T4BLMpEKm0C/Mf5xbvwNhPFyZQWRuTlGi
	 2K8lRC/ZRGhXSqZqbfknofRpAXF8cWHCLr8Txj/VxoHnciE+UCBfQ8TP8kcbalff/+
	 M9HyzyHJSrjZQ==
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
Subject: [PATCH AUTOSEL 5.4 55/79] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
Date: Mon,  5 May 2025 19:21:27 -0400
Message-Id: <20250505232151.2698893-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Shahar Shitrit <shshitrit@nvidia.com>

[ Upstream commit 633f16d7e07c129a36b882c05379e01ce5bdb542 ]

In the sensor_count field of the MTEWE register, bits 1-62 are
supported only for unmanaged switches, not for NICs, and bit 63
is reserved for internal use.

To prevent confusing output that may include set bits that are
not relevant to NIC sensors, we update the bitmask to retain only
the first bit, which corresponds to the sensor ASIC.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Link: https://patch.msgid.link/20250213094641.226501-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 3ce17c3d7a001..9d7b0a4cc48a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -156,6 +156,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	u64 value_msb;
 
 	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
+	/* bit 1-63 are not supported for NICs,
+	 * hence read only bit 0 (asic) from lsb.
+	 */
+	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
 	mlx5_core_warn(events->dev,
-- 
2.39.5


