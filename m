Return-Path: <linux-rdma+bounces-4287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20694D2CC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3774C281D7E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED2198A1B;
	Fri,  9 Aug 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T02tbz0n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D1197A93;
	Fri,  9 Aug 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215571; cv=none; b=rvjH2xHJ6rKwascpPQgMoQ34lQ+UTsTQV3VEQiJY6VR4pkAOZ5isyxK2epiWvVvCN3MUATAh9FSdhmw/a4XWNB/QfJtO1yjgDZ4vFvwyT7mu5KnhsDd4G1AWn9U4n/PCz7ECiopALi4jSNrdoxDrbgCPHX3pyv7L06tb7SQrzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215571; c=relaxed/simple;
	bh=uVLPqw+UvO4d3vl0+as7B8+tUGMM0+jq+RxNrUtEyYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apoyqj451ztM36WqrNWIK+1et021rWz5KE3y51ikA/DxFtzOvoFHaR8lKCYIzR4NCpWzovGC2pZKKc/lxX8vQFEUER3yR7MHwNo5e4us7ci9O2gQazNtMzKyiGRMGf2ZG2T+sezVmKoz5OnDIdDTf80FOkqd6/653SdyIABEgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T02tbz0n; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723215559; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=SHoLjYIreNAqMZT4TTmTcVAbo6cppGaJNj2SfOV7+po=;
	b=T02tbz0nS8Umz47R8o9elNywBpBVyVnfbSPQTwXcBHDo6GwgtfR85Q2QY7LMjZ/XE1Sp8gIifeRv80ukKq68a8e67zLXEv0pnFBPA5Nnp0F5LmaWfUb3wWPFkTHCUUeDgLfUGSR7aG3mxiHOdyJoRw74x4G/8oegStNC2jLs5j8=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WCQNTjO_1723215557)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 22:59:18 +0800
Date: Fri, 9 Aug 2024 22:59:17 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 2/4] net/smc: use ib_device_get_netdev() helper
 to get netdev info
Message-ID: <20240809145917.GB103152@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-3-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809083148.1989912-3-liujian56@huawei.com>

On 2024-08-09 16:31:46, Liu Jian wrote:
>Currently, in the SMC protocol, network devices are obtained by calling
>ib_device_ops.get_netdev(). But for some drivers, this callback function
>is not implemented separately. Therefore, here I modified to use
>ib_device_get_netdev() to get net_device.
>
>For rdma devices that do not implement ib_device_ops.get_netdev(), one of
>the issues addressed is as follows:
>before:
>smcr device
>Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
>                rxee        1    ACTIVE  0               No       0
>
>after:
>smcr device
>Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
>enp1s0f1        rxee        1    ACTIVE  0               No       0
>
>Signed-off-by: Liu Jian <liujian56@huawei.com>
>---
> net/smc/smc_ib.c   | 8 +++-----
> net/smc/smc_pnet.c | 6 +-----
> 2 files changed, 4 insertions(+), 10 deletions(-)
>
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 9297dc20bfe2..382351ac9434 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
> 	struct ib_device *ibdev = smcibdev->ibdev;
> 	struct net_device *ndev;
> 
>-	if (!ibdev->ops.get_netdev)
>-		return;
>-	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
>+	ndev = ib_device_get_netdev(ibdev, port + 1);
> 	if (ndev) {
> 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
> 		dev_put(ndev);
>@@ -921,9 +919,9 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
> 		port_cnt = smcibdev->ibdev->phys_port_cnt;
> 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
> 			libdev = smcibdev->ibdev;
>-			if (!libdev->ops.get_netdev)
>+			lndev = ib_device_get_netdev(libdev, i + 1);
>+			if (!lndev)
> 				continue;
>-			lndev = libdev->ops.get_netdev(libdev, i + 1);
> 			dev_put(lndev);
> 			if (lndev != ndev)
> 				continue;
>diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>index 2adb92b8c469..a55a697a48de 100644
>--- a/net/smc/smc_pnet.c
>+++ b/net/smc/smc_pnet.c
>@@ -1055,11 +1055,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
> 			continue;
> 
> 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
>-			if (!rdma_is_port_valid(ibdev->ibdev, i))
>-				continue;

Why remove this check ?

Best regard,
Dust


>-			if (!ibdev->ibdev->ops.get_netdev)
>-				continue;
>-			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
>+			ndev = ib_device_get_netdev(ibdev->ibdev, i);
> 			if (!ndev)
> 				continue;
> 			dev_put(ndev);
>-- 
>2.34.1
>

