Return-Path: <linux-rdma+bounces-12828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53121B2DB27
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027294E5024
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C10261B93;
	Wed, 20 Aug 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b="ReGpyh0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3F217716;
	Wed, 20 Aug 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689755; cv=none; b=hGdxX8qCHBRZTV7P374zU0d3wiNfVK80l1etea4GUDJpsRF+8lXbKz8IKOnAx0H+NBdeBRr/zNA5ccxVfDz8EzJF5kcjHkqFLzrO4/5MDfHqwWUQkasWmzZArX6GevT7nv67wKUj/cXpuuTwTAG/UvrZiBNTwoPPyumq/bOTKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689755; c=relaxed/simple;
	bh=P7T8RrXNb2knefD4QMmx6/9xeWpAlS6XNkxtZV69HGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uv3CElBMelOtv7Yo/Fn/LOpd91SYFN7y/ldM1tNQ7rTSqbTF9WCo04vAccrWNw9CQx/XfrW769ixAws/cbfnzYEsrVvraqPLbSpVelvucmojbKPeULWUkRi5RKh40TLb/v0hFWKHem3/Pt13WQd7/BiQZA2+ZWOCWL6EXGN0Pv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=ReGpyh0F; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itb.spb.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 26D7BC2CE2;
	Wed, 20 Aug 2025 14:30:29 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:3337:0:640:6097:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 6C89FC0096;
	Wed, 20 Aug 2025 14:30:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sTQ3LBFMreA0-CqoF5TFM;
	Wed, 20 Aug 2025 14:30:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1755689418; bh=k+IcBLuCwOwgJ2lPGf5MuynlKO6oP3738piA9vFkVpM=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=ReGpyh0FnvH4pOjPlIKePrN3Ry/g4H9V+UkePKvqX72oQYYMrx1hEDRXFBDYmdFe3
	 lhuTgeKa7zMy5UoCcaJkbj4Msk+Z7n4G4AfUpZsHQhTvQFoa66J42PU/TGTI2xcqTK
	 0paKc/2txK6QhCAiMPR1gzr8rm1+cNhVBVCKRAQI=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From: Ivan Stepchenko <sid@itb.spb.ru>
To: Mustafa Ismail <mustafa.ismail@intel.com>
Cc: Ivan Stepchenko <sid@itb.spb.ru>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shannon Nelson <sln@onemain.com>,
	Anjali Singhai Jain <anjali.singhai@intel.com>,
	Faisal Latif <faisal.latif@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] RDMA/i40iw: Fix 32-bit overflow in i40iw_check_mem_contiguous()
Date: Wed, 20 Aug 2025 14:28:28 +0300
Message-Id: <20250820112828.7364-1-sid@itb.spb.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pg_size and pg_idx are u32, so pg_size * pg_idx is computed in 32-bit
and wraps once the total offset reaches 4 GiB (e.g. 2 MiB pages at
pg_idx == 2048). The wrapped offset is then widened to u64, producing
a false negative: contiguous PBL entries are incorrectly reported
as non-contiguous.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Ivan Stepchenko <sid@itb.spb.ru>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index da5a41b275d8..33831cd3ce1f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2366,7 +2366,7 @@ static bool irdma_check_mem_contiguous(u64 *arr, u32 npages, u32 pg_size)
 	u32 pg_idx;
 
 	for (pg_idx = 0; pg_idx < npages; pg_idx++) {
-		if ((*arr + (pg_size * pg_idx)) != arr[pg_idx])
+		if ((*arr + ((u64)pg_size * pg_idx)) != arr[pg_idx])
 			return false;
 	}
 
-- 
2.39.5


