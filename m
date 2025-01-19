Return-Path: <linux-rdma+bounces-7092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB7A161D8
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF83A5807
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CCC1DED4C;
	Sun, 19 Jan 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQk6WXZj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0FEEB5
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291435; cv=none; b=Cgbaa1nTpe5oowd5Gj9seC+exUxEIvHKSZ5i0KbUqyoCwLehMjVXgCQckW3Ib876xLgXIJ3IaUcRazqaucWa1EFwHMOzfzjFhfxe4AOGI7bBITVcdF5sVnlovv3dh61zTt9VnVRdHdvFYPMeJ/yxNC75bvBAm7l4PMXhKCtNNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291435; c=relaxed/simple;
	bh=jD15RZoRCklDpXXoRoVsAadZUUpIm2Kv2YDd6Jiu390=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH7mG5yhSDv2WSfq7BAcfebNigYVlGctbDZTjvSEwYkfdToy6vlHcKOT4dU3BMKZkdq4ShKrqzKmFVvCH0sAlu0wn0+OmqwsA8TlbGZhambV6GhBROOym7Wc1Z93HHHA1GgQLNaJzLaOApQ9Qz7MaLGjoaghmf9UCRs6hm7Wt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQk6WXZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB05C4CEE7;
	Sun, 19 Jan 2025 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737291433;
	bh=jD15RZoRCklDpXXoRoVsAadZUUpIm2Kv2YDd6Jiu390=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQk6WXZjdNJgPp7k2IwUkxEDq4aTAMI4zY6I0WRpeAe5vt3EmOB2hsmbErRh6Xmo6
	 ++1czy7DazS8P1rDHLcF6qS8KXQ4plWwlcp2Nd9fLiCIwba/ICnAMS0VhoXtGkwbFA
	 RJZTg6irZFsCmtIuuTSAUVTplsmkuBFeNxoXfBDE90mVDKGBU8HZTAzPnodNu4P0iS
	 oekPSk676aIXeXg5Z02gpisHn+YdKglp4TUtV7cWO8kwtWCUjzbBIqNFhVvaXVquTV
	 8gZeWda1B41aZuk4+Fh6mWDR/2TyPp3vZxHptDwAHS6incCqr0Win5iYYwoAWNMd9P
	 MM2iUUAM44VQA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] IB/cache: Add log messages for IB device state changes
Date: Sun, 19 Jan 2025 14:57:00 +0200
Message-ID: <836272c0a839393c71df4df5138f2c072c6f67c2.1737290406.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737290406.git.leon@kernel.org>
References: <cover.1737290406.git.leon@kernel.org>
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

"mlx5_core 0000:08:00.0 mlx5_0: Port DOWN"
"mlx5_core 0000:08:00.0 rocep8s0f0: Port ACTIVE"

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c |  5 +++++
 include/rdma/ib_verbs.h         | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index f8413f8a9f26..a35a2f3c9ab1 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1501,6 +1501,11 @@ ib_cache_update(struct ib_device *device, u32 port, bool update_gids,
 		device->port_data[port].cache.pkey = pkey_cache;
 	}
 	device->port_data[port].cache.lmc = tprops->lmc;
+
+	if (device->port_data[port].cache.port_state != tprops->state)
+		ibdev_info(device, "Port %s\n",
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
2.47.1


