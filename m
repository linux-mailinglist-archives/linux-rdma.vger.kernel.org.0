Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4467FE8B
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jan 2023 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjA2L1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Jan 2023 06:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjA2L1O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Jan 2023 06:27:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5E87DA0;
        Sun, 29 Jan 2023 03:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551CF60C6C;
        Sun, 29 Jan 2023 11:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B310C433EF;
        Sun, 29 Jan 2023 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674991631;
        bh=oEtLzIeqqBzNIfl77J5fZ6L+u7k7eCdFxBPmp/rnweg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9/atMVtablhXzp42Tq04+Boul0es1FMiCpFmhLYWkmfwSfVlHGgjTIhnh8V7Cr/Z
         Y4LSi6HqrABsyZu25Jkc+Cvp+lLK8pApfwzibcs8kbjL7P21B6suFs1CsDCtPi9xZ+
         EV1K87SCFD3IZBvZPuEtimLM5sB6Q8kbLLbrZ8aKHVhMy8Drux5avJECXXi5rrbv21
         1xdd1q/KhL1oiq/iZ0ETL8HhZmQ5KsVjhRjmQ/Ea4FHrr5MYAaIa1GMer2gf9F7U0F
         QCkdjvKkAHvoByK4r/tYtuiCkAYkhm3GRNJFH576KVi/zK6ifqNW6yWZjO6LWHIBpC
         ct/pit0wkf1JQ==
Date:   Sun, 29 Jan 2023 13:27:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Carpenter <error27@gmail.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Message-ID: <Y9ZYC/4fEJoqV/1S@unreal>
References: <Y8/3Vn8qx00kE9Kk@kili>
 <Y9JThu/RSCGKAnTH@unreal>
 <Y9JdXfJvGhrJeLF7@kadam>
 <Y9JvrfOezthLscEP@unreal>
 <PH7PR21MB3263241A29DFFDD72A30B888CECC9@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263241A29DFFDD72A30B888CECC9@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 27, 2023 at 06:41:51AM +0000, Long Li wrote:
> > Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
> > mana_ib_create_qp_raw()
> > 
> > On Thu, Jan 26, 2023 at 02:00:45PM +0300, Dan Carpenter wrote:
> > > On Thu, Jan 26, 2023 at 12:18:46PM +0200, Leon Romanovsky wrote:
> > > > On Tue, Jan 24, 2023 at 06:20:54PM +0300, Dan Carpenter wrote:
> > > > > The "port" comes from the user and if it is zero then the:
> > > > >
> > > > > 	ndev = mc->ports[port - 1];
> > > > >
> > > > > assignment does an out of bounds read.  I have changed the if
> > > > > statement to fix this and to mirror how it is done in
> > > > > mana_ib_create_qp_rss().
> > > > >
> > > > > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft
> > > > > Azure Network Adapter")
> > > > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/mana/qp.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > > > b/drivers/infiniband/hw/mana/qp.c index ea15ec77e321..54b61930a7fd
> > > > > 100644
> > > > > --- a/drivers/infiniband/hw/mana/qp.c
> > > > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > > > @@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> > > > > *ibqp, struct ib_pd *ibpd,
> > > > >
> > > > >  	/* IB ports start with 1, MANA Ethernet ports start with 0 */
> > > > >  	port = ucmd.port;
> > > > > -	if (ucmd.port > mc->num_ports)
> > > > > +	if (port < 1 || port > mc->num_ports)
> > > >
> > > > Why do I see port in mana_ib_create_qp? It should come from ib_qp_init_attr.
> > >
> > > I am so confused by this question.  Are you asking me?
> > 
> > I asked *@microsoft folks.
> > 
> > > This is the _raw function.
> > 
> > _raw comes from QP type, it is not raw (basic) in a sense you imagine.
> > 
> > > I'm now sure what mana_ib_create_qp() has to do with it.
> > 
> > All create QP calls come through same verbs interface.
> > ib_create_qp_user->create_qp->.create_qp->mana_ib_create_qp-
> > >mana_ib_create_qp_raw
> 
> MANA requires passing a port number when creating a RAW QP on a RDMA(Ethernet) port.
> At the hardware layer, the RDMA port and ethernet port share the same hardware resources, 
> the port number needs to be known in advance when QP is created. If we don't' specify the port,
> the QP needs to take all the ports on the MANA device, some of them may have been assigned to
> Ethernet usage and can't be used for RDMA.
> 
> The reason is that unlike Nvidia CX hardware, MANA doesn't support bifurcation (for RAW QP) at the hardware level.
> [https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mellanox-bifurcated-driver-model.pdf]
> To support RAW QP on a hardware port, we need to know the port number before configuring it on the hardware.
> And Ethernet can't use this port if a RAW QP is created on it. The coordination needs to be done in software.
> 
> In production environment, there are multiple ports on the same MANA device assigned to a VM. Customer can
> configure some of the ports for Ethernet and some for RDMA/DPDK.
> 
> I have investigated using the port_num in struct ib_qp_init_attr, but it seems it can't be used for this purpose
> because the port needs to be specified by the user-mode.

And this is the most problematic part for me. I don't think that it is
RDMA user responsibility to dig in netdev port numbers.

Jason, what do you think? It looks like layering violation.

Thanks

> 
> Thanks,
> Long
> 
> > 
> > >
> > > The port comes from ib_copy_from_udata() which is just a wrapper
> > > around copy_from_user().
> > 
> > Right, and it shouldn't.
> > 
> > >
> > > regards,
> > > dan carpenter
> > >
