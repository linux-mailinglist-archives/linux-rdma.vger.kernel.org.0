Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170B8250BC5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 00:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgHXWkj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWki (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 18:40:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA5C061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 15:40:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i20so9252285qkk.8
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S0BRzZQAOYvfLXjdNexs+fzVxX6t+vGYlD+T7Uw7wc4=;
        b=FpZ18u2ZyiDYtgamXUfpe56L/F4SktuHhj+HriMONHn9kfkXBFq4mbWHE+Ax85HrOE
         yDKT0EAB214L3ehzQrFML1HM5hhr4QcLKbFMHoWO1n+z4lupId4Q6Or/xxz/vFtZEMyH
         t6T2JVJX/uz4F3gUPHvaztDdYhO4BYToLogZZhB5C+cjt//RRgeCP6k54jix7JQRFBJ5
         e8uuqfCAUOG/Bod4mlmNvHiqPmj5pWa+FNuWI5VHgosSB2089nMzBW7o9Ag8PqTPyY2/
         p30v1IeXBZ8yaVq2WQQtvVhDnJiScjRqiP/QeB/sTu66bDJNPF8FNGb6z6TrsyNIKjaz
         iwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0BRzZQAOYvfLXjdNexs+fzVxX6t+vGYlD+T7Uw7wc4=;
        b=GcHGLZSSF+meiZ9dZEu8sUrpzo6gyxWJBVFBShavOismr5yMn1EWj+Rn/o1UxIcfsc
         8yip7Wt45zEA90y2zZwK2bh3kK+4L8F3qZ/HFrkZxQtgLWol2BbwTg4KsmKSG6fCdOoP
         cz1i22lEdXlHkZCZIwvH0MLeAB1d0gFWvVGItt3VqK98psAz3t4DaIDxOP6DbdkeYN3Y
         LghO2Fbzxsv2xHpS0qnY1ZD7ATuQJxS2cWU+gcUqYOznHrQley+YLRl50K5YQeAhKgAb
         JZc5b3wiiNaC88dS84wH8YxXb1fxFqftGgAOna9TE5M12ZDNlBL/LoZiCjAnDrxN89gx
         zdWg==
X-Gm-Message-State: AOAM530aeB/jfwgdoF6z8EEo0GhtL3Rc0h3oo8qiEOb+8ccO/B2F3AAP
        nAR3GxAt3QgYDM4IWMGISwFsjKRwrfxKYQ==
X-Google-Smtp-Source: ABdhPJwJbFzAEwaBLhyOJDBmLcBKEhAM2vv3Ffm9en/LvaXei7Ia8cHnbIPyaSaFTsS2YLSqSNwYhg==
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr6680964qky.426.1598308837554;
        Mon, 24 Aug 2020 15:40:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k5sm11947222qtu.2.2020.08.24.15.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:40:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kAL8m-00E4pN-E7; Mon, 24 Aug 2020 19:40:36 -0300
Date:   Mon, 24 Aug 2020 19:40:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
Message-ID: <20200824224036.GG24045@ziepe.ca>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
 <20200824174213.GA3256703@nvidia.com>
 <5C1EC1AC-8385-4E08-9C4A-97B04AF3763B@oracle.com>
 <20200824215611.GM1152540@nvidia.com>
 <18BBE137-A534-493A-827F-7E30736793C6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18BBE137-A534-493A-827F-7E30736793C6@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 06:30:11PM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 24, 2020, at 5:56 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Aug 24, 2020 at 02:24:40PM -0400, Chuck Lever wrote:
> >> 
> >> 
> >>> On Aug 24, 2020, at 1:42 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>> 
> >>> On Mon, Aug 17, 2020 at 09:53:05AM -0400, Chuck Lever wrote:
> >>>> Oracle has an interest in a common observability infrastructure in
> >>>> the RDMA core and ULPs. Introduce static tracepoints that can also
> >>>> be used as hooks for eBPF scripts, replacing infrastructure that
> >>>> is based on printk. This takes the same approach as tracepoints
> >>>> added recently in the RDMA CM.
> >>>> 
> >>>> Change since v2:
> >>>> * Rebase on v5.9-rc1
> >>>> 
> >>>> Changes since RFC:
> >>>> * Correct spelling of example tracepoint in patch description
> >>>> * Newer tool chains don't care for tracepoints with the same name
> >>>> in different subsystems
> >>>> * Display ib_cm_events, not ib_events
> >>> 
> >>> Doesn't compile:
> >>> 
> >>> In file included from drivers/infiniband/core/cm_trace.h:414,
> >>>                from drivers/infiniband/core/cm_trace.c:15:
> >>> ./include/trace/define_trace.h:95:42: fatal error: ./cm_trace.h: No such file or directory
> >>>  95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >>>     |                                          ^
> >>> compilation terminated.
> >> 
> >> I am not able to reproduce this failure.
> >> 
> >> gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)
> > 
> > Yep, using gcc 10 too
> > 
> > Start from a clean tree?
> 
> Always.
> 
> 
> >> What if you edit drivers/infiniband/core/cm_trace.h and
> >> change the definition of TRACE_INCLUDE_PATH from "." to
> >> "../../drivers/infiniband/core" ?
> > 
> > It works
> > 
> > It is because ./ is relative to include/trace/define_trace.h ?
> 
> Yes.
> 
> It appears that the many instances of "#define TRACE_INCLUDE_PATH ."
> already in the kernel are each accompanied by Makefile magic to make
> that work correctly. I neglected (again) to add that.
> 
> But now that I've read the instructions in include/trace/define_trace.h,
> I prefer using a full relative path instead of "."-with-Makefile.
> 
> Do I need to send a v4?

No, I fixed it

Jason

