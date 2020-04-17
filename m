Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D771ADEB0
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgDQNsU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730597AbgDQNsT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 09:48:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2BC061A10
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 06:48:18 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s18so886749qvn.1
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=op4dPjwrD9QDYZwBa3JIN9ahH57aXRQ+t3CflVy3cr8=;
        b=kyP8zVi6dK+UN06S/0vCyZbk6Wtw/t/ZTqGvDTUz3If10pQdSdOZd9AowuRmbjJknz
         I4JKNNtQkvmO9a/mTLcoipilUCUNDBOz3EFrwUh8mcd7d9nuXcWNWHjFCN/7mEQ0cIt5
         pdOxvmMJdeyBjbMlKDS8iK2PYVhBFFW7+DbhLghYbb49krZFE3TyZzvh/rDDSC5PofxS
         j6CQR1ePXr8j1TJ6skaDb117FUQWVlIwJrCj38t/j2V+1P75J5VnmJEx046X8rky2hk2
         jzCRSd+EQ0uOFgVWxqSiky3Gxwkdtk9AhjQPsHfWnbIDhFeAF21kWGstZDUTwlqAZL9g
         eAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=op4dPjwrD9QDYZwBa3JIN9ahH57aXRQ+t3CflVy3cr8=;
        b=cUZT9+erJnPvjFBebvW7gNCV/hOlikgwkJ7Xfw7pp+d+Bl3JLGQr0OBxiFSB4e+pnX
         zi3WjpQXdm4N9nt9Jr2pqiGmNwmHiAPcG1Be6JkDjvFdVo2OeewR+RBCoHEUWofuKzU6
         lOYn3bN+dQd0X/kAzZHC4tWpVD2HVQwdpx4aIuWmMFc8Itw9+Jz7Z56/d6vRnCg/hUG0
         dflMubJC3zdRwzUOXfFIHQ39G/cg574lAcIoCQ1sLAeCCvPjpi168yU0zld2cHe2gwJN
         grIGmUsdkYVG8/cTp6k0SrTBl73NGd37xDX+dCjQ8h8w7qlrqgyYJ0oC+nQYImlOTna+
         WYIw==
X-Gm-Message-State: AGi0PuZjjWCE3uNIlYL8yyuW/I+LNUl5iqYxjt8ByGGF/cHc808/TXA2
        GlSOU43bG+T8Vx4HKPTAGTltWA==
X-Google-Smtp-Source: APiQypLvhGvSfzUDQrEFAvt/WCBHmAki93uc2vBo7AYzztYvN6JLCSt89dSJ9/9/yyw6CrUivTJjGA==
X-Received: by 2002:ad4:4f01:: with SMTP id fb1mr2915039qvb.162.1587131297274;
        Fri, 17 Apr 2020 06:48:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f68sm16922485qtb.19.2020.04.17.06.48.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 06:48:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPRLs-0008VR-5o; Fri, 17 Apr 2020 10:48:16 -0300
Date:   Fri, 17 Apr 2020 10:48:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     g@ziepe.ca, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417134816.GD26002@ziepe.ca>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
 <20200416184754.GZ5100@ziepe.ca>
 <20200417112624.GS1163@kadam>
 <20200417122542.GC5100@ziepe.ca>
 <20200417130955.GU1163@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417130955.GU1163@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 04:09:55PM +0300, Dan Carpenter wrote:
