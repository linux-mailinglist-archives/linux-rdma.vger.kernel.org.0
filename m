Return-Path: <linux-rdma+bounces-11390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6933ADC523
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C48B16B91B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9C28FAA7;
	Tue, 17 Jun 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXfOCzsj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830C28FA91
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149372; cv=none; b=lauzidukKr5JSE5HmjZxt9AZ/+Y0turHycu+bQhEp0xmIxu1tY14Y8Z6s+tyfl1z51N/fi4G/XQiCiTmzt9auYklUXi/YDVtH4nnavxzPvNzuB5jBqjkQZWM2v52Pu0Y4qge7hgf1btgfcq48+8rs384GMyAgyM2iWYaobe5+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149372; c=relaxed/simple;
	bh=cUhPWWozxiG65D9W0GFZpJZ/QTiKHRCwpPSw5RJ2E2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH9O4b96bml/MMvRLomxTyE0h/Ngi9BOLvGdBLX1sisq6QQ1376DvJeP7OYm9RS19ALxbUA2dsBW9EgknH9QVVXHjeBKwEG4lTagYxHS3WK0rYU7BsXafHonUNazZfR+82dCdEkrZGxCi0XsN6jxIHDQbpbUGH2E+JdoHkxyAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXfOCzsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C007AC4CEE3;
	Tue, 17 Jun 2025 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149372;
	bh=cUhPWWozxiG65D9W0GFZpJZ/QTiKHRCwpPSw5RJ2E2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXfOCzsjTrIRazkcHcS9k6Y6DvvP+dn+F8cMjwghhpftwqQ3g+N5eMBSZIuA9YROt
	 RXkP5v0d/LWiah3GgGNCVEY00Plijpl79K4uwsqbd6+XKVCsK+0XR7/hLcaYedtZmC
	 P1SmjLb4UdHE6kauWL1zO3zwV6j5cziR2Agbr2NPRBQ06Ak9tHy+s0RnuNQoOs/W7y
	 vafEFaDZuqb+P9YIPlw0RdKhEGBQXFu7FvhEvSeyLjkXysCytQUbwbDfs1qk7rKNtb
	 qirEGlq7xmGVBGPt7iaossRPTrhM40MuNOdvQPPcjjgkqRZoLbSVTxwPyw33is95x8
	 3s+Fa21393XOw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 4/7] RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
Date: Tue, 17 Jun 2025 11:35:48 +0300
Message-ID: <b57e5a81471c0451fcc32033cbb23e81eba04165.1750148509.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148509.git.leon@kernel.org>
References: <cover.1750148509.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using podman, it fails to create
the anchor.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 0c6ab0ca9a66 ("RDMA/mlx5: Expose steering anchor to userspace")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 774239d9efdc..075d6dacb1cc 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2989,7 +2989,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 	u32 ft_id;
 	int err;
 
-	if (!capable(CAP_NET_RAW))
+	if (!rdma_dev_has_raw_cap(&dev->ib_dev))
 		return -EPERM;
 
 	err = uverbs_get_const(&ib_uapi_ft_type, attrs,
-- 
2.49.0


