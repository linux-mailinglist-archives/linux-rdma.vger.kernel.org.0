Return-Path: <linux-rdma+bounces-10057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93384AAB475
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B67118824C5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC034318A;
	Tue,  6 May 2025 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXL8nF3Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276A2F0B8E;
	Mon,  5 May 2025 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486691; cv=none; b=k8S7GvOYlk9t8XnVw36l0VPqYzMLT6JbyaGCCBAMnMKXhPXYEDHs6m3+xtqP2h9gvn8SWwAHy/Je5btow9DVEBdFtv/4bHIVNdwInIZkZhLJUUPEEdUG8PQON7IWB7MpcpI2s+rbpkLqKE6AeYphikoejRGqFJxEHhoxxTyUDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486691; c=relaxed/simple;
	bh=FXBc3pVht+69N963hdV7zdEpN/uveRYU86rGwTS/SY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbCt+f+47OfCCAJTfzcgO0gIILaT6DIVa7H1TlFYQoZcuj3X7ggl1KmA3ICqdtZRQkG5OpLjHi4EoKAKKZQb99XV0SYgvDWtvxFPKGHB8xSa8aFGsOWilVwhKrDnDhBrDJ8AiM41LpdkhUrY20xneRc6K9NWtPKDsIDkdsT+BiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXL8nF3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E32C4CEEE;
	Mon,  5 May 2025 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486690;
	bh=FXBc3pVht+69N963hdV7zdEpN/uveRYU86rGwTS/SY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXL8nF3YzqTXZjyNhUjPJv4xQgXz3buZWyrWF2ZAmnhqjATSDhD7Xt5g0Q9ll1kLM
	 mRh2sZ8gpdYbLBnR4bfby/eq7/3WirE4LpWznPeWpzXxuWo6bOFrijQ+qBX18H2eux
	 ox119swqTIKpmy/TI25D/MnFWJrenWpL7cSgNDg9BVxhJRHig2hpUzHmW7mdFAnyRo
	 i2uOtLWBtHZ6qBhOhCaiQW3Moal5l5+xJFyX2pBf4qLTszYseCg1dG609R+lRL7j7+
	 7lH+bJ1JBEWURwoEE6FrQAAbH5U35j7T55tGQuRHCH5BDT9c6ttUtzKeZgbWPdc12n
	 6D4R5aF1bMyrg==
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
Subject: [PATCH AUTOSEL 6.1 153/212] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
Date: Mon,  5 May 2025 19:05:25 -0400
Message-Id: <20250505230624.2692522-153-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 9459e56ee90a6..68b92927c74e9 100644
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


