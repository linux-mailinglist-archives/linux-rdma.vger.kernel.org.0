Return-Path: <linux-rdma+bounces-3173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F005C909E5D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041421C20CF8
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EDE1946B;
	Sun, 16 Jun 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDMomB8w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B25182D8;
	Sun, 16 Jun 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554148; cv=none; b=tiGCMvXFZcGtWMx2uUh9V1lO6YbemlLNdlzHJWbkEuFYjjATw3rW/HgJwZLud7X6pufNkP9a8tFEzT69fGUD3+A7Bv0fVPq13Jj3dBbrAg7fh7omnOi8eivgp/EKvDk/mVVQVO1lnLmuqeFLv3y6KEcwkfGiTceESysVBDOY1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554148; c=relaxed/simple;
	bh=jzYsC6IezD/Lf+2W38MT2qMOCZqExEGRYGpGFTt+1U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJArO6LV39zAcmtRxKbOg044vpsGaEhMluMH6n6UNkuf08/AoRC+3+mrsxqmdpLSX8QzNumkSKXt4nxRCj8p5zcskgSc6uut7m3u/CiO7a1YuptAC0U0MVwulJAC/Yg9xNzphHdYL1NRSFnIvEHrJaxN79Jig2LN3AvE6SLBVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDMomB8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB26C2BBFC;
	Sun, 16 Jun 2024 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554147;
	bh=jzYsC6IezD/Lf+2W38MT2qMOCZqExEGRYGpGFTt+1U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDMomB8wkpMAu0jk9+ZqKOdLzXD6Ze7jM641SsaGPeQhZQWOwmQ0ZUzJ0NlnkCxjL
	 jJ9t/S18Zbg1CEnsXZskU2/x42LMrMsvHnb6GnhJwsCHR0O7kFGKxeSfZRdx2llBia
	 BAUNpimAVXwhNuMbhJ1tTV1YW0M2+fSqnIIT3HRjt0cqz1RTuuOUtDiIWDQpMJKcal
	 yxS634UpxWNIm9fvkIVy3p+gsO+zumdY4kb2i+kUYCj0iVgwTOC+dLNcxCk4mLzdYt
	 xgU3ojaQb6YWMJg9ZBAPhhSzBJRUGvo1Y/y52+xiym0ktoXIabJDiXR93cxZc0e5e3
	 UL0VBPhj7uFzA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 05/12] RDMA: Set type of rdma_ah to IB for a SMI sub device
Date: Sun, 16 Jun 2024 19:08:37 +0300
Message-ID: <195be77aae0cce93522269f22f1303d2ccbef605.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

An address handle created on a SMI port has type IB, as a SMI
port it's used for SMI management through umad.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/rdma/ib_verbs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bebc2d22f466..c20571618798 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4660,6 +4660,8 @@ static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *dev,
 			return RDMA_AH_ATTR_TYPE_OPA;
 		return RDMA_AH_ATTR_TYPE_IB;
 	}
+	if (dev->type == RDMA_DEVICE_TYPE_SMI)
+		return RDMA_AH_ATTR_TYPE_IB;
 
 	return RDMA_AH_ATTR_TYPE_UNDEFINED;
 }
-- 
2.45.2


