Return-Path: <linux-rdma+bounces-6755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60059FCFF8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 05:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982163A049D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 04:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0185733A;
	Fri, 27 Dec 2024 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yfDbul7y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9442AA4;
	Fri, 27 Dec 2024 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272304; cv=none; b=TOJPqtVXja9qPITnGzMVpI6KUCNZ1rkYEsk0n/wpLvxHbO1GlZJeLuTds66Yu0sqvtt1qLUjDRbmlTh3tcCypZFKtTe5/++6ERgEdLEl0JfsO/V/F2eubNBakX6Qn5JBnBwjUelW8q3xQtA594wwr5u9nuWX/vK+7YN8PaQoRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272304; c=relaxed/simple;
	bh=9KooM9uA6rOZrgLJ58/qmuXvemjwtIe2oCKQoWvGLoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SF2fvs+oMj8a8KHpXOm/Yg6nJqNE/Dm6XhP/u4V3d4HAt+YLcLCw8A1Jt2+VynLC1RMlv7JB16syq3LlIWCfkrcUmynEOnbFXtXcTccfUre9Y+x68mVs9+pTDwHB7vfBy3pMMqfsdZD870WbDsiniVRDZS+PgzDo/XdIm1y08Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yfDbul7y; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735272298; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PEA6YoYeyQImoXgEOXsRIu4bA0feaqonuxZ5B3IMRhY=;
	b=yfDbul7y3ABWuX4A62JygV7rxZyv4ZvS/bI5Lvb3obhuprsMm3wnGbnCiG02J4Z6tBHf9RhkQ49qXF3uHY2Q+SIHFwojZY16LKsG/TG56UQzy2LZrMillFlEUB8a1ZLUStzu13DsYLBZhN3HKAjQILTWLKwv2NQcT0I5ws4wsGw=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WMJwKuQ_1735272295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Dec 2024 12:04:57 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	PASIC@de.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: use the correct ndev to find pnetid by pnetid table
Date: Fri, 27 Dec 2024 12:04:55 +0800
Message-Id: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
to the pnetid table and will attach the <pnetid> to net device
whose name is <ethx>. But When do SMCR by <ethx>, in function
smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
use of the pnetid seems weird. Sometimes it is difficult to know
the hierarchy of net device what may make it difficult to configure
the pnetid and to use the pnetid. Looking into the history of
commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
that changes the ndev from the <ethx> to the <ethx>'s base ndev
when finding pnetid by pnetid table. It seems a mistake.

This patch changes the ndev back to the <ethx> when finding pnetid
by pnetid table.

Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 net/smc/smc_pnet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 716808f374a8..cc098780970b 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1079,14 +1079,15 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 					 struct smc_init_info *ini)
 {
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
+	struct net_device *base_ndev;
 	struct net *net;
 
-	ndev = pnet_find_base_ndev(ndev);
+	base_ndev = pnet_find_base_ndev(ndev);
 	net = dev_net(ndev);
-	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
+	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
 				   ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
-		smc_pnet_find_rdma_dev(ndev, ini);
+		smc_pnet_find_rdma_dev(base_ndev, ini);
 		return; /* pnetid could not be determined */
 	}
 	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
-- 
2.24.3 (Apple Git-128)


