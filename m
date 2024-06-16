Return-Path: <linux-rdma+bounces-3182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD8B909E70
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3281F2152C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC617C98;
	Sun, 16 Jun 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqwgFmjL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E35168DE;
	Sun, 16 Jun 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554244; cv=none; b=NSlZXQZdIJyaFTsbatEVk4bStsf/VeMbUAlkx8sSmLbbvJBw9OOWj3ZnpmOCIj1zKGCwWL0143AxpFR/XTd264rk/uNnszDHPijLFDrF/tJTdmNLZPprwMI4R9liUE/fFOkoxNmBlUtRv3zSeT2Wjecc2/2T1rk7a0a22RJQA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554244; c=relaxed/simple;
	bh=uF/KwkLLn0UI0lc5iIR0pUXgGsR8G/tVms7fj1HaAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pm+E832gOrCbdDZNKCD0rrQlbmTcR/4eJfu7J/Qbn0gSA1fJYCIsMJ2HgCVX1F7fIUhsQYxPGKp/mn9O51dq0erZUnHQqnfLW1T8lIBu3mMrU17TEEtOC89BNqoE/QjtAJvmg8AqfzWJvZJq8pSYE7fl3mITmH52BjKcgo9lsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqwgFmjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A806C2BBFC;
	Sun, 16 Jun 2024 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554243;
	bh=uF/KwkLLn0UI0lc5iIR0pUXgGsR8G/tVms7fj1HaAYc=;
	h=From:To:Cc:Subject:Date:From;
	b=RqwgFmjLAnf05Op8jPe9vOK2qNcdUnW5wUZdTxZ3YqGfzHCOPS4pv8IQtz9SaeoOV
	 ioUkmL8VeRfMZAEXT9siAnEtXSCb1LDF1ciO1d+QEScB6PaZbdmmz2LVJCn1OwmyLK
	 afCt/W8nbPoCRUKTKq2fQHT3gOyIDVfOMoSkbx6LkECRKfPJMNA2xxmaS4jAvYNT41
	 X7tq1PK5rfPn7Eii7I79s7jbiBhydY9Lb8XfaZjI2aL+Ivh0sTG3bkh1NvgarohYOw
	 kYlIPOWSIigtmw73NC2G9Axgh8hE6LSQg3X3Jm2hYRsB2QZ4MB2szOECO8DAoZsELI
	 KfMXywX0eW1ZQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next] RDMA/mlx5: Use sq timestamp as QP timestamp when RoCE is disabled
Date: Sun, 16 Jun 2024 19:10:36 +0300
Message-ID: <32801966eb767c7fd62b8dea3b63991d5fbfe213.1718554199.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

When creating a QP, one of the attributes is TS format (timestamp).
In some devices, we have a limitation that all QPs should have the same
ts_format. The ts_format is chosen based on the device's capability.
The qp_ts_format cap resides under the RoCE caps table, and the
cap will be 0 when RoCE is disabled. So when RoCE is disabled, the
value that should be queried is sq_ts_format under HCA caps.

Consider the case when the system supports REAL_TIME_TS format (0x2),
some QPs are created with REAL_TIME_TS as ts_format, and afterwards
RoCE gets disabled. When trying to construct a new QP, we can't use
the qp_ts_format, that is queried from the RoCE caps table, Since it
leads to passing 0x0 (FREE_RUNNING_TS) as the value of the qp_ts_format,
which is different than the ts_format of the previously allocated
QPs REAL_TIME_TS format (0x2).

Thus, to resolve this, read the sq_ts_format, which also reflect
the supported ts format for the QP when RoCE is disabled.

Fixes: 4806f1e2fee8 ("net/mlx5: Set QP timestamp mode to default")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/qp.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index f0e55bf3ec8b..ad1ce650146c 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -576,9 +576,12 @@ static inline const char *mlx5_qp_state_str(int state)
 
 static inline int mlx5_get_qp_default_ts(struct mlx5_core_dev *dev)
 {
-	return !MLX5_CAP_ROCE(dev, qp_ts_format) ?
-		       MLX5_TIMESTAMP_FORMAT_FREE_RUNNING :
-		       MLX5_TIMESTAMP_FORMAT_DEFAULT;
+	u8 supported_ts_cap = mlx5_get_roce_state(dev) ?
+			      MLX5_CAP_ROCE(dev, qp_ts_format) :
+			      MLX5_CAP_GEN(dev, sq_ts_format);
+
+	return supported_ts_cap ? MLX5_TIMESTAMP_FORMAT_DEFAULT :
+	       MLX5_TIMESTAMP_FORMAT_FREE_RUNNING;
 }
 
 #endif /* MLX5_QP_H */
-- 
2.45.2


