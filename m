Return-Path: <linux-rdma+bounces-1176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A386D55E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D800A284D59
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F416CA1D;
	Thu, 29 Feb 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoesQCew"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB98151CE5;
	Thu, 29 Feb 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239311; cv=none; b=E6qFdgZTSe+uEjCC94jkullMR78hp7c+7lUzAwFnBn9Gl6ZqunWyc1bGlLgbjjMLV1UcMJi3JUUpgKRQBaapne+l6nSJthH9GXmtQnEditpHaYi9ZnVloeyTWfmDu2vYOjkJdPbGeUtCFY0KfH557UfOidTFI/6//aU1XNPPkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239311; c=relaxed/simple;
	bh=q/zQI/aVAcj6DReUdBtfbzpmGks9RLFWREZi7JOicZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXb+ZuJYaBJhUrhGkMeL6OaR04PGE9vSmBRsp215yZRiAzZpbNAE2enTlBBaCPxqiamfdNa+vh4soRXLFFKAdnrZxKYqQJSBs+CWtf38snBAm5WZAU+EeHJSqrH/U3H8/YOwoGKBfeUGIU0jZT6DSjeUgJs5YXs1bsBV1IlT+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoesQCew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E52C433C7;
	Thu, 29 Feb 2024 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239311;
	bh=q/zQI/aVAcj6DReUdBtfbzpmGks9RLFWREZi7JOicZU=;
	h=From:To:Cc:Subject:Date:From;
	b=aoesQCewSTX1XHY4tDQwo3Td0/tA5g9CcpGUg0DVep+iZ/51RHM2Fs267zn0A0KO1
	 08dmTPEfmMsNMVAx6vrm+kCuq0CqRHW/fuuhizg0Ci1XWq1DBzW4qSnCvwqPdnkJu4
	 1PnuPY6E5CgDSD1C/h5oqXcOeLAFqM5SwAzJqNwzJmg0HojyeHFt7EoY60gL+N2C8j
	 x1vMtAvUxCxE/1Y/jvUwYsfCO0SJ8KkjeRGDzTvVxMjz1ZFeqSaQvV78CnjmMPELg0
	 pAd+RryXtzuVQBuzt6Iahe7rgygtsc5qweaokguw6z0ZBMs3tkf+XpKrToZeiflcRO
	 UXQkpZF/2QiuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/6] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Thu, 29 Feb 2024 15:41:41 -0500
Message-ID: <20240229204150.2862196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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
index 26cc7bbcdfe6a..7a3b56c150799 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2811,7 +2811,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


