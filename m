Return-Path: <linux-rdma+bounces-10037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9E4AAB65E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02BC7B9196
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12C3C1992;
	Tue,  6 May 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q168+Ed6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47227F754;
	Mon,  5 May 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485457; cv=none; b=Tp3G4Y32tVVck0Kx/MCE58uAGeI+7QGkHu/bCbjdEgiLebji9LP1W3F/8/wrxQTdmlsvTwK+2THikWXMEsQ1HPhndm/YFqygMNah7umNHCeZNOEGJC71k1VvxBZC2RjaQTEufOlxB5bWRIlEujNkJjBMrnpvUn+6zZECrwRO9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485457; c=relaxed/simple;
	bh=lBWU+9wpWhMPBNO5GCvKFPDkpojiMGc2rdryTUP+QnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7hrXAyvN4fObVc/FnZoSj3ooFA0ixZiDis6Ek+NbGn9dS+8XH14QUZgfQaezCRW2TAcfD37iTH90trDbsqR7afjWtEhH249H/nHeprHVjXKSBHdDdVSS8R4W/0M4kBx6ZgKTJHQ5IhIiHwiehgzME210DtNrosHjWoXydHEzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q168+Ed6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4CAC4CEF2;
	Mon,  5 May 2025 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485456;
	bh=lBWU+9wpWhMPBNO5GCvKFPDkpojiMGc2rdryTUP+QnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q168+Ed64q+GMk/Sx5Jt6dbNnzWMqbWi6Zcq/R0r1drIh968MV5p0kPHtiOkvC6DB
	 Jhz7wmK1DuT2fTXuOf3ltzvONYrgjXlnk1y6ReUtsiPec3LdPgdDSentdOruV6KfFm
	 hA2n4f/FIuR/OSXGzfEVLj8CMayjxRd/KsSIA6XfMukl2GYSA1Ii9oXwT/Sln1nK31
	 g0Kuv7VRpGrcURlNBJzA2Jd5bnrnE7CjjRkfeLMNHube8V92lBaGUCnDJ89lKMbgOx
	 YzfbTfcUEDyDFajUMXhhsBTgm6Ofl/wsqWmTv5fw7VMzHGj9iz+3RR2IlGJc9AGDfS
	 p+lrgGpLP3BVw==
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
Subject: [PATCH AUTOSEL 6.12 321/486] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
Date: Mon,  5 May 2025 18:36:37 -0400
Message-Id: <20250505223922.2682012-321-sashal@kernel.org>
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
index d91ea53eb394d..cd8d107f7d9e3 100644
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


