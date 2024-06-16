Return-Path: <linux-rdma+bounces-3186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B3909E77
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAD1C20AEC
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDAA17BA0;
	Sun, 16 Jun 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szawP9GA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1499DDAB
	for <linux-rdma@vger.kernel.org>; Sun, 16 Jun 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554599; cv=none; b=NhS+y3VtdQ/SsMUAoPxCYWiU43meo+oEtvPwuCelBz7oYW9HJXQg5LqMaRMSqiXZP0QCxHlO4l9B4B05ZcDQqfauGWR/VA0QTCsuv3U6O90MSYFnvaGXS41lO9lrCvVXJROrNPTzUPf0/+ZscB/wfnJG2mHfKVCP4RNhXnTPFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554599; c=relaxed/simple;
	bh=89qlnrqlJft9QHMSBYJXjTaVyRWiHCFCqAz8g9CnRwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRVcwjmAFeWMliUY6aIXBsUXqDAkroLNrSRsZgrEeHsMzwO97V/lDUW5mECJKiUf+7VVPs/cDEd0B7oHDc2VnAbefAYsGlRS6sOm35DUvDWiMC3ujxkWIqARD/EMhOwrUmpszZz9KTBfwZ7maP62OPRtBIzo513I2rOrZ8gtECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szawP9GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74316C2BBFC;
	Sun, 16 Jun 2024 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554599;
	bh=89qlnrqlJft9QHMSBYJXjTaVyRWiHCFCqAz8g9CnRwk=;
	h=From:To:Cc:Subject:Date:From;
	b=szawP9GA09/Gw72ANk/q+ML5Rew+B41erSbl79t5tEfjRTGtklNkNDbW1VvziLeEj
	 oX+Qzj1YTx7lWNdDaMble2kLsj3h9/YFzTNh5eD8cYY2T3btx6R31qpnfdC7pRLi/E
	 NxWxJYE/1MqowKY5Ec8yaGLkRN19wB2GNGM4/q7e5wTiyhwywyk3VvHwlBCIOjLvuq
	 oqdr6XdtZersNW8ysJDnWOjnoM/KmARwZmLbFbcWWlqUv8evQ49FvtKU4hfhRF/klx
	 VJdoW8+lBDGlXh1Sralbyd17sBCzouLt0RAKxqlbpM46N44x0rEQ7FopE7bdBPxzSO
	 sSfS2a16SS3mw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org,
	Roland Dreier <roland@purestorage.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx4: Fix truncated output warning in mad.c
Date: Sun, 16 Jun 2024 19:16:33 +0300
Message-ID: <f3798b3ce9a410257d7e1ec7c9e285f1352e256a.1718554569.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Increase size of the name array to avoid truncated output warning.

drivers/infiniband/hw/mlx4/mad.c: In function ‘mlx4_ib_alloc_demux_ctx’:
drivers/infiniband/hw/mlx4/mad.c:2197:47: error: ‘%d’ directive output
may be truncated writing between 1 and 11 bytes into a region of size 4
[-Werror=format-truncation=]
 2197 |         snprintf(name, sizeof(name), "mlx4_ibt%d", port);
      |                                               ^~
drivers/infiniband/hw/mlx4/mad.c:2197:38: note: directive argument in
the range [-2147483645, 2147483647]
 2197 |         snprintf(name, sizeof(name), "mlx4_ibt%d", port);
      |                                      ^~~~~~~~~~~~
drivers/infiniband/hw/mlx4/mad.c:2197:9: note: ‘snprintf’ output between
10 and 20 bytes into a destination of size 12
 2197 |         snprintf(name, sizeof(name), "mlx4_ibt%d", port);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/mad.c:2205:48: error: ‘%d’ directive output
may be truncated writing between 1 and 11 bytes into a region of size 3
[-Werror=format-truncation=]
 2205 |         snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
      |                                                ^~
drivers/infiniband/hw/mlx4/mad.c:2205:38: note: directive argument in
the range [-2147483645, 2147483647]
 2205 |         snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
      |                                      ^~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/mad.c:2205:9: note: ‘snprintf’ output between
11 and 21 bytes into a destination of size 12
 2205 |         snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/mad.c:2213:48: error: ‘%d’ directive output
may be truncated writing between 1 and 11 bytes into a region of size 3
[-Werror=format-truncation=]
 2213 |         snprintf(name, sizeof(name), "mlx4_ibud%d", port);
      |                                                ^~
drivers/infiniband/hw/mlx4/mad.c:2213:38: note: directive argument in
the range [-2147483645, 2147483647]
 2213 |         snprintf(name, sizeof(name), "mlx4_ibud%d", port);
      |                                      ^~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/mad.c:2213:9: note: ‘snprintf’ output between
11 and 21 bytes into a destination of size 12
 2213 |         snprintf(name, sizeof(name), "mlx4_ibud%d", port);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:244: drivers/infiniband/hw/mlx4/mad.o] Error 1

Fixes: fc06573dfaf8 ("IB/mlx4: Initialize SR-IOV IB support for slaves in master context")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index a37cfac5e23f..dc9cf45d2d32 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -2158,7 +2158,7 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 				       struct mlx4_ib_demux_ctx *ctx,
 				       int port)
 {
-	char name[12];
+	char name[21];
 	int ret = 0;
 	int i;
 
-- 
2.45.2


