Return-Path: <linux-rdma+bounces-13444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A1B7E260
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBFE1B2596A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0C31A814;
	Wed, 17 Sep 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="doZf51hp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86881F3BA2;
	Wed, 17 Sep 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112848; cv=none; b=T7lfE3T4aZWxV3cTVUK7NGe8diBfD9BmsqNOZIZ3AfSMETeBs9LlyEsS4jl3ytSUFQH+3Qk2pjOPbCJL/XGBXufGqzlERfAsHvfhV6KYHzXtzkCj9HIiGtULGFZDNIIlxsBz8L1o+GCL/ugV3fcZhkD5qSgdgwNVzvYM8UI7KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112848; c=relaxed/simple;
	bh=DW3dCW9zfLTrh7OOEGOvG1H31gk9z0NCojfNW5UCAJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPBxSA41yV6uQUPrbQ6pcxEtuzFZ697e696/hB0mBUJluBvxZzu1IJvOhJKkcVtjOcvrpJdGeUw/qpOsBtJNsr/iElnI6W5Ee6gdXxPdHNWQjZEh63VQ4zWQIi89REGDQh8iy60GCre+V3EPjCDrgFRt5VzH3MF7ImOAv8dWFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=doZf51hp; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=NU
	ZxpJS3obiOiDUp+EVz/UTN72QWU0J/B28urQMb4Ws=; b=doZf51hpIkGtFi/HEH
	ccjUM+NWwmpRMUlLBr+Ni7JmNDKjZ4sR1ZOp7+FyrqEBeOZ2RpxoLiNJ8oL3fCyK
	Uy2JmjJ1iDpu4tH/zuYO4xOz90qXKMcl0IWcqSXBT7C4yOA5C1FSzr/1YFmA8rgW
	Q4G0n46hE+ZN36u/8R8Jq6lWk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDHftAirMpo2LiKBw--.38864S2;
	Wed, 17 Sep 2025 20:40:03 +0800 (CST)
From: YanLong Dai <dyl_wlc@163.com>
To: kalesh-anakkur.purayil@broadcom.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com,
	daiyanlong@kylinos.cn,
	dyl_wlc@163.com
Subject: [PATCH v3] drivers: fix the potential memory leak in bnxt_re_destroy_gsi_sqp()
Date: Wed, 17 Sep 2025 20:40:00 +0800
Message-ID: <20250917124000.3652-1-dyl_wlc@163.com>
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
X-CM-TRANSID:_____wDHftAirMpo2LiKBw--.38864S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxKFy8GFyDZF1DWw43trb_yoW8GFy8pr
	43J3s0k3y5JF4xWFWUJFy7XF45Ga40y3ykKa9Fk3sxAa15A3WkJF93t3Zavas5ArZ5Gr4I
	vw13Jrs8G3W7WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELvtJUUUUU=
X-CM-SenderInfo: 5g1os4lof6il2tof0z/xtbBMR7LImjKpOfX4AAAsQ

From: daiyanlong <daiyanlong@kylinos.cn>

As suggested by Kalesh Anakkur Purayil, fix the potential memory leak in
bnxt_re_destroy_gsi_sqp() by continuing the teardown even if
bnxt_qplib_destroy_qp() fails, weshould not fail the resource
destroy operations

Eliminates the 'fail:' label and associated return statement

Modify commit information exceeding 75 bytes

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


