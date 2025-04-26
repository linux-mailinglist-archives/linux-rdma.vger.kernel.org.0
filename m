Return-Path: <linux-rdma+bounces-9822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B84A9D81E
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 08:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388B31BC5447
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF275191F84;
	Sat, 26 Apr 2025 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIlbAqfG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202C481B6;
	Sat, 26 Apr 2025 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647682; cv=none; b=iGCswgw/eYhkV/ERVbMvqjMlM2XAZOn2OSrn2R0GwuBidJZSPkpJuHUa3uyKCzFofPapcp4XCaZv0OBxstvSsKfjU1ov4SShJ8OeihgGeLWEjCV9zik6sBgajRQTA5w+29JofN9MbBWGXWKrl1dcFPN93M7LdpBRro6Exx35r6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647682; c=relaxed/simple;
	bh=os9zCEaCkCpN9yXXWUgkC0GWbB1/AbE3Rvj9+ZNhXGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BlbDlW2gUgIfzmwfz0iiTXqhPNes7EwOvD+Dwb693IGCPZnuo+BZnIRCktNI4LtELCVgW15i6NI9aBy37qZQra9B0PykZAmaI3aB/kq3olg4td1/KjM4FWM2X9K2h0u3jgBG1ltGgRdB9d51GnA7mGfEIlAMTC2Y2uBm7RxE34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIlbAqfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE53C4CEE2;
	Sat, 26 Apr 2025 06:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647682;
	bh=os9zCEaCkCpN9yXXWUgkC0GWbB1/AbE3Rvj9+ZNhXGI=;
	h=From:To:Cc:Subject:Date:From;
	b=UIlbAqfG2NuOCQ/4keS3DbgJERxOBXmliKxntsJBaPF/5eNTsofy3oW5+7NXJjb+4
	 0laX6LRwC3uecmAy8ciMSQK31GKJYoK+pAwyEwHXx3TlS1sx/trJiQGiyi4Of2n6jX
	 KjvGAWz7LdKQ32Y2jHAwyRa4dSvYQBuLqnL4d6z3woAOSlHPMD64c1Kc9fyH4xc8u3
	 B6wBxyR89o8gGyYCdi/VUp1TdQ61s0GJqZWqO1IjE3WMY50Y0ZsQb2ZnldTJUL4Xzo
	 FqXv/uGXKJa3IWQBS1y4JIXP8GfsdurNi/zuVq+G5vugSTIT0dvDvxAf0DDut9UVBi
	 PMjzcn1jrtZrA==
From: Kees Cook <kees@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net/mlx4_core: Adjust allocation type for buddy->bits
Date: Fri, 25 Apr 2025 23:07:58 -0700
Message-Id: <20250426060757.work.865-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=kees@kernel.org; h=from:subject:message-id; bh=os9zCEaCkCpN9yXXWUgkC0GWbB1/AbE3Rvj9+ZNhXGI=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8FXadu/kd/v0yzbedkP1WVK3iclrQxfZHV4xVjhk21 z9fO21PRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERsVjAybO//pap2s1fl05Ej cucnKXAavS95XxkztYDB6a7sJY8FbQz/TJyzY//L9Cp3buKUniWosm7JpmMOV5cpPfE/pCa9R7q NGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "unsigned long **", but the returned type will be
"long **". These are the same size allocation (pointer size) but the
types do not match. Adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>
Cc: <linux-rdma@vger.kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mr.c b/drivers/net/ethernet/mellanox/mlx4/mr.c
index d7444782bfdd..698a5d1f0d7e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mr.c
@@ -106,7 +106,7 @@ static int mlx4_buddy_init(struct mlx4_buddy *buddy, int max_order)
 	buddy->max_order = max_order;
 	spin_lock_init(&buddy->lock);
 
-	buddy->bits = kcalloc(buddy->max_order + 1, sizeof(long *),
+	buddy->bits = kcalloc(buddy->max_order + 1, sizeof(*buddy->bits),
 			      GFP_KERNEL);
 	buddy->num_free = kcalloc(buddy->max_order + 1, sizeof(*buddy->num_free),
 				  GFP_KERNEL);
-- 
2.34.1


