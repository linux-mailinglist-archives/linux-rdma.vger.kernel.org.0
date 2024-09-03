Return-Path: <linux-rdma+bounces-4712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70899969B99
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1922814FB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EA1A0BD2;
	Tue,  3 Sep 2024 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwJ1flVZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D871B12C8;
	Tue,  3 Sep 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362697; cv=none; b=Mp0YrDlSTlXAan8jALyVaEuPr0a3HodKga1E6hmQldjvyYHvPP2VhnOUsGRIwqxcc+pZnD4M++2V4tSYfK2KuNZRBK2maTdi3m+KnAauF1g/Ukz3OFhoz/iECygB5JPNoeESWhHA98wHEynJeHXQb1bV9XhJqJP60bRKw35ZbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362697; c=relaxed/simple;
	bh=V/6tdy21a6YEAJVudpdKLBB/NJR0GuimlKPZBfBXRXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4S344g5Hwwho+afOvSFdtMaC4DmhqZXC7UhXCVfbKnuHXr0o27AkgaMjSXiIh4nMig/a9LDI7IMQSB7ithzUyQUJKIoGd78g/pU6tdAhYHcDgkOx99vpYxDBu8GKRUZTTrQWav1/jMZL1Yl+gt5D+gLDOeNOiwZSUFsM3dctso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwJ1flVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490E8C4CEC4;
	Tue,  3 Sep 2024 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362696;
	bh=V/6tdy21a6YEAJVudpdKLBB/NJR0GuimlKPZBfBXRXE=;
	h=From:To:Cc:Subject:Date:From;
	b=dwJ1flVZ11GrCDIAG+yJ8igN7meruCsdDMNiJE9bHYj43btnRQqCmysmDeXsuP5lc
	 EGL5BBJDZ+hNsuCNixj4KOhB9+bi6xc2oAaU/zf0DwbwDewz6gbw9ZQzzEj2Y6GFJJ
	 qst39xMqWY3Yqg/pzsEWMe7A06Mf4s63Vn3ec4xTeMVWe9syt1M8AcqwWhosXKoeMj
	 DhJPKCwmP8l4wGM/K0gGJQZ8e0XGdpjhsHFKschCslrGurcV6RVzksDoMx4aQoIrfI
	 D08STUMQsCseOZhKLo+XhqQiMUd2F0PidZ6/6pCFs4BvTO7aq1PSyQhDmHTekUN9/r
	 YhV2qKXZeI9Ng==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 0/4] Batch of mlx5 MR cache fixes
Date: Tue,  3 Sep 2024 14:24:46 +0300
Message-ID: <cover.1725362530.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This is a batch of mlx5 MR cache fixes.

Thanks

Michael Guralnik (4):
  RDMA/mlx5: Drop redundant work canceling from clean_keys()
  RDMA/mlx5: Fix counter update on MR cache mkey creation
  RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache
  RDMA/mlx5: Fix MR cache temp entries cleanup

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 99 +++++++++++++---------------
 2 files changed, 45 insertions(+), 56 deletions(-)

-- 
2.46.0


