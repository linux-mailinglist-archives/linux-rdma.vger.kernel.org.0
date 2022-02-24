Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97034C35E4
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiBXTaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 14:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiBXTaE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 14:30:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221020E782
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 11:29:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 271BAB828FE
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 19:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4B5C340E9;
        Thu, 24 Feb 2022 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645730971;
        bh=w6XgNt7Khoct/ozFNzU3PtX2Y7iPQCzXhySKEgCjwtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNwIwICHtMuryFrY2FGIXnQK61iZt4MZNiZY/3T8ThaeebEa79sIIGwSitQYZqVca
         lzYl3xHrp5ii8K8V0uV0mwEXNvPJaSTVg+4V+ybMT7bc63nObBvRf1j6Sk2PbKYebJ
         HOi1IgVAhucrnw0RhVzXA7yVV6SBra8Jgz4AVI0SdEAVwyQFB0lSdc2ZnEtiXNS5yK
         a8PsRbtCSpyLIr7JNA0kLxpmAPq6FX24WmtFE0CbLvcfP+9QKAghEJDAz0sxznyqnD
         iDmcr8Bmw8J3HFMFjBED2Ln3mIjUauM5E9iWI4XwoceqBlmS9N41kj8P5dxlXJcKhj
         CxUPb0y917ckQ==
Date:   Thu, 24 Feb 2022 21:29:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH rdma-rc 1/3] RDMA/irdma: Fix netdev notifications for
 vlan's
Message-ID: <Yhfclznsv2Y2ZUmp@unreal>
References: <20220224005842.1707-1-shiraz.saleem@intel.com>
 <20220224005842.1707-2-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224005842.1707-2-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 06:58:40PM -0600, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Currently, events on vlan netdevs are being ignored. Fix
> this by finding the real netdev and processing the
> notifications for vlan netdevs.
> 
> Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

It is better to use the existing coding pattern.

real_dev = rdma_vlan_dev_real_dev(netdev);
if (!real_dev)
   real_dev = netdev;

> 
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index 398736d..26407d8 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -155,6 +155,8 @@ int irdma_inetaddr_event(struct notifier_block *notifier, unsigned long event,
>  	struct ib_device *ibdev;
>  	u32 local_ipaddr;
>  
> +	if (is_vlan_dev(netdev))
> +		netdev = vlan_dev_real_dev(netdev);
>  	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
>  	if (!ibdev)
>  		return NOTIFY_DONE;
> @@ -201,6 +203,8 @@ int irdma_inet6addr_event(struct notifier_block *notifier, unsigned long event,
>  	struct ib_device *ibdev;
>  	u32 local_ipaddr6[4];
>  
> +	if (is_vlan_dev(netdev))
> +		netdev = vlan_dev_real_dev(netdev);
>  	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
>  	if (!ibdev)
>  		return NOTIFY_DONE;
> @@ -243,14 +247,16 @@ int irdma_net_event(struct notifier_block *notifier, unsigned long event,
>  		    void *ptr)
>  {
>  	struct neighbour *neigh = ptr;
> +	struct net_device *netdev = (struct net_device *)neigh->dev;
>  	struct irdma_device *iwdev;
>  	struct ib_device *ibdev;
>  	__be32 *p;
>  	u32 local_ipaddr[4] = {};
>  	bool ipv4 = true;
>  
> -	ibdev = ib_device_get_by_netdev((struct net_device *)neigh->dev,
> -					RDMA_DRIVER_IRDMA);
> +	if (is_vlan_dev(netdev))
> +		netdev = vlan_dev_real_dev(netdev);
> +	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
>  	if (!ibdev)
>  		return NOTIFY_DONE;
>  
> -- 
> 1.8.3.1
> 
