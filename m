Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416E71B4CD0
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDVSos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSor (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Apr 2020 14:44:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6567C03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 11:44:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b188so1954889qkd.9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQb+d7NNZxs68QI58YYUDPymHb5uLAn0MhiMBNaOlGc=;
        b=MTj1VyOy5A6mJnbplpSwrdAf6zg0QGGJ7NrHsgZCqCfvCKmmyUMUJluIU2l6RIVIxk
         aLcDEh2hjvC6PyDzHm1cPfxgRd6dn/zAZMilWgtJUDOj2ezurn/aL+7yslWXUP9q2yOm
         aR74iPYCmt/wwwyv8fMGzzlvaxL2yXrWNDYZiKMpv9JvjNhslLpl4eDNbfrUJtyhVIzL
         xWkzE7mAWuU7QkncDv2Hih+l0383oH4wdLPl7DKsQQLUZAz9zXgzikxhxN79jxpWj0bM
         CzNLXd/4kE50APCMfZI3Ebxc4T5HxfUMioc3wd3yzJ3srNTm66+0V1aIMMIq7JTDcsvz
         xx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQb+d7NNZxs68QI58YYUDPymHb5uLAn0MhiMBNaOlGc=;
        b=LrltQMDrOO98iqg9zlZz8bC+zx/3AXyAb6C5iWcwscreVxRjMmSnB54rwkk7oqHHbn
         PLFmJFbItBkZItfK9L93vzG6a8kH7rkdze+OacwFcdfnR0Ovi9Eia7/dQA3P/4fqc6L+
         Rq7lbfzjVKteQtllKta1VWTGFKen3Y4cqteMvnqLAr5V4gwzLFnbhbK6/2Gv6S2GMKFx
         lCbZHxdBQ9jZmaE91oSpG324IlLmtQoOruApkoSlmlvLvGSixbG0GGkNplQB6rH28VJg
         k/9YljpCM94aYruep/J4fWFWgSddzYPf9lVMNMRSeOn2bt9+Gg+3KaspUePbXl4uMbFC
         DzmA==
X-Gm-Message-State: AGi0PuYTTLH603BwqM/CB44gP4GrfXMp//19l07GWzCPLAHleRKhk4NK
        oPOu221G6bknTW+WjbtFR8fd1Q==
X-Google-Smtp-Source: APiQypJ1SbC3YQTOa41UQISm0kaVcPgWt+JF4KIdKEhdzbXZJintvhil00eUMbZ37bpydEItCU4OOA==
X-Received: by 2002:a37:a909:: with SMTP id s9mr27767542qke.327.1587581086781;
        Wed, 22 Apr 2020 11:44:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p1sm1408qkd.23.2020.04.22.11.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRKMX-0003Ky-H2; Wed, 22 Apr 2020 15:44:45 -0300
Date:   Wed, 22 Apr 2020 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        Don Hiatt <don.hiatt@intel.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Set GRH fields in query QP on RoCE
Message-ID: <20200422184445.GA12730@ziepe.ca>
References: <20200413132028.930109-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413132028.930109-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:20:28PM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@mellanox.com>
> 
> GRH fields such as sgid_index, hop limit and etc. are set in the
> QP context when QP is created/modified.
> 
> Currently, when query QP is performed, we fill the GRH fields only
> if the GRH bit is set in the QP context, but this bit is not set
> for RoCE. Adjust the check so we will set all relevant data for
> the RoCE too.
> 
> Fixes: d8966fcd4c25 ("IB/core: Use rdma_ah_attr accessor functions")
> Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 1456db4b6295..a4f8e7c7ed24 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -5558,13 +5558,13 @@ static void to_rdma_ah_attr(struct mlx5_ib_dev *ibdev,
>  	rdma_ah_set_path_bits(ah_attr, path->grh_mlid & 0x7f);
>  	rdma_ah_set_static_rate(ah_attr,
>  				path->static_rate ? path->static_rate - 5 : 0);
> -	if (path->grh_mlid & (1 << 7)) {
> +
> +	if (path->grh_mlid & (1 << 7) ||
> +	    ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
>  		u32 tc_fl = be32_to_cpu(path->tclass_flowlabel);
>  
> -		rdma_ah_set_grh(ah_attr, NULL,
> -				tc_fl & 0xfffff,
> -				path->mgid_index,
> -				path->hop_limit,
> +		rdma_ah_set_grh(ah_attr, NULL, tc_fl & 0xfffff,
> +				path->mgid_index, path->hop_limit,

Why is whitespace reformatting in a -rc patch? I dropped this.

Applied to for-rc

Jason
