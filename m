Return-Path: <linux-rdma+bounces-11433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F5DADF5D5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 20:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D02717A789
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB32F49F6;
	Wed, 18 Jun 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SESRP/RI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089033085AF;
	Wed, 18 Jun 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271230; cv=none; b=XETPtWDDnJSySUvhLz1EPc5cXu/e63jQa7Vh+KdacntKektWCAv36j7Gv2kn+2XJWmhA7GFobDWdy7RvZKn4lkqw/4Ov1jkOotUEZzEFws9Z4LL9GnLEEmU5ZWKwJpEHQZv95KobMe4XAalyQ9OO7v5bZBC0jhbiFHmYJRUje3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271230; c=relaxed/simple;
	bh=01x0kqXcoH2iofNuPO0sDmz6jzhYn7gy1dxHbLncwX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P3T79mCW3E5OzQrrhgkEZLyPnjc3A46fdYZ+K+akyFtiMn9so1ZMk+UpszKq2kVR+s61o+Y0zRKLYrFPK5KKR4oDyUeFLObEytAl225yc7T2vI3xmZDQi3Rga1Gr8WAveyLZXTHk1pe7+kbhUXkATDGJ9VLVvs8ofoIlq8NOUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SESRP/RI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46106C4CEEF;
	Wed, 18 Jun 2025 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750271229;
	bh=01x0kqXcoH2iofNuPO0sDmz6jzhYn7gy1dxHbLncwX8=;
	h=From:Date:Subject:To:Cc:From;
	b=SESRP/RIZQ+ddfyIAy6xf9BJa0P0iyhTw7dfjfZWZPbP33ejucd+gTVvDjWMgUI10
	 +dvoXrvbTJTQotar1odoWLJo5cyqNvPHbT47I5GKr1dkTOSckKb4fHTyWgUJ1aam6t
	 O2GKqD7IZk6qSl4IVQ0unWKh4W5ncKQuUfAXS53bAfVNgoFURrE+N63+UgeBIV0GxQ
	 TTys5UPcvtvTfZqmidSm3waR0gryvTl3cixMWUMhK6kZZ1/Fv9XfTem5yYIoSYVV3C
	 RJPissmkor12WJcUFaZVGgsS5O30zlu+tpGHRVjbpUKXVGNJtlzAMAemdrDwXn0nBP
	 4OOhsrk5ah0AA==
From: Simon Horman <horms@kernel.org>
Date: Wed, 18 Jun 2025 19:27:00 +0100
Subject: [PATCH RFC net] net/mlx5: Avoid NULL dereference in dest_is_valid
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-mlx5-dest-v1-1-db983334259a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPMEU2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0ML3dycClPdlNTiEt1ksyRLw+TUFJPUtBQloPqCotS0zAqwWdFKQW7
 OCnmpJUqxtbUAkc/4iWQAAAA=
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Bloch <markb@mellanox.com>, Paul Blakey <paulb@mellanox.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

Elsewhere in dest_is_valid it is assumed that dest may be NULL.
But the line updated by this patch dereferences dest unconditionally.
This seems to be inconsistent.

Flagged by Smatch.
Compile tested only.

Fixes: ff189b435682 ("net/mlx5: Add ignore level support fwd to table rules")
Signed-off-by: Simon Horman <horms@kernel.org>
---
I am posting this as an RFC as I am not completely sure this change is
necessary. F.e. an invariant that I'm unaware of may preclude dest
from being NULL in this case.
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a8046200d376..7eeab93a1aa9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2041,7 +2041,8 @@ static bool dest_is_valid(struct mlx5_flow_destination *dest,
 		    ft->type != FS_FT_NIC_TX)
 			return false;
 
-		if (dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
+		if (dest &&
+		    dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
 		    ft->type != dest->ft->type)
 			return false;
 	}


