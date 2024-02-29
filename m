Return-Path: <linux-rdma+bounces-1171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971186D503
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 21:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9376B255C8
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 20:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA6E15278D;
	Thu, 29 Feb 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr7SQ2Lr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884F152780;
	Thu, 29 Feb 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239243; cv=none; b=SUYhPrx7zNSGzio3ERnYXnSccpAYTxnHhZ59VQ3SOHml/1ixXm5An7GT7hT2mSU23NwM3arsCQGmJoH29PzJq3OpDHaYHC80LcKeMxnOllpHYAl9wuMJIvOZRQUMSsO9EClWLiurF1nMRpeBTez120DRg/YiAm+ZBJj28QtCdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239243; c=relaxed/simple;
	bh=xQC6o6+q3OtIE2gwfV+uYfObv8PJwHK9mSaRmCA0uMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6p/mM8JkgSFGvSx2AdDLCXFIOEhXPbmrhf8SO0YVSw2aRT1odKEwuD81ghanS/Hzg2jF9VAOG1cUs1W/9J/BM4qK1D03iA1LPfE19vsTGJkhCrzANZX8hVyPKHhUOT/5ZbV0Oeda98ucOPKYha00fxNthWnagw6cZ4eEodxCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr7SQ2Lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E456EC43390;
	Thu, 29 Feb 2024 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239243;
	bh=xQC6o6+q3OtIE2gwfV+uYfObv8PJwHK9mSaRmCA0uMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kr7SQ2LrKtw2HSbYUzOGL0WZeX+Tcp6XBC0K4TABBm8/vDjuLnn/Ta2CweciQ6EjE
	 1+HJhXctIsIdV9AK+ZhRYqpwsH8jR7+vdEs3U8TjIehMNfIhRy57hDs9wcx1426ypk
	 v/+LGkmlRpEAX7xMAB/c/GHQEoyJe0N8Q3soe3xsd7+lmZ+DoSZGNuDMtNJx8J9dVL
	 efAPx019rsOxYVeDQOFNdyS8/Uuvu9JyLZUX61J6mNtGsxf4F4RxsrNrTAGDGbMb/g
	 Zdap8NJVY8t7jnN77uL1lkOAPIBryvDfBeM+ojo5dVuG582Bwl4Z5YdQPnPXvuEfbO
	 E3rS7h0XBY8PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/12] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Thu, 29 Feb 2024 15:40:25 -0500
Message-ID: <20240229204039.2861519-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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
index f8e2baed27a5c..7013ce20549bd 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2951,7 +2951,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


