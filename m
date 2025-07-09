Return-Path: <linux-rdma+bounces-11995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FECAFE052
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2D563F51
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951A27E074;
	Wed,  9 Jul 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMvKVPhp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8826E6EE;
	Wed,  9 Jul 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043355; cv=none; b=LP+Lu+ELDqbZE/AVmxGOV+8LgG+poYJ38ssiMlv1b/lsg4WKnxvNA5Xsh7NSIMGtIxGI10WIvPZS3vGWNkjKBF4Iwe4FqZzDA8f0VtpBmTDsAoS95ld5v5fXg+3hzHTdS7GhSpBm2Z62dXKqzVyFBPF9+Uch0pilyzifHK5VgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043355; c=relaxed/simple;
	bh=zsLcTNejPM55VnAreZ2IFc+gTs/GmuyOIND2i7+DN1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ5P6s+QL9wzK/ufW4rbdVVIUQ/qzY8ZN5VdD5undfKAgsx/kUM+3X0E4aIQG0xW1Jo+20wAu7JvXl/JMtbMnBukRmkz78GKrj4iSJ6/WWI3kTRAIaDvdcKtZJ5MEin5Br1i8+8qViZcZ8g83hsQfs20fstk4/L/MTFBwqiCYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMvKVPhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C82C4CEF5;
	Wed,  9 Jul 2025 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043355;
	bh=zsLcTNejPM55VnAreZ2IFc+gTs/GmuyOIND2i7+DN1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMvKVPhpEs6TZE47aXgUpUqmi5SZxXVPldF0hA2hH90wG6tojplKwN/FThFMj8Jck
	 yriUH7SwaXDf4KTExbMCDFZIBv4Re1HP9eceAmEM3VZpSjijW5sP8u+CgNpI1UOWoF
	 XXkYQTK8+cij3VikbW03cR4W3+qa1HrJ2By8vNyIS5Xi8yiighYJATlKo49EUXmXn5
	 z3htqli5RBXu0WDo+0VR/LeAUwaov4ZW67K7cgMsaPzh26MIdw/G3j/o9L6fbYnfm9
	 eAFDtFzgBctU0QXHo2HTiN1eZqAYGRJrJ7N7ZjHVCfIxCM9qYHqqlUZGGlJVpzv0AR
	 kA8ekMurujN/A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 1/4] net/mlx5: Expose HCA capability bits for mkey max page size
Date: Wed,  9 Jul 2025 09:42:08 +0300
Message-ID: <3e4d3fda37934430f65f72601519e22bf396fd05.1751979184.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751979184.git.leon@kernel.org>
References: <cover.1751979184.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Expose the HCA capability for maximal page size that can be configured
for an mkey. Used for enforcing capabilities when working with highly
contiguous memory and using large page sizes.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5bb124b8024c..789a1f0a6739 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2173,7 +2173,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   min_mkey_log_entity_size_fixed_buffer[0x5];
 	u8	   ec_vf_vport_base[0x10];
 
-	u8	   reserved_at_3a0[0xa];
+	u8	   reserved_at_3a0[0x2];
+	u8	   max_mkey_log_entity_size_fixed_buffer[0x6];
+	u8	   reserved_at_3a8[0x2];
 	u8	   max_mkey_log_entity_size_mtt[0x6];
 	u8	   max_rqt_vhca_id[0x10];
 
-- 
2.50.0


