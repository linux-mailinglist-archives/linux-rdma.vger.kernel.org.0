Return-Path: <linux-rdma+bounces-3588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E366B91DF9C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 14:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0051F227BA
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92A158D7B;
	Mon,  1 Jul 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMWzWQvl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE08158A2D
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837754; cv=none; b=RIJ6hu/uY7SgHZDYhZXhD7EV0NCa1/NdwTYqQ7yFKIz2p8xmClcyXcqgb+pTYXzua1iyoH2Qx14sTLrI/iJ911gMgLVCyNu3qwz7e2U+NW+LxX6Gfbcz/Xr+OnoBHOlhlZXfbK4ONDaQgPt70Reo3ODw5VT9+iMEVr8q6D1pD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837754; c=relaxed/simple;
	bh=/zx3F/+iJh0KBudnCeOyPKLD3VYA4tCwaynAuAUsVY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l94pu85IooCfnbqDQEwgOLuPNtyEzzjpic42vqW0GWmc0gz7twA76S46Le58sXYCCQqDIAzAFhx8l1nDxmupRNKApY0UWFzqsE3HrjWfXaBDmOT0ZMgjB7iaDpIvBoES3LrF2XZBMsA2A+o6ys+o4OseXY7mm1tlVMXKAylsEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMWzWQvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5B2C116B1;
	Mon,  1 Jul 2024 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837754;
	bh=/zx3F/+iJh0KBudnCeOyPKLD3VYA4tCwaynAuAUsVY8=;
	h=From:To:Cc:Subject:Date:From;
	b=RMWzWQvlYIn/7RZPECZd5yC9Ns3mbYcetJNGkmge8TjXT75zDbqTss/3cFkB1CNin
	 6Odbz9AnqQxa0b4tpuXZnkH3Nmrdx0bOQcX2+A8PALPnEcVVFimiCWcKuJOXu5fofP
	 8SfaJKP6JNosufT8IVPJ7q/Jg6UyVsWQX//lRSAL/x+orIKItiLhIcMLojyjxd5H01
	 o0nkC2ZAmTSJXgGj6422odWHlGcEJVtve7HgSuh1DpLCxpPdGzrwhVx9zkpS3V7XBt
	 Dbj05zVkPNuWgEKF2zbZ7wx8lxOUT810yoJd+dPCyDlUJyg8WeTbjjnAPk+goZtbVI
	 AW7rdBWGtscrQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/qib: Fix truncation compilation warnings in qib_init.c
Date: Mon,  1 Jul 2024 15:42:28 +0300
Message-ID: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
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

drivers/infiniband/hw/qib/qib_init.c: In function ‘qib_init_one’:
drivers/infiniband/hw/qib/qib_init.c:586:67: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 3 [-Werror=format-truncation=]
  586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
      |                                                                   ^~
In function ‘qib_create_workqueues’,
    inlined from ‘qib_init_one’ at drivers/infiniband/hw/qib/qib_init.c:1438:8:
drivers/infiniband/hw/qib/qib_init.c:586:60: note: directive argument in the range [-2147483643, 254]
  586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
      |                                                            ^~~~~~~~~~
drivers/infiniband/hw/qib/qib_init.c:586:25: note: ‘snprintf’ output between 7 and 27 bytes into a destination of size 8
  586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  587 |                                 dd->unit, pidx);
      |                                 ~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/qib/qib_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 33667becd52b..db3b25c8433a 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -581,7 +581,7 @@ static int qib_create_workqueues(struct qib_devdata *dd)
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
 		if (!ppd->qib_wq) {
-			char wq_name[8]; /* 3 + 2 + 1 + 1 + 1 */
+			char wq_name[23];
 
 			snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
 				dd->unit, pidx);
-- 
2.45.2


