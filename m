Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8F1E96CF
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2020 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgEaKFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 May 2020 06:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEaKFQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 31 May 2020 06:05:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D4F42065C;
        Sun, 31 May 2020 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590919516;
        bh=dXMkwnQAZeL8TcvuYCcB71Ob/n8op4hHUM0jXpeFsF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f30JjTwtkm98IMUZWXgOVX7LK4OL2SoQSIE7+UqWa3kKeI/G9tQfcFuvG9mh9TA8Y
         8Rt1fv7hmM1Fh9SURXjDSrlpHZ2go9Sm3RG8cUspDi3BDAgDGNI5gf2gHoTqAuljLL
         3UB/NeuuN8jMfpF8G0HE04Md7FL+MVVKf/tUJrXQ=
Date:   Sun, 31 May 2020 13:05:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Message-ID: <20200531100512.GH66309@unreal>
References: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200530140224.GA1330098@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530140224.GA1330098@mwanda>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 30, 2020 at 05:02:24PM +0300, Dan Carpenter wrote:
> The hfi1_vnic_up() function doesn't check whether hfi1_netdev_rx_init()
> returns errors.  In hfi1_vnic_init() we need to change the code to
> preserve the error code instead of returning success.
>
> Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Add error handling in hfi1_vnic_up() and add second fixes tag
>
>  drivers/infiniband/hw/hfi1/vnic_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
> index b183c56b7b6a4..03f8be8e9488e 100644
> --- a/drivers/infiniband/hw/hfi1/vnic_main.c
> +++ b/drivers/infiniband/hw/hfi1/vnic_main.c
> @@ -457,13 +457,19 @@ static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
>  	if (rc < 0)
>  		return rc;
>
> -	hfi1_netdev_rx_init(dd);
> +	rc = hfi1_netdev_rx_init(dd);
> +	if (rc < 0)
> +		goto err_remove;

Why did you check for the negative value here and didn't check below?

Thanks

>
>  	netif_carrier_on(netdev);
>  	netif_tx_start_all_queues(netdev);
>  	set_bit(HFI1_VNIC_UP, &vinfo->flags);
>
>  	return 0;
> +
> +err_remove:
> +	hfi1_netdev_remove_data(dd, VNIC_ID(vinfo->vesw_id));
> +	return rc;
>  }
>
>  static void hfi1_vnic_down(struct hfi1_vnic_vport_info *vinfo)
> @@ -512,7 +518,8 @@ static int hfi1_vnic_init(struct hfi1_vnic_vport_info *vinfo)
>  			goto txreq_fail;
>  	}
>
> -	if (hfi1_netdev_rx_init(dd)) {
> +	rc = hfi1_netdev_rx_init(dd);
> +	if (rc) {
>  		dd_dev_err(dd, "Unable to initialize netdev contexts\n");
>  		goto alloc_fail;
>  	}
> --
> 2.26.2
>
