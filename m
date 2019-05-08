Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69A917B61
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEHOOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 10:14:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39327 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEHOOF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 10:14:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id z128so9837117qkb.6
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Gogvpu3fCEum3xy6Qpg4Ey9Y5sUbRZBsScQww8Zd0M=;
        b=gP5e/uyZvV+AXnZ39B7YP9qj/F9ZbmcFDJ8H31cSJvGbn0YffATV8ElgOFlDZbqUGY
         9Q331CVJpIlR7V7+0CKFHlzzEYB7bGkpYQRqLdquXkKvzOPbvQZTlFbsHGOkJJ7vYGTV
         bCxiQsr2mqoTiOwNHv1VMJ2njOxCOvX2gUBlVCJosrxKgZ0wFlIDjPCXkrYxoKh9hx0l
         cFVNZ9u58p660/l6UOCx43Rfu2fq5cohmk5CfoMJiciuUBFk2wEf737rUda2P1RRqqpA
         +y7vUbtsDQE19NJaF9PUfmLUg9FIKepPD+9lf2NdSGZMA7rndxgoIiXCJ6RmDTnnPHvV
         0MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Gogvpu3fCEum3xy6Qpg4Ey9Y5sUbRZBsScQww8Zd0M=;
        b=GQUXwOLarBfaYFUPRyV51mv53+Sj07NmW7GJl/rvnFT5onNptLSl50zc0voQkpbf+d
         46qjF/k2i434ivbTkj+cocLE2GaTbLbWS9Cz4R8wRW/QdCvqD+4yBky88D7cLUBK6qIS
         NEsDXFFP1FDLw/0jD5t3SZjItAHjbauCORf81L4MSp4YEBqN7G5NjsT79UhP4ZYgVH8e
         wE3j75bRzHGefKmOdLbNRAq+HDKYsMZqma76NICFBwXUhF8jYCwbSC0rEg0T2jYMtG+A
         +gyJaz5nwByU/FkQFVbYACAo9DET2EE32FcpYTXl5dBoxwHAockQC5wxQCDp73TX6aQu
         m+Nw==
X-Gm-Message-State: APjAAAXDkNgQyy0PyxEDQ6XF36CJx4JqIe6wQEMlJBxpuVYHG+WgB6dE
        jZiRZiQooeWfjLiHPskFQDYNnNIMC9I=
X-Google-Smtp-Source: APXvYqzm1bn4xUzga3cK68XynUxFE/EjgrCRC8m06EpKYJSFv36DUp9/tX7EV4RhpXt6UJWUWIbL9w==
X-Received: by 2002:a37:7e81:: with SMTP id z123mr30530460qkc.69.1557324844472;
        Wed, 08 May 2019 07:14:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x125sm7089427qkd.6.2019.05.08.07.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 07:14:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hONKc-0002F5-8t; Wed, 08 May 2019 11:14:02 -0300
Date:   Wed, 8 May 2019 11:14:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 02/12] SIW main include file
Message-ID: <20190508141402.GC32282@ziepe.ca>
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
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 02:06:05PM +0000, Bernard Metzler wrote:
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
> 
> Since I did not want to roll my own bug-prone key based lookup,
> I chose idr. If you tell me xarray is just as inefficient as
> idr for sparse index distributions, I'll take xarray.

Yah, this probably wants to be a RB tree or some other data
structure.. But you can leave it as xarray it just wastes memory.

Jason
