Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F166877AD
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBBIj1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 03:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjBBIj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 03:39:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D137C316;
        Thu,  2 Feb 2023 00:39:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F0E2B82527;
        Thu,  2 Feb 2023 08:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87164C43442;
        Thu,  2 Feb 2023 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675327162;
        bh=wzKUkVCJCO/oGRtpBDbUTJ2aEswSrBNW52fyN0531Mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0XTxONHSH6MXmd8eSJ04/p4mUWkxXkAUwphC4hf80smxS4hj7ceyDD0hrU6Ht38l
         vb6aA0jpVZqJd3oOcQ4EkdzfV0+7RPNQPD3imRPqYZqY0j7wD/qlbuFxI42m/vG0aL
         /fD28MeCB0EZ+HwyHZ1f2NvuOecEYjnPZDeIiBJz5KxTLfViZYFNdRmvAdvJY0z7ua
         FaQO539lJO7vrYULzNKmtmV+Pzy2iORM8bHxTmelaN+/o+EjhO76gu5EzJ1JX9yCio
         1reXKM854INH0tgwFy4m0TxUDiGZimds2YrNBNLDMd8+RXh1uLSSYVqTCTruJRin38
         Xorlf/5zjsP8w==
Date:   Thu, 2 Feb 2023 10:39:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Carpenter <error27@gmail.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Message-ID: <Y9t2tfNHhrz2uKBK@unreal>
References: <Y8/3Vn8qx00kE9Kk@kili>
 <Y9JThu/RSCGKAnTH@unreal>
 <Y9JdXfJvGhrJeLF7@kadam>
 <Y9JvrfOezthLscEP@unreal>
 <PH7PR21MB3263241A29DFFDD72A30B888CECC9@PH7PR21MB3263.namprd21.prod.outlook.com>
 <Y9ZYC/4fEJoqV/1S@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ZYC/4fEJoqV/1S@unreal>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 29, 2023 at 01:27:07PM +0200, Leon Romanovsky wrote:
> On Fri, Jan 27, 2023 at 06:41:51AM +0000, Long Li wrote:
> > > Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
> > > mana_ib_create_qp_raw()
> > > 
> > > On Thu, Jan 26, 2023 at 02:00:45PM +0300, Dan Carpenter wrote:
> > > > On Thu, Jan 26, 2023 at 12:18:46PM +0200, Leon Romanovsky wrote:
> > > > > On Tue, Jan 24, 2023 at 06:20:54PM +0300, Dan Carpenter wrote:
> > > > > > The "port" comes from the user and if it is zero then the:
> > > > > >
> > > > > > 	ndev = mc->ports[port - 1];
> > > > > >
> > > > > > assignment does an out of bounds read.  I have changed the if
> > > > > > statement to fix this and to mirror how it is done in
> > > > > > mana_ib_create_qp_rss().
> > > > > >
> > > > > > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft
> > > > > > Azure Network Adapter")
> > > > > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > > > > ---
> > > > > >  drivers/infiniband/hw/mana/qp.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > > > > b/drivers/infiniband/hw/mana/qp.c index ea15ec77e321..54b61930a7fd
> > > > > > 100644
> > > > > > --- a/drivers/infiniband/hw/mana/qp.c
> > > > > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > > > > @@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> > > > > > *ibqp, struct ib_pd *ibpd,
> > > > > >
> > > > > >  	/* IB ports start with 1, MANA Ethernet ports start with 0 */
> > > > > >  	port = ucmd.port;
> > > > > > -	if (ucmd.port > mc->num_ports)
> > > > > > +	if (port < 1 || port > mc->num_ports)
> > > > >
> > > > > Why do I see port in mana_ib_create_qp? It should come from ib_qp_init_attr.
> > > >
> > > > I am so confused by this question.  Are you asking me?
> > > 
> > > I asked *@microsoft folks.
> > > 
> > > > This is the _raw function.
> > > 
> > > _raw comes from QP type, it is not raw (basic) in a sense you imagine.
> > > 
> > > > I'm now sure what mana_ib_create_qp() has to do with it.
> > > 
> > > All create QP calls come through same verbs interface.
> > > ib_create_qp_user->create_qp->.create_qp->mana_ib_create_qp-
> > > >mana_ib_create_qp_raw
> > 
> > MANA requires passing a port number when creating a RAW QP on a RDMA(Ethernet) port.
> > At the hardware layer, the RDMA port and ethernet port share the same hardware resources, 
> > the port number needs to be known in advance when QP is created. If we don't' specify the port,
> > the QP needs to take all the ports on the MANA device, some of them may have been assigned to
> > Ethernet usage and can't be used for RDMA.
> > 
> > The reason is that unlike Nvidia CX hardware, MANA doesn't support bifurcation (for RAW QP) at the hardware level.
> > [https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mellanox-bifurcated-driver-model.pdf]
> > To support RAW QP on a hardware port, we need to know the port number before configuring it on the hardware.
> > And Ethernet can't use this port if a RAW QP is created on it. The coordination needs to be done in software.
> > 
> > In production environment, there are multiple ports on the same MANA device assigned to a VM. Customer can
> > configure some of the ports for Ethernet and some for RDMA/DPDK.
> > 
> > I have investigated using the port_num in struct ib_qp_init_attr, but it seems it can't be used for this purpose
> > because the port needs to be specified by the user-mode.
> 
> And this is the most problematic part for me. I don't think that it is
> RDMA user responsibility to dig in netdev port numbers.

ok, I don't like it, but bug is here, let's fix it.

> 
> Jason, what do you think? It looks like layering violation.
> 
> Thanks
> 
> > 
> > Thanks,
> > Long
> > 
> > > 
> > > >
> > > > The port comes from ib_copy_from_udata() which is just a wrapper
> > > > around copy_from_user().
> > > 
> > > Right, and it shouldn't.
> > > 
> > > >
> > > > regards,
> > > > dan carpenter
> > > >
