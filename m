Return-Path: <linux-rdma+bounces-5560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197929B1FDC
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 20:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EB61F21075
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FFB17B402;
	Sun, 27 Oct 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H90EGbWT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA851BF37
	for <linux-rdma@vger.kernel.org>; Sun, 27 Oct 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730057325; cv=none; b=kzdS2noi2N3h4VkwykSj4zJ7VTyZWJc8BvEK4Geel33KWJfACZBy1/qkRDYHf8jK/uF80HNmhnG83KjLvxzJ8VIRsn2nMCw5ZRiJaQ1Z3Kwpt+0bNRqqEM2G/FhJY5X1mLM23gw7SMQFshcDgbQNNGyO9C2d5aURa6Ptb0LddaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730057325; c=relaxed/simple;
	bh=na5RqGkEZnfKl/taVAsW55k5aIMm/HhhoP69JHNVo4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFyK9Oy5+EcJicURJMqkqyDVIJ8FalD+cSH2M3kxBbOuyVHFeXFqtU7V/fphlYQiVzpxK55+BHFKkbMFXrdfvk32zzsY0szZCYeKyQMq9NKdN0FWExtJhNpRRsisRxMzaAFBDUBVlC+X5wQa8cgdNHD4LtPrKkFT4BuhMoW63Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H90EGbWT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a7dca47-4107-4bd9-b539-aacdf733f3d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730057320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdZnJKOedTRWsKA+yx0HzasB5LXG8yplTAt8DgncFdU=;
	b=H90EGbWT8vyu3mmQdhIE9QE94gB2tyisxF8QP1UqGSfgy0MeZ6ipltvC8V1+RCDybZwpaq
	ELSfA3gNVfzNx51ZEWBJI4c9btqWcSLNI1XRtt5wEpHC3Vg0mP7tAcfHtZsQ0Ufg/LdQtM
	x+m+1T/xdu1cFRcXpDbSZ4IJfxIht20=
Date: Sun, 27 Oct 2024 20:28:32 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Nils Hoppmann <niho@linux.ibm.com>, Niklas Schnell <schnelle@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>,
 Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/25 9:23, Wenjia Zhang 写道:
> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling

Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Because the commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and 
get_netdev functions") removes the get_netdev callback from 
mlx5_ib_dev_common_roce_ops, in mlx4, get_netdev is still in 
mlx4_ib_dev_ops. So the following commit will follow mlx5 to remove 
get_netdev from mlx4 driver.

 From a59f2e01428640a332a51b8d910ec166704aa441 Mon Sep 17 00:00:00 2001
From: Zhu Yanjun <yanjun.zhu@linux.dev>
Date: Sun, 27 Oct 2024 20:21:27 +0100
Subject: [PATCH 1/1] RDMA/mlx4: Use IB get_netdev functions and remove
  get_netdev callback

In the commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
functions") removed the get_netdev callback from
mlx5_ib_dev_common_roce_ops, in mlx4, get_netdev callback should also
be removed.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
compile successfully only
---
  drivers/infiniband/hw/mlx4/main.c | 35 -------------------------------
  1 file changed, 35 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c 
b/drivers/infiniband/hw/mlx4/main.c
index 529db874d67c..cf34d92de7b1 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -123,40 +123,6 @@ static int num_ib_ports(struct mlx4_dev *dev)
         return ib_ports;
  }

-static struct net_device *mlx4_ib_get_netdev(struct ib_device *device,
-                                            u32 port_num)
-{
-       struct mlx4_ib_dev *ibdev = to_mdev(device);
-       struct net_device *dev, *ret = NULL;
-
-       rcu_read_lock();
-       for_each_netdev_rcu(&init_net, dev) {
-               if (dev->dev.parent != ibdev->ib_dev.dev.parent ||
-                   dev->dev_port + 1 != port_num)
-                       continue;
-
-               if (mlx4_is_bonded(ibdev->dev)) {
-                       struct net_device *upper;
-
-                       upper = netdev_master_upper_dev_get_rcu(dev);
-                       if (upper) {
-                               struct net_device *active;
-
-                               active = 
bond_option_active_slave_get_rcu(netdev_priv(upper));
-                               if (active)
-                                       dev = active;
-                       }
-               }
-
-               dev_hold(dev);
-               ret = dev;
-               break;
-       }
-
-       rcu_read_unlock();
-       return ret;
-}
-
  static int mlx4_ib_update_gids_v1(struct gid_entry *gids,
                                   struct mlx4_ib_dev *ibdev,
                                   u32 port_num)
@@ -2544,7 +2510,6 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
         .get_dev_fw_str = get_fw_ver_str,
         .get_dma_mr = mlx4_ib_get_dma_mr,
         .get_link_layer = mlx4_ib_port_link_layer,
-       .get_netdev = mlx4_ib_get_netdev,
         .get_port_immutable = mlx4_port_immutable,
         .map_mr_sg = mlx4_ib_map_mr_sg,
         .mmap = mlx4_ib_mmap,
--
2.34.1

Zhu Yanjun

> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>   net/smc/smc_ib.c   | 8 ++------
>   net/smc/smc_pnet.c | 4 +---
>   2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9297dc20bfe2..9c563cdbea90 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
>   	struct ib_device *ibdev = smcibdev->ibdev;
>   	struct net_device *ndev;
>   
> -	if (!ibdev->ops.get_netdev)
> -		return;
> -	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
> +	ndev = ib_device_get_netdev(ibdev, port + 1);
>   	if (ndev) {
>   		smcibdev->ndev_ifidx[port] = ndev->ifindex;
>   		dev_put(ndev);
> @@ -921,9 +919,7 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
>   		port_cnt = smcibdev->ibdev->phys_port_cnt;
>   		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
>   			libdev = smcibdev->ibdev;
> -			if (!libdev->ops.get_netdev)
> -				continue;
> -			lndev = libdev->ops.get_netdev(libdev, i + 1);
> +			lndev = ib_device_get_netdev(libdev, i + 1);
>   			dev_put(lndev);
>   			if (lndev != ndev)
>   				continue;
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 1dd362326c0a..8566937c8903 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1054,9 +1054,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
>   		for (i = 1; i <= SMC_MAX_PORTS; i++) {
>   			if (!rdma_is_port_valid(ibdev->ibdev, i))
>   				continue;
> -			if (!ibdev->ibdev->ops.get_netdev)
> -				continue;
> -			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
> +			ndev = ib_device_get_netdev(ibdev->ibdev, i);
>   			if (!ndev)
>   				continue;
>   			dev_put(ndev);


