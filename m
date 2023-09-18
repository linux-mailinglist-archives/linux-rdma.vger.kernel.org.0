Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF287A49AD
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjIRMbL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbjIRMaw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 08:30:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2EE6
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 05:30:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-773a5bb6fb6so230497985a.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695040228; x=1695645028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7vxT91yrn+LfFE2Qv6hAIOALLo0Tr8T/9rovwcys4w=;
        b=KT+MeV4BJd7dtVoSsT1AXSl163dOFjedZnNlmjSy/0cK3K3ScKj+0+gxDvjF7kGzRz
         S6bGWzFO+JaAyP/xTs8S+m0CyRySFpQwvYsIi3dP6SooTWmo0L/AdBD/3M/pR/uuHr2T
         k4dGwDimpQLXFH+Nf/Su8cU70IHuRHhM+bcOcHjPebeSVz2KMHFRYZzJ+yAhOtBJUrUi
         RQdqeUpX9Y5+89fD5qM6r44CcbbAt90eIhPR7cdYvj3Cm2mCc5sD4OZamcNacIPNGliJ
         25wFXH35tkrEHkH8/PuIVEL9SJtLTmfzPTAm78XPT7062AadlRvrtkOzZBS1ROfe7l7A
         dAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040228; x=1695645028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7vxT91yrn+LfFE2Qv6hAIOALLo0Tr8T/9rovwcys4w=;
        b=QZrwS878QjbTpkbR5JrznHU1kokR9R5kLYBr8qeK79WT2TZi5wSIh45RJs0GLrG1bm
         WoxC5qdfkwo74kfnBwbX3ZhUuJj7l/7IzdH5/+fy8UP5+BjFhDGE6H5xtFOZiOw6yx46
         GY07vjvm8pZ99QKST6DVFC/SmC2yI99lBdv7xrEoF8PWuoQimjzVmtxfsFi8IZGmrVf1
         7ouzPAt/A6bvHfD067AK/mzzpiwbJFQtaXuUpE6U1oVW0+9QiHeQjbW3hN98mjNE88VT
         rTqcwWGW76dRdqRDNpMkSfVQI70AOFKXm/MjwIyYOkMu6+nr5fy3IQCKv9Xf+pPy9YPb
         0HNg==
X-Gm-Message-State: AOJu0YxpAjZicvBQVlAFl4I2L/YFSvdUlyJ/3ZTGBMDeRa7tHEoEQgu+
        JPadd4/Wki5FoXUEyb98fdxy7q4+crjPYBVm+gA=
X-Google-Smtp-Source: AGHT+IFnfGBUkPxVrBLBBWwMzWmHEw2+hD10BNdrWSMzS+jtmKQGNZ5V7NoWWc9+B8OZ9DFAhSQyIA==
X-Received: by 2002:a0c:a609:0:b0:64f:72cc:4bca with SMTP id s9-20020a0ca609000000b0064f72cc4bcamr7651338qva.47.1695040227660;
        Mon, 18 Sep 2023 05:30:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b0076c94030a2esm3097669qkm.114.2023.09.18.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:30:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiDOU-0003wr-Ay;
        Mon, 18 Sep 2023 09:30:26 -0300
Date:   Mon, 18 Sep 2023 09:30:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH for-next v1] RDMA/nldev: Add support for reporting ipoib
 netdev
Message-ID: <20230918123026.GA13795@ziepe.ca>
References: <20230915183757.510557-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183757.510557-1-kheib@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 15, 2023 at 02:37:57PM -0400, Kamal Heib wrote:
> This patch adds support for reporting the ipoib net device for a given
> RDMA device by calling ib_get_net_dev_by_params() when filling the
> port's info.
> 
> $ rdma link show mlx5_0/1
> link mlx5_0/1 subnet_prefix fe80:0000:0000:0000 lid 66 sm_lid 3 lmc 0
> 	state ACTIVE physical_state LINK_UP netdev ibp196s0f0
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
> v1: Check namespace and query pkey.
> ---
>  drivers/infiniband/core/nldev.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index d5d3e4f0de77..f3fa8143cdc7 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -308,10 +308,12 @@ static int fill_port_info(struct sk_buff *msg,
>  			  struct ib_device *device, u32 port,
>  			  const struct net *net)
>  {
> +	struct net_device *ipoib_netdev = NULL;
>  	struct net_device *netdev = NULL;
>  	struct ib_port_attr attr;
> -	int ret;
>  	u64 cap_flags = 0;
> +	u16 pkey;
> +	int ret;
>  
>  	if (fill_nldev_handle(msg, device))
>  		return -EMSGSIZE;
> @@ -340,6 +342,26 @@ static int fill_port_info(struct sk_buff *msg,
>  			return -EMSGSIZE;
>  		if (nla_put_u8(msg, RDMA_NLDEV_ATTR_LMC, attr.lmc))
>  			return -EMSGSIZE;
> +
> +		ret = ib_query_pkey(device, port, 0, &pkey);
> +		if (ret)
> +			goto out;

That doesn't really make any sense..

The whole idea there is only one ipoib device doesn't even make sense.

I still don't like this at all.

> +
> +		ipoib_netdev = ib_get_net_dev_by_params(device, port,
> +							pkey,
> +							NULL, NULL);
> +		if (ipoib_netdev && net_eq(dev_net(ipoib_netdev), net)) {
> +			ret = nla_put_u32(msg,
> +					  RDMA_NLDEV_ATTR_NDEV_INDEX,
> +					  ipoib_netdev->ifindex);
> +			if (ret)
> +				goto out;
> +			ret = nla_put_string(msg,
> +					     RDMA_NLDEV_ATTR_NDEV_NAME,
> +					     ipoib_netdev->name);
> +			if (ret)
> +				goto out;

and I don't think the existing netlink attributes should be redefined
to be about ipoib

Jason
