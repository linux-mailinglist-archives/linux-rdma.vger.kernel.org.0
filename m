Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A160422653
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhJEMZe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhJEMZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 08:25:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FBC061749
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 05:23:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z23so279718qtv.9
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ev+eS5M9hvPrzvsIFblfUE+sDw8UAqk1zX+42Sn5iM8=;
        b=i1FzT/9ka/sAlV7aez5j6yberi5dZKRnKXDrkqXSk1jTkvDHcCLQcBHhUbfbUw30Zx
         uC+6dxmgR9DzkyvfuejaATdTq7ue8q6KXvz11ZTWU7iSG5YskbUyyNGuU0iLJabEwQAE
         FeHMjD8tc1KzLwyriMedFRzxZmSiZP+pncfj4TUEVEO7SrMKFtUfkQwmw0R3bSC60VgC
         MAmjTeLWj7NsOQxywe/scAuziCIEA71jQHlhLQU5k9vXK1oYZO3KFW9b+IEId9nl/kbg
         MT4911R9eFxrpLnA2jkWvape1zXEO94T5XpKgQJ9vuxXGBvlqO1t6qwi5sTZZMeSMo8Q
         Drgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ev+eS5M9hvPrzvsIFblfUE+sDw8UAqk1zX+42Sn5iM8=;
        b=S3qh6sYcIE5Le2ZDuD9c5gEVqC5V6TcC6SsqmnJk7LGCYi8dkB0SJcnhYiapcTzZ9J
         hMH0TCHsmf9v6XEY8xOBlSFj+FqQp4wSppNFi6LDAFZshjoBD8VGgJDpZESI1CbtH7id
         xSQz4bStWyC65K7SbSDeOA50MMnzp9zvqUjJo5fMpuoli/moQ94QUp/D3l5UOw1b/eOd
         1Qfo1yX2f0n/xon5dP1y5Ut0TGZoqApqOnq+t2y2rRrsT7Yklg7gLVQy5zuDNEjS4PIE
         LfqNHXBB4ZxDDfgjms1OXDQIG+nk1bVZ5LNMGeyJebFx3p1HN5vqyGeFbVOEY8BSGSXr
         Bj4w==
X-Gm-Message-State: AOAM531KtgW/TkunsaFDWrZl9AX1l0OHY6SMayZWUIk17tdzgqDsScr4
        WDKX+7Tk3s0N20wDxkPQ6Ni9gA==
X-Google-Smtp-Source: ABdhPJzp9k62IhzfLACBD7mr0LQZ6x14wZEcUNoAWMonLo522jHFlJeNfuK6q1yI4ZmbtWoBnmQN2A==
X-Received: by 2002:ac8:7d12:: with SMTP id g18mr19593328qtb.82.1633436623225;
        Tue, 05 Oct 2021 05:23:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d17sm12077721qte.0.2021.10.05.05.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:23:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXjTx-00B5KK-Vh; Tue, 05 Oct 2021 09:23:42 -0300
Date:   Tue, 5 Oct 2021 09:23:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20211005122341.GE3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca>
 <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
 <20210916162850.GQ3544071@ziepe.ca>
 <20211005032901.1876-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005032901.1876-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 05, 2021 at 11:29:01AM +0800, Hillf Danton wrote:
> On Mon, 20 Sep 2021 10:13:10 +0200 Dmitry Vyukov wrote:
> >On Thu, 16 Sept 2021 at 18:28, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>
> >> On Thu, Sep 16, 2021 at 04:45:27PM +0200, Dmitry Vyukov wrote:
> >>
> >> > Answering your question re what was running concurrently with what.
> >> > Each of the syscalls in these programs can run up to 2 times and
> >> > ultimately any of these calls can race with any. Potentially syzkaller
> >> > can predict values kernel will return (e.g. id's) before kernel
> >> > actually returned them. I guess this does not restrict search area for
> >> > the bug a lot...
> >>
> >> I have a reasonable theory now..
> >>
> >> Based on the ops you provided this FSM sequence is possible
> >>
> >> RDMA_USER_CM_CMD_RESOLVE_IP
> >>   RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
> >>   does rdma_resolve_ip(addr_handler)
> >>
> >>                           addr_handler
> >>                             RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
> >>                             [.. handler still running ..]
> >>
> >> RDMA_USER_CM_CMD_RESOLVE_IP
> >>   RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
> >>   does rdma_resolve_ip(addr_handler)
> >>
> >> RDMA_DESTROY_ID
> >>   rdma_addr_cancel()
> >>
> >> Which, if it happens fast enough, could trigger a situation where the
> >> '&id_priv->id.route.addr.dev_addr' "handle" is in the req_list twice
> >> beacause the addr_handler work queue hasn't yet got to the point of
> >> deleting it from the req_list before the the 2nd one is added.
> >>
> >> The issue is rdma_addr_cancel() has to be called rdma_resolve_ip() can
> >> be called again.
> >>
> >> Skipping it will cause 'req_list' to have two items in the internal
> >> linked list with the same key and it will not cancel the newest one
> >> with the active timer. This would cause the use after free syndrome
> >> like this trace is showing.
> >>
> >> I can make a patch, but have no way to know if it is any good :\
> >
> >Good detective work!
> >
> >But if you have a theory of what happens, it's usually easy to write a
> >reproducer that aims at triggering this exact scenario.
> 
> Greate to know the gadgets on the syzkaller side!
> 
> In the scenario derived from the log of 2ee9bf346fbf
> ("RDMA/addr: Fix race with netevent_callback()/rdma_addr_cancel()"),
> 
>  CPU1			CPU2			CPU3
>  netevent_callback()	rdma_addr_cancel()	process_one_req()
>  
>  spin_lock_bh()
>  set_timeout()					req->callback()
>    mod_delayed_work(addr_wq,
>            &req->work, delay);
>  spin_unlock_bh()
>  			spin_lock_bh()
>  			list_del_init(&req->list)
>  			spin_unlock_bh()
>  			cancel_delayed_work_sync(&req->work)
>  			kfree(req)
>  						req->callback = NULL
>  
> the chance for uaf on CPU3 is not zero, given that canceling of the requeued
> work will not wait for the worker running the callback to complete.

I'm not sure what you are trying to say

Jason
