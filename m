Return-Path: <linux-rdma+bounces-4264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10994CC46
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1B1B2448C
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341318FDA8;
	Fri,  9 Aug 2024 08:34:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80B175D2C;
	Fri,  9 Aug 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192445; cv=none; b=rlOUyw8UWxjnEGGQhzt2xEVCQhLwxGaK3w2OnJFknGSAh9S5R3iKEQKBwXNLRUluepuAskQ3Q1QpdVEeES4ji9m4slz/d7OYIUttCw1nhjCXEz8XMRV1kHKoc1zFwOrJZp+C3t1NTzKQD7ayG6ri0XLkrti9DmpLn+FLtV2ry4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192445; c=relaxed/simple;
	bh=WL+Vpt1o1fRx+b+VsZXDsC+gUzZIpPPAMR8U539fikU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVMrtDGRhYdLerrb9Z0JNxKNAKVFDL84IiqRBE41xGamZhpS7ybcTUDuIJFJI7i5l10S4MoQyOsMX3Eb+EomCT7Z3F3+VQAM3v3nrJKEbTYMD66QswhYK8JohbLSQ2Mij4T6LHmScg1sW7cWpAQg2/XC9TvBUYyhb4KR17Uo+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WgHFy1MWxzfb7m;
	Fri,  9 Aug 2024 16:32:06 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id EBC041400C9;
	Fri,  9 Aug 2024 16:34:00 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 16:33:59 +0800
From: Liu Jian <liujian56@huawei.com>
To: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liujian56@huawei.com>
Subject: [PATCH net-next 2/4] net/smc: use ib_device_get_netdev() helper to get netdev info
Date: Fri, 9 Aug 2024 16:31:46 +0800
Message-ID: <20240809083148.1989912-3-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809083148.1989912-1-liujian56@huawei.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)

Currently, in the SMC protocol, network devices are obtained by calling
ib_device_ops.get_netdev(). But for some drivers, this callback function
is not implemented separately. Therefore, here I modified to use
ib_device_get_netdev() to get net_device.

For rdma devices that do not implement ib_device_ops.get_netdev(), one of
the issues addressed is as follows:
before:
smcr device
Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
                rxee        1    ACTIVE  0               No       0

after:
smcr device
Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
enp1s0f1        rxee        1    ACTIVE  0               No       0

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/smc/smc_ib.c   | 8 +++-----
 net/smc/smc_pnet.c | 6 +-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9297dc20bfe2..382351ac9434 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
 	struct ib_device *ibdev = smcibdev->ibdev;
 	struct net_device *ndev;
 
-	if (!ibdev->ops.get_netdev)
-		return;
-	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
+	ndev = ib_device_get_netdev(ibdev, port + 1);
 	if (ndev) {
 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
 		dev_put(ndev);
@@ -921,9 +919,9 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
 		port_cnt = smcibdev->ibdev->phys_port_cnt;
 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
 			libdev = smcibdev->ibdev;
-			if (!libdev->ops.get_netdev)
+			lndev = ib_device_get_netdev(libdev, i + 1);
+			if (!lndev)
 				continue;
-			lndev = libdev->ops.get_netdev(libdev, i + 1);
 			dev_put(lndev);
 			if (lndev != ndev)
 				continue;
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 2adb92b8c469..a55a697a48de 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1055,11 +1055,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
 			continue;
 
 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
-			if (!rdma_is_port_valid(ibdev->ibdev, i))
-				continue;
-			if (!ibdev->ibdev->ops.get_netdev)
-				continue;
-			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
+			ndev = ib_device_get_netdev(ibdev->ibdev, i);
 			if (!ndev)
 				continue;
 			dev_put(ndev);
-- 
2.34.1


