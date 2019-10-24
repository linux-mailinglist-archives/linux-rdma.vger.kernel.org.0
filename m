Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE90E346F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393657AbfJXNjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:39:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393656AbfJXNjv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 09:39:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so17437976wrv.4
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZdcHcNeW8gG+C2y+MdBIQC0fV9YArWwSlA7DmkpB+r4=;
        b=GKel99KtwTbuqKbU4jRplvJlJdoLse0r/B/JZRVqmg4VH+TyFDq52VTcNgci8EQy5X
         kU5OcPBgBNd+tRRgMGi+z71cQC1S/Q3V77cXXumFVs7WFxxPm6IAjCf573+vg9Kw6Qi/
         qBr297x3zC2GyjM1nNaes4H0FN3TeePkZUaWgT07HGtieZ+pfKN5gyEO1N2SzHM0aa5A
         2gfNl7Tk8lAuze1xtASWgM1CjOk4qIhE+vlYdQPuktyGTPUdJxrUm5Q5whfaLXQuUtvs
         5cQ/s0GY1YPvyoov3fC/zyutwEHrWnuUo7PGPpJoSM6F5exRfuZGk8ilkN1yH3NfeGQp
         oUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZdcHcNeW8gG+C2y+MdBIQC0fV9YArWwSlA7DmkpB+r4=;
        b=psCvUMuMpACutLnjv9zNjr8lPz4pUsEt2c4pkQLua9VpDe0J2OGZ/svHvQ2/fvuv14
         2V5AJku3a8S66F7AzXk3D6S11GiasNb3/Fayt3qSVJzd1pgG+V+sspRrVXaAGSArg4QA
         ABP6S/44k0jbg43Hqw+ebUl+3Pa+hKB/7WUXVqzG8lZEc7LngVDNslE2oDNEFHJQzvX9
         Qjo8MvO/8M5yKHhbb+icaTVyEUF3BLkjytwYmmRI5kfJ3U4zAIHfCegPGwLI7l+m6VeX
         uFZbNAXiaQ9sAs5CM5JdJLccqxprOy2x7rQAzFrvvD5mGMWsHlsHXPG8ZRmY2TiG7T3B
         6BNA==
X-Gm-Message-State: APjAAAW+y/T4PFx+TdGdI6NcA7dS/LzMNqYOEJS2JBsp989ScgP0nYjO
        wBaPnbWf+ULnwPZGyJlK/3I=
X-Google-Smtp-Source: APXvYqwqKzFi3aRNqfq+mSADarUYSfFdlZbtpCAm2u5yHwhtLVSohKOeI75wPd3vKFlnUMydpjLjJA==
X-Received: by 2002:a5d:6241:: with SMTP id m1mr4110488wrv.213.1571924389068;
        Thu, 24 Oct 2019 06:39:49 -0700 (PDT)
Received: from kheib-workstation (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 143sm4821627wmb.33.2019.10.24.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:39:48 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:39:44 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] selftests: rdma: Add rdma tests
Message-ID: <20191024133944.GA20148@kheib-workstation>
References: <20191023173954.29291-1-kamalheib1@gmail.com>
 <20191023174219.GO23952@ziepe.ca>
 <20191023201008.GA30186@kheib-workstation>
 <20191024063909.GQ4853@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024063909.GQ4853@unreal>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 09:39:09AM +0300, Leon Romanovsky wrote:
> On Wed, Oct 23, 2019 at 11:10:08PM +0300, Kamal Heib wrote:
> > On Wed, Oct 23, 2019 at 02:42:19PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 23, 2019 at 08:39:54PM +0300, Kamal Heib wrote:
> > > > Add a new directory to house the rdma specific tests and add the first
> > > > rdma_dev.sh test that checks the renaming and setting of adaptive
> > > > moderation using the rdma tool for the available RDMA devices in the
> > > > system.
> > >
> > > What is this actually testing? rdmatool?
> > >
> >
> > This is a very basic test that uses the rdmatool for checking two of the
> > RDMA devices functionalities.
> >
> > > This seems like a very strange kselftest to me.
> > >
> >
> > Basically, you can take a look into other subsystems selftests (e.g.
> > net) to see that it not that strange :-).
> 
> Yeah, selftests is in-kernel dumpster, everything goes in. It doesn't
> mean we should follow this path too. The in-kernel tests are great to
> check interfaces and not external tools.
>

OK, I see that you don't like the idea of using external/Userspace tools.

So, what do you suggest?! 

> >
> > Yes, the first test is very basic, but the idea behind it is to utilize
> > the kernel selftests infrastructure to test the rdma subsystem, I plan to
> > introduce more tests in the near future, hopefully other folks from the
> > community will join me too.
> 
> You don't have any version checks, the idea that you can test latest
> kernel features with installed "rdmatool" in distro is a little bit over
> optimistic.
> 
> >
> > Thanks,
> > Kamal
> >
> > > Jason
