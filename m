Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CED39D98A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFGKZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhFGKZR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 06:25:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8723D61164;
        Mon,  7 Jun 2021 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623061406;
        bh=4CDq6riRp+XfM2B+OVUd8W7279xWGwLFu70CrwK4pJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCAbd4ne3lT1EEg0FSfyB9joUP5J8NzRpEcFTdKVPbNk7utPM5a5utrcLlGWHG11L
         5jJB5GHPdliTQIt9AbyAT+VzAshEmG6/cmRoq8SNOXtfyC6kzy4ibRYtIZ2gpoKrR6
         OKoejvrCIpfctKW+qFyoDZqP4eBCkP0dQrRyHbiw=
Date:   Mon, 7 Jun 2021 12:23:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 02/15] RDMA/core: Replace the ib_port_data
 hw_stats pointers with a ib_port pointer
Message-ID: <YL3zmzSTJ8nE1yr6@kroah.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <6477a29059b1b4d92ea003e3b801a8d1df6d516d.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6477a29059b1b4d92ea003e3b801a8d1df6d516d.1623053078.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 11:17:27AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> It is much saner to store a pointer to the kobject structure that contains
> the cannonical stats pointer than to copy the stats pointers into a public
> structure.
> 
> Future patches will require the sysfs pointer for other purposes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/core_priv.h |  1 +
>  drivers/infiniband/core/nldev.c     |  8 ++------
>  drivers/infiniband/core/sysfs.c     | 14 +++++++++++---
>  include/rdma/ib_verbs.h             |  3 ++-
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index 29809dd30041..ec5c2c3db423 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -378,6 +378,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
>  
>  void ib_free_port_attrs(struct ib_core_device *coredev);
>  int ib_setup_port_attrs(struct ib_core_device *coredev);
> +struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev, u32 port_num);
>  
>  int rdma_compatdev_set(u8 enable);
>  
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 01316926cef6..e9b4b2cccaa0 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -2066,7 +2066,8 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
>  	}
>  
>  	port = nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
> -	if (!rdma_is_port_valid(device, port)) {
> +	stats = ib_get_hw_stats_port(device, port);
> +	if (!stats) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
> @@ -2088,11 +2089,6 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
>  		goto err_msg;
>  	}
>  
> -	stats = device->port_data ? device->port_data[port].hw_stats : NULL;
> -	if (stats == NULL) {
> -		ret = -EINVAL;
> -		goto err_msg;
> -	}
>  	mutex_lock(&stats->lock);
>  
>  	num_cnts = device->ops.get_hw_stats(device, stats, port, 0);
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index d11ceff2b4e4..b153dee1e0fa 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1031,8 +1031,6 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
>  			goto err;
>  		port->hw_stats_ag = hsag;
>  		port->hw_stats = stats;
> -		if (device->port_data)
> -			device->port_data[port_num].hw_stats = stats;
>  	} else {
>  		struct kobject *kobj = &device->dev.kobj;
>  		ret = sysfs_create_group(kobj, hsag);
> @@ -1053,6 +1051,14 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
>  	kfree(stats);
>  }
>  
> +struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
> +					   u32 port_num)
> +{
> +	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num))
> +		return NULL;
> +	return ibdev->port_data[port_num].sysfs->hw_stats;
> +}
> +
>  static int add_port(struct ib_core_device *coredev, int port_num)
>  {
>  	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
> @@ -1171,6 +1177,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
>  		setup_hw_stats(device, p, port_num);
>  
>  	list_add_tail(&p->kobj.entry, &coredev->port_list);
> +	if (device->port_data && is_full_dev)
> +		device->port_data[port_num].sysfs = p;

You are saving off a pointer to a reference counted structure without
incrementing the reference count on it?  That's brave, and really wrong.
Properly increment/decrement it when using and when done with it.

thnaks,

greg k-h
