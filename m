Return-Path: <linux-rdma+bounces-1755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C31C896CAA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC211C22E48
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26313666C;
	Wed,  3 Apr 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7g9uF2X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65A6CDB9
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140570; cv=none; b=TCqjXws+IilG51TmUf/SgtOq4OPri7pGLZYsucCHXVETM/KmIkzsBqxHmq2L9ZHamAdkXYDk5aFSjWwzlF6pB6/VFF8YS73iHvclfogknKO76Zf6Eu0oDfJCvnXwCn2MQWOZpiHmjvRY4mRy004ZZrpWSI2UHwdOqGMDxt16Nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140570; c=relaxed/simple;
	bh=/XIKldrdBasnTmilCHP/f+Ovi5Ftix582/1v5g/cE9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sK4JLcbd15t7jNcjYPWV4NWCiPjfdPymbLpX0gFbnZIzJj3/svKAuJc2rlNsqb+eU+BjXG5f4BbhWJMsPbONSvCceM669MRP1bwDpHQXOWW2O3EwFHwZ9Br59Isb2hwRvYvMk1kFFN4fgje9/VgTEm3HAY4JNTuMVY+HyRubTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7g9uF2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3914AC433F1;
	Wed,  3 Apr 2024 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712140569;
	bh=/XIKldrdBasnTmilCHP/f+Ovi5Ftix582/1v5g/cE9o=;
	h=From:To:Cc:Subject:Date:From;
	b=e7g9uF2XymuaiEbWLvjtW5FQSfd7Zhr0+0W8ILzqV7u4473nZGstnLNMKnz3ghJrI
	 EatDZ6+EUbeGxiX1GgCtdsiPiWSk3/DO26nf9Y3BrJNz0ZE11KQ/AOagICfca+rjkJ
	 npNda+I+RwiL9ytFPDV8GIJJRp+ZZ26gtZdXBXmZhpE4Y3LPxrFT9osuR/+eZRKCjU
	 I1XN+MWpEV4vHxJfo1GYfivjf7XwtSfLXxe7E6qSSaqKpkrX9rtpOmOVzb4j2YFygs
	 HDPgd4676qQPbz8jDX/kmDMFca6uXR4oEs6toSFYSaXMLwFoWkPv8jB2a2D38x+QN6
	 TS/0Pig4bNIhA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next v2 0/3] Rewrite mlx3 mkeys logic
Date: Wed,  3 Apr 2024 13:35:58 +0300
Message-ID: <cover.1712140377.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

This is rewrote version of [1].

[1] https://lore.kernel.org/all/cover.1706433934.git.leon@kernel.org

Thanks

Or Har-Toov (3):
  RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
  RDMA/mlx5: Change check for cacheable mkeys
  RDMA/mlx5: Adding remote atomic access flag to updatable flags

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 35 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.44.0


