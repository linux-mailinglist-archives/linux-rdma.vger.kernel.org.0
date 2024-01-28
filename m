Return-Path: <linux-rdma+bounces-780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9483F4D0
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 10:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0317DB212D5
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3C8DF4D;
	Sun, 28 Jan 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjo8hZ30"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB1DDAB
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jan 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434175; cv=none; b=nEJO5s2HBtvjfECBOYXr9Fj004wjgCdDpMi5QaOCkwfzDrftS8uc55WRRdoEjoUC5fmb6Sl1bYN342haJFSQ56/x9Ul7wOWmn4W81X09r3Rs0ev3He+rhMMlOHrrn2aPmAa740DjohKdMz0eDb70Z/8N3nMgwn7PuPNQwSdwqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434175; c=relaxed/simple;
	bh=cfyz8rryU0ySc9vaS8NEfCixTmifmFkzMfJkAVYt400=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1GT6nGlvCQ5K/HhH8ImXr/xAY+PogK4sdJ+v3cv68Otlk9plm6RO0xY6+0kAbxhgo5DKNTJlnFhCbOyy5HgFjy8CcIFc52iEDCG3In7Aqb748IaS9pFzxSDP+5Ubu33l/if+5ypRVer4Mjl63HU42tvL4YtTWzNHkg1N13ZcDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjo8hZ30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8373C433F1;
	Sun, 28 Jan 2024 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706434175;
	bh=cfyz8rryU0ySc9vaS8NEfCixTmifmFkzMfJkAVYt400=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pjo8hZ30qMvDYOsHY1Cv5+kR35Ob1LZ/I8yY8vkx3/+yLYemVmQZTNiDax/pxYGZx
	 USblXIav2sR9KFpU3uTdPJ62x3qaJ9ocE61bqEXQFkcxWh7VmmHg7X45HrSjry8i1H
	 2zewejlwrBSa4kpJR8wW876jsRC/q5snJWtkej/pyqcILQm6skcXemtQrUXsRs87B1
	 KWAs3Zpw6el/EUoLRA4AtBU2AMJDqvAYh8nyTz0ZjU1jwMNkJo+CWOjQpbJYWsXgJS
	 SaGWlC2PY/qbgrIglf1BN3nQN4v1lDJZ/lelpeO4lArgZeKGN+X5MAawhNef3rVTvF
	 mZW+a4Qq58emw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>
Subject: [PATCH rdma-next v1 3/6] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 28 Jan 2024 11:29:13 +0200
Message-ID: <7407d5ed35dc427c1097699e12b49c01e1073406.1706433934.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706433934.git.leon@kernel.org>
References: <cover.1706433934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

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
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 4d8f5180134e..9d91790a2af2 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2950,7 +2950,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