> On Fri, Apr 17, 2020 at 09:25:42AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 17, 2020 at 02:26:24PM +0300, Dan Carpenter wrote:
> > > On Thu, Apr 16, 2020 at 03:47:54PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> > > > > On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > > > > > The memcpy is still kind of silly right? What about this:
> > > > > > 
> > > > > > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > > > > > {
> > > > > > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > > > > > 	int cpy_len;
> > > > > > 
> > > > > > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > > > > > 	if (cpy_len >= len || cpy_len < 0) {
> > > > > 
> > > > > The kernel version of snprintf() doesn't and will never return
> > > > > negatives.  It would cause a huge security headache if it started
> > > > > returning negatives.
> > > > 
> > > > Begs the question why it returns an int then :)
> > > 
> > > People should use "int" as their default type.  "int i;".  It means
> > > "This is a normal number.  Nothing special about it.  It's not too high.
> > > It's not defined by hardware requirements."  Other types call attention
> > > to themselves, but int is the humble datatype.
> > 
> > No, I strongly disagree with this, it is one of my pet peeves to see
> > 'int' being used for data which is known to be only ever be positive
> > just to save typing 'unsigned'.
> > 
> > Not only is it confusing, but allowing signed values has caused tricky
> > security bugs, unfortuntely.
> 
> I have the opposite pet peeve.
> 
> I complain about it a lot.  It pains me every time I see a "u32 i;".  I
> think there is a static analysis warning for using signed which
> encourages people to write code like that.  That warning really upsets
> me for two reasons 1) The static checker should know the range of values
> but it doesn't so it makes me sad to see inferior technology being used
> when it should deleted instead.  2)  I have never seen this warning
> prevent a real life bug.

I have.. But I'm having trouble finding it in the git torrent..

Maybe this one:

commit c2b37f76485f073f020e60b5954b6dc4e55f693c
Author: Boris Pismenny <borisp@mellanox.com>
Date:   Thu Mar 8 15:51:41 2018 +0200

    IB/mlx5: Fix integer overflows in mlx5_ib_create_srq

> You would need to hit a series of fairly rare events for this
> warning to be useful and I have never seen that happen yet.

IIRC the case was the uapi rightly used u32, which was then wrongly
implicitly cast to some internal function,  accepting int, which then
did something sort of like

  int len
  if (len >= sizeof(a))
       return -EINVAL
  copy_from_user(a, b, len)

Which explodes when a negative len is implicitly cast to unsigned long
to call copy_from_user.

> The most common bug caused by unsigned variables is that it breaks the
> kernel error handling 

You mean returning -ERRNO? Sure, those should be int, but that is a
case where a value actually can take on -ve numbers, so it really
should be signed.

> but there are other problems as well.  There was an example a little
> while back where someone "fixed" a security problem by making things
> unsigned.
> 
> 	for (i = 0; i < user_value; i++) {

This is clearly missing input validation on user_value, the only
reason int helps at all here is pure dumb luck for this one case.

If it had used something like copy_to_user it would be broken.

> Originally if user_value was an int then the loop would have been a
> harmless no-op but now it was a large positive value so it lead to
> memory corruption.  Another example is:
> 
> 	for (i = 0; i < user_value - 1; i++) {

Again, code like this is simply missing required input validation. The
for loop works with int by dumb luck, and this would be broken if it
called copy_from_user.
 
> From my experience with static analysis and security audits, making
> things unsigned en mass causes more security bugs.  There are definitely
> times where making variables unsigned is correct for security reasons
> like when you are taking a size from userspace.

Any code that casts a unsigned value from userspace to a signed value
in the kernel is deeply suspect, IMHO.

If you get the in habit of using types properly then it is less likely
this bug-class will happen. If your habit is to just always use 'int'
for everything then you *will* accidently cause a user value to be
implicitly casted.

> Complicated types call attention to themselves and they hurt
> readability.  You sometimes *need* other datatypes and you want those to
> stand out but if everything is special then nothing is special.

If the programmer knows the value is never negative it should be
recorded in the code, otherwise it is hard to tell if there are
problems or not.

Is this code wrong?

 int array_idx;
 ...
 if (array_idx < ARRAY_SIZE(foo))
    return foo[array_idx];
 
Since 'int' was used the entire code flow has to be studied to
determine if 'array_idx' is ever accidently set to negative. If it is
unsigned I can tell you there is no problem right away.

I do agree with you that people blindly changing things due to
security scanners is not good..

Jason
