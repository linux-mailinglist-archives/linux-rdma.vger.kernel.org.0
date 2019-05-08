Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8593117B71
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfEHOWp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 10:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfEHOWp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 10:22:45 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A2A21530;
        Wed,  8 May 2019 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557325364;
        bh=NE2y66CaGxcFru33mUKFYIeP3zbY96BiTMMLH1mrf/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nE8cf9YAE/Fx2/QkvSeKtJPU6PgVC8RGh+afirvFGXJ0FwQIddDwG4xXsWHaFOcVq
         OiNCDduNvumJG23JU4STRoXiJ+VpkvRA3/LFBfsnR/bi/YtQZU22pNVXUCwjc0lhrE
         nt6FHH9kXq6lEuaxvvUmjR6Cqw+OLXLYyGd7e+ZI=
Date:   Wed, 8 May 2019 17:22:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 02/12] SIW main include file
Message-ID: <20190508142229.GD6938@mtr-leonro.mtl.com>
References: <20190508130834.GA32282@ziepe.ca>
 <20190507170943.GI6201@ziepe.ca>
 <20190505170956.GH6938@mtr-leonro.mtl.com>
 <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
 <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
 <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
 <OF21EE5DBF.E508AFF5-ON002583F4.004B49A6-002583F4.004D764A@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF21EE5DBF.E508AFF5-ON002583F4.004B49A6-002583F4.004D764A@notes.na.collabserv.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 02:06:05PM +0000, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 05/08/2019 03:08PM
> >Cc: "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org
> >Subject: Re: [PATCH v8 02/12] SIW main include file
> >
> >On Wed, May 08, 2019 at 08:07:59AM +0000, Bernard Metzler wrote:
> >> >> >> Memory access keys and QP IDs are generated as random
> >> >> >> numbers, since both are exposed to the application.
> >> >> >> Since XArray is not designed for sparsely distributed
> >> >> >> id ranges, I am still in favor of IDR for these two
> >> >> >> resources.
> >> >
> >> >IDR and xarray have identical underlying storage so this is
> >nonsense
> >> >
> >> >No new idr's or radix tree users will be accepted into rdma....
> >Use
> >> >xarray
> >> >
> >> Sounds good to me! I just came across that introductory video from
> >Matthew,
> >> where he explicitly stated that xarray will be not very efficient
> >if the
> >> indices are not densely clustered. But maybe this is all far beyond
> >the
> >> 24bits of index space a memory key is in. So let me drop that IDR
> >thing
> >> completely, while handling randomized 24 bit memory keys.
> >
> >xarray/idr is a poor choice to store highly unclustered random data
> >
> >I'm not sure why this is a problem, shouldn't the driver be in
> >control
> >of mkey assignment? Just use xa_alloc_cyclic and it will be
> >sufficiently clustered to be efficient.
> >
>
> It is a recommendation to choose a hard to predict memory
> key (to make it hard for an attacker to guess it). From
> RFC 5040, sec 8.1.1:
>
>   An RNIC MUST choose the value of STags in a way difficult to
>   predict.  It is RECOMMENDED to sparsely populate them over the
>   full available range.

Nice, security by obscurity, this recommendation is nonsense in real life,
protection should be done by separating PDs and not by hiding stags.

>
> Since I did not want to roll my own bug-prone key based lookup,
> I chose idr. If you tell me xarray is just as inefficient as
> idr for sparse index distributions, I'll take xarray.
>
> Thanks,
> Bernard.
>
