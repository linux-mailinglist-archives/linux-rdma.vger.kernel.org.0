Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3727B8B48
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbjJDSvf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243740AbjJDSve (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 14:51:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA9C1;
        Wed,  4 Oct 2023 11:51:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F0EC433C8;
        Wed,  4 Oct 2023 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445491;
        bh=0T+eb7tm4aVFcyKtRjbpTFX3g8MsS2qHFYW8zwU9ucs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQhpZsK6hBj1e7Yft08HWJGHu5zKZXm1CkdGXn4CRW9uWLyt4hJ+7c4Nd5uIzr4+c
         sX6o7rxpQ3zNQAZ5ya5Hfp+urWyvg42+U0jPfuBmYp137ewWzRYRb4kNMMizWD+0Ts
         8pUUa6eYHmdLDFhNSUEMQSgLGfvrjiwhYtbyN9mGCpNhRXMoIQ/6PsAFqbh0/40r9I
         lzYhPcc7Ut+793oi2vEO02RRb5M/WGpPnTr0nKsX8u6N/G9BwCutOj4EragAK70AYS
         Yt5/qJAfiop5C4WJ4+r3elS0Jt9enLorA7hR+C9g4epblyM4oY6jbs3A006Oo/9aGZ
         RiuNzFc5fR80Q==
Date:   Wed, 4 Oct 2023 21:51:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <20231004185127.GH51282@unreal>
References: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>
 <20230930073633.GC1296942@unreal>
 <1acfaaf12d1d24aa255a4da80882f8e0e98d2046.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1acfaaf12d1d24aa255a4da80882f8e0e98d2046.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 04, 2023 at 02:40:49PM +0200, Niklas Schnelle wrote:
> On Sat, 2023-09-30 at 10:36 +0300, Leon Romanovsky wrote:
> > On Fri, Sep 29, 2023 at 02:15:49PM +0200, Niklas Schnelle wrote:
> > > Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
> > > reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
> > > called in probe_one() before mlx5_pci_init(). This is a problem because
> > > mlx5_pci_init() is where the DMA and coherent mask is set but
> > > mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
> > > allocation is done during probe before the correct mask is set. This
> > > causes probe to fail initialization of the cmdif SW structs on s390x
> > > after that is converted to the common dma-iommu code. This is because on
> > > s390x DMA addresses below 4 GiB are reserved on current machines and
> > > unlike the old s390x specific DMA API implementation common code
> > > enforces DMA masks.
> > > 
> > > Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
> > > probe_one() before mlx5_mdev_init(). To match the overall naming scheme
> > > rename it to mlx5_dma_init().
> > > 
> > > Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
> > > Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > Note: I ran into this while testing the linked series for converting
> > > s390x to use dma-iommu. The existing s390x specific DMA API
> > > implementation doesn't respect DMA masks and is thus not affected
> > > despite of course also only supporting DMA addresses above 4 GiB.
> > > ---
> > > Changes in v2:
> > > - Instead of moving the whole mlx5_pci_init() only move the
> > >   set_dma_caps() call so as to keep pci_enable_device() after the FW
> > >   command interface initialization (Leon)
> > > - Link to v1: https://lore.kernel.org/r/20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/main.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > 
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Thank you for the review. Assuming the mlx5 tree is included in linux-
> next I think it would be easiest if this goes via that tree thereby
> unbreaking linux-next for s390. Or do you prefer Joerg to take this via
> the IOMMU tree or even some other tree?

Strictly speaking this is net patch, netdev maintainers should pick it.
We use mlx5 tree [1] for *-next material.

Thanks

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/

> 
> Thanks,
> Niklas
