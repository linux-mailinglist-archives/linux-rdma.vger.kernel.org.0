Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740A32867E0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgJGS47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgJGS44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 14:56:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B501C0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 11:56:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z6so4163696qkz.4
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hucdKobXaHk9Vpk01VjxDQUEIlu6eYASN/jiLFuXijg=;
        b=SNkiDcXhf8oV4GnEFwXCA2JkCI8lfRTYqFFI/i51g8N8R9CMI0TLBvayUFl3SPq2jE
         fcMBGnU5zBGw+fPNTEvGuPiKJFEEyMNXu7k+4unLOmcVu4eCgetSTtZ8jFXMRmCGPaLo
         PREcWEoNr8RjWrB0C4j2LZZmhL4snf9R0wNOAzoLdnx063EiJJxnvdvs9hpHlhLDgDDQ
         X3mGARCYDHY+PLKwsJAAuEvXBOMcY7QPKDH0UppnRh0xkwc/U8t1eg/pVQZUA9JpjtUM
         x+sQM85MfhjwFOaVpJRbWwamKLS38YjHa8En0TsrQW8Od14MZCS3GTLGvxwbipIrUlJ0
         HdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hucdKobXaHk9Vpk01VjxDQUEIlu6eYASN/jiLFuXijg=;
        b=RsTr3cWUFomHrRi1zdnelbj5ZqHcL/asbs2qU3H51Ozq8NZkBFSsUrfwfetQWQERh7
         ny8ylnHTk68azRo8G991vX+SO3kHouqFM4n5DTMLqjehdEnkhWyoWON6hqi3S42OYfsi
         bsT8m2prS1KCdq8zXIhyvO6dnMvAprPubgmVHOpLReRYnaCQZAq1TmYtGwgIBMkSeC7D
         w8+tr/2p0GvJY7VziFll/PYFdvLW7+/sxqXPid8JzmWT/JRof7keu/YehBYIkx9dzeS+
         5EcIEfZA5w7gdi7MDEyyC01Y6AywlTQGA5/XI2Le+Nou3cQ6NYs1Y485vpLEc0AsDMv2
         k2pA==
X-Gm-Message-State: AOAM530RJbBCLJO4MJdFKKDwAd/6iBE/y+w9TApoJjamvWHRokl6IEor
        BT3br4UjLqxg7lixOku/Uccbh+zvVc4tcxoK
X-Google-Smtp-Source: ABdhPJyv+pscj1uQm5l+2rGwyvNUTf34cKVOEz/9CM7hN75mUBaLoHOL+AJEukAuUIBhiCDVla6C7Q==
X-Received: by 2002:a37:dc85:: with SMTP id v127mr4365223qki.107.1602097014467;
        Wed, 07 Oct 2020 11:56:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j88sm2115558qte.96.2020.10.07.11.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:56:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQEcP-001EtS-3Q; Wed, 07 Oct 2020 15:56:53 -0300
Date:   Wed, 7 Oct 2020 15:56:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm: Use sysfs_emit functions not sprintf
Message-ID: <20201007185653.GZ5177@ziepe.ca>
References: <8a0d4fc9a4e372b125249b186689f247312d4387.camel@perches.com>
 <202010070014.76AA763CE@keescook>
 <20201007125330.GO5177@ziepe.ca>
 <a334b30e7b617eb6b0ea22f2bf00e0f188c4ae42.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a334b30e7b617eb6b0ea22f2bf00e0f188c4ae42.camel@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 11:04:42AM -0700, Joe Perches wrote:
> On Wed, 2020-10-07 at 09:53 -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 07, 2020 at 12:16:01AM -0700, Kees Cook wrote:
> > > On Tue, Oct 06, 2020 at 09:28:17AM -0700, Joe Perches wrote:
> > > > Convert the various uses of sprintf/snprintf/scnprintf to
> > > > format sysfs output to sysfs_emit and sysfs_emit_at to make
> > > > clear the output is sysfs related and to avoid any possible
> > > > buffer overrun of the PAGE_SIZE buffer.
> > > > 
> > > > Done with cocci scripts and some typing.
> > > 
> > > Can you include the cocci script in the commit log? It might be nicer to
> > > split the "manual" changes from the cocci changes, as that makes review
> > > much easier too.
> > > 
> > > Regardless, yes, I'm a fan of switching these all around to
> > > sysfs_emit*(). :)
> > 
> > Yah, +1, I'd welcome patches for drivers/infiniband as well next cycle
> 
> The script to change <foo>_show(struct device *, ...)
> function uses of
> sprintf to sysfs_emit is attached.

> $ git diff --shortstat drivers/infiniband
>  25 files changed, 322 insertions(+), 303 deletions(-)
> 
> Because it touches a lot of drivers, the 'cc' list is
> pretty large for the diff.
> 
> Given the size of the cc list, unless there's a single
> acceptable patch, I will not submit individual patches as
> I really dislike the back and forth of this sub-maintainer
> will but this sub-maintainer will not apply a patch.

This size looks not too bad, we regularly do all driver updates. Up to
you if you want split per driver. In rdma land something like this
will go ahead unless someone points to technical errors in the
conversion.

Thanks,
Jason
