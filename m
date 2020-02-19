Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035A7163CE3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 07:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgBSGHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 01:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgBSGHD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 01:07:03 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E7D208E4;
        Wed, 19 Feb 2020 06:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582092423;
        bh=g1Qn+FyCENEs3x5ZIIIy5GOIJg1BXRoZzKjv00OXXyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWIbGNBwthw5Gq8KCdY6vorm6d2SGQTNqr7LiR33EvkJz0BumFP2HaPNdtJaSPRA0
         pXGTdmhltKE95bbmLwwJZQcJAXsGHklopg7n5Zqf587ua4ptqIYjwrB5M3E1cmwyXB
         6X9i6PbFZClBMVMIVwH63dtbnhCt16/wgp8CWqzo=
Date:   Tue, 18 Feb 2020 22:07:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com" 
        <syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com>,
        "syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com" 
        <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        "syzbot+4b628fcc748474003457@syzkaller.appspotmail.com" 
        <syzbot+4b628fcc748474003457@syzkaller.appspotmail.com>,
        "syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com" 
        <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>,
        "syzbot+6956235342b7317ec564@syzkaller.appspotmail.com" 
        <syzbot+6956235342b7317ec564@syzkaller.appspotmail.com>,
        "syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com" 
        <syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com>,
        "syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com" 
        <syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com>,
        "syzbot+8458d13b13562abf6b77@syzkaller.appspotmail.com" 
        <syzbot+8458d13b13562abf6b77@syzkaller.appspotmail.com>,
        "syzbot+bd034f3fdc0402e942ed@syzkaller.appspotmail.com" 
        <syzbot+bd034f3fdc0402e942ed@syzkaller.appspotmail.com>,
        "syzbot+c92378b32760a4eef756@syzkaller.appspotmail.com" 
        <syzbot+c92378b32760a4eef756@syzkaller.appspotmail.com>,
        "syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com" 
        <syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20200219060701.GG1075@sol.localdomain>
References: <20200218210432.GA31966@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210432.GA31966@ziepe.ca>
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
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
> 
> Lets see if I told syzkaller about this properly..
> 
> EricB: If there are other rdma_cm related hits in syzkaller besides
> these 11 lets include them as  well. I wasn't able to find a way to
> search for things, this list is from your past email, thanks.
> 

Unfortunately I haven't had time to work on syzkaller bugs lately, so I can't
provide an updated list until I go through the long backlog of bugs.

A comment on the patch below:

> @@ -1112,13 +1134,17 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
>  	if (cmd.conn_param.valid) {
>  		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
>  		mutex_lock(&file->mut);
> +		mutex_lock(&ctx->mutex);
>  		ret = __rdma_accept(ctx->cm_id, &conn_param, NULL);
> +		mutex_unlock(&ctx->mutex);
>  		if (!ret)
>  			ctx->uid = cmd.uid;
>  		mutex_unlock(&file->mut);

This is nesting the new ucma_context::mutex inside the existing ucma_file::mut.

> @@ -1403,6 +1443,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
>  
> +	mutex_lock(&ctx->mutex);
>  	mutex_lock(&file->mut);
>  	mc = ucma_alloc_multicast(ctx);
>  	if (!mc) {

... but this is doing the opposite.  So it can deadlock.

What's the intended order?

Also, are these two separate mutexes actually needed?  I.e., did you consider
using the existing ucma_file::mut, but it didn't work or it wasn't fine-grained
enough?  (It looks like one ucma_file can have multiple ucma_contexts.)

- Eric
