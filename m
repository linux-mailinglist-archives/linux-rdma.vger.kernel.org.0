Return-Path: <linux-rdma+bounces-1175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD786D544
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 21:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C13B2789C
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68C16983D;
	Thu, 29 Feb 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkYRX9qZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB584169836;
	Thu, 29 Feb 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239292; cv=none; b=igp5Lvpe32cM9g4Th7r4FT2tta7YvLMWESpR8oTeOlqotwaHNhshTYj+Q+beyyr47J0WMZwt6EQEhY54vWE/s7zLyH0A+KNNvgay3nlrXTBhpka2KDaHQ2ZKzHWrub3wQQsvvKfmzMyWznM61oN194nBNWrwmI1aTNHQiS8YYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239292; c=relaxed/simple;
	bh=9eC06TIqVP4YEX5xtazcIFSDbMDbYTC3Hpi0cb+4aWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETLgGfxRv4Hkb+uJGQga6xYDu9+iaHxXuMKsWPEh2DLdo/GZd8DxDNYfz+Lf/Syj2bejhP+GI958Gm6mCBpvkpclPmdJ3ZssTlE8IpIeOvb6CHnj+E9IsO4icp8TkUn4yaKpE3nUcM83lwQVFxeOnAi5UYXPyeiqSUcV5JqDOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkYRX9qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A007C433F1;
	Thu, 29 Feb 2024 20:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239290;
	bh=9eC06TIqVP4YEX5xtazcIFSDbMDbYTC3Hpi0cb+4aWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkYRX9qZXCzIn2X5773wfiVbSsbR0x5CLDt6+SRy7xyBoCxQyBXQwRl8ciYkbpnPj
	 pzDjjPbVxKV2Tltva/qlxLI8zeQgokuKGZ6G99Uua6kp3UsYIWEwIDsfDa9qAA1PgT
	 j19FIlffwOX/fs3d0hAHAfDJQY1IW8I2phRisKnv70Mm4cLYeeH6RJrQYGCpzoP1Bk
	 DDC4XlyG1OngGeYfhG3e/8hOCoUdFek1hO9Y5M4/NaClwOW0dl2HrUGZ54AIsAkTZh
	 MwXVFj9vByYbd6UKq5vN1ZJruJ+3V7wF6a2Hzg129kJ8aSlT9jEBB7uRFHTJOcLYe/
	 kkWQW7ExZouQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/8] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Thu, 29 Feb 2024 15:41:19 -0500
Message-ID: <20240229204127.2861980-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

[ Upstream commit be551ee1574280ef8afbf7c271212ac3e38933ef ]

Relax DEVX access upon modify commands to be UVERBS_ACCESS_READ.

The kernel doesn't need to protect what firmware protects, or what
causes no damage to anyone but the user.

As firmware needs to protect itself from parallel access to the same
object, don't block parallel modify/query commands on the same object in
the kernel side.

This change will allow user space application to run parallel updates to
different entries in the same bulk object.

Tested-by: Tamar Mashiah <tmashiah@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://lore.kernel.org/r/7407d5ed35dc427c1097699e12b49c01e1073406.1706433934.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index a56ebdc15723c..f67ebd9f3cdd1 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2780,7 +2780,7 @@ DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_DEVX_OBJ_MODIFY_HANDLE,
 			UVERBS_IDR_ANY_OBJECT,
-			UVERBS_ACCESS_WRITE,
+			UVERBS_ACCESS_READ,
 			UA_MANDATORY),
 	UVERBS_ATTR_PTR_IN(
 		MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN,
-- 
2.43.0


