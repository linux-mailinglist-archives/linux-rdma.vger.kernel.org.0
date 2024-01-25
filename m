Return-Path: <linux-rdma+bounces-747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8683C27F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1661F256B4
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49D2C6A0;
	Thu, 25 Jan 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en5vp46V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249346447
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185818; cv=none; b=qhx1SuhOj9Vmx9HE9Dq+iEPRjca4dewgyftoftnglXodDxWwMwp7Y/1pHDIn+Thq9xXgav6myxXhORo7eN1Mxau1hBswrbk2ObJ3Bqgg1Bnjbwj+zvd6jzKrtp1ekaLHMD8RRcOdaz8d48pn/lmR8Ub3PrSAmt6X2xT4Lvg/Jrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185818; c=relaxed/simple;
	bh=V2r5HVeg9MJptd0Mu+lOI01g9qrIZvT93En2crvZnMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxH1YPHXJK31VqP6qzBNSjOVXMRmts8IuLbqTw0XxMExnv6o5k2R3v5hjB6UkuameXpCFi4CMoRACs4Am+s0YMNupxDl7bI26SN70pmyS3L4dtRpYS06q+OaPJt6/Ji32PN++69qYOwG6AIBM8z5+KCzxo4OHwzOu53SBxD2ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en5vp46V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0F1C433C7;
	Thu, 25 Jan 2024 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185818;
	bh=V2r5HVeg9MJptd0Mu+lOI01g9qrIZvT93En2crvZnMY=;
	h=From:To:Cc:Subject:Date:From;
	b=en5vp46Vja3Zb+fJ34eqgfUx60wMTRuvWQxEXl/AHtYqcTmecgEXnJaaOgQiddRMB
	 ru3wYDZ2RfposQ0R9oRZiIJCWKJPXEPmoBmGB40sNXkW7pS8pJil6tuqPpLeAGMeQh
	 OPM66lsoVKVAwOaytczd+PnPin34+zwWigBucqJevFILXaYsXboEC2AnkqXXemOBF0
	 E4h5fzI8zJ8UGmY7xQcZ2JgPnnplPOvFf9oK53pt9Dt5uSC56ze+blk9z5zzLrxKTy
	 3NijoeVcv0IvnOcvEmD+RumC8Vm5+H9ecLlITwIXctIymgjkZHOn0ePSbOWQNaN2ez
	 caAvyKZUJ6WcA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/6] Collection of mlx5_ib fixes
Date: Thu, 25 Jan 2024 14:30:06 +0200
Message-ID: <cover.1706185318.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

Collection of independent fixes for mlx5_ib driver.

Thanks

Leon Romanovsky (1):
  RDMA/mlx5: Fix fortify source warning while accessing Eth segment

Mark Zhang (1):
  IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if
    not supported

Or Har-Toov (3):
  RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
  RDMA/mlx5: Change check for cacheable user mkeys
  RDMA/mlx5: Adding remote atomic access flag to updatable flags

Yishai Hadas (1):
  RDMA/mlx5: Relax DEVX access upon modify commands

 drivers/infiniband/hw/mlx5/cong.c    |  6 ++++++
 drivers/infiniband/hw/mlx5/devx.c    |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 18 ++++++++++--------
 drivers/infiniband/hw/mlx5/wr.c      |  2 +-
 include/linux/mlx5/mlx5_ifc.h        |  2 +-
 include/linux/mlx5/qp.h              |  5 ++++-
 7 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.43.0


