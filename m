Return-Path: <linux-rdma+bounces-10051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09444AAB3F8
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38B6501135
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A946E566;
	Tue,  6 May 2025 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVC8fm85"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17C2ECFCE;
	Mon,  5 May 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486492; cv=none; b=h8djdPDjFZDpgIlL18SYQCS8ah/T74PB9N4MNMhJIXDHZ7cqrFmFxpj4v/RVX9X8lD8RiuGxmJyrLmnUP1nj5oHG4P9fo7mM8Sk+N5swhKNIZcagEQaHUUJ9YooEDw5uadLMqBrSnZOOUKxrcrRDfs1C0H4uIon9rVpEDgj3PHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486492; c=relaxed/simple;
	bh=h8I7W2l0A8Av/8NAZGgpa8GcCnMXaTLVsSP28OGD/9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hY4iAWr58kgq8egOb78EwaXpW7CTJEc6M6HJcM9c9JIq708Qn9kWMMl4uIl2vHT+aNUSacy7xNdn1xmy6/vyjsYyPBLhtqhm1NasAivFJRpnhAbdAyGuwmyelke3nrpGKjUqx+9ckzJ3EqN7rIJt+bMFe0mfmO90S/3gIM94gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVC8fm85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD95C4CEE4;
	Mon,  5 May 2025 23:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486491;
	bh=h8I7W2l0A8Av/8NAZGgpa8GcCnMXaTLVsSP28OGD/9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVC8fm85x82wVgD/7TFNah31UIF7PN76keT+fXREEKsH+lPxBCi7imjlgL15TpT6a
	 +hGms1w3uYxTZ06PrRhhmdAgXC8oD03pVEP8Hcz4j+NVRYq6CkjKut0Dg4q2R7CeR2
	 Ht4L+bJvsVay0XFWvwKJET85xM3K7bOHhAC5xUWuINXKAkka+m9gi3PRst+k3O3vGN
	 oyhrdE+mzZRqNa0NFF7XduL+Zxxqa0TvoCxtGOMopZ52291KduDcidu+FKO44354CR
	 odfDGiJyrGguiTPMPVX5Fk8sJ1qCQbMTQyCNq6eyB8bUICKR4ybNm7TJQWrwiM7HW4
	 A9iCvVzRH82vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jaka@linux.ibm.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 058/212] net/smc: use the correct ndev to find pnetid by pnetid table
Date: Mon,  5 May 2025 19:03:50 -0400
Message-Id: <20250505230624.2692522-58-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit bfc6c67ec2d64d0ca4e5cc3e1ac84298a10b8d62 ]

When using smc_pnet in SMC, it will only search the pnetid in the
base_ndev of the netdev hierarchy(both HW PNETID and User-defined
sw pnetid). This may not work for some scenarios when using SMC in
container on cloud environment.
In container, there have choices of different container network,
such as directly using host network, virtual network IPVLAN, veth,
etc. Different choices of container network have different netdev
hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
in host below is the netdev directly related to the physical device).
            _______________________________
           |   _________________           |
           |  |POD              |          |
           |  |                 |          |
           |  | eth0_________   |          |
           |  |____|         |__|          |
           |       |         |             |
           |       |         |             |
           |   eth1|base_ndev| eth0_______ |
           |       |         |    | RDMA  ||
           | host  |_________|    |_______||
           ---------------------------------
     netdev hierarchy if directly using host network
           ________________________________
           |   _________________           |
           |  |POD  __________  |          |
           |  |    |upper_ndev| |          |
           |  |eth0|__________| |          |
           |  |_______|_________|          |
           |          |lower netdev        |
           |        __|______              |
           |   eth1|         | eth0_______ |
           |       |base_ndev|    | RDMA  ||
           | host  |_________|    |_______||
           ---------------------------------
            netdev hierarchy if using IPVLAN
            _______________________________
           |   _____________________       |
           |  |POD        _________ |      |
           |  |          |base_ndev||      |
           |  |eth0(veth)|_________||      |
           |  |____________|________|      |
           |               |pairs          |
           |        _______|_              |
           |       |         | eth0_______ |
           |   veth|base_ndev|    | RDMA  ||
           |       |_________|    |_______||
           |        _________              |
           |   eth1|base_ndev|             |
           | host  |_________|             |
           ---------------------------------
             netdev hierarchy if using veth
Due to some reasons, the eth1 in host is not RDMA attached netdevice,
pnetid is needed to map the eth1(in host) with RDMA device so that POD
can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
as Terway, network management plugin in container environment), and in
cloud environment the eth(in host) can dynamically be inserted by CNI
when POD create and dynamically be removed by CNI when POD destroy and
no POD related to the eth(in host) anymore. It is hard to config the
pnetid to the eth1(in host). But it is easy to config the pnetid to the
netdevice which can be seen in POD. When do SMC-R, both the container
directly using host network and the container using veth network can
successfully match the RDMA device, because the configured pnetid netdev
is a base_ndev. But the container using IPVLAN can not successfully
match the RDMA device and 0x03030000 fallback happens, because the
configured pnetid netdev is not a base_ndev. Additionally, if config
pnetid to the eth1(in host) also can not work for matching RDMA device
when using veth network and doing SMC-R in POD.

To resolve the problems list above, this patch extends to search user
-defined sw pnetid in the clc handshake ndev when no pnetid can be found
in the base_ndev, and the base_ndev take precedence over ndev for backward
compatibility. This patch also can unify the pnetid setup of different
network choices list above in container(Config user-defined sw pnetid in
the netdevice can be seen in POD).

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_pnet.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 399314cfab90a..af12e02152740 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1080,14 +1080,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
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
+	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
-		smc_pnet_find_rdma_dev(ndev, ini);
+		smc_pnet_find_rdma_dev(base_ndev, ini);
 		return; /* pnetid could not be determined */
 	}
 	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
-- 
2.39.5


