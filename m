Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57361B76C4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgDXNRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgDXNR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 09:17:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C9C09B045
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 06:17:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 23so5184453qkf.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ArmYYg9gHVxZclqhQc/cgoSoOikRwX728/If3n/XW/A=;
        b=IsIepsyr4XddxHlovtTmt0m+m8ohuxPWejepCuhs8nrUsPCndbfZhcT5Q2/4b5TnGw
         PPxJBwTmqHkc5vR+vMqmLHZ21tMtcEVMujjf0W1NfhJvc9JnvWBdvGa3afjEnPkEW/ml
         LUdqNc8m8O7edBdvCwWzjyNmk17pQaN0Mm5A4eYpcOLl7gI9xeENbs4YChrbp9stc8O1
         T8E+EwRL1K2uEwFcGYQj/KagUloJII6Hzp0N4R3mUr8tChIBBTJXVdb+CHeBYUfqVE+U
         w8YgVN7lCVLq9/3GakkcrayO9d4/EniiUghZ6+z6aF6PY4b5ZwCSTiE83Zlh/wLFu+sX
         ziVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ArmYYg9gHVxZclqhQc/cgoSoOikRwX728/If3n/XW/A=;
        b=q/7USseV35EQkkmoAnY0XneAyMKk0t2FtPWl/7hBc3N5kssulRZH5ICl+YIEIla7jv
         GYgSL4Xdn5VhHL7aw/ecpl3vlHmNDrU+xvun8H8SaQG8UTanLq1y813NrRRPZY/2Gbwi
         sjf8uAOuetFCssheDgGA0KMkagiQ61bQqkkB0010xnOx/Czv3o3l0B3NYdqC1lfvtqoY
         SFyi1ugRvrxgq7rK1JKQvSsNAsd0Ik60NdsTp5soXLvwn1nwK4/bRPFLQOTcKJbkfhd5
         NsU58B9LlaFVQfb2XEXp6u9M6O3t2mNh39BlRyAPxa4JX3Q+vVwQELTWWz2mLXsHAJzq
         wPbQ==
X-Gm-Message-State: AGi0PuYNSo9l8asXfeG9/jbRNWlNu8+UnDmqU2pmAKJrypfKSBEpWvpt
        B4lkB0/cHdyzDYdryJpU9Z9lqQ==
X-Google-Smtp-Source: APiQypI1CnpfTu9ROpuJzgU7fj9BChbgZTiK8qvhRSbDCvnH4a8xHytQrsaQr8Vdau1Ocxyy44X/xQ==
X-Received: by 2002:a05:620a:14b2:: with SMTP id x18mr8410869qkj.153.1587734248080;
        Fri, 24 Apr 2020 06:17:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p24sm4068541qtp.59.2020.04.24.06.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 06:17:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRyCs-00062V-S8; Fri, 24 Apr 2020 10:17:26 -0300
Date:   Fri, 24 Apr 2020 10:17:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 4/4] RDMA/mlx5: Add support in steering default
 miss
Message-ID: <20200424131726.GA23075@ziepe.ca>
References: <20200413135220.934007-1-leon@kernel.org>
 <20200413135220.934007-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413135220.934007-5-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:52:20PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> User can configure default miss rule in order to skip matching in
> the user domain and forward the packet to the kernel steering domain.
> When user requests a default miss rule, we add steering rule
> to forward the traffic to the next namespace.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Reviewed-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/flow.c        | 35 ++++++++++++++++++++----
>  drivers/infiniband/hw/mlx5/main.c        |  9 +++---
>  include/uapi/rdma/mlx5_user_ioctl_cmds.h |  5 ++++
>  3 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
> index 7ff8d7188b82..7db672fd1395 100644
> +++ b/drivers/infiniband/hw/mlx5/flow.c
> @@ -69,19 +69,35 @@ static const struct uverbs_attr_spec mlx5_ib_flow_type[] = {
>  
>  static int get_dests(struct uverbs_attr_bundle *attrs,
>  		     struct mlx5_ib_flow_matcher *fs_matcher, int *dest_id,
> -		     int *dest_type, struct ib_qp **qp)
> +		     int *dest_type, struct ib_qp **qp, bool *def_miss)
>  {
>  	bool dest_devx, dest_qp;
>  	void *devx_obj;
> +	u32 flags;
>  
>  	dest_devx = uverbs_attr_is_valid(attrs,
>  					 MLX5_IB_ATTR_CREATE_FLOW_DEST_DEVX);
>  	dest_qp = uverbs_attr_is_valid(attrs,
>  				       MLX5_IB_ATTR_CREATE_FLOW_DEST_QP);
>  
> -	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS &&
> -	    ((dest_devx && dest_qp) || (!dest_devx && !dest_qp)))
> -		return -EINVAL;
> +	*def_miss = false;
> +	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_FLOW_MATCHER_FLOW_FLAGS)) {

attr_is_valid should not be called on flags, get_flags already knows
to return 0 as the flags if the attr is not present.

Jason
