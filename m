Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1A2FADDC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbhARXtF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 18:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbhARXtC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 18:49:02 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF92C061575
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 15:48:20 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j26so12546133qtq.8
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 15:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ed3MeSa+vYjkP75JUhCh5CWMiaLqH4Gt6vdQGvVz5Zo=;
        b=ABDcFgQEdbegUPy03ChL7qFBRZLE4d5RYB+BvpnNp/pVx70pEavdhXOASQkXNf9bQN
         h0manBPX6V294ymabO4qrgBYp3em+96lwlU6IePwaAXLM+cGvU+mq3yZi0U+QOkYBEKh
         GIZqnHRjUw3J4Oxh0Wohqs2W5jyVYzok9Xcp/P5luY0VO19KChzM5IUR1OzhOLwTnul6
         lv5qcdCaKVcNYncXHvXGfKlesNbUSeHMjkX1g12IAXyuaZcKDnYdk9sWIaMIx9qPq/pc
         jDLIyHwfLFRxUtdkfBM3XowK6nVv/q9p9/UfIwRg4HX6hzpZUgNIM4Vrx0+P8z6v1PVv
         igrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ed3MeSa+vYjkP75JUhCh5CWMiaLqH4Gt6vdQGvVz5Zo=;
        b=NDiFT57uQcf8LvUtlEJhuNSu56CvDuLLKoep5Wn5Ql4OtbRgOTq28aYFZLqO9VjeCA
         +MpNPwoaH137ahfd4tk22Xv8MMk6AO1JW4dCU1OfTSsaEZsZ7pXEeXJVMMAv69rrvI64
         BFoA6M4KoHMzWNn5h9y73sk/E8uvtO5MCbFmYpmDVXAux+njDckO67b/Z2lAt+MqN+Ia
         8I9FFubn8wS418dq0DVc5WufRPnbab3MBVYM5n1d3s5vkVN1a8y66sp7pP9mJ3zt5Pfc
         Y/Sg2VAFhLwFsOP8oea7FvuJ5QQPBiKH4lgW3ew6uqAiMnC8hIqWGiBQvv4lJ7f8BZae
         ruOA==
X-Gm-Message-State: AOAM531AoKjimRrTsnl06bnv9qDp06Tk/5/7kEygKd54aodV23QLK9Jw
        e0sGfqo9ZuJTrhOOejk69F+Vmw==
X-Google-Smtp-Source: ABdhPJw5OqLaNno2QQkR/cEBquLRW/acdyvWZgzF/G8JhHWsokTQ2HltmhSKqwd7KuQY9PUDGG88qw==
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr1910197qtv.385.1611013699444;
        Mon, 18 Jan 2021 15:48:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p13sm11792293qkg.80.2021.01.18.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 15:48:18 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1eFu-003P0N-B4; Mon, 18 Jan 2021 19:48:18 -0400
Date:   Mon, 18 Jan 2021 19:48:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210118234818.GP4605@ziepe.ca>
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 18, 2021 at 10:22:56PM +0100, Bodo Stroesser wrote:
> On 18.01.21 21:24, Jason Gunthorpe wrote:
> > On Mon, Jan 18, 2021 at 03:08:51PM -0500, Douglas Gilbert wrote:
> >> On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
> >>> On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
> >>>
> >>>> After several flawed attempts to detect overflow, take the fastest
> >>>> route by stating as a pre-condition that the 'order' function argument
> >>>> cannot exceed 16 (2^16 * 4k = 256 MiB).
> >>>
> >>> That doesn't help, the point of the overflow check is similar to
> >>> overflow checks in kcalloc: to prevent the routine from allocating
> >>> less memory than the caller might assume.
> >>>
> >>> For instance ipr_store_update_fw() uses request_firmware() (which is
> >>> controlled by userspace) to drive the length argument to
> >>> sgl_alloc_order(). If userpace gives too large a value this will
> >>> corrupt kernel memory.
> >>>
> >>> So this math:
> >>>
> >>>     	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> >>
> >> But that check itself overflows if order is too large (e.g. 65).
> > 
> > I don't reall care about order. It is always controlled by the kernel
> > and it is fine to just require it be low enough to not
> > overflow. length is the data under userspace control so math on it
> > must be checked for overflow.
> > 
> >> Also note there is another pre-condition statement in that function's
> >> definition, namely that length cannot be 0.
> > 
> > I don't see callers checking for that either, if it is true length 0
> > can't be allowed it should be blocked in the function
> > 
> > Jason
> > 
> 
> A already said, I also think there should be a check for length or
> rather nent overflow.
> 
> I like the easy to understand check in your proposed code:
> 
> 	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
> 		return NULL;
> 
> 
> But I don't understand, why you open-coded the nent calculation:
> 
> 	nent = length >> (PAGE_SHIFT + order);
> 	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
> 		nent++;

It is necessary to properly check for overflow, because the easy to
understand check doesn't prove that round_up will work, only that >>
results in something that fits in an int and that +1 won't overflow
the int.

> Wouldn't it be better to keep the original line instead:
> 
> 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);

This can overflow inside the round_up

Jason
