Return-Path: <linux-rdma+bounces-10003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A42AAA989
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099F83AB6B3
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010429CB5F;
	Mon,  5 May 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPpGJc4I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D39299A8F;
	Mon,  5 May 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484996; cv=none; b=WqCu2eR+3QEWv55iyWum2CicnguGqQBSBTS74K1F2p1tRMD4haVv5z2RPvembe47RDTKGdCmMUN2oB8J0d8YQ010tL6qRdTLUSza7NJzZUDNVEhhBgrpUEl+M4DdqpPzmHmSzy/RNNKZHhDqwrttpyT6YoVAZknd4b41c/SBqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484996; c=relaxed/simple;
	bh=YODJSnivOEZDxjFwX5FgO6CI5awOhrnlo4GZiVdtxTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcMQd86iVszw0IhtKo83uABDshRKjgcHtd10CwyuZKio1pJ8HZvCFvldvgAxP7yrGNk9XgqoPvRTbjvdRhqBUHnBfa45r2Up39256tKDd5X95vO5j8pNgWMPJb2zah/v71ALj6Hl9+W3Gq8QGLxN8vqKbjBmaKGSCOE5MIIMa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPpGJc4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09839C4CEEE;
	Mon,  5 May 2025 22:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484995;
	bh=YODJSnivOEZDxjFwX5FgO6CI5awOhrnlo4GZiVdtxTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPpGJc4IZ7KNISGFSeF9tXCHY9PpZ6F60YKESDa8E2Y6Y8kOIkDhc4jsgo+cdOH4Z
	 8UUYnzoIoX+v2TpAYcDTPCV84Vbrqs1PamnPhNsfesf08yCLOJ2D0eIyjaPh5VxXP5
	 OXv52Gm36MCjf9kxafzlabb7B77AuZIBklK2Am6thxU+lMeV8vBiRmDGSf/2SuI73L
	 q5ScI7bKojb5CRhc1esvNhGKOuDQ91uNO+2aJ/3Rh8P6RHQN5m3NoRNV2JBolYgPIE
	 02MVmirGbLW4ce2jmSeafMUlCJ4HDVMP2sYumUFpjMa1E/wl7DV+q+fqyX8Z0QRpYM
	 C5diEw/Wh/5OA==
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
Subject: [PATCH AUTOSEL 6.12 116/486] net/smc: use the correct ndev to find pnetid by pnetid table
Date: Mon,  5 May 2025 18:33:12 -0400
Message-Id: <20250505223922.2682012-116-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 716808f374a8d..b391c2ef463f2 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
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


