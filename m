Return-Path: <linux-rdma+bounces-8669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A69A5F829
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F34719C3959
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D42676CA;
	Thu, 13 Mar 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGTfE6QR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194B267F77
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876207; cv=none; b=CkT1G9+rAKWeIh4++ZI8g09JYH8PidUduvpwJh8LLh6DkEjNHBXTwUxF/HH9hdewKRwtsQJDdge6y1hWKqN6gQgxS7mvjqqx4KRgI8W20B9oIF1Oj3zdO35l6DGwI3Lq3W+sC9wLFeESdkTxE/bxlzfJBbEAaWv2c/UwUSREYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876207; c=relaxed/simple;
	bh=0uScM323W9FbB4rtVJPSTb0m955bNu3yCjkSJzuSB4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xk6X7Fa9FTblFx8Pg09vXU5FlXW2f/5w7fml87GUn7TYmm5ZXn8x6cXinI5MAHCaUDLDYRqH9QgQUbkKUo+rb+8AgYzbHRLhqDGeg9QtflXBVgBAqrRfVz74oAg5RPGxEmNlzIbxfjQVuvgGXFxmvhMNK99N+VVXuRe+QWPx9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGTfE6QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1293C4CEE5;
	Thu, 13 Mar 2025 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876206;
	bh=0uScM323W9FbB4rtVJPSTb0m955bNu3yCjkSJzuSB4g=;
	h=From:To:Cc:Subject:Date:From;
	b=HGTfE6QRnt0grnPmHBqNEj7Yz3kFbvdaozgDfzR6ASrZ3aitUAdkuXjkt8X6R4Vm7
	 nU4upVPQmjZsrFM8NMqqKleWzoTmWU3+zRrH1uQw/QYVFcKM9zOEj8HSckUd8wWNOU
	 UkB28wCS6BuOjjfBdAIi/u4XxlUHt1ePkUkLa+5NIe04CFtQcn/3fcxFOM04IzaQTH
	 kIDLEKIdrVd1IIb8SCoHKntEikBKorRCKOyQzLYUojQfpFBLUrE4TGboY09h4mrg4P
	 q/STgEym6zM8+WS+XZsaQxj+pR6vhhmOQ+SxAWe2J+VQC8ahfVvpP9hPPrzFTrFpQ8
	 +FkVbIJcOvo5g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/7] Batch of mlx5_ib fixes
Date: Thu, 13 Mar 2025 16:29:47 +0200
Message-ID: <cover.1741875692.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is batch of various fixes to mlx5_ib driver.

Thanks

Chiara Meiohas (1):
  RDMA/mlx5: Fix calculation of total invalidated pages

Michael Guralnik (5):
  RDMA/mlx5: Fix MR cache initialization error flow
  RDMA/mlx5: Fix cache entry update on dereg error
  RDMA/mlx5: Drop access_flags from _mlx5_mr_cache_alloc()
  RDMA/mlx5: Fix page_size variable overflow
  RDMA/mlx5: Align cap check of mkc page size to device specification

Patrisious Haddad (1):
  RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

 drivers/infiniband/hw/mlx5/cq.c      |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 23 ++++++++++---
 drivers/infiniband/hw/mlx5/mr.c      | 50 +++++++++++++++++-----------
 drivers/infiniband/hw/mlx5/odp.c     | 10 +++---
 4 files changed, 56 insertions(+), 29 deletions(-)

-- 
2.48.1


