Return-Path: <linux-rdma+bounces-750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D891083C282
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0AB28C690
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5762C6A0;
	Thu, 25 Jan 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSAaKde8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351619472
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185832; cv=none; b=Cs7QSuilt+2BJt2BdV2TWSY3/Dxv/KMRRJLk/oESflP32SQSoZYCaWweat8pj6m+BtO+/iPtYDhsK1mL1IxDP1k7gIyrEyqhkQ/of5ZOEM73VHphidoEWrQYmprCZzjowSVVYp6xPa8hYVuYuFys2xf7qxRVcA87HIRsII/i5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185832; c=relaxed/simple;
	bh=cfyz8rryU0ySc9vaS8NEfCixTmifmFkzMfJkAVYt400=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqyObdTkJN+VrPGv4d0ROut4NbvtAsLi00KxzcvcpyXn9SQEOMgF9GHKJmpzTWqZpKF9kb6/HMVGCTekvzkeXlsB+pqXy959vtkPrxPvs2Ipw348t3he4rkltLrVFM4ozn8Cae/sDK5wIXdLjdawOUx0Rfu5k9MO5y0iLfcnFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSAaKde8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A280C433F1;
	Thu, 25 Jan 2024 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185831;
	bh=cfyz8rryU0ySc9vaS8NEfCixTmifmFkzMfJkAVYt400=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSAaKde8Uqs+87rbH4RffoDlrzmRhjmqNwiynC/+eOhIrRKQhqWBd0bHXqnQpG/8H
	 viOoYjARS4eFVBDHi+f/YYz4RnhzZIBCQAT2mpOHEJpGxC8JFiv47tLFJkHZh0xMlq
	 Ekqq3AZYiHMezq8Ld4F8ZCjVW3U6gGxouyojM3zPyeQbNNA0/4rOKXDvs9QB0ZiWlx
	 GUE7j++XkgRqcjP6tktFipPPQ4Tj8grwRGXjRmrWlGrpSXnjOKRDkodRu8KV6JiTWx
	 YoJ59XN5fKFSE/Qw1jwUGGx6j1Bu1YidpORQQo/9VYqp8oRhYI29bxJM4ipuC39MBQ
	 3g3a0UySCihwQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Thu, 25 Jan 2024 14:30:09 +0200
Message-ID: <7407d5ed35dc427c1097699e12b49c01e1073406.1706185318.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706185318.git.leon@kernel.org>
References: <cover.1706185318.git.leon@kernel.org>
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


