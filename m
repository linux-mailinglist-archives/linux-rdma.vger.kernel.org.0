Return-Path: <linux-rdma+bounces-13442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EEB7CEBF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D83B0DFC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896032BC08;
	Wed, 17 Sep 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lav+aB9v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267832BBE2;
	Wed, 17 Sep 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111270; cv=none; b=hQ8x/FGUOVrhIhXLYfSNNyV5mfChiQvsGihskTCGAkUnXwPI+vqKyn/oFItN5Zm8IXIpqXD5iJrdpWnvx7gSGuEyoZIAx3xFY35PDWveoCnRLBBVLjF9rs6mCawb0to+bCysBwfDOsTm+fZi1drh2oULD/hNOOR+m7mZjSWwvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111270; c=relaxed/simple;
	bh=eW0rWSGx1yd6D6Wb3LD020lvJK4XLUZHtQocjNMoZAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flrBV/Yv5IGMTiswE3sFhzj18P1LsozaRPV7qCFDzU37ewwLXOWkqjTPabqcRb3nrNTLAeYaY7ReX1hUhDP6Fb/sQeHEOkd6bqx0d1drDohswYnjOxTLfTGshyvRzmsixUXi4Zflsfle7cR//IZnAvsCYVgfB0wnc9lHZiy2Epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lav+aB9v; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VO
	P+h06XUi+pFlJ8jximhc9Ol4TMRSXDlDvXnHCskfM=; b=Lav+aB9v66CV4akDhW
	QuToaUiD5kvF3DVwpNt1C7t/yMQuyrdTkDkKtXJp2I+lk8VjBD9SzAmone7o1yzR
	cjLk/ZrNTsLS4ll1XWtT3Q+pzkNrCXadF8cBVY1TuyzzAxCkMCGhq+fBJ7+tEGub
	KCpJU5mYl6GITmCeSnARAkPrc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3P4Dypcpo_gerBw--.39401S2;
	Wed, 17 Sep 2025 20:13:39 +0800 (CST)
From: YanLong Dai <dyl_wlc@163.com>
To: kalesh-anakkur.purayil@broadcom.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com,
	daiyanlong@kylinos.cn,
	dyl_wlc@163.com
Subject: [PATCH v2] drivers: fix the potential memory leak in bnxt_re_destroy_gsi_sqp()
Date: Wed, 17 Sep 2025 20:13:37 +0800
Message-ID: <20250917121337.6529-1-dyl_wlc@163.com>
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
X-CM-TRANSID:_____wD3P4Dypcpo_gerBw--.39401S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxKFy8GFyDCw4fJF4Utwb_yoW8Gry5pr
	43J3s0k3y5JF4xWFWUAry7Xr45Ga40y3ykta9Fk3sxAa15A3Z7XF93t3Zavas5ArZ5Gr4I
	vw13Xrs8Ga17WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEv38UUUUUU=
X-CM-SenderInfo: 5g1os4lof6il2tof0z/1tbiSA-LImjKmRF+6wABsQ

From: daiyanlong <daiyanlong@kylinos.cn>

As suggested by Kalesh Anakkur Purayil, fix the potential memory leak in bnxt_re_destroy_gsi_sqp() by continuing the teardown even if bnxt_qplib_destroy_qp() fails, we should not fail the resource destroy operations

Eliminates the 'fail:' label and associated return statement

Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 260dc67b8b87..15d3f5d5c0ee 100644
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
@@ -951,8 +950,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	rdev->gsi_ctx.sqp_tbl = NULL;
 
 	return 0;
-fail:
-	return rc;
 }
 
 /* Queue Pairs */
-- 
2.43.0


