Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A474162AEE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRQp2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 11:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRQp2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 11:45:28 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8696122B48;
        Tue, 18 Feb 2020 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582044328;
        bh=epo58b2WikVc0ZabAMvhNTTtacIM1ukyIR+QpKYIqnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVnQJtJxoWIVpHmd+Hvj0LSs97fKL4udCu0tL4g4QybZ40DIp2PvJ/PhJOeq5WraM
         mz/5km4igKNb6CH1dsZUC8rXRFWQeooXczc2WIo7yCLBE1Z1ilZhvbuQGzbDeOQruS
         MFsEtkmEw8qOKCvSUD1ZiVFsqkVm5gtdLZ3a8tjU=
Date:   Tue, 18 Feb 2020 18:45:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next] RDMA/srpt: Avoid print error when modify_port
 is not supported
Message-ID: <20200218164523.GB14557@unreal>
References: <20200218101740.27762-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218101740.27762-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 12:17:40PM +0200, Kamal Heib wrote:
> Avoid printing the following error when modify_port isn't supported.
>
> [47541.541145] ib_srpt disabling MAD processing failed.
>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 98552749d71c..eba2b156616d 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -628,12 +628,14 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
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
> +		ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> +		if (ret < 0 && ret != -EOPNOTSUPP)
>  			pr_err("disabling MAD processing failed.\n");

This print doesn't make any sense, we are unregistering MAD agent anyway.

>  		if (sport->mad_agent) {
>  			ib_unregister_mad_agent(sport->mad_agent);
> --
> 2.21.1
>
