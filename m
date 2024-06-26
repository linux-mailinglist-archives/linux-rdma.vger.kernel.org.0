Return-Path: <linux-rdma+bounces-3492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3891784A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 07:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EC0282157
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 05:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD31465A5;
	Wed, 26 Jun 2024 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5E4Bgse"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F514146A64;
	Wed, 26 Jun 2024 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380873; cv=none; b=R93bLIt+iiFFvaiZQPAB0+I7Q2Fh/nSAlmbxYKBRpted7GXi3naaNsLPBdsruYn0j+kL8WWep7CEL0ORlExHi0eBfEfMCQnqmxOAJWFcskpZ/5dYtKHfJeB+tcKAZPh30tUTgs3XBqEWfVEgk+LM4LW34UaWmEOHGbsj7oqEvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380873; c=relaxed/simple;
	bh=7hdMr15z96txrxYuo49EkPDqmnH+yLqNedUNybqtN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHnhJPQRfmAsXDlh3j3zp45YbuI4bFP5xvZvpuq/chaJNXK/st2ZB4Hh4gyMYABrn7MF2pDOy8vbedh79vx/mGIrNRDfJrJBj2A12eM9pZdVBHEXNP1NA8V9ZYUBkFs02uN/2fRS9zaw4hWO3SKwJD3F05yZwUAK2AAdeVsZe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5E4Bgse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777C8C2BD10;
	Wed, 26 Jun 2024 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719380873;
	bh=7hdMr15z96txrxYuo49EkPDqmnH+yLqNedUNybqtN1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5E4BgseIOhci9v98Gw+VJm3TCwN3z59M5Y6n8kCGHu6jndlDxUgHdbi04FWVvH6s
	 BoSwhqImhZ9AIp0ZbiwI5/iiIpIfZsbkxGcSi+3f6V5HSZh/SLhm1r5E9mlHoOWLVM
	 xYO8J2qKxWRPxA5VSFMTKL7sMI1+UH1P36hw2myyf/vE2wzLJ/BJqh43yBvCGQFeTR
	 xkIxxvXOfRj3IYDUvBcL2armWqC9Br1JewNNKFALtH0P/rz/3vnBk9Qw8pqlDul1V0
	 qH6CZKK583M25/v8jYGm8xWoxlfigPScj3fNaGje4IeeUteVoBe+J404DV1rp3SDSN
	 4QSHS1BcGPs4A==
Date: Wed, 26 Jun 2024 08:47:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, weh@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240626054748.GN29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>

On Tue, Jun 25, 2024 at 03:28:27AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> When mc->ports[0] is not slave, use it in the set_netdev.
> When mana is used in netvsc, the stored net devices in mana
> are slaves and GIDs should be taken from their master devices.
> In the baremetal case, the mc->ports devices will not be slaves.

I wonder, why do you have "... | IFF_SLAVE" in __netvsc_vf_setup() in a
first place? Isn't IFF_SLAVE is supposed to be set by bond driver?

> 
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index b07a8e2e838f..5395306a86e8 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -11,6 +11,8 @@ MODULE_DESCRIPTION("Microsoft Azure Network Adapter IB driver");
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS(NET_MANA);
>  
> +#define mana_ndev_is_slave(dev)   (((dev)->flags & IFF_SLAVE) == IFF_SLAVE)

There is no need in macro for one line of code and there is no need in "==",
as the result will be boolean.

> +
>  static const struct ib_device_ops mana_ib_dev_ops = {
>  	.owner = THIS_MODULE,
>  	.driver_id = RDMA_DRIVER_MANA,
> @@ -56,7 +58,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  {
>  	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
>  	struct gdma_dev *mdev = madev->mdev;
> -	struct net_device *upper_ndev;
> +	struct net_device *ndev;
>  	struct mana_context *mc;
>  	struct mana_ib_dev *dev;
>  	u8 mac_addr[ETH_ALEN];
> @@ -85,16 +87,19 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
>  
>  	rcu_read_lock(); /* required to get upper dev */
> -	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
> -	if (!upper_ndev) {
> +	if (mana_ndev_is_slave(mc->ports[0]))
> +		ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
> +	else
> +		ndev = mc->ports[0];
> +	if (!ndev) {
>  		rcu_read_unlock();
>  		ret = -ENODEV;
> -		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
> +		ibdev_err(&dev->ib_dev, "Failed to get netdev for port 1");
>  		goto free_ib_device;
>  	}
> -	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
> -	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, upper_ndev->dev_addr);
> -	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
> +	ether_addr_copy(mac_addr, ndev->dev_addr);
> +	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
> +	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
>  	rcu_read_unlock();
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
> -- 
> 2.43.0
> 
> 

