Return-Path: <linux-rdma+bounces-11671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B623AE9D30
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E723A42FC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D917BA1;
	Thu, 26 Jun 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKwxVPAw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFFC147
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939579; cv=none; b=Z/kFCzp5SH89e47G6Po65WRYs2jMrLzI7b0QNsNsU64oMTXN9QVkcDzgGx7EfaHC2Nz3Kt3IFUbFWW77pyM9kMOZcBwBW9pJe3tH9s1O47EuR+lRdoWxa+YKUG0w1lLuE0bA9meaY4HxoQqVFKKwhLcI+4ZNWg17Mco7kCpcUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939579; c=relaxed/simple;
	bh=g8zbu/j5yrKyebrE2YsQc3GU3IioW4UU6yAsMTZU2nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tW3ojt+HncyiYjM+SsX0kcADY+WorO5qpLVHcm+1H49cPTYjFvtTIuMf3KJ7t0jRj7OcEJHlja87xqtd6/O5Koop5FGQkue8GaEEpyXudFBiZl0OeBsszk0w1dgPEWym4dBPb8U0mlLHKsGze82MysGdv1ipl9nYSqF2Wdm9XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKwxVPAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8ACC4CEEB;
	Thu, 26 Jun 2025 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939578;
	bh=g8zbu/j5yrKyebrE2YsQc3GU3IioW4UU6yAsMTZU2nk=;
	h=From:To:Cc:Subject:Date:From;
	b=jKwxVPAwTlp5A2jEZoTZeNiJ4CCS7Jy0NVHdFSuZs6bR3QsPeoBmxvxhCwtcBADh3
	 SJpi8HVzpWpnmAWYOK5cJwrVA/Yqd/2hAc1eDxtKF1QxqszHKKApmN9QcDne2d5W7V
	 aOdolajcBhuD+J1ASGg3vPk6B5/fjJZTQrMaIqaBiA+HdViT0fB946lJ1KPMiZxJKa
	 KzIjQu6odurSXM+oSx3MKv8j5vrtfD00ulFFVPxzrlIkgj4er8bBm+08tCiTwaRems
	 5AIkzVD+vwXrvrNSHGYrLlV4C9XjZ7MlCu3WtN/NtO7ZI+Lu6POQAmsehdEnt0LNn4
	 DAgSd2Ja/gU+A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 0/7] Check CAP_NET_RAW in right namespace
Date: Thu, 26 Jun 2025 15:05:51 +0300
Message-ID: <cover.1750938869.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1: 
 * Moved QP checks to be earlier. 
v0: https://lore.kernel.org/all/cover.1750148509.git.leon@kernel.org

The following series from Parav clears the mud where against which
namespace the CAP_NET_RAW should be checked.

It is followup of this discussion:
https://lore.kernel.org/all/20250313050832.113030-1-parav@nvidia.com

Thanks

Parav Pandit (7):
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
  RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA
    counters
  RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify

 drivers/infiniband/core/core_priv.h           |  2 +-
 drivers/infiniband/core/counters.c            |  2 +-
 drivers/infiniband/core/device.c              | 27 +++++++++++++++++++
 drivers/infiniband/core/nldev.c               |  4 +--
 drivers/infiniband/core/uverbs_cmd.c          | 21 +++++++++------
 drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 drivers/infiniband/hw/mlx5/fs.c               |  7 +++--
 include/rdma/ib_verbs.h                       |  2 ++
 9 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.49.0


