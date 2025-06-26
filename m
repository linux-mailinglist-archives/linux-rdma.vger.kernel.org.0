Return-Path: <linux-rdma+bounces-11688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60210AEA5F4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55C41C43E9C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F92EF2B2;
	Thu, 26 Jun 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcbQyo4q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658A2ECEAB
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964311; cv=none; b=ndfgZyvt9o0uEgrPCSW/O340uCDWCtgfgzayxXc2b2zdOrHIxBA31Boq7KMCd1VkZpJH/pBSWJkfohMXZzVIzjO4lEEZPjrKPIJiR932tdoy+wbUILJ2Qxz3M/08ipa1lUNJjLatqafd9vA3UFA58y13MYjbqM1Ep/DaobWdsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964311; c=relaxed/simple;
	bh=KOibAT8JU9tCNVfFzWCCFC7bJHTkqLMDv7ipUMZ1tQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orcMkgrGAVxmLqgC83k1nB0WEKxmeH9I2WBbu3B8k0rY1lICEgNKe4edQrFGGJAbOxYNcbEJ5EYh3oAIayWHcO6Rus276AjBo717ZoFgc5L3Pn/Bq6NQiCElbK6uCmLMiwl8IPNFJOPC5JA7hqBlO+rLzr3ObpqXU0sj+/FQENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcbQyo4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4143BC4CEEB;
	Thu, 26 Jun 2025 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964311;
	bh=KOibAT8JU9tCNVfFzWCCFC7bJHTkqLMDv7ipUMZ1tQA=;
	h=From:To:Cc:Subject:Date:From;
	b=DcbQyo4qCfK9q2GEX09pIJElfz/M71aLULoJkO7kqQLwvXXTULxwuny/TiwKSy8OB
	 VnXABQZ3/+EnlTnLKKcGKJdUfPMFtUD33+BG+UaT0SXIQJJCno0qKZ1Q0QzRm6zxss
	 KVQAOhe1YWkHwWGqN4DKlW1kQD1fHMXltSzfWfbCUrSpGrhyBdh1hjKjrjgSDrJDGf
	 BRQcVbkqpkJBO1CK0JTLPly7Ou12nXnpQ1Ff174iGQTPab6NBIXXbHPnlpuDkN6SYS
	 2Tl4dijOXv2kbXKaF5zx/f2DQ++xjop0CIwCnFFKK19UehqZIAnNMRWMyYw9EugXWy
	 2EynVLRIGLYzQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next v2 0/9] Check CAP_NET_RAW in right namespace
Date: Thu, 26 Jun 2025 21:58:03 +0300
Message-ID: <cover.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2:
 * Resend right series
 * Split "RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create"
 * to three small patches. Maybe I should squash them when I'll  apply.
v1: https://lore.kernel.org/all/cover.1750938869.git.leon@kernel.org
 * Moved QP checks to be earlier.
v0: https://lore.kernel.org/all/cover.1750148509.git.leon@kernel.org

The following series from Parav clears the mud where against which
namespace the CAP_NET_RAW should be checked.

It is followup of this discussion:
https://lore.kernel.org/all/20250313050832.113030-1-parav@nvidia.com

Thanks


Parav Pandit (9):
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
  RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify
  RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA
    counters

 drivers/infiniband/core/counters.c            |  2 +-
 drivers/infiniband/core/device.c              | 27 +++++++++++++++++
 drivers/infiniband/core/nldev.c               |  2 +-
 drivers/infiniband/core/rdma_core.c           | 29 +++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c          | 10 +++----
 drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 drivers/infiniband/hw/mlx5/fs.c               |  4 +--
 include/rdma/ib_verbs.h                       |  3 ++
 9 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.49.0


