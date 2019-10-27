Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A218E6091
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 06:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfJ0FVT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 01:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJ0FVT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 01:21:19 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF3120663;
        Sun, 27 Oct 2019 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572153678;
        bh=WI80wLeSWXgk/wKUoS9fAjeB8Z11vhijN7lFtnEYu/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQPY/8czG8nadi3jI731/FiS7ss6Qej73Ojs7uUMJpaF5KfV8DEkg1HVt6+jYrHDp
         1fh9HnoWDa6r9JQ6xwEifpF0qLfFRDelg0X90I5A4RN93D5ANyeSxsWD242kgLRMIW
         be5C3aHv0pD9eyjumwFjzUuzY8DOhC4w7uyyuiSk=
Date:   Sun, 27 Oct 2019 07:21:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Subject: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191027052111.GW4853@unreal>
References: <20191004174804.GF13988@ziepe.ca>
 <20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
 <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 12:11:16PM +0000, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 10/04/2019 07:48PM
> >Cc: "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org,
> >bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
> >bvanassche@acm.org
> >Subject: [EXTERNAL] Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ
> >drain logic
> >
> >On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
> >> <...>
> >>
> >> >>   *
> >> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp,
> >const
> >> >struct ib_send_wr *wr,
> >> >>  	unsigned long flags;
> >> >>  	int rv = 0;
> >> >>
> >> >> +	if (wr && !qp->kernel_verbs) {
> >> >
> >> >It is not related to this specific patch, but all siw
> >"kernel_verbs"
> >> >should go, we have standard way to distinguish between kernel and
> >> >user
> >> >verbs.
> >> >
> >> >Thanks
> >> >
> >> Understood. I think we touched on that already.
> >> rdma core objects have a uobject pointer which
> >> is valid only if it belongs to a user land
> >> application. We might better use that.
> >
> >No, the uobject pointer is not to be touched by drivers
> >
> Now what would be the appropriate way of remembering/
> detecting user level nature of endpoint resources?
> I see drivers _are_ doing 'if (!ibqp->uobject)' ...

IMHO, you should rely in "udata" to distinguish user/kernel objects.

>
> Other drivers keep it with the private state, like iw40,
> but I learned we shall get rid of it.
>
> We may export an inline query from RDMA core, or simply
> #define is_usermode(ib_obj *) (ib_obj->uobject != NULL)
> ?
>
> Thanks and best regards,
> Bernard
>
