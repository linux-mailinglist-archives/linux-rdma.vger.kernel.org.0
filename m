Return-Path: <linux-rdma+bounces-7877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F25A3D187
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20243BBD01
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C51E04A9;
	Thu, 20 Feb 2025 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXIRhtl2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CA1DFE3A
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034039; cv=none; b=P26qDIa79AGtuCh+SeT6tzUYuJIinb7bkcLy7sQbU7cuY0eTAYaiajPuxwwdc9zvDpNpuliDQMUAPsl4X9cFsjRCqRjJ7sXi95za7jUhmR7oK6HbGx1AMD2odVZit+fP5iJ6oHrpLZZWMoNNk3OfTgEGjvdZzymV5mhem3wlLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034039; c=relaxed/simple;
	bh=rUWSYNNauNeIAZr9PHzQQoL/vFLLYj9ijLUsuS5iJyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dO14+8S1AIVidqb5/zIU3QoD61C5x5PemJ/FvSAvDulE/w9Hg3HzAg8hkHfMqGWVUZYrP76/NE34wUVs7iwph1n24TY7jbNJT/PreRaf4DxDUSQDj86sHiTbV80WFz2n8hPlRTlibVdJyaFIPtcDVvpLiqz1fxHz+bTLTKaPoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXIRhtl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B85C4CED1;
	Thu, 20 Feb 2025 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740034038;
	bh=rUWSYNNauNeIAZr9PHzQQoL/vFLLYj9ijLUsuS5iJyU=;
	h=From:To:Cc:Subject:Date:From;
	b=LXIRhtl2m/bHxP7OXYzjGs/ngUTP4g+uZQ8iaCOC7ivgqgHl6hm5OFYI36OSVTakC
	 EdDbnJssfVd+QeHH6nnA2/+NsCyMhZIKobzxK94iQtdMUgqDCRivlD+v1HHblxkevT
	 xhDj5yGVWmyTssPAhQHERfz/KHpI/CSuyE4I9U2UlBNIqJM434rEOuh7NvWB9xVJ44
	 vhLuEQ71QFIlZKKxGRjly2NWemR7PqnNS6OtGGgYY+KBR5ZTXqqNl6JU50nsb5HVaJ
	 4OGE30xrcjzhqKw6eizUXTTvGZ3dKGbIPck+AbbgCQPDywmIOeXeO0YKkdyvBcODcZ
	 6EHs+EvfRKGaA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix bind QP error cleanup flow
Date: Thu, 20 Feb 2025 08:47:10 +0200
Message-ID: <25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

When there is a failure during bind QP, the cleanup flow destroys the
counter regardless if it is the one that created it or not, which is
problematic since if it isn't the one that created it, that counter could
still be in use.

Fix that by destroying the counter only if it was created during this call.

Fixes: 45842fc627c7 ("IB/mlx5: Support statistic q counter configuration")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 4f6c1968a2ee..81cfa74147a1 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -546,6 +546,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	bool new = false;
 	int err;
 
 	if (!counter->id) {
@@ -560,6 +561,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 			return err;
 		counter->id =
 			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+		new = true;
 	}
 
 	err = mlx5_ib_qp_set_counter(qp, counter);
@@ -569,8 +571,10 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	return 0;
 
 fail_set_counter:
-	mlx5_ib_counter_dealloc(counter);
-	counter->id = 0;
+	if (new) {
+		mlx5_ib_counter_dealloc(counter);
+		counter->id = 0;
+	}
 
 	return err;
 }
-- 
2.48.1


