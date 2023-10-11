Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522FB7C5B81
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjJKSpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJKSpH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 14:45:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7C93;
        Wed, 11 Oct 2023 11:45:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B9C433C8;
        Wed, 11 Oct 2023 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697049905;
        bh=XmDRLNzf5ytup1OHHRhzK/7qdpPUABDvfVb5lSUbBvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/QrI7GZn6oHHjq6PL22tcl8Sx1ZdlgCkfUrjIb19TSlbDsnEBtDNJ3smo7as5tYU
         emulSWHR3dGL6nR6JaBFNncgAmky8cuQtu46LY9GU07tCurXHHyDXtmMMWKZPoXPVq
         l06QWtV2RfNEfzCOv5KkFzGXKjhj3mig6ZLBXHLZcqZOZ7oyw3O8umfDZI7IxIhNEN
         BVbfWWFsE38jzhOnFkbP/xUqHVRsxBdlUMWdBWf+URHMsS1NyCOe8MlCVA3YihKR1H
         qC/K189+DjY3Rl6QGSzdRoutEXypQICXa+0LNIVtKlJE56kyy7Ms4lNIcXRIbl1ckH
         WpV3mw1PFQMqA==
Date:   Wed, 11 Oct 2023 11:45:04 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <ZSbtMO8AWLx29RBS@x130>
References: <20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com>
 <20230928175959.GU1642130@unreal>
 <a1f8b9f8c2f9aecde8ac17831b66f72319bf425a.camel@linux.ibm.com>
 <20230929103117.GB1296942@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230929103117.GB1296942@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29 Sep 13:31, Leon Romanovsky wrote:
>On Fri, Sep 29, 2023 at 11:40:49AM +0200, Niklas Schnelle wrote:
>> On Thu, 2023-09-28 at 20:59 +0300, Leon Romanovsky wrote:
>> > On Thu, Sep 28, 2023 at 03:55:47PM +0200, Niklas Schnelle wrote:
>> > > Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
>> > > reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
>> > > called in probe_one() before mlx5_pci_init(). This is a problem because
>> > > mlx5_pci_init() is where the DMA and coherent mask is set but
>> > > mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
>> > > allocation is done during probe before the correct mask is set. This
>> > > causes probe to fail initialization of the cmdif SW structs on s390x
>> > > after that is converted to the common dma-iommu code. This is because on
>> > > s390x DMA addresses below 4 GiB are reserved on current machines and
>> > > unlike the old s390x specific DMA API implementation common code
>> > > enforces DMA masks. Fix this by switching the order of the
>> > > mlx5_mdev_init() and mlx5_pci_init() in probe_one().
>> > >
>> > > Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
>> > > Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
>> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> > > ---
>> > > Note: I ran into this while testing the linked series for converting
>> > > s390x to use dma-iommu. The existing s390x specific DMA API
>> > > implementation doesn't respect DMA masks and is thus not affected
>> > > despite of course also only supporting DMA addresses above 4 GiB.
>> > > That said ConnectX VFs are the primary users of native PCI on s390x and
>> > > we'd really like to get the DMA API conversion into v6.7 so this has
>> > > high priority for us.
>> > > ---
>> > >  drivers/net/ethernet/mellanox/mlx5/core/main.c | 12 ++++++------
>> > >  1 file changed, 6 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > > index 15561965d2af..06744dedd928 100644
>> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > > @@ -1908,10 +1908,6 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>> > >  		goto adev_init_err;
>> > >  	}
>> > >
>> > > -	err = mlx5_mdev_init(dev, prof_sel);
>> > > -	if (err)
>> > > -		goto mdev_init_err;
>> > > -
>> > >  	err = mlx5_pci_init(dev, pdev, id);
>> > >  	if (err) {
>> > >  		mlx5_core_err(dev, "mlx5_pci_init failed with error code %d\n",
>> > > @@ -1919,6 +1915,10 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>> > >  		goto pci_init_err;
>> > >  	}
>> > >
>> > > +	err = mlx5_mdev_init(dev, prof_sel);
>> > > +	if (err)
>> > > +		goto mdev_init_err;
>> > > +
>> >
>> > I had something different in mind as I'm worry that call to pci_enable_device()
>> > in mlx5_pci_init() before we finished FW command interface initialization is a bit
>> > premature.
>> >
>> > What about the following patch?
>> >
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > index 15561965d2af..31f1d701116a 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > @@ -905,12 +905,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
>> >
>> >         pci_set_master(pdev);
>> >
>> > -       err = set_dma_caps(pdev);
>> > -       if (err) {
>> > -               mlx5_core_err(dev, "Failed setting DMA capabilities mask, aborting\n");
>> > -               goto err_clr_master;
>> > -       }
>> > -
>> >         if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
>> >             pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
>> >             pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
>> > @@ -1908,9 +1902,15 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>> >                 goto adev_init_err;
>> >         }
>> >
>> > +       err = set_dma_caps(pdev);
>> > +       if (err) {
>> > +               mlx5_core_err(dev, "Failed setting DMA capabilities mask, aborting\n");
>> > +               goto dma_cap_err;
>> > +       }
>> > +
>> >         err = mlx5_mdev_init(dev, prof_sel);
>> >         if (err)
>> > -               goto mdev_init_err;
>> > +               goto dma_cap_err;
>> >
>> >         err = mlx5_pci_init(dev, pdev, id);
>> >         if (err) {
>> > @@ -1942,7 +1942,7 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>> >         mlx5_pci_close(dev);
>> >  pci_init_err:
>> >         mlx5_mdev_uninit(dev);
>> > -mdev_init_err:
>> > +dma_cap_err:
>> >         mlx5_adev_idx_free(dev->priv.adev_idx);
>> >  adev_init_err:
>> >         mlx5_devlink_free(devlink);
>> >
>> > Thanks
>>
>> The above works too. Maybe for consistency within probe_one() it would
>> then make sense to also rename set_dma_caps() to mlx5_dma_init()?
>
>Sounds great, thanks
>
>BTW, I was informed offlist that Saeed also has fix to this issue,
>but I don't know if he wants to progress with that fix as it has wrong
>RCA in commit message and as an outcome of that much complex solution,
>which is not necessary.
>
>So I would be happy to see your patch with mlx5_dma_init().
>
>Thanks
>

Actually I prefer the internal patch, it moves the dma parts out of
mlx5_cmd_init() into mlx5_cmd_enable() which happens after dma caps are
set. since it is using the current mlx5 function structure and breakdown, 
I prefer it over adding new function to the driver.

I will share the patch, I will let Niklas test it and approve it before
submission.

Thanks,
Saeed.

>
