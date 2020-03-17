Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15144188EC9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 21:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQUP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 16:15:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35722 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 16:15:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id d8so34876456qka.2
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RcQJB7Wv962sHHetSf7hshBSrNKNeDkBlfxsZ1vpNAQ=;
        b=H+Zrpb6UUFLTVGuaCO9shavuaBpy9fRH43KpXyKlr5OXdSg9H1w16puFUjvChYoJG9
         arBboQbS17s9m6xViJ6DtPqCDyhZvLqQbha+Dby2Qs8EV27NiCOMbR5v0XirC8Om6Bn4
         F92d27t8rV3N3v6igdLX/nQctMIkuDUCZFV6WLVhzEWWstlgFDwHuoN9H1GAJS7KIPwO
         kwwm7DZyolGj4QLa2nT0W7uAZ9wvjOpRvnoUh7j6hLQXV4bDPi4S5sUlNXU3LagmS3BU
         JC+evzW7kC+tMMLQIjgX56i21gexoc+XPUSs9Cy98DkR8Mj6uxB6o7QQX82uL1gTjUaX
         GgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RcQJB7Wv962sHHetSf7hshBSrNKNeDkBlfxsZ1vpNAQ=;
        b=ttpLkxAPmlz9aD8Bz1naDYCYcV+agHnRrDZl8Y8764BJ1fzPHdamRJYj3X3kvziIlq
         rJVpW5vYMxWE77HX2HmgM8ODlcR0CewIAFBzn9rZQHApPgsP/UVh8joBv9yFWr4xAcPM
         cJ/RabrOEzOf1gTO4ec4VbGDBeIUlLGo4ZQWpyRIOo4esY+rqisjrawO2GkK7RsrRkO2
         /hDiW+e/a7RbyM4IrVR1efZvjXCgUQeQeXQXaPlFsCi+DPehGEVjaU6Gu3z+Jesa4s+G
         q9RnFqxO7LOAJ3r+UQOnEdXXlsKC9hRTxJlC9v66KH0O/Yym2JVe8dlnh6v9Y51nPXso
         p6ug==
X-Gm-Message-State: ANhLgQ2mhKkgegDuwaazlEGfTaVQumUBObXwtiuOVtSYDVcdmvefFTWy
        b4A9y+KcqllgOT4ShNc1owcOiw==
X-Google-Smtp-Source: ADFU+vtL85ZtLUqcFFFOB/lV2/hNJyHX2knPLqCstgkmwBYunmQ5HDwcBwxhf0dbiC+XeS4Mku1kxg==
X-Received: by 2002:ae9:e892:: with SMTP id a140mr654387qkg.274.1584476124127;
        Tue, 17 Mar 2020 13:15:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w134sm2553134qka.127.2020.03.17.13.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 13:15:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEIcU-0005IL-VY; Tue, 17 Mar 2020 17:15:22 -0300
Date:   Tue, 17 Mar 2020 17:15:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 00/15] Fix locking around cm_id.state in the
 ib_cm
Message-ID: <20200317201522.GA20284@ziepe.ca>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 11:25:30AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> >From Jason:
> 
> cm_id.state is a non-atomic value that must always be read and written
> under lock, or while the thread has the only pointer to the cm_id.
> 
> Critically, during MAD handling the cm_id.state is used to control when
> MAD handlers can run, and in turn what data they can touch. Without
> locking, an assignment to state can immediately allow concurrent MAD
> handlers to execute, potentially creating a mess.
> 
> Several of these cases only risk load/store tearing, but create very
> confusing code. For instance changing the state from IB_CM_IDLE to
> IB_CM_LISTEN doesn't allow any MAD handlers to run in either state, but a
> superficial audit would suggest that it is not locked properly.
> 
> This loose methodology has allowed two bugs to creep in. After creating an
> ID the code did not lock the state transition, apparently mistakenly
> assuming that the new ID could not be used concurrently. However, the ID
> is immediately placed in the xarray and so a carefully crafted network
> sequence could trigger races with the unlocked stores.
> 
> The main solution to many of these problems is to use the xarray to create
> a two stage add - the first reserves the ID and the second publishes the
> pointer. The second stage is either omitted entirely or moved after the
> newly created ID is setup.
> 
> Where it is trivial to do so other places directly put the state
> manipulation under lock, or add an assertion that it is, in fact, under
> lock.
> 
> This also removes a number of places where the state is being read under
> lock, then the lock dropped, reacquired and state tested again.
> 
> There remain other issues related to missing locking on cm_id data.
> 
> Thanks
> 
> It is based on rdma-next + rdma-rc patch c14dfddbd869
> ("RMDA/cm: Fix missing ib_cm_destroy_id() in ib_cm_insert_listen()")
> 
> Jason Gunthorpe (15):
>   RDMA/cm: Fix ordering of xa_alloc_cyclic() in ib_create_cm_id()
>   RDMA/cm: Fix checking for allowed duplicate listens
>   RDMA/cm: Remove a race freeing timewait_info
>   RDMA/cm: Make the destroy_id flow more robust
>   RDMA/cm: Simplify establishing a listen cm_id
>   RDMA/cm: Read id.state under lock when doing pr_debug()
>   RDMA/cm: Make it clear that there is no concurrency in
>     cm_sidr_req_handler()
>   RDMA/cm: Make it clearer how concurrency works in cm_req_handler()
>   RDMA/cm: Add missing locking around id.state in cm_dup_req_handler
>   RDMA/cm: Add some lockdep assertions for cm_id_priv->lock
>   RDMA/cm: Allow ib_send_cm_dreq() to be done under lock
>   RDMA/cm: Allow ib_send_cm_drep() to be done under lock
>   RDMA/cm: Allow ib_send_cm_rej() to be done under lock
>   RDMA/cm: Allow ib_send_cm_sidr_rep() to be done under lock
>   RDMA/cm: Make sure the cm_id is in the IB_CM_IDLE state in destroy

Applied to for-next. 

Jason
