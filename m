Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA242F46F5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 09:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbhAMI4s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 03:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbhAMI4r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 03:56:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC66C061575
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 00:56:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i24so1028411edj.8
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 00:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7fjkOyOWd5QBVeXWAICOZsj+o7ARRaPwLwntk8avo4=;
        b=bWDa9VmuxS6dfPgqavaqqBy4jix/j9c9QrOMdetg9hiL/uW+fvmxpoQDyWeH1Z3pj0
         4nT4MFo/lWoXQ4oXOqwQPJEctrui2aVaYt2kzGmt5QqoDz1QPwGu19KtBGVthIF7pDoO
         2EzZyl019J/U/befb82g5B4PzsiZWhe2j6VRt/7PK0dO5KzjtKwUz0Q5tp5LJqsGkPe/
         3BTaZwO6759/FNLmReW3GNIZyP7GFSPm9b39onPY0ZLQGrHiGvc78WFnj/gRAB9aStFf
         O757Xon1KGww8ZdqQL5e9KLfVsF29OMe+UlkfOPNWFF5Nrzora96MdS2s0J5Xr/ouNSE
         QwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7fjkOyOWd5QBVeXWAICOZsj+o7ARRaPwLwntk8avo4=;
        b=gX2FatuNtRTr1J92g1cp5LXrHDi5mmM3CNQClaQQX4dX43Mg09peeryz/Hpc40X1Cx
         eQOBYg6wHVLk3LHO7LHtyYvzAh2iL6p60CeLUyUJQMIDtNi48uChw5DldLzroRYdVyXP
         AQKj9twbbiiW1/2W/rAIoxHcLo7Css7AnQDIdwZkdaVAuAUPJmWaKnMcp7FXdjb1FdnR
         ZFjKSc+YR48zGbni7JHncOEWG09Va6enNmXzdKM5VwM3OySMnGOflZJoxKEI1pXclUT8
         +npNIKXsya3jp2tWM93RaNS9CJmtPWqanEUnNSXgnPrq3nMXGouRsx3CS4uyykV4VnUt
         2bYw==
X-Gm-Message-State: AOAM5301UXvcjNNbJucm5szsAHwK3tHGCQnBt0qpYOmOuVfoYCp+96Bh
        ypiPciaOW6nG1zUPl0rKHpWPDUY5/IR79rNryqmGVQ==
X-Google-Smtp-Source: ABdhPJxCc4OLzHkX7nforrq3zVKxnvXQUhgzWHS0EwK4VuazAiSrDnakkSsBKGFgz6fK+MPjjDSf6lDROoBMP52p51E=
X-Received: by 2002:a50:e845:: with SMTP id k5mr939805edn.35.1610528165888;
 Wed, 13 Jan 2021 00:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
 <20201217141915.56989-3-jinpu.wang@cloud.ionos.com> <20210112191309.GC4605@ziepe.ca>
In-Reply-To: <20210112191309.GC4605@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 13 Jan 2021 09:55:54 +0100
Message-ID: <CAMGffE=ajRJ++=aiVTKbj=QYg8OiW2GTBgwic+4mY9wSjqL4Uw@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 02/19] RMDA/rtrs-srv: Occasionally flush
 ongoing session closing
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,
On Tue, Jan 12, 2021 at 8:13 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 17, 2020 at 03:18:58PM +0100, Jack Wang wrote:
> > If there are many establishments/teardowns, we need to make sure
> > we do not consume too much system memory. Thus let on going
> > session closing to finish before accepting new connection.
>
> Then just limit it, why this scheme?
Will think about it, thanks for the suggestion.

>
> > In cma_ib_req_handler, the conn_id is newly created holding
> > handler_mutex when call this function, and flush_workqueue
> > wait for close_work to finish, in close_work rdma_destroy_id
> > will be called, which will hold the handler_mutex, but they
> > are mutex for different rdma_cm_id.
>
> No, there are multiple handler locks held here, and the new one is
> already marked nested, so isn't even the thing triggering lockdep.
>
> The locking for CM is already bonkers, I don't want to see drivers
> turning off lockdep. How are you sure that work queue doesn't become
> (and won't ever in the future) become entangled with the listening
> handler_mutex?
IIUC, only new created conn_id is passed and save in ULP. but I
understand your concerns,
I will drop this patch, think about other solution. Do you need a
resend/rebase for the reset of the patchset?
>
> Jason

Thanks!
