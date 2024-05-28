Return-Path: <linux-rdma+bounces-2627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011B8D1BAE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1480C1F22BF0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36716D9AA;
	Tue, 28 May 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j80c7Uy+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105316DEB0
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900786; cv=none; b=UvPRHjT18s42ZCCwry+EnNpr3gQqDBp76fVI2kHZGJ0zHpXxahdyCCUnihFAGQJTvb23o710vCVfUyD5BBJjXZDx1JG9giwqbPGUlsn6+1zRJ+YUV2jMjYCEAWFii+hX8c+FaGQ9vbfiubAfdifslfpvcSxYev4VriLyILvIYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900786; c=relaxed/simple;
	bh=RQBIJZ584cV+/tQTnCf95VsjRToiFSgVYsuoVDSszc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqNr7UdLQQ1m0dW0W6Qsg3iGlkyOpx3sGGo1yLw5HMwdQYfuTK4tIJH3laxiazGqiE14GHc2YoIKO0+gNJBDtldFL18wg7yZtYwZpEydwYWg11k1ox19iMoGVhv3uDF5Z63WsJ8AjpM+OYo8usw1PE0UfKBkS2S3aMiqpDWxXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j80c7Uy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE649C32782;
	Tue, 28 May 2024 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900786;
	bh=RQBIJZ584cV+/tQTnCf95VsjRToiFSgVYsuoVDSszc0=;
	h=From:To:Cc:Subject:Date:From;
	b=j80c7Uy+wBipKdvgDslawuv9X2S5fdcCZ76VRrRahYvWhhLt4uEbtPN+t2+LZv5Iw
	 kDEFNLR6tuYOl2C/8HDWiORWlZ1tfgQ6/9C4ufE86eZ/ZG+T97T8k1Tr2dLBOVEC+/
	 J4upcB1y5xzPw0pw0pM8cgVlZKPxzS0QnaqZ+dnMAt+7lf/SFJJ6J9x5P1ObOrPzJ/
	 CtN9Qk9RvIly3uvz78BOzpiJFb03M2pfRv9RBr91GqutP6yAMu9M5q4J5YLqyeODWK
	 A20f9yDngzxLRE0uaGsNq5mEcuK9yHBFmKB/UGaGM7BZXMM064KKkV+ZYIEUhonZIT
	 kN43HatAdMNLg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc 0/6] Batch of mlx5 fixes for v6.10
Date: Tue, 28 May 2024 15:52:50 +0300
Message-ID: <cover.1716900410.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Various fixes which I collected during the last few weeks.

Thanks

Jason Gunthorpe (3):
  RDMA/mlx5: Remove extra unlock on error path
  RDMA/mlx5: Follow rb_key.ats when creating new mkeys
  RDMA/mlx5: Ensure created mkeys always have a populated rb_key

Leon Romanovsky (1):
  RDMA/cache: Release GID table even if leak is detected

Patrisious Haddad (1):
  RDMA/mlx5: Add check for srq max_sge attribute

Yishai Hadas (1):
  RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init

 drivers/infiniband/core/cache.c   | 13 ++++---------
 drivers/infiniband/hw/mlx5/main.c |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c   |  8 ++++----
 drivers/infiniband/hw/mlx5/srq.c  | 13 ++++++++-----
 4 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.45.1


