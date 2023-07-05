Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12434747DFF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGEHMN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 03:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjGEHMM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 03:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF02E4F;
        Wed,  5 Jul 2023 00:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F8E61459;
        Wed,  5 Jul 2023 07:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ACCC433BA;
        Wed,  5 Jul 2023 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688541130;
        bh=hirsQoR0Ki1y4mUH7a+brxAKQyn2XVL41lANxF68XXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUfKg1UqyRX9KE7Re4I4c3G2u+cmO8A2NedgsQYbQqtlMvnrl20jh78pWv62ny8GU
         iDae4fymiqJ/37M+HowWbxSE/bnWyt21S9qRppfUKHtCUt4gJU0WDeMzz/qaraNNqW
         wU5fDyB3IK23YGlXL7P9jSRB5IQ86R6WSUnE1cfITZ7VqBNtDOAUX+NpBnNIJJP0Rd
         fozo9tWFHVf7Dx+wz/pCrtQ4TZ1CxImX8G6JNLwyVS+mvo1IFw+0lJENGkp96GjG71
         eesLQ3ud6fjZvpwsPC/QzJBRtKGQc/HXNIK1VQ87+JGwYC8oG72ZFcby6OfaeZBA2H
         HQxJwonT/DKHg==
Date:   Wed, 5 Jul 2023 10:12:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230705071205.GH6455@unreal>
References: <20230603063833.541682-1-huangjunxian6@hisilicon.com>
 <20230611174605.GG12152@unreal>
 <1b11b9e9-a729-0d61-52e3-6bcf132ca356@hisilicon.com>
 <20230628050019.GC23952@unreal>
 <53e8025d-803d-f6c5-b853-8352163d9a2e@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e8025d-803d-f6c5-b853-8352163d9a2e@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 05, 2023 at 11:05:50AM +0800, Junxian Huang wrote:
> 
> 
> On 2023/6/28 13:00, Leon Romanovsky wrote:
> > On Mon, Jun 19, 2023 at 02:20:54PM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2023/6/12 1:46, Leon Romanovsky wrote:
> >>> On Sat, Jun 03, 2023 at 02:38:33PM +0800, Junxian Huang wrote:
> >>>> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> >>>>
> >>>> Previously, there was no way to query the number of lanes for a network
> >>>> card, so the same netdev_speed would result in a fixed pair of width and
> >>>> speed. As network card specifications become more diverse, such fixed
> >>>> mode is no longer suitable, so a method is needed to obtain the correct
> >>>> width and speed based on the number of lanes.
> >>>
> >>> I'm sorry but I didn't understand the problem statement. Can you please
> >>> provide an example of configuration that will give different results 
> >>> before this patch and after?
> >>>
> >>
> >> I'll give examples with 20G and 200G netdevs respectively.
> >>
> >> 20G:
> >> Before this patch, regardless of the actual number of lanes, the width and
> >> speed displayed in ibv_devinfo would be always fixed:
> >> 	active_width: 4X
> >> 	active_speed: 5 Gbps
> >> After this patch, there will be different combinations of width and speed
> >> according to the number of lanes. For example, for a 20G netdev whose number
> >> of lanes is 2, the width and speed displayed in ibv_devinfo will be:
> >> 	active_width: 2X
> >> 	active_speed: 10 Gbps
> >>
> >> 200G:
> >> Before this patch, netdevs with netdev_speed more than 40G cannot get a right
> >> width and speed in ibv_devinfo. Only the default result would be displayed:
> >> 	active_width: 4X
> >> 	active_speed: 25 Gbps
> >> After this patch, taking an example with 4 lanes, the displayed results will be:
> >> 	active_width: 4X
> >> 	active_speed: 50 Gbps
> >>
> > 
> > <...>
> > 
> >>>> +	cap_link_lanes_supported = netdev->ethtool_ops->cap_link_lanes_supported;
> >>>>  	rtnl_unlock();
> >>>>  
> >>>>  	dev_put(netdev);
> >>>>  
> >>>>  	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
> >>>>  		netdev_speed = lksettings.base.speed;
> >>>> +		if (cap_link_lanes_supported && lksettings.lanes) {
> >>>
> >>> According to the documentation cap_link_lanes_supported defines if
> >>> number of lanes can be supplied by user and I would expect from
> >>> __ethtool_get_link_ksettings() to get right numbers after it was
> >>> changed.
> > 
> > No, I'm saying that cap_link_lanes_supported is variable which only says
> > if number of lanes can be changed and __ethtool_get_link_ksettings()
> > will return right number of lanes every time it is called without need
> > to call to ib_get_width_and_speed() again.
> > 
> > Thanks
> > 
> 
> These two functions have different purposes.
> 
> The number of lanes is indeed obtained from __ethtool_get_link_ksettings(),
> and ib_get_width_and_speed() converts the number of lanes into ib_width and
> ib_speed, which are the output of ib_get_eth_speed().

Great, so why do you need to rely on cap_link_lanes_supported in ib_get_width_and_speed()?

Thanks
