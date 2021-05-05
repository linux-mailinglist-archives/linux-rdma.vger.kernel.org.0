Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772F0373FB3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhEEQ1F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 12:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233823AbhEEQ1F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 May 2021 12:27:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 217AF6103E;
        Wed,  5 May 2021 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620231968;
        bh=Z21VGL0l2EWL4GAmbkuG+zABHfxkzRrq8jf6Ywv9C8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXoYVX38RYe2Bj6wX/VqMkyl9UKiWlgdJWOR8LReHfp2SrXosJFJmVKVl4dJZKD5H
         gsKkjeZ7rPYbqimSqsjE5bkgIeEoH8QAL288dedQeTC/YHDlNSrbAnK57M1UwkRYTy
         c8DnQBULfsKfqL2xw5tMcL8Y3xBdP83iTCKs3kfk=
Date:   Wed, 5 May 2021 18:26:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <YJLHHpatWOgJo0Zk@kroah.com>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210402233018.GA7721@ziepe.ca>
 <202104021823.64FA6119@keescook>
 <20210404135713.GB7721@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404135713.GB7721@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 04, 2021 at 10:57:13AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 02, 2021 at 06:29:55PM -0700, Kees Cook wrote:
> > On Fri, Apr 02, 2021 at 08:30:18PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 02, 2021 at 04:03:30PM -0700, Kees Cook wrote:
> > > 
> > > > > relevant. It seems to me that the hw_counters 'struct attribute_group'
> > > > > should probably be its own kobj within both of these structures so they
> > > > > can have their own sysfs ops (unless there is some other way to do this
> > > > > that I am missing).
> > > 
> > > Err, yes, every subclass of the attribute should be accompanied by a
> > > distinct kobject type to relay the show methods with typesafety, this
> > > is how this design pattern is intended to be used.
> > > 
> > > If I understand your report properly the hw_stats_attribute is being
> > > assigned to a 'port_type' kobject and it only works by pure luck because
> > > the show/store happens to overlap between port and hsa attributes?
> > 
> > "happens to" :) Yeah, they're all like this, unfortunately:
> > https://lore.kernel.org/lkml/202006112217.2E6CE093@keescook/
> 
> All? I think these are all bugs, no?
> 
> struct kobj_attribute is only to be used with a kobj_sysfs_ops type
> kobject
> 
> To cross it over to a 'struct device' kobj is completely wrong, the
> same basic wrongness being done here.
>  
> > I'm not convinced that just backing everything off to kobject isn't
> > simpler?
> 
> It might be simpler, but isn't right - everything should continue to
> work after a patch like this:
> 
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -67,6 +67,7 @@ struct ib_port {
>  
>  struct port_attribute {
>  	struct attribute attr;
> +	uu64 pad[2];

Ick, don't do that :(

>  	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
>  	ssize_t (*store)(struct ib_port *, struct port_attribute *,
>  			 const char *buf, size_t count);
> 
> If it doesn't it is still broken.
> 
> Using container_of() with the wrong types is an unconditional
> error. A kasn test to catch this would be very cool (think like RTTI
> and dynamic_cast<>() in C++)
> 
> > > And then two show/set functions that bounce through the correct types
> > > to the data.
> > 
> > I'd like to make these things compile-time safe (there is not type
> > associated with use the __ATTR() macro, for example). That I haven't
> > really figured out how to do right.
> 
> They are in many places, for instance.
> 
> int device_create_file(struct device *dev,
>                        const struct device_attribute *attr)
> 
> We loose the type safety when working with attribute arrays, and
> people can just bypass the "proper" APIs to raw sysfs ones whenever
> they like.
> 
> It is fundamentally completely wrong to attach a 'struct
> kobject_attribute' to a 'struct device' kobject.

But it works because we are using C and we don't have RTTI :)

Yes, it's horrid, but we do it because we "know" the real type that is
being called here.  That was an explicit design decision at the time.

If that was a good decision or not, I don't know, but it's served us
well for the past 20 years or so...

thanks,

greg k-h
