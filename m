Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5B172997
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 21:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgB0UmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 15:42:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37303 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UmJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 15:42:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so814207qke.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4T+b4VonCJoeTFWhDSRlZjDGr8q9L8uI5HwdLR0Xik=;
        b=XfcdP2uLkVjLyPFVrroKdtc7FFpI6neIiFhZwRepTDp0KKRENtKn9sWkI9G8SFLMWS
         4Z/NR4x8XyRJ1OoHuoaryocUZ1nkTmYHN8+nxJJNLkNQzJFYX/y1pfH0liYBHz7DanXg
         Y9bH5i5lvUIxS8OSgMQWTT09l66XzBM48wFAt0L/akYVcDt6NsqF1if25Z4IyGYL7m+H
         iEffA4GmcUqbpM8PnUNtSyjj5GMjTA6/ha9EuneBmnWpfrDmy5W8N0YpSI1k7YBUJFvV
         o2NNN8+Y1WQpH4XjcxgEksP+Qr1dsUJOQTAkUoULrmHR7pSScLTefwGN1d5V/03QcYsv
         I+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4T+b4VonCJoeTFWhDSRlZjDGr8q9L8uI5HwdLR0Xik=;
        b=Mh2Eir1rIrDI58mqrZnWpy1T5J2tVYoSUcPBgGbPyFaAp+VKA3saHOypZ0RmLB/FAZ
         DxW+Pdaw+rI3p5DUMoa01axF4lNOVfdJ7RPwMzJ70uiLN0UV0PgqghQggKawiuXzBB+2
         Xhx7cKI0Q4YLVjc9O/Frk+lYOh7N6MIcOrmLPBYCZryUhSPN7Z6AV+bCk7/svyh2/qww
         R24hmju9ofXblCOBpVSy/FlalQ6AochypkGAZaWfCFjEv6c+DWJ00vbr+ZJHh3AV8WVU
         FipS4uEyKBJ6FJt7Xoc1yusEvntwU8F/1/J+S0bIZh32YCiFLxq32OIttzR7bvGfHOyJ
         vDhQ==
X-Gm-Message-State: APjAAAU4epHmdL22dauw6At4YqmTou6Im0ep5OovvNOjOMX5TZNh5aKI
        UeXxlODwM3EGHlxf5OhkcGaq/bZ85Gj1kw==
X-Google-Smtp-Source: APXvYqxNb9DxLFcf23i54OdwfwQ9/x1tWlNYZCGZcSz7DCC/uLT5D08Z7M/Lh7uJRvZcjR5eQQ1xkA==
X-Received: by 2002:a37:a6cf:: with SMTP id p198mr1317668qke.298.1582836128563;
        Thu, 27 Feb 2020 12:42:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o10sm3708906qtp.38.2020.02.27.12.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 12:42:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7Pyx-0008DY-Oe; Thu, 27 Feb 2020 16:42:07 -0400
Date:   Thu, 27 Feb 2020 16:42:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20200227204207.GB31359@ziepe.ca>
References: <20200218210432.GA31966@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210432.GA31966@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 09:04:36PM +0000, Jason Gunthorpe wrote:
> The rdma_cm must be used single threaded.
> 
> This appears to be a bug in the design, as it does have lots of locking
> that seems like it should allow concurrency. However, when it is all said
> and done every single place that uses the cma_exch() scheme is broken, and
> all the unlocked reads from the ucma of the cm_id data are wrong too.
> 
> syzkaller has been finding endless bugs related to this.
> 
> Fixing this in any elegant way is some enormous amount of work. Take a
> very big hammer and put a mutex around everything to do with the
> ucma_context at the top of every syscall.
> 
> Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
> Reported-by: syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com
> Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com
> Reported-by: syzbot+4b628fcc748474003457@syzkaller.appspotmail.com
> Reported-by: syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com
> Reported-by: syzbot+6956235342b7317ec564@syzkaller.appspotmail.com
> Reported-by: syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com
> Reported-by: syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com
> Reported-by: syzbot+8458d13b13562abf6b77@syzkaller.appspotmail.com
> Reported-by: syzbot+bd034f3fdc0402e942ed@syzkaller.appspotmail.com
> Reported-by: syzbot+c92378b32760a4eef756@syzkaller.appspotmail.com
> Reported-by: syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/ucma.c | 50 ++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

It has had some testing on the Mellanox test suite, so applied to
for-next.

I did not put this in -rc or cc stable since it seems like it should
have more testing

Jason
