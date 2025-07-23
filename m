Return-Path: <linux-rdma+bounces-12425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECFB0F3D7
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31DF3AEB6E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51F28C86D;
	Wed, 23 Jul 2025 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpNOZwsm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35B24EF7F
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276884; cv=none; b=ZQV/f6jRyGg/08ehjeIonyV7UIGPSeEbmOaBu/HRDoenFEJ8rT1z693zl0OEplTlTVeaXVx9MTJob6cEclf57EuSSj30RM8aLlLt1KNpoCHsE66PvmBSreCt8UwmoBJBwxaAXUYuv5w8B3xA8NP2RLwTLnNvl6mKn3hoX0/ou5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276884; c=relaxed/simple;
	bh=S1JJ3oZahCd669eF5kOGIpV0YN4/CSb04jTR/fJPgp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqfC+Q2Fv1gHM2xWRai2OFfs8vxsik7OAD+PdNC0vOTswmltFp2lIBDzLBExazSBPK/4uOqOYxY4eKhgIe55rt3/qyGJGnz7w2ePEfFC4ArIFpeZ6uKW/n9IvGK9f5tKlLzvuGUGlx782EG3KfutUYuyXikxxSrYlUZhkCcqLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpNOZwsm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753276878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D5OI2DYeRa5WRjON6ljfvAKfOZnthoTeI6wkjizuMWM=;
	b=wpNOZwsmKaxon6SSqZV4gF6jcjP7YDgDpy3yvHcW7Kp4YcYBEuzxInNqtMw+M77jIyXfQp
	sOuzeqKASWHuYxOGCpmPhIZbAHfo01PphffRxZIbMU2sPOmgNRv4mvrgC57z583j1si1Mv
	OAhdSvkWBM5CLUgMvm4OKr1hLHK13b0=
From: bernard.metzler@linux.dev
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [PATCH RESEND] RDMA/siw: Change maintainer email address
Date: Wed, 23 Jul 2025 15:21:07 +0200
Message-ID: <20250723132107.2188-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bernard Metzler <bernard.metzler@linux.dev>

Change siw maintainer email address since old address
will become disfunctional. Also add info to .mailmap

Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 85ad46d20220..1abf57830425 100644
--- a/.mailmap
+++ b/.mailmap
@@ -138,6 +138,7 @@ Benjamin Poirier <benjamin.poirier@gmail.com> <bpoirier@suse.de>
 Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@gmail.com>
 Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@redhat.com>
 Benno Lossin <lossin@kernel.org> <benno.lossin@proton.me>
+Bernard Metzler <bernard.metzler@linux.dev> <bmt@zurich.ibm.com>
 Bingwu Zhang <xtex@aosc.io> <xtexchooser@duck.com>
 Bingwu Zhang <xtex@aosc.io> <xtex@xtexx.eu.org>
 Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..84bce0f7aee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22994,7 +22994,7 @@ S:	Maintained
 F:	drivers/leds/leds-net48xx.c
 
 SOFT-IWARP DRIVER (siw)
-M:	Bernard Metzler <bmt@zurich.ibm.com>
+M:	Bernard Metzler <bernard.metzler@linux.dev>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/sw/siw/
-- 
2.50.0


