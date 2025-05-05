Return-Path: <linux-rdma+bounces-9994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB15FAAA5AA
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C52188956D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC53154CB;
	Mon,  5 May 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ltg6Jzsq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F93154C0;
	Mon,  5 May 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484244; cv=none; b=mfM1s58x2I0RIJtthtt9rC5m/fbaJNK0O+9218s/5/UbVoLJsuskUYNnDLIFCngtLOeaIkjE0gEYZII3YhdvTE7teWsr8pTEn4vxEmOy8+vz2eRYerBIyJ2F9Yph0gdk1/kfg7O9JEpKPa6V4/DGths9gQSzY0JqiVfy1A7Aj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484244; c=relaxed/simple;
	bh=lBWU+9wpWhMPBNO5GCvKFPDkpojiMGc2rdryTUP+QnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGiUBC43igQYryMwMjrsu2VEba2o16kgOGywMagFEzI+Bo6P4cIOi7CXECMhFJnp77rbN+R6JEHvx3hkLDgpJizKEcxm9ekB92/WxaED2UjSe2H75Gx/XOnc9b9AvcSo5HmRyG+wBAfKpmahAneAiN8evEgV8gkgNZQpogN6rdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ltg6Jzsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA40C4CEE4;
	Mon,  5 May 2025 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484243;
	bh=lBWU+9wpWhMPBNO5GCvKFPDkpojiMGc2rdryTUP+QnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ltg6Jzsq5vlEonrLEDMpyMHawcnQy9i3rXAVynprmel7EMcSdTOcG27nT4mzZKy4o
	 QRGi5uxJaxD0SC0xzs+UoV3s6PSFZX+fvImqbWnvgD7XeS8xHEfaKDvE4ySVOkyq1M
	 itU21biqC6vNHuoNUthmIwWb1okHEvVEG6Z3rTyiWaqsBVR5dgFySqeXxiCPEJ7IgQ
	 jHHEcLD6jcHJDW27z2/0dYPsC+CjlvGBi8y+ziemgpJX75m7oYjmCi90TRpD5kzdlp
	 6s07OzF6CfAiHRb7lwMR3C/3Hgj8I70hKaaR66Vuu3kddjbGUCwOKwpVgRjwnXdVMh
	 F4+5hC7DhyCHg==
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
Subject: [PATCH AUTOSEL 6.14 407/642] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
Date: Mon,  5 May 2025 18:10:23 -0400
Message-Id: <20250505221419.2672473-407-sashal@kernel.org>
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


