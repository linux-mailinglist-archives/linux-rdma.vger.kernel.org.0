Return-Path: <linux-rdma+bounces-3437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D4D914E57
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 15:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078991F22FAB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C213D889;
	Mon, 24 Jun 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAS0Rdpj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156E136E3B
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235479; cv=none; b=D9B4FoEZt2y0Ffa0uYNbpORkSXBfVHIkr1Q6ZWuW224rqgRnH5QI0RYqBrolLKhYIOzZEt/t2P1I4kyP20Yd6IJbge/wLaUnyapv5ast7AiFbRps8K6HSv59pnJNR5pVtm81VjhJcrc24wDIH+lNKDoFeU5ct3xqzqJodwlmbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235479; c=relaxed/simple;
	bh=OtJqbCE9YE8lSOcgpszt1c7qDw//cqstbJDFqzLMyGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTvHw7eHkjS+8iTuKgVNnaR0ev6I+QhPalRwQFTi8uTBWOh8+SkbrMf2S/HQ9TKLj16MBRizPgzyot5B3J1DPKmbK/A/ZH2muwc54InfkQRqLrW3OBtamflL01bh/SUkuh+bbPg2v1SQuzwDCN+cMgjJcfrLUd3VCT9Vg817DpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAS0Rdpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADCBC32782;
	Mon, 24 Jun 2024 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235478;
	bh=OtJqbCE9YE8lSOcgpszt1c7qDw//cqstbJDFqzLMyGw=;
	h=From:To:Cc:Subject:Date:From;
	b=AAS0RdpjIIgiBotz8CTP+HkedJuneT6ytOK/VJF6eAN1XiJkFwSBIEMYB/cywwune
	 D5RGeuPMT+RyhSGFNDHw8qes93/7qM1kvrbwunNg+eJPcmhLCDLxNAcA3VyCp2LSPH
	 bPsS5+0beR6WPF7oI50dWo/I8N+v+8AIOjUB8/hmG5xBzASbM02HM6eN9JxhqCyONj
	 qdXluN/zZ2YE6XiLv+QFGBQCyhAfIPEJeNwBsDWRSF35so6SDzs9zXX81AvPKUYrqt
	 iK7KW2YaGGBAeuHtg4L9ec/kh4QUD1LiDRjvpuECtc2rhCfDZHuaYC4tMUIvbQU9CH
	 irVJGSfauQ9gg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/device: Return error earlier if port in not valid
Date: Mon, 24 Jun 2024 16:24:32 +0300
Message-ID: <022047a8b16988fc88d4426da50bf60a4833311b.1719235449.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to allocate port data if port provided is not valid.

Fixes: c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an alternative to get_netdev")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8547cab50b23..7aaf2b4c1844 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2163,6 +2163,9 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	unsigned long flags;
 	int ret;
 
+	if (!rdma_is_port_valid(ib_dev, port))
+		return -EINVAL;
+
 	/*
 	 * Drivers wish to call this before ib_register_driver, so we have to
 	 * setup the port data early.
@@ -2171,9 +2174,6 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	if (ret)
 		return ret;
 
-	if (!rdma_is_port_valid(ib_dev, port))
-		return -EINVAL;
-
 	pdata = &ib_dev->port_data[port];
 	spin_lock_irqsave(&pdata->netdev_lock, flags);
 	old_ndev = rcu_dereference_protected(
-- 
2.45.2


