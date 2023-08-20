Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D599781D4E
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHTKCs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjHTKCq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 06:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6109A5260
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 02:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A4460ED4
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 09:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC04C433C7;
        Sun, 20 Aug 2023 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692525571;
        bh=X91QKg7Fc5nMnO2vsMXj3t2MpczDXtEgtfY3MkuBHbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tw8H8klr/L/35MQP7T/CdKiVTZQ9TdGsJ6ZTZjxCAQTdFmu0HZCrqIEct/ySec9PN
         at+iU+bQNI4c0sI/ITB80RiWwTqhFRRHHNxsEPdWecuyCQTasM4IhGSEF9YzePI+qG
         WYTGyhOl3N0k/QNGVf2B9T/82JslYbGkyv1JoqiiFWSLh5DSytDv56ucZK2MIY588u
         yx7mD7+fLwILebYZfVDwroXG4453Xm2APiApI14vJPe0JMLqKzL014J72LLfd10jLA
         8IK/Mq9FPLQyPSNP3ao/nOgqbSm0Jqn/5rQJMWJtks/nFF7Pi1qh92YFRBl7VrgFfB
         fnWkxZpBSuafQ==
Date:   Sun, 20 Aug 2023 12:59:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Get upper device only if device
 is lagged
Message-ID: <20230820095926.GE1562474@unreal>
References: <cover.1692168533.git.leon@kernel.org>
 <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
 <ZN+dX1hkUbEIHid4@nvidia.com>
 <ZN+fdgo4givpj12R@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+fdgo4givpj12R@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 18, 2023 at 01:42:30PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 01:33:35PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 16, 2023 at 09:52:23AM +0300, Leon Romanovsky wrote:
> > > From: Mark Bloch <mbloch@nvidia.com>
> > > 
> > > If the RDMA device isn't in LAG mode there is no need
> > > to try to get the upper device.
> > > 
> > > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++++-------
> > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > > index f0b394ed7452..215d7b0add8f 100644
> > > --- a/drivers/infiniband/hw/mlx5/main.c
> > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > @@ -195,12 +195,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
> > >  	case NETDEV_CHANGE:
> > >  	case NETDEV_UP:
> > >  	case NETDEV_DOWN: {
> > > -		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
> > >  		struct net_device *upper = NULL;
> > >  
> > > -		if (lag_ndev) {
> > > -			upper = netdev_master_upper_dev_get(lag_ndev);
> > > -			dev_put(lag_ndev);
> > > +		if (ibdev->lag_active) {
> > 
> > Needs locking to read lag_active
> 
> Specifically the use of the bitfield looks messed up.. If lag_active
> and some others were set only during probe it could be OK.

All fields except ib_active are static and set during probe.

> 
> But mixing other stuff that is being written concurrently is not OK to
> do like this. (eg ib_active via a mlx5 notifier)

What you are looking is the following change, did I get you right?

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9d0c56b59ed2..ee73113717b2 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1094,7 +1094,7 @@ struct mlx5_ib_dev {
        /* serialize update of capability mask
         */
        struct mutex                    cap_mask_mutex;
-       u8                              ib_active:1;
+       bool                            ib_active;
        u8                              is_rep:1;
        u8                              lag_active:1;
        u8                              wc_support:1;

> 
> Jason
