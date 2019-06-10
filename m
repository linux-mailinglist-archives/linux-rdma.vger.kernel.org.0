Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D0E3B705
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbfFJONj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 10:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390716AbfFJONi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:13:38 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6588E207E0;
        Mon, 10 Jun 2019 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560176018;
        bh=+ymoEARvOyWEPq9d3MxixAECVvIFccL7Ye1wpC4hrgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0f6H4YRf5KX/JcibCZHrCXhO+KEdxnsdL500ETGQebu1gSIM3RO0kv+vZnBgxLlhv
         d1V/CbUk5jgrv5LFIbe/88HlgdyLJLqMapobglTwmI4Haw+hm1H1QQudozpFS77uLs
         bSOTdcPovyNeDCRS0P2JN0tBsruieyqXc1uWB8dk=
Date:   Mon, 10 Jun 2019 17:13:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 1/3] RDMA: Move rdma_node_type to uapi/
Message-ID: <20190610141334.GB6369@mtr-leonro.mtl.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-2-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605183252.6687-2-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 03:32:50PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> This enum is exposed over the sysfs file 'node_type' and over netlink via
> RDMA_NLDEV_ATTR_DEV_NODE_TYPE, so declare it in the uapi headers.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/verbs.c  |  2 +-
>  include/rdma/ib_verbs.h          | 13 +------------
>  include/uapi/rdma/rdma_netlink.h | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index e666a1f7608d86..56af18456ba776 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -209,7 +209,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
>  EXPORT_SYMBOL(ib_rate_to_mbps);
>
>  __attribute_const__ enum rdma_transport_type
> -rdma_node_get_transport(enum rdma_node_type node_type)
> +rdma_node_get_transport(unsigned int node_type)
>  {
>
>  	if (node_type == RDMA_NODE_USNIC)
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index cdfeeda1db7f31..d5dd3cb7fcf702 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -132,17 +132,6 @@ struct ib_gid_attr {
>  	u8			port_num;
>  };
>
> -enum rdma_node_type {

Why did you drop "enum rdma_node_type" and changed to be anonymous enum?

> -	/* IB values map to NodeInfo:NodeType. */
> -	RDMA_NODE_IB_CA 	= 1,
> -	RDMA_NODE_IB_SWITCH,
> -	RDMA_NODE_IB_ROUTER,
> -	RDMA_NODE_RNIC,
> -	RDMA_NODE_USNIC,
> -	RDMA_NODE_USNIC_UDP,
> -	RDMA_NODE_UNSPECIFIED,
> -};
> -
>  enum {
>  	/* set the local administered indication */
>  	IB_SA_WELL_KNOWN_GUID	= BIT_ULL(57) | 2,
> @@ -164,7 +153,7 @@ enum rdma_protocol_type {
>  };
>
>  __attribute_const__ enum rdma_transport_type
> -rdma_node_get_transport(enum rdma_node_type node_type);
> +rdma_node_get_transport(unsigned int node_type);
>
>  enum rdma_network_type {
>  	RDMA_NETWORK_IB,
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index 41db51367efafb..f588e8551c6cea 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -147,6 +147,18 @@ enum {
>  	IWPM_NLA_HELLO_MAX
>  };
>
> +/* For RDMA_NLDEV_ATTR_DEV_NODE_TYPE */
> +enum {
> +	/* IB values map to NodeInfo:NodeType. */
> +	RDMA_NODE_IB_CA = 1,
> +	RDMA_NODE_IB_SWITCH,
> +	RDMA_NODE_IB_ROUTER,
> +	RDMA_NODE_RNIC,
> +	RDMA_NODE_USNIC,
> +	RDMA_NODE_USNIC_UDP,
> +	RDMA_NODE_UNSPECIFIED,
> +};
> +
>  /*
>   * Local service operations:
>   *   RESOLVE - The client requests the local service to resolve a path.
> --
> 2.21.0
>
