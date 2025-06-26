Return-Path: <linux-rdma+bounces-11696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3DAEA5FB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131423AB9D0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53642EF2B7;
	Thu, 26 Jun 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDM1QOO8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDD1F3BB5
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964347; cv=none; b=UdsQQxYCFTpzGfGcUy+a5ZO8EozMKlEisWMWut8uvIJcxOuE6u9Ci8+GhWLCMceSekNNVOr7rSS9xwimE3CqyGqast3Ql4pp2ZIuGfEBY+CaiyyDgfDyP/jR5V977USju4bNmo2cTnnXveyR03DJ5Z3C+fu4ItsbNVjBLKodFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964347; c=relaxed/simple;
	bh=CPlITQZ6cl1nml5/WV7PXh/Jwjy8/62phWPsbFmMcWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msLVy5eLemB9WHc/D1JebM+tJwlgvmvhsY/uLdkCP6BYTZCgZzSDSD2noEBvQEN1UrI8GpAUW0G4JkqSKwfj5WhFOS2qOPOW6UD38hWMFuGQNhhey95dhvbVm/NAmqxzgfc5uBUvl+JF/1AmxYqW9AcrzmFfvZb6f3KEEjUhpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDM1QOO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EF6C4CEEB;
	Thu, 26 Jun 2025 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964347;
	bh=CPlITQZ6cl1nml5/WV7PXh/Jwjy8/62phWPsbFmMcWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDM1QOO8PzvPMYkz7sRPDhyv8vLISKWcckRDHJ+8GSVuDffgmdXw31N+DSUk2ySnS
	 geHnLYgyZTKNrWOD0LMxZArtDOFWLeIIrGd1uiBZIRF1LhESfvVtb6Qu0tfiqmcZxk
	 DEb4brU0KSWObqkqLrNMZjSl5MoLTPCy46Ot77nqrp7Ran8/lyUB9IlWjAsuxC+e4P
	 B6B044QI9Xmyzg0Eq75QO/Si5OOe3sblId6LBIScWkNBjWFPYJv7AoxyfCNMsJXhwA
	 Wm9n8Grlk7AmWuzdcBOnkHY9hzVUY65cVPRWuN16YK2zpWMP4rEcVqxQFbrI9TQvx1
	 40wcrfQR76Yqg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 9/9] RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA counters
Date: Thu, 26 Jun 2025 21:58:12 +0300
Message-ID: <68e2064e72e94558a576fdbbb987681a64f6fea8.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
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
non default user namespace, such check fails.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration support")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index e6ec7b7a40af..c3aa6d7fc66b 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -461,7 +461,7 @@ static struct ib_qp *rdma_counter_get_qp(struct ib_device *dev, u32 qp_num)
 		return NULL;
 
 	qp = container_of(res, struct ib_qp, res);
-	if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
+	if (qp->qp_type == IB_QPT_RAW_PACKET && !rdma_dev_has_raw_cap(dev))
 		goto err;
 
 	return qp;
-- 
2.49.0


