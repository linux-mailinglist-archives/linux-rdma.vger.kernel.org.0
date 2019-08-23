Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF2E9B45D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436527AbfHWQPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 12:15:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45131 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389546AbfHWQPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 12:15:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so8608965qki.12
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JisyHvK10WwGRYBcE16FzqVxwHIHjwxz3JGGgVaFyng=;
        b=ROF3MC8/+3SrMOJBQYfJo5Wdv5+27NpJFHhpq84ruRUBg+SiK1Tlzxc4uG59n9SPKA
         SRqUBijL4FFZwLNeZyXw8KQg5tU+aPQJQCFywXsb/nt/zf0+9HE2jLOnzuUZCizawc2A
         gG6drJRVm6BkwliCUTgfJT/laghzJRh+482lw8h/Ak2MqR4pH8zTUnPEEqHUc2Fb9shg
         h/cEzaPSqFPiKeFLAnvUWw6rONHWVEG/EKFm7gT0n9wAShpPjRAQ4kDVf+iCp2tI3AH3
         5+fBWpg6rpcT9VJG31JVBvMwewSHohC7TvvUZfrPGQAl63VQFDlOthic7GmfMUNo3VEj
         YtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JisyHvK10WwGRYBcE16FzqVxwHIHjwxz3JGGgVaFyng=;
        b=R/7cD3ttzJtIKtZ9G54ht/8PwshZ60Cz67wgH481uIemjchlMoLKbtOfwEAMq93C2R
         Th6LXgrLaPcQUl77OoIddqPDhR4MmxlL3/HpjXC/lTRwsQop5zT670/0TgqrHQvLRCi/
         UEjfRFfHKReye6HaV+ne6v3RYlmTtatPVXRwguWGJsTCROGSSJ6wAt+AnLjSGpmgngzE
         8Mpel/ytkDyEMUywD7qEAUCbvNL6CyZwfAzPx4ro3Ebf24R2tmbfeOuWdZYjiyzx8ahv
         OgHoAPepmZklidaSCd2hPSsg4Hy5BX6YlVaA70gSUADPwlG8bHFQu8Ntcr8k0xJop9p4
         CazQ==
X-Gm-Message-State: APjAAAWCVbV6g77tiN9IV3wFmNi1LvjxK4A4EyVGusKM6QwaBwvqUUVd
        WyNhRE829pdYH9gZFd3KLy3kOg==
X-Google-Smtp-Source: APXvYqzvTz4BjcXmaSVn2PkO71UOR18gsqM94hefhEnHBRZI1x2KdekzXrqa0DrILYobPn3IxR0A8g==
X-Received: by 2002:a37:67c3:: with SMTP id b186mr4764770qkc.320.1566576952582;
        Fri, 23 Aug 2019 09:15:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h4sm1474056qtq.82.2019.08.23.09.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 09:15:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1CEB-0007fz-RI; Fri, 23 Aug 2019 13:15:51 -0300
Date:   Fri, 23 Aug 2019 13:15:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
Message-ID: <20190823161551.GI12968@ziepe.ca>
References: <20190823144221.GF12968@ziepe.ca>
 <0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
 <20190822173738.26817-1-bmt@zurich.ibm.com>
 <20190822184147.GO29433@mtr-leonro.mtl.com>
 <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
 <OF6BB8D2A0.FBBB26D8-ON0025845F.00522370-0025845F.0052E0CD@notes.na.collabserv.com>
 <7367a14c19c1d733615ea2e4c143b28fa81f6f90.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7367a14c19c1d733615ea2e4c143b28fa81f6f90.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 23, 2019 at 12:13:54PM -0400, Doug Ledford wrote:
> On Fri, 2019-08-23 at 15:05 +0000, Bernard Metzler wrote:
> > > > Doug,
> > > > May I ask you to amend this patch in a way which would
> > > > just stop this monument of programming stupidity from
> > > > prolonging into the future, while of course recognizing
> > > > the impossibility of erasing it from the past?
> > > > Exchanging the %u with %d would help me regaining
> > > > some self-confidence ;)
> > > 
> > > A
> > >  q?a:b
> > > 
> > > Expression has only a single type. There are some tricky rules on
> > > this, but since gcc does not complain on the %u it means
> > > 'q?(u32):(int)' is a (u32) and the -1 is implicitly casted.
> > > 
> > > The better thing to write would have been U32_MAX instead of -1
> > > 
> > 
> > What I wanted to have though is an easy to spot invalid number
> > for the QP. This is why I wanted to have it a negative number
> > on the screen, which is obviously not nicely achievable. So,
> > yeah, U32_MAX is a better idea. It will not very often be a
> > valid QP ID...
> 
> Given that this patch was still the top of my tree, I fixed this up. 
> But, I think U32_MAX is wrong.  It should be UINT_MAX (which is what I
> used).  Otherwise it will give errors on s390 where an int is 31 bits
> (and anywhere else that might have a non-32 bit int).

qp_id returns u32 and the types of both sides of the : should be
identical

A non-32 bit int does not exist in Linux, everything would break.

Jason
