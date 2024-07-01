Return-Path: <linux-rdma+bounces-3584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB091DE73
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA381F21CDA
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D821494C1;
	Mon,  1 Jul 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpcRp/Mw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B984D02;
	Mon,  1 Jul 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834936; cv=none; b=dCMMiIWi5zLBr1oBsVTsCx77JG2pMrgCRasQAmFSidIrjLG1dDJeU02b0Crnh/hZgKwFNWgaeezgr+bu7ibkPODtYJOcEjeoEpp9gwT96i9wVlJNFV2ow3VLlwedpkfkbpq7/OSVPKslSuEqXsz+NPG3jLN/Km4+7TxBpI0Llhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834936; c=relaxed/simple;
	bh=QmbpbLh2vv9qkheHthped1BnCs5gg8xKMMk1KW24fYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2dvmQbaiqJwt5o/JMWuWhMsU25P+LRPZ0H5PfvtH/q/wAwkkJXKCiMf+dNjZ7wtXbsBhuFgSdyitgiaL/DN9PEMAEMhVTTuISReQW2ae5/4wgOuBVJKJuleoL/wCYB72xuH6vVPx8zlklkMedx80lDlHB4fFUxFxhdVRVizNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpcRp/Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C01C116B1;
	Mon,  1 Jul 2024 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719834935;
	bh=QmbpbLh2vv9qkheHthped1BnCs5gg8xKMMk1KW24fYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpcRp/MwxHhVzsXP9gJtkgq0YLTyOBa/Ul+FlXxfFRFj2KZIwJxYQpJyKtF1sck91
	 VZF8LEncLY822CTKsetyJkaWZgkIAFJRHuRBc/W3LfrEgPjlMlj0K8gyyCurYMrreC
	 zQ/qR8CDZOymj/Kc1yKIk8pV+II7pw5opl4wOLNnGn1vchif3AhQuO2zESoT6vHBSX
	 13OMQ6nKnF3NtYiuu871bXRw6/RFlLSJcKogTTFK4+7eQBr5k2hvn9xuqSX7pbNvdo
	 aaKSKJ0nDGFFT2xeQ5cGEByGvMja6QdKD00R5vr3lT7/GJQbF4VXADtb6Gu+yiF06f
	 7x7qHrQX4Nn4g==
Date: Mon, 1 Jul 2024 14:55:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 04/12] RDMA/core: Support IB sub device with
 type "SMI"
Message-ID: <20240701115532.GC13195@unreal>
References: <cover.1718553901.git.leon@kernel.org>
 <44253f7508b21eb2caefea3980c2bc072869116c.1718553901.git.leon@kernel.org>
 <8dd1179c-a738-4abe-b21b-448ff8a21ebb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dd1179c-a738-4abe-b21b-448ff8a21ebb@linux.dev>

On Sat, Jun 29, 2024 at 08:14:56AM +0800, Zhu Yanjun wrote:
> 在 2024/6/17 0:08, Leon Romanovsky 写道:
> > From: Mark Zhang <markzhang@nvidia.com>
> > 
> > This patch adds 2 APIs, as well as driver operations to support adding
> > and deleting an IB sub device, which provides part of functionalities
> > of it's parent.
> > 
> > A sub device has a type; for a sub device with type "SMI", it provides
> > the smi capability through umad for its parent, meaning uverb is not
> > supported.
> > 
> > A sub device cannot live without a parent. So when a parent is
> > released, all it's sub devices are released as well.
> > 
> > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   drivers/infiniband/core/device.c      | 68 +++++++++++++++++++++++++++
> >   drivers/infiniband/core/uverbs_main.c |  3 +-
> >   include/rdma/ib_verbs.h               | 43 +++++++++++++++++
> >   include/uapi/rdma/rdma_netlink.h      |  5 ++
> >   4 files changed, 118 insertions(+), 1 deletion(-)

<...>

> > +int ib_del_sub_device_and_put(struct ib_device *sub)
> > +{
> > +	struct ib_device *parent = sub->parent;
> > +
> > +	if (!parent)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&parent->subdev_lock);
> 
> mutex_destroy of subdev_lock is missing. When mutex_lock is called, it had
> better call mutex_destroy when the mutex lock is not used any more.
> Other mutex locks in this file, for example subdev_lock and subdev_lock,
> call mutex_destroy in the function ib_device_release.
> 
> Perhaps subdev_lock can also call mutex_destroy in ib_device_release?

Thanks, I will add this fixup to the series.

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7aaf2b4c1844..7b418c717f29 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -503,6 +503,7 @@ static void ib_device_release(struct device *device)
                          rcu_head);
        }

