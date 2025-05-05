Return-Path: <linux-rdma+bounces-9985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1AAA9FC7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 00:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BCB3A9CCC
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 22:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC76289E35;
	Mon,  5 May 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnBG8gYY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76D289E24;
	Mon,  5 May 2025 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483356; cv=none; b=FfmLxb8t90yPlzrt+/qd9K6Kz80gS7MQfpT0E0kn4LubG6iJ+fKLyw5mEvk8l7zkc2LLoOwtC73zeVIAkIDjvTdrrakYMDGC6hxQUUUxNIi/CMrVxx7UsVUY7pWVH39F9TMZugwkdPWt2qtKP8zky7VrH4E2ktO+hiU2z7Tujks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483356; c=relaxed/simple;
	bh=lhQ6mUiBQnHPA2cCofkCOBLSJVtphr9Q8IureAFARzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aawBnMfK3kxhnSi6k2Tn7mWFvSbF5m0Ups0ZM6kOVXbU77cBSL/745AEQLzL62bAQfZ3V1HGbmj1smnS46i8JaTBn2E1j1+kKLFFuoKjuE/3vbuaC72NB29Eg9kDQJyRM4IjPcaxowVwqs/lCzipkHExyhBBo36r8AkzmuTQ5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnBG8gYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C3AC4CEEF;
	Mon,  5 May 2025 22:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483356;
	bh=lhQ6mUiBQnHPA2cCofkCOBLSJVtphr9Q8IureAFARzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnBG8gYYQY62o0GkWl0f1sD7jppcg0nEUBszWloQC3glVX2rlDFu0GnqDmyEvIixo
	 V8VgJ0Lu9Hmqpb6GjFziooIyojwxdW0kY0BzXyg27Q1JjCcLxFXmeY48xoJPHkU2Tt
	 RL0t97yI1ATnL8hVweiZSheYOy3smH5yADZGeKwAbWabbs5KSGjqFFHZ+dxgeKTAax
	 SZiA6DfC+jbaKnZUwjLuGIf81MKNH1CKBWo28xN6vwd2y2jjEJReXRHNHc/fC1C92i
	 5/WaVxRJCx7NB02V1FwTIww+bfrIuX5oylsPUwp8IzyatnZDcx4C6cvW2nsngotwIU
	 ksz11Tdu9oKng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Zhang <markzhang@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 051/642] net/mlx5e: Use right API to free bitmap memory
Date: Mon,  5 May 2025 18:04:27 -0400
Message-Id: <20250505221419.2672473-51-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit cac48eb6d383ee4f037e320608efa5dec029e26a ]

Use bitmap_free() to free memory allocated with bitmap_zalloc_node().
This fixes memtrack error:
  mtl rsc inconsistency: memtrack_free: .../drivers/net/ethernet/mellanox/mlx5/core/en_main.c::466: kfree for unknown address=0xFFFF0000CA3619E8, device=0x0

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Link: https://patch.msgid.link/1742412199-159596-3-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8fcaee381b0e0..c748fb07fbd22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -359,7 +359,7 @@ static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
 	return 0;
 
 err_nomem:
-	kvfree(shampo->bitmap);
+	bitmap_free(shampo->bitmap);
 	kvfree(shampo->pages);
 
 	return -ENOMEM;
@@ -367,7 +367,7 @@ static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
 
 static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 {
-	kvfree(rq->mpwqe.shampo->bitmap);
+	bitmap_free(rq->mpwqe.shampo->bitmap);
 	kvfree(rq->mpwqe.shampo->pages);
 }
 
-- 
2.39.5


