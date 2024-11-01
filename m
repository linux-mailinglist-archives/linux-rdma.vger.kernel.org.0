Return-Path: <linux-rdma+bounces-5699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B39B94F9
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322CA2831C8
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC21C9B7A;
	Fri,  1 Nov 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bQGZJQun"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836802AE74;
	Fri,  1 Nov 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477482; cv=none; b=qX1ItH6+6s01HWC/CLqjpim5qrtYvSrvy3J3J5gcLXfCzL/s24laEAfct/KRQr7d9M+hVh14WDpbo6R+B1BI/DtccOZ4Al4/z9qwahzJeWtiXEf5DK673cvsvx8eSCGbazl9TC6ajMyqX6B7eMuDSVcSvkaqVdtDNLxRDGG8ZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477482; c=relaxed/simple;
	bh=8fCDDzaSxAsK1oye51t3wRdiFsy4z87++OyNss/h6ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpsUulw+lIUnSRyFe4tts5QPz0OkRI8ADu3NPcimEY9jtPltHOaHDYn+8XAzIzEo4vWvQanIkyPY6GpHmeksbrWofcGTzrZ2to15f58JJNUGu63WGzOHpad7cNZ2QOkqa3lzIFnL1bqd4xUw2XYbMfJYStlPAGg+fIiBkz8RCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bQGZJQun; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 6uEutykeYoG5N6uEwtJmmW; Fri, 01 Nov 2024 17:11:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730477471;
	bh=3CFwSVpzoG+hmvmU8SEfKB0VCv9gP01+xTrWzWWleTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bQGZJQunAGFBPQsFk+nbCacJfDfr3s0H52xkLIPhKdGIaU5M3nD7vZ9bUP0ikALw6
	 TDzunRpL4vjS3rYYS4h+sja48DbR+EeWBEypwQRIt7sQgNDRWPW2hm0mQIGVGOJLCQ
	 XLOewfynDYGi5Yny7ymcc7d6Q4gwEXJe4WJ4BMiJpL78ednE4/+XfGBYrYNOda9iC1
	 4nBu4JnUksJDdvjDeD156Xe2GAAlP9QNpmW0GyGOCCDoXZoSDziAkFT+QHyiETKH7O
	 RhC7YWGZTOR1O/yUvgbDhr7a3kx4oggoRl5abl8hQAAcvE2Hh644r3NMCpQ9C41nEU
	 /FfsejcR4gUlg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Nov 2024 17:11:11 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH v2 2/2] RDMA/bnxt_re: Remove some dead code
Date: Fri,  1 Nov 2024 17:10:57 +0100
Message-ID: <f02eb630734ee530315dce9f60b078f631ae93d0.1730477345.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <9e48ff955ae55fc39a9eb1eb590d374539eab5ba.1730477345.git.christophe.jaillet@wanadoo.fr>
References: <9e48ff955ae55fc39a9eb1eb590d374539eab5ba.1730477345.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the probe succeeds, then auxiliary_get_drvdata() can't return a NULL
pointer.

So several NULL checks can be removed to simplify code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only

Changes in v2:
  - None

v1: https://lore.kernel.org/all/bc1135dc297ed2c6f3ca9446a2747b0c89102e61.1729930153.git.christophe.jaillet@wanadoo.fr/
---
 drivers/infiniband/hw/bnxt_re/main.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 465cec4a1bd4..9eb290ec71a8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -300,9 +300,6 @@ static void bnxt_re_shutdown(struct auxiliary_device *adev)
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
 	struct bnxt_re_dev *rdev;
 
-	if (!en_info)
-		return;
-
 	rdev = en_info->rdev;
 	ib_unregister_device(&rdev->ibdev);
 	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
@@ -316,9 +313,6 @@ static void bnxt_re_stop_irq(void *handle)
 	struct bnxt_qplib_nq *nq;
 	int indx;
 
-	if (!en_info)
-		return;
-
 	rdev = en_info->rdev;
 	rcfw = &rdev->rcfw;
 
@@ -339,9 +333,6 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	struct bnxt_qplib_nq *nq;
 	int indx, rc;
 
-	if (!en_info)
-		return;
-
 	rdev = en_info->rdev;
 	msix_ent = rdev->en_dev->msix_entries;
 	rcfw = &rdev->rcfw;
@@ -1991,10 +1982,6 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
 	struct bnxt_re_dev *rdev;
 
 	mutex_lock(&bnxt_re_mutex);
-	if (!en_info) {
-		mutex_unlock(&bnxt_re_mutex);
-		return;
-	}
 	rdev = en_info->rdev;
 
 	if (rdev)
@@ -2043,9 +2030,6 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 	struct bnxt_en_dev *en_dev;
 	struct bnxt_re_dev *rdev;
 
-	if (!en_info)
-		return 0;
-
 	rdev = en_info->rdev;
 	en_dev = en_info->en_dev;
 	mutex_lock(&bnxt_re_mutex);
@@ -2090,9 +2074,6 @@ static int bnxt_re_resume(struct auxiliary_device *adev)
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
 	struct bnxt_re_dev *rdev;
 
-	if (!en_info)
-		return 0;
-
 	mutex_lock(&bnxt_re_mutex);
 	/* L2 driver may invoke this callback during device recovery, resume.
 	 * reset. Current RoCE driver doesn't recover the device in case of
-- 
2.47.0


