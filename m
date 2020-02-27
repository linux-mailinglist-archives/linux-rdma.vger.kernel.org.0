Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D2171B18
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 14:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgB0N7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 08:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732616AbgB0N7d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 08:59:33 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523A120578;
        Thu, 27 Feb 2020 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811972;
        bh=snXq7299MOd1SNY9mZKm0ZJNAu/o4Ts0lAlaZTYzQm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxwEwUZ4cxHoMFyezxjlPbyhaFv/fhKP/prdW2Hsly673StqC21gOPqeW6iz+642V
         Wj7x+vlkHsT886f933Mxzbj1XrA/g6Eyv1JO1Dl8FPgeb1QoksIJmaWgVWi4IM28C/
         2wY2MGNJu7OFVHQGSCsG+9LH8B52fGEPkK/z8o/o=
Date:   Thu, 27 Feb 2020 15:59:29 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Vladimir Koushnir <vladimirk@mellanox.com>
Cc:     Haim Boozaglo <haimbo@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200227135929.GM12414@unreal>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca>
 <20200226135749.GE12414@unreal>
 <20200226170946.GA31668@ziepe.ca>
 <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
 <20200227124937.GK12414@unreal>
 <DBAPR05MB70932DD7E5FC7DCDD71543A3CEEB0@DBAPR05MB7093.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBAPR05MB70932DD7E5FC7DCDD71543A3CEEB0@DBAPR05MB7093.eurprd05.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 12:57:31PM +0000, Vladimir Koushnir wrote:
> Ibstat dumps the current status only.
> It has nothing to do with hotplug.

Of course, print has nothing to do with hotplug, but we are talking
about general function to sort linked list of already existing devices.
The idea to sort such list in insertion means that every hotplug event
will reshuffle the list.

Thanks

>
> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> Sent: Thursday, February 27, 2020 2:50 PM
> To: Haim Boozaglo <haimbo@mellanox.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org
> Subject: Re: "ibstat -l" displays CA device list in an unsorted order
>
> On Thu, Feb 27, 2020 at 09:48:45AM +0200, Haim Boozaglo wrote:
> >
> >
> > On 2/26/2020 7:09 PM, Jason Gunthorpe wrote:
> > > On Wed, Feb 26, 2020 at 03:57:49PM +0200, Leon Romanovsky wrote:
> > > > On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
> > > > > On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
> > > > > >
> > > > > >
> > > > > > On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> > > > > > > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > When running "ibstat" or "ibstat -l", the output of CA
> > > > > > > > device list is displayed in an unsorted order.
> > > > > > > >
> > > > > > > > Before pull request #561, ibstat displayed the CA device
> > > > > > > > list sorted in alphabetical order.
> > > > > > > >
> > > > > > > > The problem is that users expect to have the output sorted
> > > > > > > > in alphabetical order and now they get it not as expected (in an unsorted order).
> > > > > > >
> > > > > > > Really? Why? That doesn't look like it should happen, the
> > > > > > > list is constructed out of readdir() which should be sorted?
> > > > > > >
> > > > > > > Do you know where this comes from?
> > > > > > >
> > > > > > > Jason
> > > > > > >
> > > > > >
> > > > > > readdir() gives us struct by struct and doesn't keep on alphabetical order.
> > > > > > Before pull request #561 ibstat have used this API of libibumad:
> > > > > > int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
> > > > > >
> > > > > > This API used this function:
> > > > > > n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> > > > > >
> > > > > > scandir() can return a sorted CA device list in alphabetical order.
> > > > >
> > > > > Oh what a weird unintended side effect.
> > > > >
> > > > > Resolving it would require adding a sorting pass on a linked
> > > > > list.. Will you try?
> > > >
> > > > Please be aware that once ibstat will be converted to netlink, the
> > > > order will change again.
> > >
> > > This is why I suggest a function to sort the linked list that tools
> > > needing sorted order can call. Then it doesn't matter how we got the
> > > list
> > >
> > > Jason
> > >
> >
> > I can just sort the list at the time of insertion of each node.
>
> Will you "resort" your list in the hotplug event?
>
> Thanks
>
> >
> > Haim.
