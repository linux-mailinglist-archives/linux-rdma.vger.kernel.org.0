Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDA170091
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgBZN5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 08:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgBZN5w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 08:57:52 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A09042467B;
        Wed, 26 Feb 2020 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582725471;
        bh=XgwNi2pGTQGnshv0k0m5gJ0yXUmSyZYqwZHo0xuQ4uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5L3AARifoVUQDV9ECdqShhAsL1TlFDwh88e6oLVaObX6EdyG/xMISnfBDVxH9M1a
         r3VEKlfbBeZBpHQ4BnxtnuyJnCih/MR0ndAt0yJUv3/BQzPye0D/14dgfa4rNGWe4V
         jAFcTisLgPVxkThYwhsA1jnTkSwL5nGFIr5B01zA=
Date:   Wed, 26 Feb 2020 15:57:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Haim Boozaglo <haimbo@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200226135749.GE12414@unreal>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226134310.GX31668@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
> >
> >
> > On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> > > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > > Hi all,
> > > >
> > > > When running "ibstat" or "ibstat -l", the output of CA device list
> > > > is displayed in an unsorted order.
> > > >
> > > > Before pull request #561, ibstat displayed the CA device list sorted in
> > > > alphabetical order.
> > > >
> > > > The problem is that users expect to have the output sorted in alphabetical
> > > > order and now they get it not as expected (in an unsorted order).
> > >
> > > Really? Why? That doesn't look like it should happen, the list is
> > > constructed out of readdir() which should be sorted?
> > >
> > > Do you know where this comes from?
> > >
> > > Jason
> > >
> >
> > readdir() gives us struct by struct and doesn't keep on alphabetical order.
> > Before pull request #561 ibstat have used this API of libibumad:
> > int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
> >
> > This API used this function:
> > n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> >
> > scandir() can return a sorted CA device list in alphabetical order.
>
> Oh what a weird unintended side effect.
>
> Resolving it would require adding a sorting pass on a linked
> list.. Will you try?

Please be aware that once ibstat will be converted to netlink, the order
will change again.

Thanks

>
> Jason
