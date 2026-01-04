Return-Path: <linux-rdma+bounces-15286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3BCF109C
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D8D03020147
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000630E83F;
	Sun,  4 Jan 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDF5qgBm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987C30DED4;
	Sun,  4 Jan 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534718; cv=none; b=Py3PMwZfatgsg4nedEJQUhyn3c1a62hisxDINoZbHKAVjW2M+yo2l+IPQrNf8Toe4y4ZJqRriWj07UP44bqxurZmtRrTB+XaDe7q17K9UvlsH4o44KYlFonDnnp7CZZuzFEBVcH72pwB/WFBoJGDfEgdo5kz9Z/uU42Q2JX95aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534718; c=relaxed/simple;
	bh=zyQCc/ionfSra2OR43YGpjX2gNO3Y7Zq64wRAGZWgRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPwKBH5e65JE6gfCGRIEt9XO41AAcnwxy2hcpLlsqpmFqYDfkj1lJetlHZZW4Z2yXsJh1Blo8lv9vg098RO6h5VgThHd1J/O8DI3lJfMAKWjOEZaYeZiIlMWmA3hFCwREsys33Tc851lgTbKRRYZA94KRbKN72EyRIs+Z+yghsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDF5qgBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0814DC19422;
	Sun,  4 Jan 2026 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534717;
	bh=zyQCc/ionfSra2OR43YGpjX2gNO3Y7Zq64wRAGZWgRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDF5qgBmTeXCzRuADBQ1XtpPOJSlaiQZ1KlfLCDZ7Be5qnj3leJ6aQF8OMWaYbXc3
	 2uPJS5M6nVGkHANOwcDY17v6AzNv6Ee3ZSCejTRAXX+u09u71PF5CRrc+7CyaA6mP3
	 LxdGwLFEEOO/Zbiv1pWAd6v0RwrV3tjCLHXhAqqE/yuWBz7iVB/4ghzSGAa1iWHPhM
	 M2vz2z1o3yr0v7b47sgdj0PbhzsSBbyk7yyrK42cZdkYaifaDJ6/D1vqMIeeFREv3N
	 PGA1fk6fVPMQvlxSOrVouiGKq6hezto/Lw7VYgtJJnN7jW6sXV8PJk2M2oNvrrVGWP
	 5GhDOxZC2glLg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Fix ucaps init error flow
Date: Sun,  4 Jan 2026 15:51:35 +0200
Message-ID: <20260104-ib-core-misc-v1-3-00367f77f3a8@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

In mlx5_ib_stage_caps_init(), if mlx5_ib_init_ucaps() fails after
mlx5_ib_init_var_table() succeeds, the VAR bitmap is leaked since
the function returns without cleanup.

Thus, cleanup the var table bitmap in case of error of initializing
ucaps before exiting, preventing the leak above.

Fixes: cf7174e8982f ("RDMA/mlx5: Create UCAP char devices for supported device capabilities")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 40284bbb45d6..8d515d266125 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4466,12 +4466,16 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	    MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL) {
 		err = mlx5_ib_init_ucaps(dev);
 		if (err)
-			return err;
+			goto err_ucaps;
 	}
 
 	dev->ib_dev.use_cq_dim = true;
 
 	return 0;
+
+err_ucaps:
+	bitmap_free(dev->var_table.bitmap);
+	return err;
 }
 
 static const struct ib_device_ops mlx5_ib_dev_port_ops = {

-- 
2.52.0


