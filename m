Return-Path: <linux-rdma+bounces-14659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69125C75000
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D06F34EB3B7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB173596F7;
	Thu, 20 Nov 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwxZhHcO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FB33DEE9;
	Thu, 20 Nov 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651734; cv=none; b=uktCmAPV8NXVN1j1VsHETZbDK6OGjO7XGKCe/ny314OsHSh2jNnbRJtfFXRTeTJYhTLvP8r3arERh0ggHTWc0ufbFOpviqpbFZUo4l7zh6yGkpfUVcuF0sCs2LsyTgMHyY2+aUfdochYhWCb5nrKgDAF+ns9jl/UKx1yTgaRwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651734; c=relaxed/simple;
	bh=7x4OtjOMIM+zu4+4zFJ/k3D4n0gvkkT3PbIbHmGF2Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnqvihsovQydWj8yvgRlOWBGo8t5vldTXwKdS3fS0nV+DnL39sqvvmWMRpolqkgS+jf9OLQUPDyDn8kD2RJx6PTsy+uvSHmMBHhSA1YIGXmSFgmIB9eBABNgB9HVMWwognOwR6EGKsnHHnI5RViRDrZjRQO9OYvDUQDjA0k9skc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwxZhHcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FD5C4CEF1;
	Thu, 20 Nov 2025 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763651732;
	bh=7x4OtjOMIM+zu4+4zFJ/k3D4n0gvkkT3PbIbHmGF2Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwxZhHcOavtO2bEINrT4DqP2NPrh36KTvuj3KOwVVHryR6Tv5gknRGP9GBmPfV548
	 iza+0vCqyeM5eIDTUpEB9iMAqNn5bn68D/4dMha55Imbm/76yrimqoMmlYcE4ElRUC
	 PJY3cEfH/d00MGrllDTNFjYwSvXmgPZ/qOXdXt8qX0FFMvzD2jy3qfcXLHRt0LU6XU
	 fnXM2tPRtbEBVtNYkdWzXOy7PT5MIr2NXqSNUtgUfMJ8xzTqppqNSb4/jypF/eluhF
	 X4qd4vh8om98n9EJxCo1P5PAzs41STSU6t+rp5CuSwLBkZCRefoTV07ypwPPbSgQEw
	 wWEhbeCJZncFQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Add support for 1600_8x lane speed
Date: Thu, 20 Nov 2025 17:15:16 +0200
Message-ID: <20251120-speed-8-v1-2-e6a7efef8cb8@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
References: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Add a check for 1600G_8X link speed when querying PTYS and report it
back correctly when needed.

While at it, adjust mlx5 function which maps the speed rate from IB
spec values to internal driver values to be able to handle speeds
up to 1600Gbps.

Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++++
 drivers/infiniband/hw/mlx5/qp.c   | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 90daa58126f4..40284bbb45d6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -511,6 +511,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_4X;
 		*active_speed = IB_SPEED_XDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8):
+		*active_width = IB_WIDTH_8X;
+		*active_speed = IB_SPEED_XDR;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 88724d15705d..69af20790481 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3451,10 +3451,11 @@ int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate)
 {
 	u32 stat_rate_support;
 
-	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS)
+	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS ||
+	    rate == IB_RATE_1600_GBPS)
 		return 0;
 
-	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
+	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_1600_GBPS)
 		return -EINVAL;
 
 	stat_rate_support = MLX5_CAP_GEN(dev->mdev, stat_rate_support);

-- 
2.51.1


