Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8867D4B0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjAZSxM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 13:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjAZSxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 13:53:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00B3B0F7
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 10:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66144B81EDE
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 18:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977CBC433D2;
        Thu, 26 Jan 2023 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674759186;
        bh=mi5YvqJf9uDZ0pKFdPwLhzIqOwfv533jRT/7mis5QTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCE6wiFcao9Udz2Pi9SQJc51+DlYKl7dXKqyZhA510F45j77BtsmeC0V4VWZLy2sG
         pjHuF/zzd6MNBsb68w4VgwQ+mu1R/JC207w7f9a9HCEcmlHhdxsPfPxE2HAKtIbsVj
         U4vHLwMOXvEUTMDou0j71KXqT+2LYVRQz2/9TJ6GMBj3q5w1RA0T26PnPDOO95rxk/
         m1RgSB8CA2IM+Xezu1Djb1+H+kiCh6s76mxmpTvcxX8rFFrmffFDmKTizYtphdqlfY
         E9r6QXY6hAvhRdDj1HtEsb2dp8wc/mOeSr+eS+bZnKICdhyh/WXwAcCx4bzzxitzpY
         oGTsxQF3LgeYA==
Date:   Thu, 26 Jan 2023 20:53:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced
 IPoIB over netlink
Message-ID: <Y9LMDRBWH+L5CTio@unreal>
References: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
 <Y9LH5kim0d5rBKOR@unreal>
 <Y9LJOHWYidVHBDMO@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LJOHWYidVHBDMO@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 26, 2023 at 02:40:56PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 26, 2023 at 08:35:18PM +0200, Leon Romanovsky wrote:
> > On Tue, Jan 24, 2023 at 08:24:18PM +0200, Leon Romanovsky wrote:
> > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > > 
> > > Make sure that non-enhanced IPoIB queues are configured with only
> > > 1 tx and rx queues over netlink. This behavior is consistent with the
> > > sysfs child_create configuration.
> > > 
> > > The cited commit opened up the possibility for child PKEY interface
> > > to have multiple tx/rx queues. It is the driver's responsibility to
> > > re-adjust the queue count accordingly. This patch does exactly that:
> > > non-enhanced IPoIB supports only 1 tx and 1 rx queue.
> > > 
> > > Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leon@nvidia.coma
> > > ---
> > > Changelog:
> > > v2:
> > >  * Changed implementation
> > > v1: https://lore.kernel.org/all/752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org
> > >  * Fixed typo in warning print.
> > > v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
> > > ---
> > >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > 
> > 
> > Dragos pointed to me that I sent commit with "old" commit message.
> > The right one is below and I'll fix it locally once will apply it.
> > 
> > Jason, are you happy with the patch?
> 
> Why not use min?

It doesn't give anything as we are in legacy IPoIB path and it will be
min with 1 anyway.

Thanks

> 
> Jason
