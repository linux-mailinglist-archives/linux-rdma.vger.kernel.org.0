Return-Path: <linux-rdma+bounces-4206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCA948118
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA191C21F62
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793417921D;
	Mon,  5 Aug 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHZIfzlg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BE165EE7;
	Mon,  5 Aug 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880706; cv=none; b=azrp/Xz5jcO4SOIp8RUkJcKr7PBDXMxSDVoNs7o+4Qbc1rwKh/sTDSFiWTly7EMIRrV/T6QNr/hUi7nKiOo2xcRpvt53znuys+izIxB7vTmz+EzzFnyRaoX8LNNZC1Ng16VmTocTaZJ9VFBLa6/0l9oGClSAoXrfLmQozM8vzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880706; c=relaxed/simple;
	bh=D/p/sm0X47naiWpZmPaylW7bn5QRjiP+yFSrDBMSf7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btFqnVrynFckb8HvWNDgSQeVMJqd/93vpeKREt3s5uZRasyKYwGs9sKyfBhvKOBxHEYiIWT2cunaul7r1PE3umapXpM2g7wRAi2j3mgV3vvVNJSa7eeIwh0BnWwDglI7xaPs9ZZJ2SC8+rfzh3tjEPo4wux3BdoVBbiNcZOFPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHZIfzlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8EBC32782;
	Mon,  5 Aug 2024 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880705;
	bh=D/p/sm0X47naiWpZmPaylW7bn5QRjiP+yFSrDBMSf7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHZIfzlgyCmtSkKL2SNrO0awzxh2s5Zcyw0dZZbz63888x+Feek4d/Wcdfj+x53KC
	 RaAXNxK/ZSUKA87Sspr84J10ZvUu1tB9QNQCuGWqwmOTQvGJJrRKBlMlzxZyo885VP
	 AdQ0GBF6Bq/grDRjDBTClrIDxk3afS0qjT2sPTIb+5h9t2OZNHRrcXEAwI0KGHX9mA
	 RgbR3y4iMIVMpWMF+o1B1GBoTRMLeSwQAh8eMGLg8eycU4Q+Dq+LTfYoobXtcwwjZ4
	 0ftj2ucFqQbu9HCEqWtrAK+7XHrn5tLn60bZUeQBRdVcYizmb4u9IrCVBtXiyNu2X+
	 fP5Yp3AsXbhuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/15] net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule
Date: Mon,  5 Aug 2024 13:57:11 -0400
Message-ID: <20240805175736.3252615-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175736.3252615-1-sashal@kernel.org>
References: <20240805175736.3252615-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.44
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit 94a3ad6c081381fa9ee523781789802b4ed00faf ]

This patch reduces the size of hw_ste_arr_optimized array that is
allocated on stack from 640 bytes (5 match STEs + 5 action STES)
to 448 bytes (2 match STEs + 5 action STES).
This fixes the 'stack guard page was hit' issue, while still fitting
majority of the usecases (up to 2 match STEs).

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://patch.msgid.link/20240730061638.1831002-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
index 042ca03491243..d1db04baa1fa6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
@@ -7,7 +7,7 @@
 /* don't try to optimize STE allocation if the stack is too constaraining */
 #define DR_RULE_MAX_STES_OPTIMIZED 0
 #else
-#define DR_RULE_MAX_STES_OPTIMIZED 5
+#define DR_RULE_MAX_STES_OPTIMIZED 2
 #endif
 #define DR_RULE_MAX_STE_CHAIN_OPTIMIZED (DR_RULE_MAX_STES_OPTIMIZED + DR_ACTION_MAX_STES)
 
-- 
2.43.0


