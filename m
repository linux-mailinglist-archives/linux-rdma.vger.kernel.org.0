Return-Path: <linux-rdma+bounces-10012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8548AAAF47
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891023B2282
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B832392F81;
	Mon,  5 May 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goV/6BaL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459B39261B;
	Mon,  5 May 2025 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486193; cv=none; b=LDuvHYrVdBLeiuMTkI0nEp1qhOyoZihudHz4dxgHPZzgPjKSg3IRJdSpdEV/0qnTwXzsS+4AqwDh9E+c0bM4LtbROnpbiDyPjkrHuw8YZbgk/L1gHocUC5G/10Qe91yB11kiFv5lrse30w4qF8PcEAVEmrOELx1szoG5YZhQY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486193; c=relaxed/simple;
	bh=1vJ/RkwK9XOtkNV4BeP4I/h8Dllsc5LhJWJpWyi82YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TebCMbiMJpYo7Is9v/UwnZCbQZZVBi1u4HErlgvlFlyaVKp0xkHPfnHpYXFp9Qfsj4fqjiAnh+MIPxXEgu3Dd2vmOZh/nYG4T1BFn2QGOMDCID3aQBrzht0haiXbxGuE/b7gbkuZs6rjC1MbAlWOx7knQv0qo25yyll6eCIbCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goV/6BaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4BFC4CEEF;
	Mon,  5 May 2025 23:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486192;
	bh=1vJ/RkwK9XOtkNV4BeP4I/h8Dllsc5LhJWJpWyi82YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goV/6BaLajjIwwZhnABotXULvAYLmm06oMfBfjwhk4aFn704lS3RvgzjIz5NzST+S
	 1kGITeKH9zhkwduS/7M/9VDekF6UpWcs5lCkjrvHNcWF7ijQq3C7c54bIF7upWYHDS
	 GTzNFsJh6sTDjdiRb60RS5FXUsQ5pepjhVEK8xN3c20BqavRcXSL1UAOwJz1V0rmHG
	 gX0uOG7hYv0v0/qwSQBWHxofvoln1ku0hNr2hEk9u5vwYSZU1Nv2C2tQv+AI2bUBsA
	 aLmwAtmy4yKM4vj0hu7XVKMUuvH60WsEX+XRWNIcU62ZcCWDtiZr9iv8rE4Qf+8rpc
	 4dALfASFcppbQ==
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
Subject: [PATCH AUTOSEL 6.6 196/294] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
Date: Mon,  5 May 2025 18:54:56 -0400
Message-Id: <20250505225634.2688578-196-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 3ec892d51f57d..0f4763dab5d25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -163,6 +163,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
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


