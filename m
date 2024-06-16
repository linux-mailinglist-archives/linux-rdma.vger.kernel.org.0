Return-Path: <linux-rdma+bounces-3170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A42909E57
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABC12816ED
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9238E1BC57;
	Sun, 16 Jun 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjKZVm5T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FD1BC4B;
	Sun, 16 Jun 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554135; cv=none; b=X/iUdsGYkb6EeDEc2ptZ1jwIv2Y/TFTp8sagcqiKkkNyfRRGPLp4q0q4VX2Eo0o5e7IAYcrSNfmKAtiC07YUDb3PWyWgjpFks5mNn5hiUL42GkAJhf/XAN35RozXEiVcfHaRxi8TMJ84Gtwd0pOOn6ZgMEztweyfF6roDAfVzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554135; c=relaxed/simple;
	bh=Yr0F0tcy7MVxE2G9ap3ePTzSt2p5bMapDxl4NlU3Shg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSNPV+leXCmb8WjjppjZSIIsZOGPDH3Mlwko/UDEG71F4vy+avOfsw4VOkpeEFArzAl6G28KG9nDLJJWgumMu0lkeJW9rXl68AOKb1Epnhw4saepUyTOGhMsndd0oWz1R+xZ7KAtEZ66hziqt6gC2b/lUNL3pBFNR/YJ8qwPnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjKZVm5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC9AC2BBFC;
	Sun, 16 Jun 2024 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554134;
	bh=Yr0F0tcy7MVxE2G9ap3ePTzSt2p5bMapDxl4NlU3Shg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjKZVm5TCCQdjMykpQyy5DHxOGj0mu0u9Xi7qcijdk1iPqOArpFGv/0lw09udu/Js
	 IOV/xIjULoP30giiAzK4o06O/VhF9hHxsGwhklrAjL01ZxdOF5nvWhSaIgur1Wniqe
	 UzCl2QZfcKDp63D9nzcuusEF8O0T7Sb+YjtEIo238/2lX3VOQol5u3UlyD19otaU/q
	 W5bAia7pIG+eYeVV8KiGV3zWq0G8mWNeBJorhe+bOZ8+In7wRp0171+DZ5gYb/kLtv
	 3jI+xT4uzZpdOQqigtWqoi9j7XAsoeHYS4X0Fey77MHRWASQCWvsZ+4//eLXiCqvQQ
	 9yCB71IQd91GQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 01/12] RDMA/core: Create "issm*" device nodes only when SMI is supported
Date: Sun, 16 Jun 2024 19:08:33 +0300
Message-ID: <359f73c9a388d5e3ae971e40d8507888b1ba6f93.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

For an IB port create it's issm device node only when it has SMI
capability. In following patches mlx5 is going to support IB devices
without this cap.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/user_mad.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 2ed749f50a29..f760dfffa188 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1321,15 +1321,17 @@ static int ib_umad_init_port(struct ib_device *device, int port_num,
 	if (ret)
 		goto err_cdev;
 
-	ib_umad_init_port_dev(&port->sm_dev, port, device);
-	port->sm_dev.devt = base_issm;
-	dev_set_name(&port->sm_dev, "issm%d", port->dev_num);
-	cdev_init(&port->sm_cdev, &umad_sm_fops);
-	port->sm_cdev.owner = THIS_MODULE;
-
-	ret = cdev_device_add(&port->sm_cdev, &port->sm_dev);
-	if (ret)
-		goto err_dev;
+	if (rdma_cap_ib_smi(device, port_num)) {
+		ib_umad_init_port_dev(&port->sm_dev, port, device);
+		port->sm_dev.devt = base_issm;
+		dev_set_name(&port->sm_dev, "issm%d", port->dev_num);
+		cdev_init(&port->sm_cdev, &umad_sm_fops);
+		port->sm_cdev.owner = THIS_MODULE;
+
+		ret = cdev_device_add(&port->sm_cdev, &port->sm_dev);
+		if (ret)
+			goto err_dev;
+	}
 
 	return 0;
 
@@ -1345,9 +1347,13 @@ static int ib_umad_init_port(struct ib_device *device, int port_num,
 static void ib_umad_kill_port(struct ib_umad_port *port)
 {
 	struct ib_umad_file *file;
+	bool has_smi = false;
 	int id;
 
-	cdev_device_del(&port->sm_cdev, &port->sm_dev);
+	if (rdma_cap_ib_smi(port->ib_dev, port->port_num)) {
+		cdev_device_del(&port->sm_cdev, &port->sm_dev);
+		has_smi = true;
+	}
 	cdev_device_del(&port->cdev, &port->dev);
 
 	mutex_lock(&port->file_mutex);
@@ -1373,7 +1379,8 @@ static void ib_umad_kill_port(struct ib_umad_port *port)
 	ida_free(&umad_ida, port->dev_num);
 
 	/* balances device_initialize() */
-	put_device(&port->sm_dev);
+	if (has_smi)
+		put_device(&port->sm_dev);
 	put_device(&port->dev);
 }
 
-- 
2.45.2


