Return-Path: <linux-rdma+bounces-2825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE888FB17E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 13:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987BB28171B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961B145A10;
	Tue,  4 Jun 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bZIrT/28"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F805144D21;
	Tue,  4 Jun 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502169; cv=none; b=oJyZtQkHJttTEi53InsNTmVV8V9T+vFLt+ufzX0eHjVZY6mJ91J+tlHWMK6FRdWoOGvDEYa0IY395MSZbPeJFjIJojKNHqTxqZHyv+8I2VQUKK9lS49uwQjERDOKCwG3PCKuZgB0y3XFvQxxn4uvTeAHkM16SZz/TQVYNDoxRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502169; c=relaxed/simple;
	bh=2HtaCje/AByO8y8ttVnVbtxmSFQ/xg7CJhaRqfcF0Ys=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bj8/4ConVCPmNzH8Llpdqfg1mPsoPzoxx4MjWxiRY6UvTGYznGnY4GaTaDoyBG4Zy5i3jCQUVZ4nVQevy2U5aD6iRMYkPl3iR/D3Wo1C3an05LFbBLuqDyvhfIeUHwiwpgh7BDIH0/Bn0Gpol0yBjWiYnMAxKzFUAbnUBxRdndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bZIrT/28; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4684E20B915A;
	Tue,  4 Jun 2024 04:56:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4684E20B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717502167;
	bh=b/MoSSPuCfOeziCi8nOimS5wI7JeCnaNuAEAlFo9bSA=;
	h=From:To:Cc:Subject:Date:From;
	b=bZIrT/28dl3EvAYyniP1/Kkv8nk+8njU1bsfzhQ61prpnwCVjNnLbJBP9UPrGsBYI
	 U4DC3g8VQWQCcj2yGH6bGqODHsC2zabAnKeHRimMD6LhGOuMFYtaQVG4u4uuvk8Ljk
	 O04Zr/LSlKIEq15voaNRj5JAee33nc/DONG1SVX4=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Date: Tue,  4 Jun 2024 04:56:02 -0700
Message-Id: <1717502162-4161-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Ignore optional ib_access_flags when an MR is created.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 4f13423..887b09d 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -112,6 +112,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		  "start 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
 		  start, iova, length, access_flags);
 
+	access_flags &= ~IB_ACCESS_OPTIONAL;
 	if (access_flags & ~VALID_MR_FLAGS)
 		return ERR_PTR(-EINVAL);
 
-- 
2.43.0


