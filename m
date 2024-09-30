Return-Path: <linux-rdma+bounces-5156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC498A5A8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE5E1C22546
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBB18FDBE;
	Mon, 30 Sep 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="msClhyMN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB115C15E;
	Mon, 30 Sep 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703852; cv=none; b=TNlNvBrEXCMo5rM4ahrFtGZk/y/ASEtMLWtU3LNObd1UYpbWBQVpnyRRmSEQhcE70RTSPxDUxXc74bmeE5WW1izUONfJ2xm5yXxaJO4zcLUOBipYnMdB7PFnxCf5DSLWOk9ugannwj8K/96x6B+v5PumYIVRXNeAJh59viMVkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703852; c=relaxed/simple;
	bh=lezCBWWFHbn8MQ1S1VdxEUGegYb4MopXWakVPWCvzZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rI96fjdFlzJSxUJxkq3hH9+XeXGi4gfR0UeBa/QDXgdxjmbF9q6a9RWYXzicWBfkpsXQ8JJxdLCgYXI9brX1j8+ahvP6XxhtTEVWPkulle9A+X7l34LK5ji7VZm8IJpRQr+3UW/1+lDVFfefJpq/QW+N/VWz1kl3ozasNbd1a6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=msClhyMN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=M5BQIoqcpQBFHOofTMEAPSxPpT3+Ax65uySTt2sbYDU=; b=msClhyMNQLO9d0O0
	QLM0XB9HLaznrEtDCRKYAtkrbggeXpbr5X1r0V8UaKLOZk0pRMkNt/utmZp35PGF71EBymt+c15C9
	zWgkx9pT7MYTqvrYlU6+ZZagWQuJHje2r72a1gtKL5QC/oJsZTXFUkjeA4cDWa4MMh+OfiUqoyNyv
	ft5FYVt3YzrETxuriSdI4Ek3ByokU9F7VdMpW1U1p4F7EPmuiMJwjaYRYJOQMis/XQ+Chra0zFRrW
	oKOyW2z2MUPwxxzFWqJs0Rwlh+/7UVFwbqbmDpqg5/ti3Mbwgtya3e48v7eeeayhuqQP6vAPgO/rV
	veLYgn0q51e+9eR8jQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1svGh0-007z1U-0f;
	Mon, 30 Sep 2024 13:44:02 +0000
From: linux@treblig.org
To: allison.henderson@oracle.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Simon Horman <horms@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH net-next] net/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Date: Mon, 30 Sep 2024 14:43:58 +0100
Message-ID: <20240930134358.48647-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
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
2.46.2


