Return-Path: <linux-rdma+bounces-1173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8886D526
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 21:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744152864D4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 20:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0711504FE;
	Thu, 29 Feb 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMmcl2kE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25115176D;
	Thu, 29 Feb 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239272; cv=none; b=boB6vbDu/to3CMeRGe0P0TNMoZdyjSYsupufq/VdvFD8Jb1Tdk701TyFCXeikc9NyErQac45XqksJCIMg37GYDsQscuW/59Sz7mRUQD5hosyv3gGyMO/vC1uMl+fZxSiHdo7K0RMNZeWshDZOdXffO3E0wIvi5tjghvkDYSwmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239272; c=relaxed/simple;
	bh=8VVwG/bIdg9aEww7zqF3oialBxlZZB4yvhDB3Q+do1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F56FG3WrDNxllyK4KKk9IXCEui03ymgOKxgU/DKELQwCpSCtb6qCqy4ljeSiCLDiLe+guBXlA4EIwA5qtOBmQH0OjPeZYU7sYstGMtgHGAC1Dg93XF3fUz3J7ASIZ2Tt/fr4FW7G6V9WlfWIoFSsEMDIQKAGjLhanBT+Vi35ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMmcl2kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEECBC43390;
	Thu, 29 Feb 2024 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239269;
	bh=8VVwG/bIdg9aEww7zqF3oialBxlZZB4yvhDB3Q+do1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMmcl2kE3YMKibPSHj3M4Jo5R8MezvDg611J8v9+6nP7kukokUQ72fn6QeoCYoJRA
	 3mEl2kmnN/vRyH4eD75lVoh0i1TPPl9PH+NWUhYgMvC3TMHpNiF+cKPH90HNRyGX0J
	 uxWHwujCoHUt7xLFcDwF/LhlBl/AgjQ7i70AUXwf1zFNmUTpOLgF9DbchSAzaizqnt
	 jO6dXn2V6B7IDVGSLrtcN7LHF5Z+opfcflytLAQYqRfd3Qy2/4XysKmcZQQ1gAeNvD
	 00xo4Y/XeKQb2lhe4HwTPvW/IlcJD//Tcv2elsNTR8CePAaocIIqzAVIchFPkyWx9F
	 +mWMxxLcbrMUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/9] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Thu, 29 Feb 2024 15:40:58 -0500
Message-ID: <20240229204107.2861780-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204107.2861780-1-sashal@kernel.org>
References: <20240229204107.2861780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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
index 104e5cbba066b..ef3585af40263 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2922,7 +2922,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


