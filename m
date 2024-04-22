Return-Path: <linux-rdma+bounces-2005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43D8AD4F4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 21:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EE42820D7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72CA155340;
	Mon, 22 Apr 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpA+743e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA215533D;
	Mon, 22 Apr 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814651; cv=none; b=r2z+QfRlzTUGqXlku+xzlz3aO4mUrF3t5UWyiQUiOpmTv1he8Nxp9GCl0yRCA8/LBqLnKLZSi1laJ4R4hr49isOuckzaX3gnmLoZQt183m7TJD96Pf1GpNYx85ArgSbrWgtmUk6/rOzJn8qcDOdeiM1qjUvz6k++D8/mUWsFK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814651; c=relaxed/simple;
	bh=nl/+nK1/56DD4qxS5QM0oGTNrWbYL2Zi4T3VxsnXE0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4mdbDULpbYQ9xqT1HfEz+fCwsaRgOOqxhnk/HgZTRrQsRSjyaAQT/Pxw49M1vIFsz15c0AhmAnvs6wwJ8trSOnd/DtMOp+pcefCsSsBI7z49V94c3IU0b+yiQ9srLkyHkbWF6ELiU9FvqU5PqDljNai0e7SoIP8LwYzjl7ndiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpA+743e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F0BC113CC;
	Mon, 22 Apr 2024 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713814650;
	bh=nl/+nK1/56DD4qxS5QM0oGTNrWbYL2Zi4T3VxsnXE0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpA+743ex3p7k4ofgCFbEffBtUhEeq+dqGpVkhg3cT0W2kxre4kk323ke3Pcs0HiH
	 R0LwI8m2aK1FQfMft5eYc4v/n0nuDCGxxvR0soQO0RC0xe9m1zUdvhLtZKdJot+KCP
	 l5x7wwFUCcB7mN/6mBcl7EE6ENjEP1/Ep2Jc+ZZmd/PAiqfk7rsM/sEqyHLDUxB7Nx
	 5WqNJY8pCW/spk9TtxsQIx4VHA0C+FcqPLOFcGZowtvgXTY826XKsbuaAJr6ECu6i+
	 Tf8Btic8i0+oVZjUhdKSCklQvybotDvdhrVCTKFrAQ+OHBO6LOFEQ4cfy/q/T1qJyE
	 KSspSNfW/HA8Q==
Date: Mon, 22 Apr 2024 12:37:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 4/6] RDMA/mana_ib: enable RoCE on port 1
Message-ID: <20240422193728.GA44715@dev-arch.thelio-3990X>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
 <1712738551-22075-5-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712738551-22075-5-git-send-email-kotaranov@linux.microsoft.com>

Hi Konstantin,

On Wed, Apr 10, 2024 at 01:42:29AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Set netdev and RoCEv2 flag to enable GID population on port 1.
> Use GIDs of the master netdev. As mc->ports[] stores slave devices,
> use a helper to get the master netdev.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 15 +++++++++++++++
>  drivers/infiniband/hw/mana/main.c   | 15 +++++++++++----
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 47547a962b19..e7981301d10b 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -53,6 +53,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  {
>  	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
>  	struct gdma_dev *mdev = madev->mdev;
> +	struct net_device *upper_ndev;
>  	struct mana_context *mc;
>  	struct mana_ib_dev *dev;
>  	int ret;
> @@ -79,6 +80,20 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	dev->ib_dev.num_comp_vectors = 1;
>  	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
>  
> +	rcu_read_lock(); /* required to get upper dev */
> +	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
> +	if (!upper_ndev) {
> +		rcu_read_unlock();
> +		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
> +		goto free_ib_device;
> +	}

Clang now warns (or errors with CONFIG_WERROR):

  drivers/infiniband/hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
     88 |         if (!upper_ndev) {
        |             ^~~~~~~~~~~
  drivers/infiniband/hw/mana/device.c:150:9: note: uninitialized use occurs here
    150 |         return ret;
        |                ^~~
  drivers/infiniband/hw/mana/device.c:88:2: note: remove the 'if' if its condition is always false
     88 |         if (!upper_ndev) {
        |         ^~~~~~~~~~~~~~~~~~
     89 |                 rcu_read_unlock();
        |                 ~~~~~~~~~~~~~~~~~~
     90 |                 ibdev_err(&dev->ib_dev, "Failed to get master netdev");
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     91 |                 goto free_ib_device;
        |                 ~~~~~~~~~~~~~~~~~~~~
     92 |         }
        |         ~
  drivers/infiniband/hw/mana/device.c:62:9: note: initialize the variable 'ret' to silence this warning
     62 |         int ret;
        |                ^
        |                 = 0
  1 error generated.

I could not really find a consistent return code for when
netdev_master_upper_dev_get_rcu() fails. -ENODEV?

Cheers,
Nathan

> +	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
> +	rcu_read_unlock();
> +	if (ret) {
> +		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
> +		goto free_ib_device;
> +	}
> +
>  	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 29550f2173ff..7a9d7e13b7b1 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -527,11 +527,18 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
>  int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
>  			       struct ib_port_immutable *immutable)
>  {
> -	/*
> -	 * This version only support RAW_PACKET
> -	 * other values need to be filled for other types
> -	 */
> +	struct ib_port_attr attr;
> +	int err;
> +
> +	err = ib_query_port(ibdev, port_num, &attr);
> +	if (err)
> +		return err;
> +
> +	immutable->pkey_tbl_len = attr.pkey_tbl_len;
> +	immutable->gid_tbl_len = attr.gid_tbl_len;
>  	immutable->core_cap_flags = RDMA_CORE_PORT_RAW_PACKET;
> +	if (port_num == 1)
> +		immutable->core_cap_flags |= RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 

