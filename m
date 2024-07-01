Return-Path: <linux-rdma+bounces-3589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DF091DF9D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5631E1F22867
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C714D701;
	Mon,  1 Jul 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW3i0dx8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1179155381
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837758; cv=none; b=ftje73BiFUFhG12ZNlEaZQf7hexQJXnleDGsJkg5okxxs8G7Y3FgIFe5b+5SadyJNA90lqsPqIcEfSKjOzanxaiWPJpHsowH2PoWplo0CiFc7521sI9NEJqKgZDMuWLrlLTdO3weW58TuxKTsrmuoTzWfWW8/zThSnoy2iBXK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837758; c=relaxed/simple;
	bh=6UmkcBclHs0MYzrXM3wBbSaid5lteMEaNtTSdMElkYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=typSy0A8ROalGz75podcoklOSXkIZexYGI9gFF19YU1NwoSM5luxShVk3vqKym/k116MzSyVmL4a4SMIyWN7WlioKc155O2iVhgoJ2wjrUc84lKGgi1EtiTd2EvOI/TXZZW+Z/dchW8sVVKLEqVz3Y1OTBtbFUTZWVo7GsqEOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW3i0dx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7C7C116B1;
	Mon,  1 Jul 2024 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837758;
	bh=6UmkcBclHs0MYzrXM3wBbSaid5lteMEaNtTSdMElkYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kW3i0dx8eGygLZGxuqSvHQRl6EhS1yNtO7cj4z/WcGSfJO7hJdbHcnQicQJIlzu1U
	 pbJBC3WTeLPgpNviZIKIrcriAm8+M4lJKe3I0s1agY+FhAUogTOk+Kj94Trs3kC5w2
	 fCuBv6y2CQxT3m/kVyLjeCmVjht2SfekjYRpa9wfHEnl3jt+3eHgcbfekDHJvMpUDt
	 dQ7EfEVd/9rf3xTL8fGVLFcSiY7QZbesZG0P4sNiXhnZxfy7P8USSdt+xX1u3jiTRa
	 VuU3UqvwqmlREi+v2xdVboZtlp9nd41VuT2UXdTJLeBGcvWzgYZ6/uyMlS4N2uDZYH
	 OTHINRSBNQIcw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/qib: Fix truncation compilation warnings in qib_verbs.c
Date: Mon,  1 Jul 2024 15:42:29 +0300
Message-ID: <1fb6393fa2e0702fef995834c3c7db972bbc4d06.1719837715.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
References: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Reduce nodename string size to fit IB_DEVICE_NODE_DESC_MAX.

drivers/infiniband/hw/qib/qib_verbs.c: In function ‘qib_register_ib_device’:
drivers/infiniband/hw/qib/qib_verbs.c:1554:40: error: ‘%s’ directive output may be truncated writing up to 64 bytes into a region of size 43
[-Werror=format-truncation=]
 1554 |                  "Intel Infiniband HCA %s", init_utsname()->nodename);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/qib/qib_verbs.c:1553:9: note: ‘snprintf’ output between 22 and 86 bytes into a destination of size 64
 1553 |         snprintf(ibdev->node_desc, sizeof(ibdev->node_desc),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1554 |                  "Intel Infiniband HCA %s", init_utsname()->nodename);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cc1: all warnings being treated as errors

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/qib/qib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 0080f0be72fe..5fcb41970ad9 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1551,7 +1551,7 @@ int qib_register_ib_device(struct qib_devdata *dd)
 	ibdev->dev.parent = &dd->pcidev->dev;
 
 	snprintf(ibdev->node_desc, sizeof(ibdev->node_desc),
-		 "Intel Infiniband HCA %s", init_utsname()->nodename);
+		 "Intel Infiniband HCA %.42s", init_utsname()->nodename);
 
 	/*
 	 * Fill in rvt info object.
-- 
2.45.2


