Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067B04D2FD3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiCINVL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 08:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCINVL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 08:21:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05D14FBF1
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 05:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3AC0B82164
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 13:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20184C340E8;
        Wed,  9 Mar 2022 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646832009;
        bh=WrUKLcGbOoVG4UTu4j6PwN44NpmDexNlLFs8z9KUaH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+RitiuSBQfxUEZwh6Cc0XbiyJvwEcp1ytEGyx0RTMQHl3y9LX5cgy09jrKpxR9+W
         y/bIHetdRFGaojbBIBi2L2m3JGAY3QEBg7oKr5LTlQM2k6MHI98GEkQliB+yQaySkd
         2mKe4R7UtZeSkZXflqsvGbjEGrnEMOVhTcUMXOipV40nIulJjheJ/Otootfb4wMR3b
         Q4eLqr9oP4JGVoF5PtnuophZ9/vbUfd3Y+7CIsguX4tnsr+cpJn9/k0tOsZua0mPam
         6Y7urAJqxag2Pu7Eyuypndr61c5Nh12uAsBz2+jJcf0AolzmleT57yyEcBxHCVUuif
         xG/f3FpLYf4ow==
Date:   Wed, 9 Mar 2022 15:20:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] libibverbs/examples: Add missing device
 attributes
Message-ID: <YiiphVezgIaf/IFg@unreal>
References: <20220209025308.20743-1-yangx.jy@fujitsu.com>
 <YgOCXCXWyCTxvva8@unreal>
 <20220211124139.GL4160@nvidia.com>
 <4043a417-4cd8-1868-9085-65e0b61a6a74@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4043a417-4cd8-1868-9085-65e0b61a6a74@fujitsu.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 07, 2022 at 10:03:25AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/2/11 20:41, Jason Gunthorpe wrote:
> > On Wed, Feb 09, 2022 at 10:59:08AM +0200, Leon Romanovsky wrote:
> >> On Wed, Feb 09, 2022 at 10:53:08AM +0800, Xiao Yang wrote:
> >>> make ibv_devinfo command show more device attributes.
> >>>
> >>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> >>>   libibverbs/examples/devinfo.c | 29 +++++++++++++++++++++++++----
> >>>   libibverbs/verbs.h            | 13 ++++++++++---
> >>>   2 files changed, 35 insertions(+), 7 deletions(-)
> >> I have a feeling that a long time ago, we had a discussion if and how
> >> expose device capabilities and the decision was that we don't report
> >> in-kernel specific device caps.
> > Right, it is kernel bug they leak out in the first place.
> >
> >>> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> >>> index a9f182ff..68591c7b 100644
> >>> +++ b/libibverbs/verbs.h
> >>> @@ -136,7 +136,9 @@ enum ibv_device_cap_flags {
> >>>   	IBV_DEVICE_MEM_WINDOW_TYPE_2B	= 1 << 24,
> >>>   	IBV_DEVICE_RC_IP_CSUM		= 1 << 25,
> >>>   	IBV_DEVICE_RAW_IP_CSUM		= 1 << 26,
> >>> -	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29
> >>> +	IBV_DEVICE_CROSS_CHANNEL	= 1 << 27,
> >>> +	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29,
> >>> +	IBV_DEVICE_INTEGRITY_HANDOVER	= 1 << 30
> >>>   };
> >>>   
> >>>   enum ibv_fork_status {
> >>> @@ -149,8 +151,13 @@ enum ibv_fork_status {
> >>>    * Can't extended above ibv_device_cap_flags enum as in some systems/compilers
> >>>    * enum range is limited to 4 bytes.
> >>>    */
> >>> -#define IBV_DEVICE_RAW_SCATTER_FCS (1ULL << 34)
> >>> -#define IBV_DEVICE_PCI_WRITE_END_PADDING (1ULL << 36)
> >>> +#define IBV_DEVICE_ON_DEMAND_PAGING		(1ULL << 31)
> >>> +#define IBV_DEVICE_SG_GAPS_REG			(1ULL << 32)
> >>> +#define IBV_DEVICE_VIRTUAL_FUNCTION		(1ULL << 33)
> >>> +#define IBV_DEVICE_RAW_SCATTER_FCS		(1ULL << 34)
> >>> +#define IBV_DEVICE_RDMA_NETDEV_OPA		(1ULL << 35)
> >>> +#define IBV_DEVICE_PCI_WRITE_END_PADDING	(1ULL << 36)
> >>> +#define IBV_DEVICE_ALLOW_USER_UNREG		(1ULL << 37)
> > And don't copy ABI into header like this, the kernel parts need to be
> > moved to the kernel uabi header and cleaned
> 
> Hi Jason, Leon
> 
> Sorry, it's not clear to me.
> 
> 1) Is it necessary to add these missing attributes?
> 
> 2) If necessary, do you think they need to be moved into 
> kernel-headers/rdma?

We wanted to say that these device supported capabilities shouldn't be
added to ibv_devinfo.

Thanks

> 
> Best Regards,
> 
> Xiao Yang
> 
> >
> > Jason
