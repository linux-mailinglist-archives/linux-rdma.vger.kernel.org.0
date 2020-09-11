Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CC266572
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKRDI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgIKRBm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 13:01:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FCBC061757
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 10:01:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so8418779qtv.3
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hQC5h4tmhJe0o6/7GihSPzVFpGRqbcoLdlsbFYRWvJE=;
        b=ETjF5S+F6vyqp8xD14BBvlkWN5J7Mj7/bzBIomrefzra9O0UN4PLiDy/6jiIWkc3UV
         IZnBe1TTqBxLJhRT8jUduG/qvencO3jGWqpNvpfHOAMRk04CrifkwkbcWhRYZp6HUHq1
         0lGbYdNO9hfYQts6HpAWSNRV1UapBFS96xOOJV8XmunIDBQYDnUDyTsf7McyIT+NR8Wq
         H6mjJo6cZD89+EkgBoubbpiLrOCMKvqoEB8q2IsRAkumaei7M6avUNmXai9uU43701/P
         LK6MgJBKCnG+H2p1muMmUiAejSwiQSq/66nLA7p8i+IjI8YQ6pVDBo7P+TRfo921lN/L
         bkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQC5h4tmhJe0o6/7GihSPzVFpGRqbcoLdlsbFYRWvJE=;
        b=qzZLDaY0xUEHUeaz+cvG1ngFg4dz2Ss+euhJcqX1Dq5AQZnCPEHgUi42UTAOUfaEmX
         J2SGwPEEOo+w4EBpvYjM5cNbrFMxfF79Qjy2JqD/w150JeI0A7DnutGSTjJ8izE02Zk5
         apCoDDyKNYcw39JJSLn+3eM4EkfAleeVHjrudwrOedxy4gW4ODRBVO/HneQxOwgMFGuU
         OmhXFvTWy8eCxxSYCuXDu2fSgow0A4rB3SJjI88q4O/UX3Yh5oBCSTKR+9LWg72Z8g1S
         mYO1CbM8lPUrQuZRs7DDy9T5G4zdI2YPVSLHvHK+l0kLRP8VocD+UzXMExTSXj7bzU68
         LQJA==
X-Gm-Message-State: AOAM530lY9DwVlpWqctFS/oRnJWKGGWssJF7zucF0Iqg7/a4+0Qel0g3
        QB/YhdPOYaSFGYE4gYSmuNi1EQ==
X-Google-Smtp-Source: ABdhPJyCFCumfnLKani2CUL3oiVZh0W4ll9EBQ13YKmcxlm9eCZAWXiL7vqQ0sINhFhnX0HMCgsfPw==
X-Received: by 2002:ac8:5341:: with SMTP id d1mr2849701qto.176.1599843701359;
        Fri, 11 Sep 2020 10:01:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u15sm3456866qtj.3.2020.09.11.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:01:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGmQd-0050vl-Nk; Fri, 11 Sep 2020 14:01:39 -0300
Date:   Fri, 11 Sep 2020 14:01:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200911170139.GU87483@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
 <20200911041640.20652-1-hdanton@sina.com>
 <20200911152017.18644-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911152017.18644-1-hdanton@sina.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 11, 2020 at 11:20:17PM +0800, Hillf Danton wrote:
> 
> On Fri, 11 Sep 2020 08:57:50 -0300 Jason Gunthorpe wrote:
> > On Fri, Sep 11, 2020 at 12:16:40PM +0800, Hillf Danton wrote:
> > > Detect race destroying ctx in order to avoid UAF.
> > > 
> > > +++ b/drivers/infiniband/core/ucma.c
> > > @@ -625,6 +625,10 @@ static ssize_t ucma_destroy_id(struct uc
> > >  		return PTR_ERR(ctx);
> > >  
> > >  	mutex_lock(&ctx->file->mut);
> > > +	if (ctx->destroying == 1) {
> > > +		mutex_unlock(&ctx->file->mut);
> > > +		return -ENXIO;
> > > +	}
> > >  	ctx->destroying = 1;
> > >  	mutex_unlock(&ctx->file->mut);
> > >  
> > > @@ -1826,6 +1830,8 @@ static int ucma_close(struct inode *inod
> > >  
> > >  	mutex_lock(&file->mut);
> > >  	list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
> > > +		if (ctx->destroying == 1)
> > > +			continue;
> > >  		ctx->destroying = 1;
> > >  		mutex_unlock(&file->mut);
> > >  
> > 
> > ucma_destroy_id() is called from write() and ucma_close is release(),
> > so there is no way these can race?
> 
> Sound good but what's reported is uaf in the close path, which is
> impossible without another thread releasing the ctx a step ahead
> the closer.
> Can we call it a race if that's true?

Migrate is the cause, very tricky:

		CPU0                      CPU1
	ucma_destroy_id()
				  ucma_migrate_id()
				       ucma_get_ctx()
	xa_lock()
	 _ucma_find_context()
	 xa_erase()
				       xa_lock()
					ctx->file = new_file
					list_move()
				       xa_unlock()
				      ucma_put_ctx
				   ucma_close()
				      _destroy_id()

	_destroy_id()
	  wait_for_completion()
	  // boom


ie the destrory_id() on the initial FD captures the ctx right before
migrate moves it, then the new FD closes calling destroy while the
other destroy is still running.

Sigh, I will rewrite migrate too..

Jason
