Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFB7D808
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfHAIuM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:50:12 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:18081 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAIuM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 04:50:12 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x718nabU028577;
        Thu, 1 Aug 2019 01:49:37 -0700
Date:   Thu, 1 Aug 2019 14:19:36 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next V2 4/4] RDMA/{cxgb3, cxgb4, i40iw}: Remove
 common code
Message-ID: <20190801084934.GA2911@chelsio.com>
References: <20190731202459.19570-1-kamalheib1@gmail.com>
 <20190731202459.19570-5-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731202459.19570-5-kamalheib1@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thursday, August 08/01/19, 2019 at 01:54:59 +0530, Kamal Heib wrote:
> Now that we have a common iWARP query port function we can remove the
> common code from the iWARP drivers.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
Thanks for the changes! Ack for cxgb4.
Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>


>  drivers/infiniband/hw/cxgb3/iwch_provider.c | 25 ---------------------
>  drivers/infiniband/hw/cxgb4/provider.c      | 24 --------------------
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 11 ---------
>  3 files changed, 60 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
> index 5848e4727b2e..dcf02ec02810 100644
> --- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
> +++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
> @@ -991,33 +991,8 @@ static int iwch_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
>  static int iwch_query_port(struct ib_device *ibdev,
>  			   u8 port, struct ib_port_attr *props)
>  {
> -	struct iwch_dev *dev;
> -	struct net_device *netdev;
> -	struct in_device *inetdev;
> -
>  	pr_debug("%s ibdev %p\n", __func__, ibdev);
>  
> -	dev = to_iwch_dev(ibdev);
> -	netdev = dev->rdev.port_info.lldevs[port-1];
> -
> -	/* props being zeroed by the caller, avoid zeroing it here */
> -	props->max_mtu = IB_MTU_4096;
> -	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
> -
> -	if (!netif_carrier_ok(netdev))
> -		props->state = IB_PORT_DOWN;
> -	else {
> -		inetdev = in_dev_get(netdev);
> -		if (inetdev) {
> -			if (inetdev->ifa_list)
> -				props->state = IB_PORT_ACTIVE;
> -			else
> -				props->state = IB_PORT_INIT;
> -			in_dev_put(inetdev);
> -		} else
> -			props->state = IB_PORT_INIT;
> -	}
> -
>  	props->port_cap_flags =
>  	    IB_PORT_CM_SUP |
>  	    IB_PORT_SNMP_TUNNEL_SUP |
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 5e59c5708729..d373ac0fe2cb 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -305,32 +305,8 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
>  static int c4iw_query_port(struct ib_device *ibdev, u8 port,
>  			   struct ib_port_attr *props)
>  {
> -	struct c4iw_dev *dev;
> -	struct net_device *netdev;
> -	struct in_device *inetdev;
> -
>  	pr_debug("ibdev %p\n", ibdev);
>  
> -	dev = to_c4iw_dev(ibdev);
> -	netdev = dev->rdev.lldi.ports[port-1];
> -	/* props being zeroed by the caller, avoid zeroing it here */
> -	props->max_mtu = IB_MTU_4096;
> -	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
> -
> -	if (!netif_carrier_ok(netdev))
> -		props->state = IB_PORT_DOWN;
> -	else {
> -		inetdev = in_dev_get(netdev);
> -		if (inetdev) {
> -			if (inetdev->ifa_list)
> -				props->state = IB_PORT_ACTIVE;
> -			else
> -				props->state = IB_PORT_INIT;
> -			in_dev_put(inetdev);
> -		} else
> -			props->state = IB_PORT_INIT;
> -	}
> -
>  	props->port_cap_flags =
>  	    IB_PORT_CM_SUP |
>  	    IB_PORT_SNMP_TUNNEL_SUP |
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index d169a8031375..8056930bbe2c 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -97,18 +97,7 @@ static int i40iw_query_port(struct ib_device *ibdev,
>  			    u8 port,
>  			    struct ib_port_attr *props)
>  {
> -	struct i40iw_device *iwdev = to_iwdev(ibdev);
> -	struct net_device *netdev = iwdev->netdev;
> -
> -	/* props being zeroed by the caller, avoid zeroing it here */
> -	props->max_mtu = IB_MTU_4096;
> -	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
> -
>  	props->lid = 1;
> -	if (netif_carrier_ok(iwdev->netdev))
> -		props->state = IB_PORT_ACTIVE;
> -	else
> -		props->state = IB_PORT_DOWN;
>  	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
>  		IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
>  	props->gid_tbl_len = 1;
> -- 
> 2.20.1
> 
