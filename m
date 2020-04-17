Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D51AE1A3
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgDQP4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728603AbgDQP4V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 11:56:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8383C061A0F
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 08:56:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x8so1142083qtp.13
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5ZmL/lkK7p6sLrLWGHaYJr8ALem1oHicAKASp6iJuw=;
        b=hjCFx5RJ3D/BBYOq+Y6PDF/JMJ6L7fE5sjgYh/a751A4DDAqmv9Dg4L93SeUqCfdLz
         cuToO5Z8aNGs/aNNgZrhVSEXyh/FdCp6OGrRr9LXeZ5bUQfjLQOXPSB2wzB9QRh+cwCD
         L3gvo8ffRa/HFxNoSLGjQXnXEWL+ppxM35jar5tIAnlo667Pz1jUIOT5tSKI63lUfLJ9
         QeBNdWDkmL1Eos75ndtt7TM9C3LXhq1BRXP6WCtXv7vEhWrUxLVzz57w53bot/xc2ezs
         BSSDNLAyfMoe2Zq+ZYn/PvaW011qZcLtxNez831X+K0IHCJgXMnBoadAxdXHnTi0vCoE
         ZaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5ZmL/lkK7p6sLrLWGHaYJr8ALem1oHicAKASp6iJuw=;
        b=PjI/ytS25JKGFg4xhpru3gFr+Xhe07PoYd5qBri2XH5BM66p86WWx492RJhgOvPAmU
         JFTK0iaN/AjzLnQDx+M8pH3DzHMQmCJ8Fl5CVoxiYiV9NqhvWWBdlrgbZrtTEn1SjVx1
         RYySFo8asPi3iEnFk02YPokslvNg508eq242ipPwx+7r1hNbXlNBr/k4oaoX5Wvdkxjz
         gEOJfcrd5P5Mdgy3Hpi4aV8l5s9jlV8QyzogjkPk9PNUDfYgCH57AWT62j0Ga53BXJlZ
         Vs5uKWUCqvquGdzB6GN/E4LawfTo8xFKLGE0pe9ISdArMdH+vNkBudttSKgDyW6y+Th3
         qQOg==
X-Gm-Message-State: AGi0PuZ5LhLGx+FYjOPaT+L5atuSoF6GWGcfeTIKYa8BOWgX/Xsejds3
        X5P90353Ow7+ehjheJy57lHPTQ==
X-Google-Smtp-Source: APiQypJ38fd0b2LrQ3XC+DfMxeutcIwIoSdqwwVCUYOwgW9Ij6b/tyXqcaVfXJ3Ob03JzSrm6kHntw==
X-Received: by 2002:ac8:1788:: with SMTP id o8mr3659700qtj.15.1587138980467;
        Fri, 17 Apr 2020 08:56:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x18sm9413102qkn.107.2020.04.17.08.56.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 08:56:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPTLm-0002G7-US; Fri, 17 Apr 2020 12:56:18 -0300
Date:   Fri, 17 Apr 2020 12:56:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     g@ziepe.ca, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417155618.GG26002@ziepe.ca>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
 <20200416184754.GZ5100@ziepe.ca>
 <20200417112624.GS1163@kadam>
 <20200417122542.GC5100@ziepe.ca>
 <20200417130955.GU1163@kadam>
 <20200417134816.GD26002@ziepe.ca>
 <20200417151314.GV1163@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417151314.GV1163@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 06:13:14PM +0300, Dan Carpenter wrote:
> I was just meant unsigned iterators, not sizes.  I consider that to be a
> different sort of bug.  The original code did this:
> 
> 	desc_size = max_t(int, 32, desc_size);
> 
> Using signed casts for min_t() always seems like a crazy thing to me.  I
> have a static checker warning for those but I think people didn't accept
> my patches for those if it was only for kernel hardenning and
> readability instead of to fix bugs.  I don't know why, maybe casting to
> an int is faster?

Casting usually doesn't cost anything... But I think this shows again
why int is trouble: most likely desc_size is a unsigned value stored
in an int, and the temptation of max_t is to use the type of the
output variable.  So 'int' is a logical, if not bonkers choice.

If desc_size was properly unsigned then the author should keep using
unsigned through the max_t()

> > > You would need to hit a series of fairly rare events for this
> > > warning to be useful and I have never seen that happen yet.
> > 
> > IIRC the case was the uapi rightly used u32, which was then wrongly
> > implicitly cast to some internal function,  accepting int, which then
> > did something sort of like
> > 
> >   int len
> >   if (len >= sizeof(a))
> >        return -EINVAL
> >   copy_from_user(a, b, len)
> 
> This code works.  "len" is type promoted to unsigned and negative values
> are rejected.

Expecting people to know the unsigned/sign implicit promotion rules
for expressions to determine the code is right/wrong is just asking to
much, IMHO. I certainly don't have them all memorized and try to avoid
them :(

Using int pretty much guarentees you hit those cases...

> The real life example was slightly more complicated than that.  But the
> point is that a lot of people think unsigned values are inherently more
> safe and they use u32 everywhere as a default datatype.  I argue that
> the default should always be int unless there is a good reason
> otherwise.

Why? In my experience most values actually are never negative.

> to save memory.  There are reasons for the other datatypes to exist, but
> using them is tricky so it's best to avoid it if you can.

I can't say I have the same experience..
 
> There is a lot of magic to making your limits unsigned long type.

Oh? More magic than int is implictly promoted to unsigned anyhow?

> > > Originally if user_value was an int then the loop would have been a
> > > harmless no-op but now it was a large positive value so it lead to
> > > memory corruption.  Another example is:
> > > 
> > > 	for (i = 0; i < user_value - 1; i++) {
> > 
> > Again, code like this is simply missing required input validation. The
> > for loop works with int by dumb luck, and this would be broken if it
> > called copy_from_user.
> 
> The thing about int type is that it works like people expect normal
> numbers to work.

Not really. Some cases are a bit better, some are worse. As above when
using int:

 -1 >= sizeof(A) == true

Which is not at all how any sane person thinks about normal
numbers. There are lots of these odd traps around implicit promotion.

While foo-1 is right there, explicitly. If foo-1 < 0 and the code is
not expecting it then you have a clear problem.

> People normally think that zero minus one is going to
> be negative but if they change to u32 by default then it wraps to
> UINT_MAX and that's unexpected.  

Maybe I've been doing this too long, but this seems totally expected
to me...

> There is an element where the static checker encourages people to
> "change your types to match" and that's garbage advice.  Changing
> your types doesn't magically make things better and I would argue
> that it normally makes things worse.

I don't know much about this warning, but I do find that people
starting out tend to just use 'int' everywhere and 'hope for the best'
without any clear understanding or thinking of what types are what.

> > If you get the in habit of using types properly then it is less likely
> > this bug-class will happen. If your habit is to just always use 'int'
> > for everything then you *will* accidently cause a user value to be
> > implicitly casted.
> 
> This is an interesting theory but I haven't seen any evidence to support
> it.  My intuition is that it's better to only care when you have to
> otherwise you get overwhelmed.

If you make everything unsigned, there really is no downside, other
than possible subtraction related issues that exist anyhow, AFAIK.

This is the approach the C std uses, pretty much the entire API is
properly marked with signed/unsigned. I feel in pretty good company
advocating that this is the best way to write C code :)

But then again, I find the modular math intuitive and aware to be
careful with subtraction...

Jason
