Return-Path: <linux-rdma+bounces-2364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68568C0C0B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CE41F22ABF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79646149C7C;
	Thu,  9 May 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQsZOevS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A745149C74
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240381; cv=none; b=d9hcE5mzXRCnGAmhkXaKVvK57ET7akTNVHivZP8BqOcM9sC4WpMtY8it/uP9yp/wiEQqN1rn1bPRGhsyWynin4p0udIBzLPNHzOl67ieA3MHpE1odBxngaFemujlbN3fqQqjjpNZgD5gKal+8SU3J+LVgId/yJ107TBipldUCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240381; c=relaxed/simple;
	bh=ZOT4JZaiRgIFTvI8wFh95vMtKK+jc/SotT6Ymf3uM0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eS5w/hHQMR/ItE0zP+f5ZFDkevkEWaB4AnaXjldwPzbgMNpJ7i+/N2uIybCCd8aAM6Xsi4IT22KRJroLdKjQGRxkaJjLB0U/c9Pk/gl3bj1j22ZrsYoEGBbn0fodl2131zc3xkCz89SGz2zZqjEN1w82Cs9jJc9T1ZTGFYaz3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQsZOevS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46744C2BBFC;
	Thu,  9 May 2024 07:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715240380;
	bh=ZOT4JZaiRgIFTvI8wFh95vMtKK+jc/SotT6Ymf3uM0w=;
	h=From:To:Cc:Subject:Date:From;
	b=fQsZOevST485uGPg6FtQTxhpiHALGElsV7ctXax5VJwTs0sumSycZbWhtolyzUW3o
	 IsFd8Ljb+R0Gh2hC7hBnFsgUYnbhsALWqKGdbX2KwKYOFL4/TivGOfimr+Hh0Ro/16
	 SAoI0qFUWPwbZuUwTJs8lJwFek/Cekv4goMG9qsR+yJjS/t/OaaZzcCa4Hhp26UtsN
	 lRWZZtM9aPcJVo79AG2lM6GW2WUjwyyQlG8lc3CCUHrKOF+IHjFW/IwBLTU8KK+pPg
	 Gq4oBQu/8g//kgS0yCW6/kSxFmFACMGdzHD7NfxN9CXFjepZ8Cnh5f2xP4ElpycTAu
	 oXfHokYRs8ASw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1] RDMA/IPoIB: Fix format truncation compilation errors
Date: Thu,  9 May 2024 10:39:33 +0300
Message-ID: <e9d3e1fef69df4c9beaf402cc3ac342bad680791.1715240029.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Truncate the device name to store IPoIB VLAN name.

[leonro@5b4e8fba4ddd kernel]$ make -s -j 20 allmodconfig
[leonro@5b4e8fba4ddd kernel]$ make -s -j 20 W=1 drivers/infiniband/ulp/ipoib/
drivers/infiniband/ulp/ipoib/ipoib_vlan.c: In function ‘ipoib_vlan_add’:
drivers/infiniband/ulp/ipoib/ipoib_vlan.c:187:52: error: ‘%04x’
directive output may be truncated writing 4 bytes into a region of size
between 0 and 15 [-Werror=format-truncation=]
  187 |         snprintf(intf_name, sizeof(intf_name), "%s.%04x",
      |                                                    ^~~~
drivers/infiniband/ulp/ipoib/ipoib_vlan.c:187:48: note: directive
argument in the range [0, 65535]
  187 |         snprintf(intf_name, sizeof(intf_name), "%s.%04x",
      |                                                ^~~~~~~~~
drivers/infiniband/ulp/ipoib/ipoib_vlan.c:187:9: note: ‘snprintf’ output
between 6 and 21 bytes into a destination of size 16
  187 |         snprintf(intf_name, sizeof(intf_name), "%s.%04x",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  188 |                  ppriv->dev->name, pkey);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:244: drivers/infiniband/ulp/ipoib/ipoib_vlan.o] Error 1
make[6]: *** Waiting for unfinished jobs....

Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Limited device name to 10 characters to allow 16 bytes for snprintf.
---
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 4bd161e86f8d..562df2b3ef18 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -184,8 +184,12 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 
 	ppriv = ipoib_priv(pdev);
 
-	snprintf(intf_name, sizeof(intf_name), "%s.%04x",
-		 ppriv->dev->name, pkey);
+	/* If you increase IFNAMSIZ, update snprintf below
+	 * to allow longer names.
+	 */
+	BUILD_BUG_ON(IFNAMSIZ != 16);
+	snprintf(intf_name, sizeof(intf_name), "%.10s.%04x", ppriv->dev->name,
+		 pkey);
 
 	ndev = ipoib_intf_alloc(ppriv->ca, ppriv->port, intf_name);
 	if (IS_ERR(ndev)) {
-- 
2.45.0


