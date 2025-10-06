Return-Path: <linux-rdma+bounces-13784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B50CBBDEFA
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A58234AF0D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B3276058;
	Mon,  6 Oct 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+X7Qjzf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187A275864;
	Mon,  6 Oct 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751812; cv=none; b=hww5euUm3HEHzlFJ5euGX1xphoVv0oSozirkyogOGMaV26Mqp1qUv797mjUvZLuVeNo4zQh+M1NvSuP0LEsmpnNyPEEOoiQ9rdK3IERGoAjHU7jaNuRXD4eiWlYkB2FvpaclMuLuEP0G2kI/zzZGiEpY++dK2ZKGCEND2TEaVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751812; c=relaxed/simple;
	bh=vlcJSPU43ikMg/a7K7vtrothkiSXiq63kikfjDRAOXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uN0UEGId8Q7wSIH0b40Ef6Hzvc/Cj29lnW7oFURqHHU+Lx0EvuGRk2OPjJ3couO9/15jq+wdiZ7ruZyyKdlMIvNvt9QeQqBfthsgO95V7hcH44YxEKEWC6LrzCHW7O/6xyxLL9QNoInSx6zhQOOCk+4pHWsk401qUjUR0z+Paw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+X7Qjzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABDBC4CEF5;
	Mon,  6 Oct 2025 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759751811;
	bh=vlcJSPU43ikMg/a7K7vtrothkiSXiq63kikfjDRAOXM=;
	h=From:To:Cc:Subject:Date:From;
	b=Q+X7QjzfM3v9ra9raJ/9dGIoz1Hw5TwJquXVk0ntzYwmUuWLRWjQwGJgdO4bksToL
	 Bgd4lZSJOpaccj0MEHHTfiLiuN9JG3gcGkwWLVt6OwBCfNHULqghkzcox++hGD3HYz
	 h0FPJNBd7n3Uqdgbh0YPc7OhAKopIfOtzYrEE80XXksbOLyCXZqVGL6YGTG641STLo
	 LOviNDsntuJhJCDX1WcctQc/XylHqLahO2zLEzcg9LgS2gW2Ja2m/fYYj+VCg87nAa
	 RFn37g9iA0bIYiG9lKXEJ4uo1HyPEycd8hk22svy2sJvq4+QkfS9C5SUUzsY4t+2vB
	 GT1SxhKqndmHQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: fix pre-2.40 binutils assembler error
Date: Mon,  6 Oct 2025 13:56:34 +0200
Message-Id: <20251006115640.497169-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Old binutils versions require a slightly stricter syntax for the .arch_extension
directive and fail with the extra semicolon:

/tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'

Drop the semicolon to make it work with all supported toolchain version.

Link: https://lore.kernel.org/all/20251001163655.GA370262@ax162/
Reported-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: fd8c8216648c ("net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index c281153bd411..05e5fd777d4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -266,7 +266,7 @@ static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
 	if (cpu_has_neon()) {
 		kernel_neon_begin();
 		asm volatile
-		(".arch_extension simd;\n\t"
+		(".arch_extension simd\n\t"
 		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
 		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
 		:
-- 
2.39.5


