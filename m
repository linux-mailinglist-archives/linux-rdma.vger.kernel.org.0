Return-Path: <linux-rdma+bounces-2151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E48B6F77
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EB128335B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB1129E7E;
	Tue, 30 Apr 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6W4UoB+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144B1292D2;
	Tue, 30 Apr 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472313; cv=none; b=ZnJJYQnYQ0nXC9skdplOAsmMlsx/IO5NTPMGvGWwtYJHCpyA1pc4H/Up/o74nykScUL+1QuMy5tXCUR6EGHbqCTGOeQiaWWp7TO60Wp4Of4/5a7yCQ1xG/dwsapFFpm409yUV2Khgf3Ul8/sTWEj9qUtYIgbTY3MF/4vfhd2TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472313; c=relaxed/simple;
	bh=rdVvA+4rlBJ+RNd99WGh8IJBSNkpYBqlfoF6+e5inyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce+0HKWqNOPM+TyeVAGE3Tn/3lkZOu3fBoj+D/T/wsebYTYC1Uir70dGu+iP2tltq0lZXWCRgdKwql9OUJGvO5Lu9h3TVDmPvib/Q2j53JtmSvVjwG7EvkxuVPW810UbqHFlPTdGd5czINYbqKmfea6nSCZ2gdirGzcz7gVbFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6W4UoB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDF0C2BBFC;
	Tue, 30 Apr 2024 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714472313;
	bh=rdVvA+4rlBJ+RNd99WGh8IJBSNkpYBqlfoF6+e5inyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6W4UoB+iVu2swNbM4oXoRezgGrOUhgNz1yvZYbal+T1q6q66tkD4rWzkC8K3BVMz
	 PVUfd/c/CGSJoJLKDpcQGbEsYR/G8Ajm7/wtH46IV6EnVjl9vRA2Mqg0t583MJkhLt
	 L/sb62nCPKBEaZAo9ngStbVdYy5Qxz+kajGb63kJJtQPUmEDjDv++z+UDSwG7RdyA/
	 2XuSI0fM1ttLxHTMwyRW2T4IYbzLjcbHJ/Mfka3nhb8WkgiJzX95tYBS7fUAG4q+a1
	 3c/Su/mgGv7uEJTxbDHwQLZtyi2mFbDPNIGqfQDn1YUsrgWY6uAJLpEmAql7pBJpUK
	 tKpE+LhiIrdGw==
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-netdev <netdev@vger.kernel.org>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH iproute2-next 1/2] rdma: update uapi header
Date: Tue, 30 Apr 2024 13:18:19 +0300
Message-ID: <b265f104d37354266a30238701d0f73b298a5209.1714472040.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714472040.git.leonro@nvidia.com>
References: <cover.1714472040.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Update rdma_netlink.h file up to kernel commit e18fa0bbcedf
("RDMA/core: Add an option to display driver-specific QPs in the rdmatool")

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index e8861b5e..a6c8a52d 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -558,6 +558,12 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE, /* u8 */
 
+	RDMA_NLDEV_ATTR_DRIVER_DETAILS,		/* u8 */
+	/*
+	 * QP subtype string, used for driver QPs
+	 */
+	RDMA_NLDEV_ATTR_RES_SUBTYPE,		/* string */
+
 	/*
 	 * Always the end
 	 */
-- 
2.44.0


