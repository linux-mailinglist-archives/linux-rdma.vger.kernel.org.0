Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29F740BDB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjF1Iwj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 04:52:39 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:45268 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjF1Ijt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 04:39:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7D7612DF;
        Wed, 28 Jun 2023 05:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9424C433C0;
        Wed, 28 Jun 2023 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687928424;
        bh=S9w9Ylazfr7gGMk55LWAdREn4bJPj4VRqpvqxNv5hV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peP2yC05HOPmvk9tkvMp2uX47B029yxV6vo4HWIwpxiq0UHmrXsBBeEfENlZhX2e/
         PTF+NJt5upiW0JRdZ6usdewdVBmJiv2AEafsbuwlogF8AdTQlQFVwA1hhyU52a7N9f
         RBY/0CqrFuc1uoUgYdya8yEcmUG3zIzM8ECx/dQdxLCzMjVyMsmfzSeMaZpKBdpG62
         eJ2/qk4rP79dhegV4MOTT18LcZgJsyClNqBOvWZxuJgPHNP7LgN3czlOCkQuPvwEMa
         XTLsguD8wLXLV8YUvw7pIsWNJAXT2dfNpUdBCBYMgGiPAoY1QjbfaISmUu6hxgHpcu
         Pk7+DsG6800NA==
Date:   Wed, 28 Jun 2023 08:00:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230628050019.GC23952@unreal>
References: <20230603063833.541682-1-huangjunxian6@hisilicon.com>
 <20230611174605.GG12152@unreal>
 <1b11b9e9-a729-0d61-52e3-6bcf132ca356@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b11b9e9-a729-0d61-52e3-6bcf132ca356@hisilicon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 19, 2023 at 02:20:54PM +0800, Junxian Huang wrote:
> 
> 
> On 2023/6/12 1:46, Leon Romanovsky wrote:
> > On Sat, Jun 03, 2023 at 02:38:33PM +0800, Junxian Huang wrote:
> >> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> >>
> >> Previously, there was no way to query the number of lanes for a network
> >> card, so the same netdev_speed would result in a fixed pair of width and
> >> speed. As network card specifications become more diverse, such fixed
> >> mode is no longer suitable, so a method is needed to obtain the correct
> >> width and speed based on the number of lanes.
> > 
> > I'm sorry but I didn't understand the problem statement. Can you please
> > provide an example of configuration that will give different results 
> > before this patch and after?
> > 
> 
> I'll give examples with 20G and 200G netdevs respectively.
> 
> 20G:
> Before this patch, regardless of the actual number of lanes, the width and
> speed displayed in ibv_devinfo would be always fixed:
> 	active_width: 4X
> 	active_speed: 5 Gbps
> After this patch, there will be different combinations of width and speed
> according to the number of lanes. For example, for a 20G netdev whose number
> of lanes is 2, the width and speed displayed in ibv_devinfo will be:
> 	active_width: 2X
> 	active_speed: 10 Gbps
> 
> 200G:
> Before this patch, netdevs with netdev_speed more than 40G cannot get a right
> width and speed in ibv_devinfo. Only the default result would be displayed:
> 	active_width: 4X
> 	active_speed: 25 Gbps
> After this patch, taking an example with 4 lanes, the displayed results will be:
> 	active_width: 4X
> 	active_speed: 50 Gbps
> 

<...>

> >> +	cap_link_lanes_supported = netdev->ethtool_ops->cap_link_lanes_supported;
> >>  	rtnl_unlock();
> >>  
> >>  	dev_put(netdev);
> >>  
> >>  	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
> >>  		netdev_speed = lksettings.base.speed;
> >> +		if (cap_link_lanes_supported && lksettings.lanes) {
> > 
> > According to the documentation cap_link_lanes_supported defines if
> > number of lanes can be supplied by user and I would expect from
> > __ethtool_get_link_ksettings() to get right numbers after it was
> > changed.

No, I'm saying that cap_link_lanes_supported is variable which only says
if number of lanes can be changed and __ethtool_get_link_ksettings()
will return right number of lanes every time it is called without need
to call to ib_get_width_and_speed() again.

Thanks

> > 
> > Thanks
> > 
> 
> I'm sorry but I didn't quite understand. Do you mean the critical section of
> rtnl_lock() here should be expanded to make sure getting the right number of
> lanes?
> 
> Junxian
> 
> >> +			ib_get_width_and_speed(netdev_speed, lksettings.lanes,
> >> +					       speed, width);
> >> +			return 0;
> >> +		}
> >>  	} else {
> >>  		netdev_speed = SPEED_1000;
> >> -		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
> >> -			netdev_speed);
> >> +		if (rc)
> >> +			pr_warn("%s speed is unknown, defaulting to %u\n",
> >> +				netdev->name, netdev_speed);
> >>  	}
> >>  
> >>  	if (netdev_speed <= SPEED_1000) {
> >> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> >> index 1e7774ac808f..7dc926ec7fee 100644
> >> --- a/include/rdma/ib_verbs.h
> >> +++ b/include/rdma/ib_verbs.h
> >> @@ -552,6 +552,18 @@ static inline int ib_width_enum_to_int(enum ib_port_width width)
> >>  	}
> >>  }
> >>  
> >> +static inline int ib_int_to_ib_width(u32 lanes)
> >> +{
> >> +	switch (lanes) {
> >> +	case 1: return IB_WIDTH_1X;
> >> +	case 2: return IB_WIDTH_2X;
> >> +	case 4: return IB_WIDTH_4X;
> >> +	case 8: return IB_WIDTH_8X;
> >> +	case 12: return IB_WIDTH_12X;
> >> +	default: return IB_WIDTH_1X;
> >> +	}
> >> +}
> >> +
> >>  enum ib_port_speed {
> >>  	IB_SPEED_SDR	= 1,
> >>  	IB_SPEED_DDR	= 2,
> >> @@ -563,6 +575,20 @@ enum ib_port_speed {
> >>  	IB_SPEED_NDR	= 128,
> >>  };
> >>  
> >> +static inline int ib_eth_to_ib_speed(u32 speed)
> >> +{
> >> +	switch (speed) {
> >> +	case SPEED_2500: return IB_SPEED_SDR;
> >> +	case SPEED_5000: return IB_SPEED_DDR;
> >> +	case SPEED_10000: return IB_SPEED_FDR10;
> >> +	case SPEED_14000: return IB_SPEED_FDR;
> >> +	case SPEED_25000: return IB_SPEED_EDR;
> >> +	case SPEED_50000: return IB_SPEED_HDR;
> >> +	case SPEED_100000: return IB_SPEED_NDR;
> >> +	default: return IB_SPEED_SDR;
> >> +	}
> >> +}
> >> +
> >>  enum ib_stat_flag {
> >>  	IB_STAT_FLAG_OPTIONAL = 1 << 0,
> >>  };
> >> -- 
> >> 2.30.0
> >>
