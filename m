Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8986A4AED78
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 10:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiBIJBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 04:01:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbiBIJBv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 04:01:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F992C1DC70C
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 01:01:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDB6DB81F68
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 08:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339EBC340E7;
        Wed,  9 Feb 2022 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644397155;
        bh=Cqp4AjceF347GKBzzGEZbn93BwzdMYrpJ7MSHgAFn4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6/oxFlM/vM9ksUraRTAM9O2DGqL2yVS1ipw3CvmgYPcvbk1ox/MTRrI0v5wN6q/d
         /P2dq+mGpxju7GrQIBMJAzayyq5Qixdrs9FFigCiqy9q+oRuNk3Q3cnfRpz9wcWYJr
         PO+Zzx6STCV3UGxJoaonVd4zHGESNJRbghq82QHEKq7BqEQbe6wSKA8r9sFyHHPHTs
         W3XkLLe/Uz5bIme3YKb9379z39g71MUBu2evUVVp4RL/XbZn8O4pfW4qf+17Eal8jC
         OdJvCvN+LQxB4pagsTH+xbPmLuG6M8IcqWIc+14oVwygqXhbWGw7FBn/WXZNS1QjXA
         G9g9cnxW5n1Ug==
Date:   Wed, 9 Feb 2022 10:59:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] libibverbs/examples: Add missing device
 attributes
Message-ID: <YgOCXCXWyCTxvva8@unreal>
References: <20220209025308.20743-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209025308.20743-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 10:53:08AM +0800, Xiao Yang wrote:
> make ibv_devinfo command show more device attributes.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  libibverbs/examples/devinfo.c | 29 +++++++++++++++++++++++++----
>  libibverbs/verbs.h            | 13 ++++++++++---
>  2 files changed, 35 insertions(+), 7 deletions(-)

I have a feeling that a long time ago, we had a discussion if and how
expose device capabilities and the decision was that we don't report
in-kernel specific device caps.

Jason, do you remember anything like this?

Thanks

