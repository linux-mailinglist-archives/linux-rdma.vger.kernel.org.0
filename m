Return-Path: <linux-rdma+bounces-7093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7692A161D9
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AC9164E9D
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2721DED6E;
	Sun, 19 Jan 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzv067oj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA36EEB5
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291437; cv=none; b=dGgzDbPk/9gb4j/ZJ+QqWHbxTXczPUrM1qammGwMP46KNI4BijnpfHkIbQHWEgIRJLzizXA6Z73EIBoGJOJY7v/f/kIXpd31pr1vlQVvWhikDZA9+9g6DqoaZSVQ2SsuMZv669BnnkR/L18JWTyI30AXzFqJ0+L51aw6EmH0Hfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291437; c=relaxed/simple;
	bh=RE8qJVesfpU8vzkRw7dceBBasePuOpg/DRMFlgSlo08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4tSkTBgglsNvDZbASn7md5R3X9D+BxBI3oVFoZsKwyG64kMn4o2u9qyBPuHLU6LtigoaFQ1DKkUvwHPqJuexs4y35eyteO5ggpjm7QEHMzWkH7xF+P+NTBbBboxyfF0D6+HuZdLyfHL9rQytIqPLoMmEJ+b2mWkYqTxC9dQp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzv067oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B5C4CED6;
	Sun, 19 Jan 2025 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737291437;
	bh=RE8qJVesfpU8vzkRw7dceBBasePuOpg/DRMFlgSlo08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lzv067ojHdD6PaA86QQGPjengntmPc7Kzrlf+iNP2VeiXBBzmEWwGYucmW3kQjNtH
	 04Moi2xdG5pBCsXgPRq5ultefiiSQFne2wuD+yl9Dxj7ijUy5gjUQGCOst4yGOknv5
	 TMJnBsBxB0pLnR0+/JCvN0yKnNT1ZC0lDIv2oW/VjSy4pG421rc7au7+K6PmaE3DZ6
	 oJPUSGO/zgg8lhJazAHPMl+MdHPGVMocwBcgucxSea9SFxTlkyvHo7pG7KXpJYqHS0
	 /dq5ugXg6WSfJI/Q3qr6DUMG2qAP0X4sdxzkqDRZSje9y87yjSQ2Y37Z/h2gYFYtZw
	 xu+CvLeWR3vbw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/core: Use ib_port_state_to_str() for IB state sysfs
Date: Sun, 19 Jan 2025 14:57:01 +0200
Message-ID: <5fe1664b6c363800ce2469261a9cb909473275ad.1737290406.git.leon@kernel.org>
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

Refactor the IB state sysfs implementation to replace the local array
used for converting IB state to string with the ib_port_state_to_str()
function.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 9f97bef02149..7491328ca5e6 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -216,24 +216,12 @@ static ssize_t state_show(struct ib_device *ibdev, u32 port_num,
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	static const char *state_name[] = {
-		[IB_PORT_NOP]		= "NOP",
-		[IB_PORT_DOWN]		= "DOWN",
-		[IB_PORT_INIT]		= "INIT",
-		[IB_PORT_ARMED]		= "ARMED",
-		[IB_PORT_ACTIVE]	= "ACTIVE",
-		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
-	};
-
 	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%d: %s\n", attr.state,
-			  attr.state >= 0 &&
-					  attr.state < ARRAY_SIZE(state_name) ?
-				  state_name[attr.state] :
-				  "UNKNOWN");
+			  ib_port_state_to_str(attr.state));
 }
 
 static ssize_t lid_show(struct ib_device *ibdev, u32 port_num,
-- 
2.47.1


