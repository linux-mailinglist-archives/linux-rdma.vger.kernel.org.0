Return-Path: <linux-rdma+bounces-7363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52C7A25A0B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 13:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA853A3D60
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B82080CE;
	Mon,  3 Feb 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQsYOfDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0B2080C8
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586930; cv=none; b=talYbWAsqbpmzHoNGuWIvKfDmedr2y825CrtAVmjXkN1CIwFYhzhaRTtAw8u0aDsO6Eqpr+bQY1SMncdOFgnEl3ewmvMgwBINppzRpSB1Jn1RVpP8tD3hqEsVlgRcF7uHwUax41EPo9Gm5eA9IJv/Rjry6cv53Udcgnu78m3QwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586930; c=relaxed/simple;
	bh=6m+etHzS50IQZaeVn+Tmw2katLiNzpjz3NmuvDMCnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZITXjmzxf1Fkqr6QwktCR4ujZSyMzwg3MALECDHnnBXq9gL2qg3KNACaehyxEahVuyKgdweokF1/QZEdPS3klN1uo++dUFctA77YGVmbeEQIfuo5LWY3GjkND6PlOZv8MIw3yOLpMbGZKlQBhE7uDqQzHMaJzLSOdWoOebm1VAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQsYOfDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0D1C4CED2;
	Mon,  3 Feb 2025 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738586930;
	bh=6m+etHzS50IQZaeVn+Tmw2katLiNzpjz3NmuvDMCnR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQsYOfDh5/I75sKivlGe4nJQkA1+0hwxGZ3bqdaAKg3kPle8MIjI1sF19aoE4mLS4
	 /9z/g4k7bnbWW9fq2muIm9oXQdfBssBngREr3iUbwOXJBKIkEWdCYBkQhmQ5yLUtvw
	 Jmn0utKerJSBjL1IjYsZenRwlB2QnZb+Nqlo0LTfMM4HfL8ugvx3Q+kHKVsvDQ0x23
	 pwV/6aI7D4FBSxXvQA6gAf6LO686mH1kl56Cis11j2yJe8nC7FEtytDadsCaHmuwMe
	 SIMEUM0JP9QUjsccOk+eab6wor9HyL6syFHEX065DAntoeZgGAE3aJSntj9Hw9gb0d
	 1rX0dFuMbZckQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/3] IB/cache: Add log messages for IB device state changes
Date: Mon,  3 Feb 2025 14:48:04 +0200
Message-ID: <2d26ccbd669bad99089fa2aebb5cba4014fc4999.1738586601.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738586601.git.leon@kernel.org>
References: <cover.1738586601.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Enhance visibility into IB device state transitions by adding log messages
to the kernel log (dmesg). Whenever an IB device changes state, a relevant
print will be printed, such as:

"mlx5_core 0000:08:00.0 mlx5_0: Port: 1 Link DOWN"
"mlx5_core 0000:08:00.0 rdmap8s0f0: Port: 2 Link ACTIVE"

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c |  6 ++++++
 include/rdma/ib_verbs.h         | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index f8413f8a9f26..9979a351577f 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1501,6 +1501,12 @@ ib_cache_update(struct ib_device *device, u32 port, bool update_gids,
 		device->port_data[port].cache.pkey = pkey_cache;
 	}
 	device->port_data[port].cache.lmc = tprops->lmc;
+
+	if (device->port_data[port].cache.port_state != IB_PORT_NOP &&
+	    device->port_data[port].cache.port_state != tprops->state)
+		ibdev_info(device, "Port: %d Link %s\n", port,
+			   ib_port_state_to_str(tprops->state));
+
 	device->port_data[port].cache.port_state = tprops->state;
 
 	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0ad104dae253..b59bf30de430 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -519,6 +519,23 @@ enum ib_port_state {
 	IB_PORT_ACTIVE_DEFER	= 5
 };
 
+static inline const char *__attribute_const__
+ib_port_state_to_str(enum ib_port_state state)
+{
+	const char * const states[] = {
+		[IB_PORT_NOP] = "NOP",
+		[IB_PORT_DOWN] = "DOWN",
+		[IB_PORT_INIT] = "INIT",
+		[IB_PORT_ARMED] = "ARMED",
+		[IB_PORT_ACTIVE] = "ACTIVE",
+		[IB_PORT_ACTIVE_DEFER] = "ACTIVE_DEFER",
+	};
+
+	if (state < ARRAY_SIZE(states))
+		return states[state];
+	return "UNKNOWN";
+}
+
 enum ib_port_phys_state {
 	IB_PORT_PHYS_STATE_SLEEP = 1,
 	IB_PORT_PHYS_STATE_POLLING = 2,
-- 
2.48.1


