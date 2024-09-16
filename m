Return-Path: <linux-rdma+bounces-4972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990397A66C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD611F23B59
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7413B2B6;
	Mon, 16 Sep 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="iXJJbw/7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14EE80C0A;
	Mon, 16 Sep 2024 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506264; cv=none; b=OS0p6Mwdtci5C+hQUGpQkqbzOsKHYA5V+I3SZp3ztxTSR4G75odLGLVD96JGhkft2MuDZZ93SuKFdFN95CYSTBeHmBMnupmZShp4IR0AJFIg/BBRpV07iam8FT5IQvxuBWTKM6WPJjsL/Zq0uVeazWzSWDgnPl2qcbS64rdethE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506264; c=relaxed/simple;
	bh=Rh0YZTPe0Fxpg2O+DQbTTdbOqUtyQT7J30Gu/BLqNxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5b1C3oeXggfJ0whS5sCtNFj+1LNikYqFWy32bZkMEouZWas/MuD/0O503BAY6cRirtF1EHynlVEJCsrPdaNZfBXp8oVUFAE9rkQwkl32g4CDu2hvv+ij2VgQ8nhDQe0SyUQ2cmmzpG0q5mmbsZpVWk17RDn7h17WLUptLnv+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=iXJJbw/7; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id A38D5C0002;
	Mon, 16 Sep 2024 19:58:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru A38D5C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1726505905; bh=+wLeg7mpilRmYdVCD7x49nLso215F1FrvY0wUpgGC2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iXJJbw/7jSkSGRVZ3/qTTDLl10AYibVFvJ/OnhknH9pcN28QZYVm2wBbCSvg8/ZVm
	 U3nAGl0X9P7HSPlwvqMkIxR8g8uFtv97vWK259UrYx0/t44yFjGzNJBiWd4oRAvHcN
	 DgQAzVg7RoGf7ecYWsg9OTTKIstpuFNBS9pA+OMh9YR1aaBJ3zt2Y6kbqlwGPOPjA5
	 eGr6uMLvSe/gHVybFLk9Q+esqNKbhx4yDl7EC3D4bFKaG1SeF6+w8aLF1dYBQpBp1w
	 d8rv/oBXjqrCRg98rP4vGaPVfOe75dzFh4u0pKoCu8xhDHSeEg4shvYGS5RkvGoRzO
	 SqaavYE/vgPpA==
Received: from ksmg01.maxima.ru (unknown [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 19:58:25 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.247.12) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Mon, 16 Sep 2024 19:58:24 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Mustafa Ismail
	<mustafa.ismail@intel.com>, Shiraz Saleem <shiraz.saleem@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/irdma: fix error message in irdma_modify_qp_roce()
Date: Mon, 16 Sep 2024 21:58:05 +0500
Message-ID: <20240916165817.14691-1-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187775 [Sep 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;maxima.ru:7.1.1;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/16 11:48:00 #26596414
X-KSMG-AntiVirus-Status: Clean, skipped

Use a correct field max_dest_rd_atomic instead of max_rd_atomic for the
error output.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 76c5f461faca..baa3dff6faab 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1324,7 +1324,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		if (attr->max_dest_rd_atomic > dev->hw_attrs.max_hw_ird) {
 			ibdev_err(&iwdev->ibdev,
 				  "rd_atomic = %d, above max_hw_ird=%d\n",
-				   attr->max_rd_atomic,
+				   attr->max_dest_rd_atomic,
 				   dev->hw_attrs.max_hw_ird);
 			return -EINVAL;
 		}
-- 
2.46.1