> 
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index cef6e2ea..8e889842 100644
> --- a/libibverbs/examples/devinfo.c
> +++ b/libibverbs/examples/devinfo.c
> @@ -267,7 +267,9 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
>  				   IBV_DEVICE_MEM_WINDOW_TYPE_2B |
>  				   IBV_DEVICE_RC_IP_CSUM |
>  				   IBV_DEVICE_RAW_IP_CSUM |
> -				   IBV_DEVICE_MANAGED_FLOW_STEERING);
> +				   IBV_DEVICE_CROSS_CHANNEL |
> +				   IBV_DEVICE_MANAGED_FLOW_STEERING |
> +				   IBV_DEVICE_INTEGRITY_HANDOVER);
>  
>  	if (dev_cap_flags & IBV_DEVICE_RESIZE_MAX_WR)
>  		printf("\t\t\t\t\tRESIZE_MAX_WR\n");
> @@ -315,8 +317,12 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
>  		printf("\t\t\t\t\tRC_IP_CSUM\n");
>  	if (dev_cap_flags & IBV_DEVICE_RAW_IP_CSUM)
>  		printf("\t\t\t\t\tRAW_IP_CSUM\n");
> +	if (dev_cap_flags & IBV_DEVICE_CROSS_CHANNEL)
> +		printf("\t\t\t\t\tCROSS_CHANNEL\n");
>  	if (dev_cap_flags & IBV_DEVICE_MANAGED_FLOW_STEERING)
>  		printf("\t\t\t\t\tMANAGED_FLOW_STEERING\n");
> +	if (dev_cap_flags & IBV_DEVICE_INTEGRITY_HANDOVER)
> +		printf("\t\t\t\t\tINTEGRITY_HANDOVER\n");
>  	if (dev_cap_flags & unknown_flags)
>  		printf("\t\t\t\t\tUnknown flags: 0x%" PRIX32 "\n",
>  		       dev_cap_flags & unknown_flags);
> @@ -382,13 +388,28 @@ static void print_odp_caps(const struct ibv_device_attr_ex *device_attr)
>  static void print_device_cap_flags_ex(uint64_t device_cap_flags_ex)
>  {
>  	uint64_t ex_flags = device_cap_flags_ex & 0xffffffff00000000ULL;
> -	uint64_t unknown_flags = ~(IBV_DEVICE_RAW_SCATTER_FCS |
> -				   IBV_DEVICE_PCI_WRITE_END_PADDING);
> -
> +	uint64_t unknown_flags = ~(IBV_DEVICE_ON_DEMAND_PAGING |
> +				   IBV_DEVICE_SG_GAPS_REG |
> +				   IBV_DEVICE_VIRTUAL_FUNCTION |
> +				   IBV_DEVICE_RAW_SCATTER_FCS |
> +				   IBV_DEVICE_RDMA_NETDEV_OPA |
> +				   IBV_DEVICE_PCI_WRITE_END_PADDING |
> +				   IBV_DEVICE_ALLOW_USER_UNREG);
> +
> +	if (ex_flags & IBV_DEVICE_ON_DEMAND_PAGING)
> +		printf("\t\t\t\t\tON_DEMAND_PAGING\n");
> +	if (ex_flags & IBV_DEVICE_SG_GAPS_REG)
> +		printf("\t\t\t\t\tSG_GAPS_REG\n");
> +	if (ex_flags & IBV_DEVICE_VIRTUAL_FUNCTION)
> +		printf("\t\t\t\t\tVIRTUAL_FUNCTION\n");
>  	if (ex_flags & IBV_DEVICE_RAW_SCATTER_FCS)
>  		printf("\t\t\t\t\tRAW_SCATTER_FCS\n");
> +	if (ex_flags & IBV_DEVICE_RDMA_NETDEV_OPA)
> +		printf("\t\t\t\t\tRDMA_NETDEV_OPA\n");
>  	if (ex_flags & IBV_DEVICE_PCI_WRITE_END_PADDING)
>  		printf("\t\t\t\t\tPCI_WRITE_END_PADDING\n");
> +	if (ex_flags & IBV_DEVICE_ALLOW_USER_UNREG)
> +		printf("\t\t\t\t\tALLOW_USER_UNREG\n");
>  	if (ex_flags & unknown_flags)
>  		printf("\t\t\t\t\tUnknown flags: 0x%" PRIX64 "\n",
>  		       ex_flags & unknown_flags);
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index a9f182ff..68591c7b 100644
> --- a/libibverbs/verbs.h
> +++ b/libibverbs/verbs.h
> @@ -136,7 +136,9 @@ enum ibv_device_cap_flags {
>  	IBV_DEVICE_MEM_WINDOW_TYPE_2B	= 1 << 24,
>  	IBV_DEVICE_RC_IP_CSUM		= 1 << 25,
>  	IBV_DEVICE_RAW_IP_CSUM		= 1 << 26,
> -	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29
> +	IBV_DEVICE_CROSS_CHANNEL	= 1 << 27,
> +	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29,
> +	IBV_DEVICE_INTEGRITY_HANDOVER	= 1 << 30
>  };
>  
>  enum ibv_fork_status {
> @@ -149,8 +151,13 @@ enum ibv_fork_status {
>   * Can't extended above ibv_device_cap_flags enum as in some systems/compilers
>   * enum range is limited to 4 bytes.
>   */
> -#define IBV_DEVICE_RAW_SCATTER_FCS (1ULL << 34)
> -#define IBV_DEVICE_PCI_WRITE_END_PADDING (1ULL << 36)
> +#define IBV_DEVICE_ON_DEMAND_PAGING		(1ULL << 31)
> +#define IBV_DEVICE_SG_GAPS_REG			(1ULL << 32)
> +#define IBV_DEVICE_VIRTUAL_FUNCTION		(1ULL << 33)
> +#define IBV_DEVICE_RAW_SCATTER_FCS		(1ULL << 34)
> +#define IBV_DEVICE_RDMA_NETDEV_OPA		(1ULL << 35)
> +#define IBV_DEVICE_PCI_WRITE_END_PADDING	(1ULL << 36)
> +#define IBV_DEVICE_ALLOW_USER_UNREG		(1ULL << 37)
>  
>  enum ibv_atomic_cap {
>  	IBV_ATOMIC_NONE,
> -- 
> 2.34.1
> 
> 
> 
