Return-Path: <linux-rdma+bounces-13441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF6B7CE84
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856A07B2040
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE336998C;
	Wed, 17 Sep 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UisjxDyZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7B3451AE;
	Wed, 17 Sep 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108985; cv=none; b=TqTuaAZPmgH+aN/lK1fERqSxUH1ouFbUwnSQjb1TEEDALpTpa2ORfBJk8DliesiA3+rKfiVr/Uq1ec6Ouai1AjJz6npA3vfNn9C4dE7kGOOt88nBc2RyjNyyC0wqsvQIjMPQPk9hgwbkdzubKgY2QvmSY7cn3W1pbSoHCnJdKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108985; c=relaxed/simple;
	bh=U9daN9h/Rq5DkreMjSWcA27ljnCEl/j+/TsM04nyJTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2KITTl8htzjfUJqrNfhP/k36h35B93prhHb668owvLTKWAJ4tUkOENHvYPiANhSIh3Ow3jspiMQXbk1Q03dKe58/1t8RWvk2gWb0/6rj6DKWOcBin6xib6z9E63HYXd0VSFtL5I6goPBjCWgcI+28MdEWUmccs/3NE0i/RHph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UisjxDyZ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/o
	BE8vrkjBcb2gv0f+kFmkhC3kasnGmTcU9eWhgDVXw=; b=UisjxDyZW9BJGOFfjx
	iC0UHaYAzjmA3pb8w7qmBktRf/Rqcy+qFUgiVfHksdhF9oZtUoDQwjgnxBS4f3oh
	+rnlInsa8Fp22ucWkqEiMpi+mjSAhH038h7C0lo87IHDncA2jq+osuhMOCmzfjuy
	GndH7rmdqTPw24XZnrJyAN9yY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnNvQNncpoH1CSDQ--.15275S2;
	Wed, 17 Sep 2025 19:35:42 +0800 (CST)
From: YanLong Dai <dyl_wlc@163.com>
To: kalesh-anakkur.purayil@broadcom.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com,
	daiyanlong@kylinos.cn,
	dyl_wlc@163.com
Subject: [PATCH] drivers: fix the potential memory leak in bnxt_re_destroy_gsi_sqp()
Date: Wed, 17 Sep 2025 19:35:39 +0800
Message-ID: <20250917113539.6139-1-dyl_wlc@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916134915.GC82444@unreal>
References: <20250916134915.GC82444@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnNvQNncpoH1CSDQ--.15275S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1fZrW3ZFyUXw13Gw17KFg_yoWkWrg_GF
	yjqr92qryUCF4rur17XF15Gry09rsFgw4v93Z2qa4UKry2yw45ZayDt3sxZw47W3y8Grnx
	tFy5G340kF1FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZID7UUUUUU==
X-CM-SenderInfo: 5g1os4lof6il2tof0z/1tbiSALLImjKmRF+6gAAsd

From: daiyanlong <daiyanlong@kylinos.cn>

As suggested by Kalesh Anakkur Purayil, fix the potential memory leak in bnxt_re_destroy_gsi_sqp() by continuing the teardown even if bnxt_qplib_destroy_qp() fails, we should not fail the resource destroy operations

Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 260dc67b8b87..adee44aa0583 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -931,10 +931,9 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 
 	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
-	if (rc) {
+	if (rc)
 		ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
-		goto fail;
-	}
+
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
 
 	/* remove from active qp list */
-- 
2.43.0