+       mutex_destroy(&dev->subdev_lock);
        mutex_destroy(&dev->unregistration_lock);
        mutex_destroy(&dev->compat_devs_mutex);

Thanks

> 
> Zhu Yanjun
> 
> > +	list_del(&sub->subdev_list);
> > +	mutex_unlock(&parent->subdev_lock);
> > +
> > +	ib_device_put(sub);
> > +	parent->ops.del_sub_dev(sub);
> > +	ib_device_put(parent);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(ib_del_sub_device_and_put);
> > +
> >   #ifdef CONFIG_INFINIBAND_VIRT_DMA
> >   int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
> >   {
> > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> > index 495d5a5d0373..bc099287de9a 100644
> > --- a/drivers/infiniband/core/uverbs_main.c
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -1114,7 +1114,8 @@ static int ib_uverbs_add_one(struct ib_device *device)
> >   	struct ib_uverbs_device *uverbs_dev;
> >   	int ret;
> > -	if (!device->ops.alloc_ucontext)
> > +	if (!device->ops.alloc_ucontext ||
> > +	    device->type == RDMA_DEVICE_TYPE_SMI)
> >   		return -EOPNOTSUPP;
> >   	uverbs_dev = kzalloc(sizeof(*uverbs_dev), GFP_KERNEL);
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 477bf9dd5e71..bebc2d22f466 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -2661,6 +2661,18 @@ struct ib_device_ops {
> >   	 */
> >   	int (*get_numa_node)(struct ib_device *dev);
> > +	/**
> > +	 * add_sub_dev - Add a sub IB device
> > +	 */
> > +	struct ib_device *(*add_sub_dev)(struct ib_device *parent,
> > +					 enum rdma_nl_dev_type type,
> > +					 const char *name);
> > +
> > +	/**
> > +	 * del_sub_dev - Delete a sub IB device
> > +	 */
> > +	void (*del_sub_dev)(struct ib_device *sub_dev);
> > +
> >   	DECLARE_RDMA_OBJ_SIZE(ib_ah);
> >   	DECLARE_RDMA_OBJ_SIZE(ib_counters);
> >   	DECLARE_RDMA_OBJ_SIZE(ib_cq);
> > @@ -2771,6 +2783,15 @@ struct ib_device {
> >   	char iw_ifname[IFNAMSIZ];
> >   	u32 iw_driver_flags;
> >   	u32 lag_flags;
> > +
> > +	/* A parent device has a list of sub-devices */
> > +	struct mutex subdev_lock;
> > +	struct list_head subdev_list_head;
> > +
> > +	/* A sub device has a type and a parent */
> > +	enum rdma_nl_dev_type type;
> > +	struct ib_device *parent;
> > +	struct list_head subdev_list;
> >   };
> >   static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
> > @@ -4820,4 +4841,26 @@ static inline u16 rdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
> >   const struct ib_port_immutable*
> >   ib_port_immutable_read(struct ib_device *dev, unsigned int port);
> > +
> > +/** ib_add_sub_device - Add a sub IB device on an existing one
> > + *
> > + * @parent: The IB device that needs to add a sub device
> > + * @type: The type of the new sub device
> > + * @name: The name of the new sub device
> > + *
> > + *
> > + * Return 0 on success, an error code otherwise
> > + */
> > +int ib_add_sub_device(struct ib_device *parent,
> > +		      enum rdma_nl_dev_type type,
> > +		      const char *name);
> > +
> > +
> > +/** ib_del_sub_device_and_put - Delect an IB sub device while holding a 'get'
> > + *
> > + * @sub: The sub device that is going to be deleted
> > + *
> > + * Return 0 on success, an error code otherwise
> > + */
> > +int ib_del_sub_device_and_put(struct ib_device *sub);
> >   #endif /* IB_VERBS_H */
> > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> > index a214fc259f28..d15ee16be722 100644
> > --- a/include/uapi/rdma/rdma_netlink.h
> > +++ b/include/uapi/rdma/rdma_netlink.h
> > @@ -602,4 +602,9 @@ enum rdma_nl_counter_mask {
> >   	RDMA_COUNTER_MASK_QP_TYPE = 1,
> >   	RDMA_COUNTER_MASK_PID = 1 << 1,
> >   };
> > +
> > +/* Supported rdma device types. */
> > +enum rdma_nl_dev_type {
> > +	RDMA_DEVICE_TYPE_SMI = 1,
> > +};
> >   #endif /* _UAPI_RDMA_NETLINK_H */
> 

