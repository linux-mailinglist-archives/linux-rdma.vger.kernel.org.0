Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C991D09DC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 09:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgEMHWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 03:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbgEMHWH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 03:22:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778B3206D6;
        Wed, 13 May 2020 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589354527;
        bh=Ixbs7+oR1AT+CVV/fnupdP3jsWRe2qWxWek+L5hw6FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raBuFHLErBMwKJ9Sp//2XV1QQROXqXtIDk0oxhDaM4ha6bDn253YAGCt8+IUtjnj4
         9pe+909Nm7P3OUNpJp9rmy2p9T/n99QaVhnnyWzYQw8nWFbrMCHn5tIERqF1Rm8/GV
         ycmTz4sGNsVt6YzDahtN90Q7E37iZFMusxN5KGaE=
Date:   Wed, 13 May 2020 10:22:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513072203.GR4814@unreal>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511222918.62576-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 01:29:18AM +0300, Kamal Heib wrote:
> Avoid disabling device management for devices that don't support
> Management datagrams (MADs) by checking if the "mad_agent" pointer is
> initialized before calling ib_modify_port, also change the error message
> to a warning and make it more informative.
>
> Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 7ed38d1cb997..7b21792ab6f7 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
>  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
>  	};
>  	struct srpt_port *sport;
> +	int ret;
>  	int i;
>
>  	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
>  		sport = &sdev->port[i - 1];
>  		WARN_ON(sport->port != i);
> -		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
> -			pr_err("disabling MAD processing failed.\n");
>  		if (sport->mad_agent) {
> +			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> +			if (ret < 0)
> +				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
> +					dev_name(&sport->sdev->device->dev),

The ib_modify_port() shouldn't be called if it expected to fail.

Thanks

> +					sport->port, ret);
>  			ib_unregister_mad_agent(sport->mad_agent);
>  			sport->mad_agent = NULL;
>  		}
> --
> 2.25.4
>
