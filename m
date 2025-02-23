Return-Path: <linux-rdma+bounces-8025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5CA411F9
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 22:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6011703ED
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255A1FF7D0;
	Sun, 23 Feb 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Wjpcj9RH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9E2AF11;
	Sun, 23 Feb 2025 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740347755; cv=none; b=ljJRVmr/XVljg2eB6QEV4ORA2Z5j/fkO18g+9AThqq4xJIy+ovLiAgf6fl5Saon6Ou6WKo0wizFcT2SMxQL30FANhlbgJIy8ftDHQs5DOWgaQknLr1W+juHSUCoF27WVp3JO0MBX40CWxdnyvfpQAYVGEaCwhjEMaU0kLHvX698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740347755; c=relaxed/simple;
	bh=tX0kc8X39jQdhSp33iWrQ3o4fa8zDm23gPF0qSCxCis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lH1iYcG6bzCOhZzS6NkgCEu+8z5rrNBoNWsZQbyeQwdT18zZDokl2+sSSOSexb0mrFvZdN70xKPUNdTKE6PZOTxieXkH5zsGSUo4G71yN5yq0s5mGI75FUFar5qFWVTzEJz9iHM+U0bypksEQzfdVRulVW605RWQ07gx3SF3yG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Wjpcj9RH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=TmzNnu9QaYnb7f5vbT+kfkDJykW1ytVc4VptMubFhK4=; b=Wjpcj9RHKpa/JK4F
	UqiWn6ghsiQPbJJycoT2igtU2cTyv/XwdfJ9I0TwXqV/ThBUlc2SecISL9A0V/JhH8EdzvrpzVIHG
	cN5eH78Solz11u8aFLV8EIlK+C0jlvHg8tdUgVko5FQYZnyqAEbqrZUOgGEiPKtzYqlMHvhnyN0Yl
	K4US3UfD0L4E1iVlNuroNgvNLLnpyzf/VXh4PGSKVTo5bf5iewFZUV+srgxZmU8wp0CVxTRZgJo+T
	WUSHqwHakEpboUMlHRflnS1ts/rogyrx7yStOu2GjuCgKFhpeSEtUKByVRkgBD84UcxXaR3u7W3+a
	nI+H62uTIWQX3V7Q/A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tmJwv-000DvC-34;
	Sun, 23 Feb 2025 21:55:45 +0000
From: linux@treblig.org
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/hfi1: Remove unused one_qsfp_write
Date: Sun, 23 Feb 2025 21:55:43 +0000
Message-ID: <20250223215543.153312-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of one_qsfp_write() was removed in 2016's
commit 145dd2b39958 ("IB/hfi1: Always turn on CDRs for low power QSFP
modules")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/hw/hfi1/qsfp.c | 20 --------------------
 drivers/infiniband/hw/hfi1/qsfp.h |  2 --
 2 files changed, 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qsfp.c b/drivers/infiniband/hw/hfi1/qsfp.c
index 52cce1c8b76a..3b7842a7f634 100644
--- a/drivers/infiniband/hw/hfi1/qsfp.c
+++ b/drivers/infiniband/hw/hfi1/qsfp.c
@@ -404,26 +404,6 @@ int qsfp_write(struct hfi1_pportdata *ppd, u32 target, int addr, void *bp,
 	return count;
 }
 
-/*
- * Perform a stand-alone single QSFP write.  Acquire the resource, do the
- * write, then release the resource.
- */
-int one_qsfp_write(struct hfi1_pportdata *ppd, u32 target, int addr, void *bp,
-		   int len)
-{
-	struct hfi1_devdata *dd = ppd->dd;
-	u32 resource = qsfp_resource(dd);
-	int ret;
-
-	ret = acquire_chip_resource(dd, resource, QSFP_WAIT);
-	if (ret)
-		return ret;
-	ret = qsfp_write(ppd, target, addr, bp, len);
-	release_chip_resource(dd, resource);
-
-	return ret;
-}
-
 /*
  * Access page n, offset m of QSFP memory as defined by SFF 8636
  * by reading @addr = ((256 * n) + m)
diff --git a/drivers/infiniband/hw/hfi1/qsfp.h b/drivers/infiniband/hw/hfi1/qsfp.h
index df1389bad86b..5c59d53fcb63 100644
--- a/drivers/infiniband/hw/hfi1/qsfp.h
+++ b/drivers/infiniband/hw/hfi1/qsfp.h
@@ -195,8 +195,6 @@ int qsfp_write(struct hfi1_pportdata *ppd, u32 target, int addr, void *bp,
 	       int len);
 int qsfp_read(struct hfi1_pportdata *ppd, u32 target, int addr, void *bp,
 	      int len);
-int one_qsfp_write(struct hfi1_pportdata *ppd, u32 target, int addr, void *bp,
-		   int len);
 int one_qsfp_read(struct hfi1_pportdata *ppd, u32 target, int addr, void *bp,
 		  int len);
 struct hfi1_asic_data;
-- 
2.48.1


