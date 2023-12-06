Return-Path: <linux-rdma+bounces-281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D72807197
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356AE281DD9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351B3DB86;
	Wed,  6 Dec 2023 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8FCuc6H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5023C6A3;
	Wed,  6 Dec 2023 14:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3551C433CD;
	Wed,  6 Dec 2023 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701871310;
	bh=Hr4nB6qIyAl9SrKx63EHLJuuK3BK3CxkeypRrNZUQbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8FCuc6HbKP9P9CAJfbLowGSTUrYrjiHxsxs7xn+ImCBvx8722tDaBqE1V5s4WrWS
	 TVF3pkJP2n8XuZIRYmSK0dtWsr51sK+ad8g4xyLto8nHQHPaItjXVmaEisoa+SQoX/
	 /VbCl0EGnGs8wIGfkkiCGzl/+3G4buQEdyKHcL+6LiiHb8AGsQQH4fMyfpB+NsATjo
	 WYfbDJMxE/fj6U71nDyIzdm6Q6bj+nptuRVKJo9JE7ncdN7z/3evh6oUhUfSEhs6y7
	 6QF7qK51lAGzkc42Uf5v8x1A0Wo1MJjb+zX4Mjk1R6/1k7T0gZhJsC6usc1kenyrY/
	 JhJcNdET/pf2g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 1/5] net/mlx5: Introduce indirect-sw-encap ICM properties
Date: Wed,  6 Dec 2023 16:01:34 +0200
Message-ID: <107cca7dd6a932a1704abf6ebd1b801105546a8e.1701871118.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701871118.git.leon@kernel.org>
References: <cover.1701871118.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shun Hao <shunh@nvidia.com>

Add new fields for device memory capabilities, in order to support
creation of new ICM memory type of SW encap.

Signed-off-by: Shun Hao <shunh@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6f3631425f38..02b25dc36143 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1193,7 +1193,8 @@ struct mlx5_ifc_device_mem_cap_bits {
 	u8         log_sw_icm_alloc_granularity[0x6];
 	u8         log_steering_sw_icm_size[0x8];
 
-	u8         reserved_at_120[0x18];
+	u8         log_indirect_encap_sw_icm_size[0x8];
+	u8         reserved_at_128[0x10];
 	u8         log_header_modify_pattern_sw_icm_size[0x8];
 
 	u8         header_modify_sw_icm_start_address[0x40];
@@ -1204,7 +1205,11 @@ struct mlx5_ifc_device_mem_cap_bits {
 
 	u8         memic_operations[0x20];
 
-	u8         reserved_at_220[0x5e0];
+	u8         reserved_at_220[0x20];
+
+	u8         indirect_encap_sw_icm_start_address[0x40];
+
+	u8         reserved_at_280[0x580];
 };
 
 struct mlx5_ifc_device_event_cap_bits {
-- 
2.43.0


