Return-Path: <linux-rdma+bounces-4088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94A93FFFB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F631F22E96
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC1189F32;
	Mon, 29 Jul 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="OpzR6fZS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BF40BF2;
	Mon, 29 Jul 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286895; cv=none; b=k5R1y2174niKSIApAc7zUtHIg2y+nVdbI3EwEF4lmrFlPRWFe6p/8nq/t9wGcZAD3o1Iic5HWwkD6oAciposCfasiULRFE+1Z+Qh/X2L/Rf3KvjZHaJqlgzISFwih8VuOed2+9UZgwyxhZdlycRsFYzQc4puir5vzHoSTUNQMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286895; c=relaxed/simple;
	bh=ZPCHyt14h9rG+/4oBmipKs8kQr5e09jD8I6jSCEK2Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llbIVrlvVcwtHHK3rbf69o57kZP//4KeC8Hi/LRcW1gsWll642ukuzTZ1bFVS/H62tdAt75NOgfXbNNHYl+s5wFIYAh2OQuG2ELEzBsUrPVEbh/I1t2QqE/ipQfz9eL0pZ1MS4Ui+x8JRF66H7rRLm7da3WjTjUDGEmHSML5sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=OpzR6fZS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zngzblXNPWXX2q/9U9D7y9SN2Ue+kcr4OtlW8gtDGxg=; b=OpzR6fZS0e3+8pYa
	q2+Ib7gbn6yUqxDhirDrywHb0tNh0tLBn5+ryNyLn0o4jbwuMqoW1FVdGDKv1colH5Ks4QSTyooBq
	rO8THScJUELGbyirQthA/NsIc6+dpzzCq12ZvX1m6FnsPefzn3rMXGjZV+Gh7rei+jClHnzcz0tGE
	SGcgq2xA67VealNhX+qP6oOD0J7Ur4L2WnjWnOZK8LiiHzID/3ean4SuM4eFu8b3Oe3I1fk5Zsg4E
	yHiwhhJGaC0G9WIRrt2uuqc+z0tB8ueYyw+IqiSR9wqABjLh/GT68H40zF1QXFxjGI77zIXlVUwAe
	VYco94ovUtAQ8Zdwcw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sYXUb-00DsT5-2N;
	Mon, 29 Jul 2024 21:01:17 +0000
From: linux@treblig.org
To: leon@kernel.org,
	allison.henderson@oracle.com,
	horms@kernel.org,
	yanjun.zhu@linux.dev
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Date: Mon, 29 Jul 2024 22:01:14 +0100
Message-ID: <20240729210114.48522-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'rds_ib_dereg_odp_mr' has been unused since the original
commit 2eafa1746f17 ("net/rds: Handle ODP mr
registration/unregistration").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 net/rds/ib_rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index 8f070ee7e742..d1cfceeff133 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -40,10 +40,6 @@
 #include "rds.h"
 
 struct workqueue_struct *rds_ib_mr_wq;
-struct rds_ib_dereg_odp_mr {
-	struct work_struct work;
-	struct ib_mr *mr;
-};
 
 static void rds_ib_odp_mr_worker(struct work_struct *work);
 
-- 
2.45.2


