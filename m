Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E771E9C82
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 06:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFAEYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 00:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAEYi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jun 2020 00:24:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BF7206C3;
        Mon,  1 Jun 2020 04:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590985478;
        bh=CcihwOi33H58gACHQydbUlf/YXb8ng4PMSUzQxTNo/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sI8bjV1juLcx7HCE6JKpD2qOX6UHa7neny40GvwvGdoIa2au5XIlHeYTyaYIGgE3K
         MhHvlamF8ooBEBh6D8saTYN18HUYIM/HBdaOVmzc028Gw3qiZ5zLJn2gHOlbS7mkwn
         8pmXmpicID9puWU4OOVhANM7mlwCumtNWyRhTv6A=
Date:   Mon, 1 Jun 2020 07:24:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Message-ID: <20200601042433.GA34024@unreal>
References: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200530140224.GA1330098@mwanda>
 <20200531100512.GH66309@unreal>
 <20200531173655.GT22511@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531173655.GT22511@kadam>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 31, 2020 at 08:36:55PM +0300, Dan Carpenter wrote:
> On Sun, May 31, 2020 at 01:05:12PM +0300, Leon Romanovsky wrote:
> > On Sat, May 30, 2020 at 05:02:24PM +0300, Dan Carpenter wrote:
> > > The hfi1_vnic_up() function doesn't check whether hfi1_netdev_rx_init()
> > > returns errors.  In hfi1_vnic_init() we need to change the code to
> > > preserve the error code instead of returning success.
> > >
> > > Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
> > > Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > v2: Add error handling in hfi1_vnic_up() and add second fixes tag
> > >
> > >  drivers/infiniband/hw/hfi1/vnic_main.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
> > > index b183c56b7b6a4..03f8be8e9488e 100644
> > > --- a/drivers/infiniband/hw/hfi1/vnic_main.c
> > > +++ b/drivers/infiniband/hw/hfi1/vnic_main.c
> > > @@ -457,13 +457,19 @@ static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
> > >  	if (rc < 0)
> > >  		return rc;
> > >
> > > -	hfi1_netdev_rx_init(dd);
> > > +	rc = hfi1_netdev_rx_init(dd);
> > > +	if (rc < 0)
> > > +		goto err_remove;
> >
> > Why did you check for the negative value here and didn't check below?
> >
>
> I just copied the pattern in the nearest code.  I didn't realize until
> now that it was different in both functions...  The checking isn't done
> consistently in this file.
>
> I can resend on Tuesday though if you want.

I imagine that Jason will fix it once he will apply the patch.

Thanks

>
> regards,
> dan carpenter
>
