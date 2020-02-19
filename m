Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2784F164319
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBSLNR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 06:13:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36356 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBSLNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 06:13:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so44675wru.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 03:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RyJW27hSCcsJKKMLQWuyuSb+TqLo4Bq+Lac4a7MICtw=;
        b=WvD6Bt0pFtkRTcy5rhGHguR+eYQZmPFHrPm3M1r9AosaeVtUnyq0mwkDf3IOo3Qzgi
         wmg1T2rnf7EG/amgJhcJAwI0WZZX5wY3mu49GzsdM18r8kYEpytdqbvZqZAiZWQ/sna+
         ch0JgyoUPoAz0j3HtG6BKsOcw994YLDWMt83Tkd3Geo/qcv3SjghB7s24F0eiLs8/VAi
         Mv5q2z1Et2DLbJwpEFJdCNltwyJujsJlpT8ShJVs+k4Y8Wvu9L7AeBBltmgwJeH5yx+a
         lv2G4A0JYLierpgMLEGqZXNOHW1IJex4ZcRt/y1sycXq/KklSajmyfLPIQsPzOccFQdX
         45jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RyJW27hSCcsJKKMLQWuyuSb+TqLo4Bq+Lac4a7MICtw=;
        b=Y/oUp+92YdljcEEIbQ1XSSe15sqDx04khG7FUak/C6K03/89pEWxtPdWOfGQ++Pz3Y
         3/yO2PDGINtFhjw2Jv9Id+ciu+WSXYdHw444xoEG77lkWlLx8agWYJQ9NnpvwOTL7OTo
         DwYjy6un7onMPgFAtRz9zaZRtE0m5TJ7VzhYEoqbtSvtpAPsevKDJWroM5RH8L/wyagT
         JLmTEVmnJLlW7NZhonWxLBJJuF+ODArF5cpEzosD9E9xpweDmqMiruyI5xw8a0pk4lML
         RDVb/U2AgZ/DfC0voFq2UxMSEqoJ1vNHiwDu2yDvdvcAZX9NBpc0+2uDBdRhSF2wCoQK
         wABQ==
X-Gm-Message-State: APjAAAXBdovU8IDEFURPkXii0XKP9gADsIcAcGcHnNworjY4jacJ2J4i
        ++SxKHUQ2yrM4bfS9Cly77w=
X-Google-Smtp-Source: APXvYqzGhn8FMyUILNt1lcBlzybjTDEwW99QdaLQ7sj0wKpj6Al5yMMoTQf86AvtWu4zIuknZJvKDw==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr33936562wrn.133.1582110794595;
        Wed, 19 Feb 2020 03:13:14 -0800 (PST)
Received: from kheib-workstation (bzq-109-65-128-51.red.bezeqint.net. [109.65.128.51])
        by smtp.gmail.com with ESMTPSA id x21sm2383589wmi.30.2020.02.19.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 03:13:14 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:13:11 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200219111311.GA15804@kheib-workstation>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
 <20200218165847.GA15239@unreal>
 <20200219084359.GA12296@kheib-workstation>
 <20200219093321.GI15239@unreal>
 <20200219102110.GA13582@kheib-workstation>
 <20200219105320.GJ15239@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219105320.GJ15239@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 12:53:20PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 19, 2020 at 12:21:10PM +0200, Kamal Heib wrote:
> > On Wed, Feb 19, 2020 at 11:33:21AM +0200, Leon Romanovsky wrote:
> > > On Wed, Feb 19, 2020 at 10:43:59AM +0200, Kamal Heib wrote:
> > > > On Tue, Feb 18, 2020 at 06:58:47PM +0200, Leon Romanovsky wrote:
> > > > > On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
> > > > > > Make sure to set the active_{speed, width} attributes to avoid reporting
> > > > > > the same values regardless of the underlying device.
> > > > > >
> > > > > > Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> > > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > > ---
> > > > > > V2: Change rc to rv.
> > > > > > ---
> > > > > >  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> > > > > > index 73485d0da907..d5390d498c61 100644
> > > > > > --- a/drivers/infiniband/sw/siw/siw_verbs.c
> > > > > > +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> > > > > > @@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
> > > > > >  		   struct ib_port_attr *attr)
> > > > > >  {
> > > > > >  	struct siw_device *sdev = to_siw_dev(base_dev);
> > > > > > +	int rv;
> > > > > >
> > > > > >  	memset(attr, 0, sizeof(*attr));
> > > > >
> > > > > This line should go too. IB/core clears attr prior to call driver.
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > > > This can be done in a separate patch as this patch fixes a specific issue.
> > >
> > > Whatever works for you, if you don't value your own time, go for it,
> > > do separate patch for every line you are changing. It just looks crazy
> > > to see changes like this:
> > >  * changed line
> > >  * line to be changed, but not changed
> > >  * another changed line
> > >
> > > Thanks
> > >
> >
> > Leon, With all my respect, This isn't your decision what I do and when.
> 
> Please carefully reread my answer, I didn't say what and when you should
> do, simply gave to you an explanation why request remove useless memeset
> makes sense in the context of proposed patch.
> 
> Thanks

I simply give an answer to why I think otherwise, That doesn't mean that
I don't value my own time...

Thanks,
Kamal

