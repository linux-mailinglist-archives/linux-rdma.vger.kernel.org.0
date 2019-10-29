Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC104E7F63
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 05:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfJ2Eyx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 00:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbfJ2Eyx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 00:54:53 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561572086A;
        Tue, 29 Oct 2019 04:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572324892;
        bh=FJYlDkTaFNG4HFBlzA479pdefGVFqg041Eq1V5zQpe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQ2qnmMLcthN1PCk+DNP18GV6Uf/XRv91/EyNYJP/03rSKyMBofJFdU6hIkI6G1k6
         xHV3N8fn8WwJHLvX2yxiaAsXK36qMSjWcJw69VHD32UQrYYXF6oyVvf6T1MbwpbuiI
         wT/oVIMhbkdr6jon9VZCOhKvY8GO+aJvjyioVkfQ=
Date:   Tue, 29 Oct 2019 06:54:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Subject: Re: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191029045447.GA5545@unreal>
References: <20191027052111.GW4853@unreal>
 <20191004174804.GF13988@ziepe.ca>
 <20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
 <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
 <OF7628E460.D6869428-ON002584A1.003AE367-002584A1.00455D5D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7628E460.D6869428-ON002584A1.003AE367-002584A1.00455D5D@notes.na.collabserv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 12:37:38PM +0000, Bernard Metzler wrote:
> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Leon Romanovsky" <leon@kernel.org>
> >Date: 10/27/2019 06:21AM
> >Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
> >bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
> >bvanassche@acm.org
> >Subject: [EXTERNAL] Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix
> >SQ/RQ drain logic
> >
> >On Fri, Oct 25, 2019 at 12:11:16PM +0000, Bernard Metzler wrote:
> >> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
> >>
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 10/04/2019 07:48PM
> >> >Cc: "Leon Romanovsky" <leon@kernel.org>,
> >linux-rdma@vger.kernel.org,
> >> >bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
> >> >bvanassche@acm.org
> >> >Subject: [EXTERNAL] Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix
> >SQ/RQ
> >> >drain logic
> >> >
> >> >On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
> >> >> <...>
> >> >>
> >> >> >>   *
> >> >> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp,
> >> >const
> >> >> >struct ib_send_wr *wr,
> >> >> >>  	unsigned long flags;
> >> >> >>  	int rv = 0;
> >> >> >>
> >> >> >> +	if (wr && !qp->kernel_verbs) {
> >> >> >
> >> >> >It is not related to this specific patch, but all siw
> >> >"kernel_verbs"
> >> >> >should go, we have standard way to distinguish between kernel
> >and
> >> >> >user
> >> >> >verbs.
> >> >> >
> >> >> >Thanks
> >> >> >
> >> >> Understood. I think we touched on that already.
> >> >> rdma core objects have a uobject pointer which
> >> >> is valid only if it belongs to a user land
> >> >> application. We might better use that.
> >> >
> >> >No, the uobject pointer is not to be touched by drivers
> >> >
> >> Now what would be the appropriate way of remembering/
> >> detecting user level nature of endpoint resources?
> >> I see drivers _are_ doing 'if (!ibqp->uobject)' ...
> >
> >IMHO, you should rely in "udata" to distinguish user/kernel objects.
> >
>
> right, we already do that at resource creation time, when
> 'udata' is available.  But there is no such parameter
> around during resource access (post_send/post_recv/poll_cq/...),
> when user land or kernel land application specific
> code might be required.
> That's why siw currently saves that info to a resource
> (QP/CQ/SRQ) specific parameter 'kernel_verbs'. I agree
> this parameter is redundant, if the rdma core object
> provides that information as well. The only way I see
> it provided is the validity of the uobject pointer of
> all those resources.
> Either (1) we use that uobject pointer as an indication
> of application location, or (2) we remember it from
> resource creation time when udata was available, or
> (3) we have the rdma core exporting that information
> explicitly.
> siw, and other drivers, are currently implementing (2).
> Some drivers implement (1). I'd be happy to change siw
> to implement (1) - to get rid of 'kernel_verbs'.

Many if not all "kernel_verbs" variables are copy/paste.
The usual way to handle difference in internal flows is to
rely on having pointer initialized, e.g.
if (siw_device->some_specific_kernel_pointer)
 do_kernelwork(siw_device->some_specific_kernel_pointer->extra)

Thanks

>
> Thanks and best regards,
> Bernard.
>
>
>
>
> >>
> >> Other drivers keep it with the private state, like iw40,
> >> but I learned we shall get rid of it.
> >>
> >> We may export an inline query from RDMA core, or simply
> >> #define is_usermode(ib_obj *) (ib_obj->uobject != NULL)
> >> ?
> >>
> >> Thanks and best regards,
> >> Bernard
> >>
> >
> >
>
