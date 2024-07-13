Return-Path: <linux-rdma+bounces-3853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87919303AA
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2024 06:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F1A1F2258E
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2024 04:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901618C05;
	Sat, 13 Jul 2024 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bANDJkuh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60CD2F5;
	Sat, 13 Jul 2024 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720845705; cv=none; b=hlVKazgm0PTYb+4LS5qHl4FzVJXBlU0TZV5jBtP1U8Bbd2bDx1THGJ6w1ziFJi6sSEvjaSc5d0XRvuJU/gdnJp6Mmu+7+QC7/7jglmkyMKlydGGyrTGXndVlAgM1BH03e03RbbwmBJg/aLeixt5z/FiEm+UFcPO21kDmiylpWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720845705; c=relaxed/simple;
	bh=BAN/FoLkKqJ7o/Sgv4Ya+vo7ER4SQOYOWelgNwML6j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nrp02BtxJ/Wy1b4bPweWhXmUDV7WA1iJqB2dg8rskeYuXHiABhIStvFD1SR+WJb6iNWEdLhZ6u5VG3u4Wnp3lvcxCiEiFC6SXoA8c9wVeLvwHNz+asizgtNIbrBvVkjDxvDg3EQQGvA94KTxBiPzu8MZlQjOA0kUGTU26CviWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bANDJkuh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kotaranov@linux.microsoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720845699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owIU+BispT0gpT7gy6n31ejQ9klRJBL3xgbsZ9D/u64=;
	b=bANDJkuhIjQpHopAJyDkVTIZTguso60SeO/bokWyKNMsxHYl0JZODBMyknYq0XQ7sK8cQ8
	ngO41Cq/rBoyxTacQ5p/+SVLBIO70HE6D3MiPHTUzPORf4QY42eSTc0TcotMAEVt0j6rnz
	JuP9YCSI9V0POalwU5kwl+uVrZ4TG6s=
X-Envelope-To: kotaranov@microsoft.com
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: haiyangz@microsoft.com
X-Envelope-To: kys@microsoft.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: decui@microsoft.com
X-Envelope-To: wei.liu@kernel.org
X-Envelope-To: sharmaajay@microsoft.com
X-Envelope-To: longli@microsoft.com
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <5818dd90-edf5-4480-be94-15aea66c2359@linux.dev>
Date: Sat, 13 Jul 2024 06:41:35 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: Set correct device into ib
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
 kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/11 15:37, Konstantin Taranov 写道:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Add mana_get_primary_netdev_rcu helper to get a primary
> netdevice for a given port. When mana is used with
> netvsc, the VF netdev is controlled by an upper netvsc
> device. In a baremetal case, the VF netdev is the
> primary device.
> 
> Use the mana_get_primary_netdev_rcu() helper in the mana_ib
> to get the correct device for querying network states.
> 
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> I would appreciate if I could get Acks on it from:
> * netvsc maintainers (e.g., Haiyang)
> * net maintainers (e.g., Jakub, David, Eric, Paolo)
> 
> v1->v2:
> Leon Romanovsky asked to make a helper in the net/mana and get
> acks from net maintainers.
> v2->v3:
> Added warn on rcu lock not held.
> Use the word "primary" instead of "master"
> Merged two commits into one and submitted to rdma-next
> 
>   drivers/infiniband/hw/mana/device.c           | 16 ++++++++--------
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++++++++++
>   include/net/mana/mana.h                       |  2 ++
>   3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index b07a8e2e838f..7ac01918ef7c 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -56,7 +56,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>   {
>   	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
>   	struct gdma_dev *mdev = madev->mdev;
> -	struct net_device *upper_ndev;
> +	struct net_device *ndev;
>   	struct mana_context *mc;
>   	struct mana_ib_dev *dev;
>   	u8 mac_addr[ETH_ALEN];
> @@ -84,17 +84,17 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>   	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
>   	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
>   
> -	rcu_read_lock(); /* required to get upper dev */
> -	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
> -	if (!upper_ndev) {
> +	rcu_read_lock(); /* required to get primary netdev */
> +	ndev = mana_get_primary_netdev_rcu(mc, 0);
> +	if (!ndev) {
>   		rcu_read_unlock();
>   		ret = -ENODEV;
> -		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
> +		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
>   		goto free_ib_device;
>   	}
> -	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
> -	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, upper_ndev->dev_addr);
> -	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
> +	ether_addr_copy(mac_addr, ndev->dev_addr);
> +	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
> +	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
>   	rcu_read_unlock();
>   	if (ret) {
>   		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b89ad4afd66e..68c2bea2c022 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3007,3 +3007,22 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>   	gd->gdma_context = NULL;
>   	kfree(ac);
>   }
> +
> +struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
> +{
> +	struct net_device *ndev;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> +			 "Taking primary netdev without holding the RCU read lock");

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> +	if (port_index >= ac->num_ports)
> +		return NULL;
> +
> +	/* When mana is used in netvsc, the upper netdevice should be returned. */
> +	if (ac->ports[port_index]->flags & IFF_SLAVE)
> +		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
> +	else
> +		ndev = ac->ports[port_index];
> +
> +	return ndev;
> +}
> +EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, NET_MANA);
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 59823901b74f..f9b4b0dcb69f 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -797,4 +797,6 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
>   int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
>   		   u32 doorbell_pg_id);
>   void mana_uncfg_vport(struct mana_port_context *apc);
> +
> +struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index);
>   #endif /* _MANA_H */


