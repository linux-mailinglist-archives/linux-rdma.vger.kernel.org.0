Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636F7A48C4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjIRLwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjIRLwP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 07:52:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1489DFF
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 04:52:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E1C433C8;
        Mon, 18 Sep 2023 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695037929;
        bh=jAkhofe4hPDNeeR6tm2n+lT9TNL6CvjuSVdNH+w+OwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8t7NVu2gGEQUbphbHZVW2rtMk6J43AHnWzH8KNov9hBFIrOJAnjeScSL2YCDnL81
         xHtAq8WG23GF8G6g/4c/na5MCb/L2tQYPQuISbTGJcZX3pjKBSIibNr9n/5fbthRWl
         q5fbE5SuEPDO/K679c5FRN3H/mnOaSDXTjaJLki1/QLFWbR5zDaTzo6vgSAwstmUge
         bRHTPYGWpvnjI2U7NymjOf4c9FRr8iGSMQVto4n14z9fXlHkilfXDyetgOZrZgG3JQ
         GBXFCfaBEzQ2WPnLPJEoS1KwZMkOetgKvuSJu1ZfCJbpJA406oFmF8bhIjO4ht3iXl
         PXthAeoOD7/VQ==
Date:   Mon, 18 Sep 2023 14:52:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next v1] RDMA/nldev: Add support for reporting ipoib
 netdev
Message-ID: <20230918115206.GB103601@unreal>
References: <20230915183757.510557-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183757.510557-1-kheib@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> +		}
>  	}
>  	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_STATE, attr.state))
>  		return -EMSGSIZE;

You will leak ipoib_netdev here, need to change return to be "goto out".

Thanks

> @@ -357,6 +379,9 @@ static int fill_port_info(struct sk_buff *msg,
>  	}
>  
>  out:
> +	if (ipoib_netdev)
> +		dev_put(ipoib_netdev);
> +
>  	if (netdev)
>  		dev_put(netdev);
>  	return ret;
> -- 
> 2.41.0
> 
