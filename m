Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA717B307B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjI2Kd0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjI2Kc6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 06:32:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEC30D2;
        Fri, 29 Sep 2023 03:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B69C433CB;
        Fri, 29 Sep 2023 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695983481;
        bh=FyI+dsOnH/X0cysENP+nRu+CcEkiY7j5v+DUffXIqF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBkRbsUgS6sPs0g6v3EbGO76TB3RYjCfrxy69B+PQkFKoM/0hO2i2K9//UxF2jh/b
         N1lG/1RxBDao8JTpRyHUxO14W/nS7H6hoA5moeDVWyrlvF/LgM6ifsGlmEXGfw+ZOS
         qT2wrRdOas14L5g9bMEVQMT9YJl+sdWCaHcQepKdQtfqlzWmnbBm+B/b13x5k5in5P
         rsGapN0L7+bB3L9hhKuWGL7ozebFM4+TeaYe7jFxJP+F11lVRQ0TZI2xS79hcdv1ih
         6oEFeMCmfUxD8RWS12Tu+q5Ie2gakLQxX/MOpIJqkrpdBNEn56iwmIBBFkyJsGkdZe
         UHO32dq8sYP1g==
Date:   Fri, 29 Sep 2023 13:31:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH net] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <20230929103117.GB1296942@unreal>
References: <20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com>
 <20230928175959.GU1642130@unreal>
 <a1f8b9f8c2f9aecde8ac17831b66f72319bf425a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f8b9f8c2f9aecde8ac17831b66f72319bf425a.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 29, 2023 at 11:40:49AM +0200, Niklas Schnelle wrote:
> On Thu, 2023-09-28 at 20:59 +0300, Leon Romanovsky wrote:
> > On Thu, Sep 28, 2023 at 03:55:47PM +0200, Niklas Schnelle wrote:
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
> > > enforces DMA masks. Fix this by switching the order of the
> > > mlx5_mdev_init() and mlx5_pci_init() in probe_one().
> > > 
> > > Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
> > > Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > Note: I ran into this while testing the linked series for converting
> > > s390x to use dma-iommu. The existing s390x specific DMA API
> > > implementation doesn't respect DMA masks and is thus not affected
> > > despite of course also only supporting DMA addresses above 4 GiB.
> > > That said ConnectX VFs are the primary users of native PCI on s390x and
> > > we'd really like to get the DMA API conversion into v6.7 so this has
> > > high priority for us.
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/main.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > > index 15561965d2af..06744dedd928 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > > @@ -1908,10 +1908,6 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  		goto adev_init_err;
> > >  	}
> > >  
> > > -	err = mlx5_mdev_init(dev, prof_sel);
> > > -	if (err)
> > > -		goto mdev_init_err;
> > > -
> > >  	err = mlx5_pci_init(dev, pdev, id);
> > >  	if (err) {
> > >  		mlx5_core_err(dev, "mlx5_pci_init failed with error code %d\n",
> > > @@ -1919,6 +1915,10 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  		goto pci_init_err;
> > >  	}
> > >  
> > > +	err = mlx5_mdev_init(dev, prof_sel);
> > > +	if (err)
> > > +		goto mdev_init_err;
> > > +
> > 
> > I had something different in mind as I'm worry that call to pci_enable_device()
> > in mlx5_pci_init() before we finished FW command interface initialization is a bit
> > premature.
> > 
> > What about the following patch?
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > index 15561965d2af..31f1d701116a 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > @@ -905,12 +905,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
> >  
> >         pci_set_master(pdev);
> >  
> > -       err = set_dma_caps(pdev);
> > -       if (err) {
> > -               mlx5_core_err(dev, "Failed setting DMA capabilities mask, aborting\n");
> > -               goto err_clr_master;
> > -       }
> > -
> >         if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
> >             pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
> >             pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
> > @@ -1908,9 +1902,15 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
> >                 goto adev_init_err;
> >         }
> >  
> > +       err = set_dma_caps(pdev);
> > +       if (err) {
> > +               mlx5_core_err(dev, "Failed setting DMA capabilities mask, aborting\n");
> > +               goto dma_cap_err;
> > +       }
> > +
> >         err = mlx5_mdev_init(dev, prof_sel);
> >         if (err)
> > -               goto mdev_init_err;
> > +               goto dma_cap_err;
> >  
> >         err = mlx5_pci_init(dev, pdev, id);
> >         if (err) {
> > @@ -1942,7 +1942,7 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
> >         mlx5_pci_close(dev);
> >  pci_init_err:
> >         mlx5_mdev_uninit(dev);
> > -mdev_init_err:
> > +dma_cap_err:
> >         mlx5_adev_idx_free(dev->priv.adev_idx);
> >  adev_init_err:
> >         mlx5_devlink_free(devlink);
> > 
> > Thanks
> 
> The above works too. Maybe for consistency within probe_one() it would
> then make sense to also rename set_dma_caps() to mlx5_dma_init()?

Sounds great, thanks

BTW, I was informed offlist that Saeed also has fix to this issue,
but I don't know if he wants to progress with that fix as it has wrong
RCA in commit message and as an outcome of that much complex solution,
which is not necessary.

So I would be happy to see your patch with mlx5_dma_init().

Thanks

> 
> Thanks,
> Niklas
