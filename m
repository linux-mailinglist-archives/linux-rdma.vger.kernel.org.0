Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0568285DEE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgJGLOI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 07:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGLOI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Oct 2020 07:14:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA1F2075A;
        Wed,  7 Oct 2020 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602069247;
        bh=DOf+fGULKypNeKX5XKHMWcinNDzcmA4fOJVJVIfbd3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEolGSYjn7QTi5WLOFkut57IBKIzVOk7+zWPR0LHcMSi07wE6FRTR8W1xiF+w3XEs
         2zStyptkwmfr/5UkSn9TP7flJzQqUwZE1jj7M0E/8l4cjEWv5F2s0bLaL6r+tUilaE
         rsC8H2XszS398n+XVE1LmZ8DlwXcprwDAMc57B2g=
Date:   Wed, 7 Oct 2020 14:14:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Add rdma_dev_to_netns()
Message-ID: <20201007111403.GC3678159@unreal>
References: <20201007090355.1101408-1-ka-cheong.poon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007090355.1101408-1-ka-cheong.poon@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 02:03:55AM -0700, Ka-Cheong Poon wrote:
> This function returns the namespace of a struct ib_device if the RDMA
> subsystem is in exclusive network namespace mode.  If the subsystem is
> in shared namespace mode, this function returns NULL.
>
> Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
> ---
>  drivers/infiniband/core/device.c | 16 ++++++++++++++++
>  include/rdma/ib_verbs.h          |  1 +
>  2 files changed, 17 insertions(+)

We don't merge functions without users.

Thanks

>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index c36b4d2b61e0..a3dd95bf3050 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -144,6 +144,22 @@ bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
>  }
>  EXPORT_SYMBOL(rdma_dev_access_netns);
>
> +/**
> + * rdma_dev_to_netns() - Return the net namespace of a given device if the
> + *			 RDMA subsystem is in exclusive network namespace
> + *			 mode.  If it is in shared namespace mode, this
> + *			 function returns NULL.  Caller can use it to
> + *			 differentiate the two modes of the RDMA subsystem.
> + *
> + * @device: Pointer to rdma device to get the namespace
> + */
> +struct net *rdma_dev_to_netns(const struct ib_device *device)
> +{
> +	return ib_devices_shared_netns ? NULL :
> +		read_pnet(&device->coredev.rdma_net);
> +}
> +EXPORT_SYMBOL(rdma_dev_to_netns);
> +
>  /*
>   * xarray has this behavior where it won't iterate over NULL values stored in
>   * allocated arrays.  So we need our own iterator to see all values stored in
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c0b2fa7e9b95..aeced1a3324f 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4715,6 +4715,7 @@ static inline struct ib_device *rdma_device_to_ibdev(struct device *device)
>
>  bool rdma_dev_access_netns(const struct ib_device *device,
>  			   const struct net *net);
> +struct net *rdma_dev_to_netns(const struct ib_device *device);
>
>  #define IB_ROCE_UDP_ENCAP_VALID_PORT_MIN (0xC000)
>  #define IB_GRH_FLOWLABEL_MASK (0x000FFFFF)
> --
> 2.18.4
>
