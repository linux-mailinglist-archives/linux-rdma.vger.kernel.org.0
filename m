Return-Path: <linux-rdma+bounces-11335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F59ADAB9D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CE7188C3AF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C71235C17;
	Mon, 16 Jun 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoFbTLI6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762661B042E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065344; cv=none; b=UmE1vD9whJ+AeGTITOudInmd99GEkXqxt5bT2qCCxgGcTR91o7pjlXtqSOZhWfm99h6M7sw1tDD2e+0zDDNNhB1j2Vdmhwy0AQIT39QY7sN5k2Rm1V+Zx2/cASsdm9KekiBjr06KjApzZ2nVn+oHQ/Gft+DyVf3ccJcxj9uoNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065344; c=relaxed/simple;
	bh=StZgESgpiWskJO2aWjqi8tQDGLLle3aIQ62fbHlM7qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDF6cTi8S218xrTeAv8VDCaqkBnitKIfJzwfQdOAJagvfloT2U9zeq1lAn+ppCfLmyTdcZtBshBjwy9aDJ2yWJy3U32oOZBv92ADMRzQC1YRYvD+waLcvW5I8+yJbG1J264Zb1XwOmaI9XfWcixgCbiuAUZW73VoOv6bjQgqJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoFbTLI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE2C4CEEA;
	Mon, 16 Jun 2025 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750065344;
	bh=StZgESgpiWskJO2aWjqi8tQDGLLle3aIQ62fbHlM7qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoFbTLI6+IEtgAOlLsW6t7LVwnt8LlXolLEj074ZDkuzq80coe0ZhB3/+/sRFENXK
	 0fHg6CPvGg1br/piwCgZB3KFSeaL1bDx9QyHy0iA0YKRQEo/L09s0AK/ngVLp4AXNi
	 76xNb0dUGTe+k4KXWthCJLvpWiwRc7sy5yXxsr99A2zq9zQGdK7hAf/D2ROjF3TbJ2
	 LHk6iQ2t+KZSuvTOrFrC4BbLgxmTTVw/vvptev3Q5MTE7nWPq1GWPC7db+p6cTit/u
	 3LPUoensSisaehjxQGyLUwiJ6nx4kNTZ9/0z51zboIbjjb0i6dyUCH8LQJo7kdxdzE
	 fkhRgykH6zJdQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-rc 1/3] RDMA/mlx5: Fix HW counters query for non-representor devices
Date: Mon, 16 Jun 2025 12:14:52 +0300
Message-ID: <56bf8af4ca8c58e3fb9f7e47b1dca2009eeeed81.1750064969.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750064969.git.leon@kernel.org>
References: <cover.1750064969.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

To get the device HW counters, a non-representor switchdev device
should use the mlx5_ib_query_q_counters() function and query all of
the available counters. While a representor device in switchdev mode
should use the mlx5_ib_query_q_counters_vport() function and query only
the Q_Counters without the PPCNT counters and congestion control counters,
since they aren't relevant for a representor device.

Currently a non-representor switchdev device skips querying the PPCNT
counters and congestion control counters, leaving them unupdated.
Fix that by properly querying those counters for non-representor devices.

Fixes: d22467a71ebe ("RDMA/mlx5: Expand switchdev Q-counters to expose representor statistics")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index b847084dcd99..943e9eb2ad20 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -398,7 +398,7 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 		return ret;
 
 	/* We don't expose device counters over Vports */
-	if (is_mdev_switchdev_mode(dev->mdev) && port_num != 0)
+	if (is_mdev_switchdev_mode(dev->mdev) && dev->is_rep && port_num != 0)
 		goto done;
 
 	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
-- 
2.49.0


