Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A268716504D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSUyH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:54:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39281 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSUyH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 15:54:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id c5so1293882qtj.6
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLaIAW0Lkknrx7pEhMD4u2gukgtf4c3eSrw1zC53+uM=;
        b=dl7RHlWFHf6J5KKRNoP969BUk8w4nDMrtJ+aGdOUjYW3QHprh5gsqZq7QncqrqqZr4
         m6xHh6c564ahAVkep43+wkQ3fgYwkM9YhVtI8bKgRnMO1oY2+WxxHXD35c5yDG6luu2v
         3Zi+nX/FchZBVp9K50ol1q6HNC4IfwkJpH65jzk0BpYn1MsHmi6BdJgi/uy2mAIzULY6
         OUGff6e7hKDgBwdhTQ7bXcqMRGD1OQMXD/Q8q+Vkh7enZFpvJDKOqY1s83i19hYagwG0
         e8KK/pGgsBEvYSI2qH5gPpfdZtwlxuj7vERqBmO1RIadQsgaTdReUsE/4pUFSJY99yuM
         XAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLaIAW0Lkknrx7pEhMD4u2gukgtf4c3eSrw1zC53+uM=;
        b=ltDaTul9qRsvS/vusYrt5c1nSecAXQHV3an1I9TbrrNBMLw71OhqsD3Eo7hT3+oPbg
         wR6+CufmD05XENJFKdyKfqMm5pYNIT+XhSAWjPRfNnb1BwUGm4mDk+9/UfOSQ29XQaTm
         qGs0AcWI4kUSvfwWx/4BOQaIIpg9YFuAt+tx6B3hLLY1aBNkk9Dpd918HOQ3sh6WVC31
         eXtOyb55C4XHQkrgIFc+LslUfOtMwbXpvqUdSBlFJNWxPEttlBc/qX8MvshQwCaPQ/pP
         XRIFAqEUpHqR2IJY3NrVm0HNTONuS17AZ1cJPyE+fdk6JifI/2jU7cBxmlkfJknaoBtO
         ZQiw==
X-Gm-Message-State: APjAAAU8EY4oiupmGXin1CyEvZUugqOxaALSgsXDIG5QHcjlJcc3CrdJ
        sTsAU9yEtK/ktbWhzDZrFzbvOg==
X-Google-Smtp-Source: APXvYqyvdHHF5nHRsZfIaz28uyycqjYc6epPoIy4SsohMfvnnCgJwRmR5vxio4lrHBjarf5BLVSe3A==
X-Received: by 2002:ac8:5513:: with SMTP id j19mr23959953qtq.143.1582145646469;
        Wed, 19 Feb 2020 12:54:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 123sm458739qkj.113.2020.02.19.12.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:54:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WM9-0003ir-JE; Wed, 19 Feb 2020 16:54:05 -0400
Date:   Wed, 19 Feb 2020 16:54:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/core: Fix use of logical OR in get_new_pps
Message-ID: <20200219205405.GX31668@ziepe.ca>
References: <20200217204318.13609-1-natechancellor@gmail.com>
 <20200219204625.GA12915@ziepe.ca>
 <20200219205010.GA44941@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219205010.GA44941@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 01:50:10PM -0700, Nathan Chancellor wrote:
> On Wed, Feb 19, 2020 at 04:46:25PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 17, 2020 at 01:43:18PM -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > > 
> > > ../drivers/infiniband/core/security.c:351:41: warning: converting the
> > > enum constant to a boolean [-Wint-in-bool-context]
> > >         if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
> > >                                                ^
> > > 1 warning generated.
> > > 
> > > A bitwise OR should have been used instead.
> > > 
> > > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/889
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/security.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Applied to for-next, thanks
> > 
> > Jason
> 
> Shouldn't this go into for-rc since the commit that introduced this was
> merged in 5.6-rc2? I guess I should have added that after the PATCH in
> the subject line, I always forget.

Oops, that was a typo, it did go to -rc

[each artisanal 'applied' message is uniquely hand crafted]

Jason
