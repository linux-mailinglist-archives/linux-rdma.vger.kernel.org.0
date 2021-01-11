Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC372F1889
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 15:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbhAKOnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 09:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbhAKOns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 09:43:48 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B4C061795
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 06:43:08 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u26so18087273iof.3
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 06:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Uy4dmSh1YXfPmAlEsVIKk8C/onNwMc2Qs5bzKzONEY=;
        b=IEBc0YK6atXTkF/0ep40Msod91NjmTr9cLAHeYx9ZEwhH9/ioU/Ke/2QaOxLtPTflQ
         h5+BFBVQYdQNlmztL63yL9yF/DkIS7V2iwlKHqyZ57yiGKFKpE8Z4DHqNwECA+THTqfg
         KK39n68NS76uYp4WCHPSKGCW/gZCXz8UFs/Nh+z8uxLeMskRR5ScoHWZvxzqV5kAcR7b
         kNx2p48bUJZM0tuIXW6mjHt+XYdfvQwyHKmb3zBhoNRGX6b2B3g13TphzPcLudJwyQqQ
         6kgxwhtTkNyxPxSA/XRHBsFC2o9+3zYifBIBE4/wKNhZRjV/bFn2BjQtWPS0J19LWhAh
         E8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Uy4dmSh1YXfPmAlEsVIKk8C/onNwMc2Qs5bzKzONEY=;
        b=RWANCzoKVd4ce5QDClEwDc50TnRHIIDeip8g5urudDZuTanzA1AdFeVp0btbBSj22k
         PJUCNO099UhfpfVx0mWFbk0VTQK8gS8DK4G6OnoxOZbpsYBUwNnBy8oOL+GJtv8Ii25A
         Q+L9wdt0urtViTFE6/0G5G/nt0riQMfqoeEPJqvGmIkl+zmndMAHOUQM0gG53ZXKuMZX
         IzbIVHLmeMs5l47KPfInp8ZE3cOmEHXsp0N5ZlhZEJbAxH2lpbAJol8oQllNccazHg37
         qBX0swachY6ooYkO/UNcbIRzieAnErwo575jEtRDFtUInM1/NslieI5qpdAeEuzRZ2Jc
         pwsQ==
X-Gm-Message-State: AOAM5339OaAt/IiHaWH5cMyJR+/mLXK0t0bO+4sCY40IXeSuvSOj/6rg
        +z07TCJ9qm/hN46ehoBAJ4MpEQ==
X-Google-Smtp-Source: ABdhPJyZ4N4cjirnjDbebnDeZG+f7StyYJS43ntMtcIQPUiYPQbNQdhEnL7AFHNuclaajx6Qc8gFDA==
X-Received: by 2002:a05:6602:1cb:: with SMTP id w11mr14752467iot.45.1610376188168;
        Mon, 11 Jan 2021 06:43:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id a7sm15427506iln.0.2021.01.11.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:43:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyyPS-005WSa-NT; Mon, 11 Jan 2021 10:43:06 -0400
Date:   Mon, 11 Jan 2021 10:43:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        ddiss@suse.de
Subject: Re: [PATCH v5 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210111144306.GK504133@ziepe.ca>
References: <20201228234955.190858-1-dgilbert@interlog.com>
 <20201228234955.190858-2-dgilbert@interlog.com>
 <20210107174410.GB504133@ziepe.ca>
 <76827f07-9484-d2c6-346b-0bdccfdf4a7a@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76827f07-9484-d2c6-346b-0bdccfdf4a7a@interlog.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 09, 2021 at 05:58:50PM -0500, Douglas Gilbert wrote:
> On 2021-01-07 12:44 p.m., Jason Gunthorpe wrote:
> > On Mon, Dec 28, 2020 at 06:49:52PM -0500, Douglas Gilbert wrote:
> > > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > > index a59778946404..4986545beef9 100644
> > > +++ b/lib/scatterlist.c
> > > @@ -554,13 +554,15 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
> > >   #ifdef CONFIG_SGL_ALLOC
> > >   /**
> > > - * sgl_alloc_order - allocate a scatterlist and its pages
> > > + * sgl_alloc_order - allocate a scatterlist with equally sized elements
> > >    * @length: Length in bytes of the scatterlist. Must be at least one
> > > - * @order: Second argument for alloc_pages()
> > > + * @order: Second argument for alloc_pages(). Each sgl element size will
> > > + *	   be (PAGE_SIZE*2^order) bytes
> > >    * @chainable: Whether or not to allocate an extra element in the scatterlist
> > > - *	for scatterlist chaining purposes
> > > + *	       for scatterlist chaining purposes
> > >    * @gfp: Memory allocation flags
> > > - * @nent_p: [out] Number of entries in the scatterlist that have pages
> > > + * @nent_p: [out] Number of entries in the scatterlist that have pages.
> > > + *		  Ignored if NULL is given.
> > >    *
> > >    * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
> > >    */
> > > @@ -574,8 +576,8 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
> > >   	u32 elem_len;
> > >   	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> > > -	/* Check for integer overflow */
> > > -	if (length > (nent << (PAGE_SHIFT + order)))
> > > +	/* Integer overflow if:  length > nent*2^(PAGE_SHIFT+order) */
> > > +	if (ilog2(length) > ilog2(nent) + PAGE_SHIFT + order)
> > >   		return NULL;
> > >   	nalloc = nent;
> > >   	if (chainable) {
> > 
> > This is a little bit too tortured now, how about this:
> > 
> > 	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
> > 		return NULL;
> > 	nent = length >> (PAGE_SHIFT + order);
> > 	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
> > 		nent++;
> > 
> > 	if (chainable) {
> > 		if (check_add_overflow(nent, 1, &nalloc))
> > 			return NULL;
> > 	}
> > 	else
> > 		nalloc = nent;
> > 
> 
> And your proposal is less <<tortured>> ?

Yes, obviously checking something fits in a variable is less tortured
than checking the result of math is correct.

> I'm looking at performance, not elegance and I'm betting that two
> ilog2() calls [which boil down to ffs()] are faster than two
> right-shift-by-n_s and one left-shift-by-n . Perhaps an extra comment
> could help my code by noting that mathematically:
>   /* if n > m for positive n and m then: log(n) > log(m) */

One instruction difference seems completely irrelavent here.

If you care about micro-optimizing this then please add a
check_shr_overflow() just like we have for check_shl_overflow() that
has all the right tricks.

Probably:

input_type x = arg >> shift;
if (x != (output_type)x)
   fail
return (output_type)x

Is fastest.

Jason
