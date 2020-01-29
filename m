Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE414C44B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 02:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgA2BEw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 20:04:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46659 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2BEw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jan 2020 20:04:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so15422905qke.13
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2020 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RT0GBPdAMYQEWqN3T40tILPLmJD96iz9Ok1Jp11iDSo=;
        b=hPlRBhAgZfeLKGfh1vWbEQGKe/FM9IlGcsXHk7GPx3xQ7e+EfbTggJLImBTi/n20tm
         Df0bvG7kIBWaZWfOVei7ZwvjwIJwSL5CdGhP/ys0licq/2p1qK/wahYEYMu0vyNTKu7c
         L8KvkafP0YuzDc0c5uyGvPCLq5DLV53odZNBsXPLtmo9/VvdYFf5PMkS2XqYefecjHWw
         cYZTWtWX3RRjdvtvT8EhO3SDs35k+K2BwVmDaL0QxEvxT+ymxWe7HyahgCvH/ZOKngqJ
         gU4s3/Aew4LjgdCStNMvc/7VIGR43daoFq/Q7gneEAew7P9PUb0pBHRzVoI3xgPYI7ov
         dSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT0GBPdAMYQEWqN3T40tILPLmJD96iz9Ok1Jp11iDSo=;
        b=b1aPABNhPj/mtFNEG1OrCNQGVj/sdosIXSJWOGpcn4LkGnamqiV9W+lt2NTAZPbQe0
         uBZCaD+Q3HhlH2O9du5Yn1NE9sDVVeWD/vDXqOF4gk48Z3sHxOWT6CHnVSE8ZaInT6nY
         4CgTcazNpXhgOjI+tYyDQ2zgUQrffTmC+7vGWkHpIMpug8SRW4jFgr/67pUwm1Sadbd6
         A72zQpEkC/Gby9JkxYrng24oPs2SIpG7KSvVHyfJKivt8tRqJZewRqnx6+UG1Sm44K6J
         FaBH72s7aJ9UksO8dRe55wrdbo/l0rrhyzjubSpeisJGrlEfOTHJQaaWqekVYQuo8zh8
         xdhw==
X-Gm-Message-State: APjAAAWHJHMtzByV8Oj9lEYcongFgqH18UDOsf5FqBXY7Cg9f6xBuIzE
        PZOeA4iY8oPysZcO1BYQltXCxQ==
X-Google-Smtp-Source: APXvYqx3gH7DqfcrCXYyt/OZ4quCICovyLEdtCCHEKtzT0bdOo2HLCXZ79LjX1fBUlJDjtkqo+1m9w==
X-Received: by 2002:a05:620a:1030:: with SMTP id a16mr24591414qkk.1.1580259890845;
        Tue, 28 Jan 2020 17:04:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n55sm196693qta.91.2020.01.28.17.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 17:04:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwbmj-0008Bz-OB; Tue, 28 Jan 2020 21:04:49 -0400
Date:   Tue, 28 Jan 2020 21:04:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang LI <honli@redhat.com>
Cc:     "Hefty, Sean" <sean.hefty@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: resource leak in librdmacm
Message-ID: <20200129010449.GA29820@ziepe.ca>
References: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
 <BYAPR11MB3272F4913688AE9B3BFF815C9E0D0@BYAPR11MB3272.namprd11.prod.outlook.com>
 <20200122085655.GA126224@dhcp-128-72.nay.redhat.com>
 <20200122152258.GA142196@dhcp-128-72.nay.redhat.com>
 <20200123142135.GA171304@dhcp-128-72.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123142135.GA171304@dhcp-128-72.nay.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 23, 2020 at 10:21:35PM +0800, Honggang LI wrote:
> On Wed, Jan 22, 2020 at 11:23:02PM +0800, Honggang LI wrote:
> 
> > void test_fini(void)
> > {
> 
> 
> > 	if (handle)
> > 		dlclose(handle);
>                 ^^^^^^^
> > 	handle = NULL;
> 
> In case we did not call dlclose, there will be only one file descriptor
> leak. It will reduce the file descriptor leak.
> 
> Does that imply librdamcm was designed to load once and only unload when
> process exit?

Yes.

We had some old code that attempted to clean up on dlclose/process
exit, but it turns out that whole concept is racey and broken when
threads are used.

To run valgrind testing like this the library needs to provide some
kind of 'cleanup internal data' call, which our libries don't have. 

I think it would be useful addition to both libraries.

You should also see memleaks from valgrind on exit, IIRC. Lots of
static lists don't get cleaned.

Jason
