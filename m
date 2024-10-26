Return-Path: <linux-rdma+bounces-5530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB389B1643
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521F21C21267
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F01C8FD4;
	Sat, 26 Oct 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rCAyjCqT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-83.smtpout.orange.fr [80.12.242.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888741632D3;
	Sat, 26 Oct 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930213; cv=none; b=WiWNDZIK04zr/uVEQANILzhLb0fIjCmpMRlV52pIL2pqRi/mLcAHlj6DLmQlrg0suhsLvtQFdE617Sgcqsv0lnqXpuBdZDVGt+Zw3ms0GUv1u9m2fUnnLcDivorgA6XsguZeSHZ9hq/m9iydukiIIppIAAzVcUR6Lqpu70S46Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930213; c=relaxed/simple;
	bh=eXezoRSGEJgqkLw+eS7eu6iiVu4G2376j5oOa6lRMIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmJtX6BmJVPTjCtRZa/P8Sq/sJpkXKtvNG8Ics1PV4Lqnhz3KMoHTzjSiemf+oOFOrJJkKC8PTYSwlEKvVTSJKoETYRGmT+AmHRa2jxQChxaP05QsInAT5xp/0ziDeLH8CSbNUDUYFVaUl212c6WNrtUfMbPchtqP+nvGXYJ1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rCAyjCqT; arc=none smtp.client-ip=80.12.242.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4brttJTpvLmOL4bs2tUbsE; Sat, 26 Oct 2024 10:10:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729930203;
	bh=jwyVolGT/MuttDEEvCVVvrLh3Bzx6w8Pcg5EguUcACM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rCAyjCqToG4VITQW0xko/5scReyi0PVS3BGi6S+V77YCZI5oTsan8o+iV3MQ4NykU
	 vCX3Tdod7dR1t+0qo4GWd9sQcj+qW4apYzhQ+0bc3LYfN6m5eDdtdhmvRPFUWTXShE
	 GJ8AaepmzuDYImDTdtyUGfdPCjr5dKQdhlk/Sgvv0SgYTDrXajiBNJSxqh60lyKnCV
	 oR6nhPHZX1S0wpTlc8Bzm6zWiEALsJvxUrL6EHcQdAWX6qNv8gduG5ayIRLafrQEE9
	 LN47dBRm7e1kc13fpDn6yLwgunlVQnvOY2MQ8LWkBki6Jw50oEIuEvAz1cyFbLG4lq
	 0BPkz1JVUSDbw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 10:10:03 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH 2/2] RDMA/bnxt_re: Remove some dead code
Date: Sat, 26 Oct 2024 10:09:43 +0200
Message-ID: <bc1135dc297ed2c6f3ca9446a2747b0c89102e61.1729930153.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <580de136ad9b85b0d70709e912cfddd21b7e3f6f.1729930153.git.christophe.jaillet@wanadoo.fr>
References: <580de136ad9b85b0d70709e912cfddd21b7e3f6f.1729930153.git.christophe.jaillet@wanadoo.fr>
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
---
 drivers/infiniband/hw/bnxt_re/main.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d183e293ec96..e510ffe91de3 100644
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


