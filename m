Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFB322049
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBVTia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 14:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhBVTi2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 14:38:28 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9BC061574
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 11:37:48 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z190so13815848qka.9
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 11:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FYbFJDhKg60lLbX0Obo0od+A8LWTXpgulppUOUHY5Ws=;
        b=aCDQL/pH49A9A3sKIAY6ydX1W9f2VecAPEKZmd4apN/l2eAZH8mJ4e25T1o3HzZz+I
         qhFdFgSIRnQPSNDJIGudD2zC98uhfY6ZMe3SYavmJe+BF6nNQh9/G4aVTBwhNQwroBB+
         8LgcPbnpkSbjbjG0YN4n8jvfSa2tzvDs3dCzF0Wu8ukC8h05lq+R/aHORc6ewDWIfsS2
         zKxsuHwlGbKvMcShNrRoyGM5Tmm239plI0f9NDX6K51ekeq0winwqniT0Ct+hcxgAhMI
         /U7f10XOllLfNziFH+YZXlPFWPT464jud58MfudmCIZe+lY5dbH6CsIQtgDO+H5tvP2U
         HvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FYbFJDhKg60lLbX0Obo0od+A8LWTXpgulppUOUHY5Ws=;
        b=OA2AbafPAJcblqdND8Ste+FNcx+KF+7Md858vlLq5zM5R+pmsYpJ+y2aOe3j9EiFeD
         /7OFsWxuh1F2AB5MKP01YNiln/yMv4vigaQk84a6ceQJX/dinmchQ8+sKOzVvv/Bc3VK
         dywa0GuUYoGwTfupe3qhaqi/HLrodC41UGNynuoDqS3m8h0SXNIOxaUjx7RWgCxLL+1/
         UGIKVNXCGO8cIRajNM7ztHcOgCqzQYdcDFpZmjV4raqNqOlRSBF5jLIp23+dqdliG+KY
         r2MwPBM28MccFW44Q+t9lcERRn/ahM5Wgr4q+roseEoW4WAeoiQbpmP8H7fm4S1c+K5X
         MVdQ==
X-Gm-Message-State: AOAM532kjh5tbmI8A1W83k/IA1URS1zEHIFDjWcbeVXyvtBREzZ9m/fo
        lnpK2mPm2uGKEftHQy1xv2Uciw==
X-Google-Smtp-Source: ABdhPJwyP3qxUVzbR8gt94ZjFcCzRaPbDj210qZEn4dSpWf1jL6EiCNZYw99xevRCP3xglPI8vPphg==
X-Received: by 2002:a05:620a:14af:: with SMTP id x15mr23357916qkj.392.1614022667785;
        Mon, 22 Feb 2021 11:37:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b191sm5226211qkc.74.2021.02.22.11.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:37:47 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEH1e-00EalI-MR; Mon, 22 Feb 2021 15:37:46 -0400
Date:   Mon, 22 Feb 2021 15:37:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210222193746.GM2643399@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
 <20210222155559.GH2643399@ziepe.ca>
 <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 09:24:18PM +0200, Gal Pressman wrote:
> On 22/02/2021 17:55, Jason Gunthorpe wrote:
> > On Mon, Feb 22, 2021 at 05:36:17PM +0200, Gal Pressman wrote:
> > 
> >> "Mellanox HCAs keep track of the last index for which the user received an
> >> event. Using this index, it is guaranteed that an event is generated immediately
> >> when a request completion notification is performed and a CQE has already been
> >> reported."
> > 
> > I don't think verbs exposes this behavior.
> 
> So in theory this hardware could generate events that the user app
> doesn't expect?

Not really, it shuffles around how race conditions are resolved.

> But looking at ibv_ud_pingpong for example, I don't understand how
> that could even work.  The test arms the CQ on creation (consumder
> index 0), calls ibv_get_cq_event(), wakes up and immediately arms
> the CQ again (before polling, consumer index is still 0).

By IBTA spec this is wrong and racey.

> This means that the next ibv_get_cq_event() will wake up immediately, as the CQ
> was armed twice with the same consumer index and the first completion already
> exists. Surely that's not what's meant to happen?

If the driver for this HW stuffs the consumer index then yes, you'd
get a wakeup as though the new entries were delivered instantly after
the arm. If it stuffs the current producer index then you get behavior
like IBTA describes.

I'd say they are both compatible ways to approach this, the app can't
tell the state of the CQ, so it can't know if the new CQEs were
delievered before or after it ARM'd it.

> Do you have a way to verify whether this test gets stuck? Maybe I am
> missing something?

If the mlx5 implementation is doing like you say then it will not get
stuck on that HW, but it is not to spec

> What do you mean by arming a non-empty CQ?

The arm only has meaning if you know the CQ is empty because then you
can reliably catch the empty->!empty transition, which is the whole
point.

If the CQ is non-empty then, by spec, if no new events arrive it will
never be signaled - the app must re-poll it on its own so why arm it?

> The man pages suggest a scheme where the app should call ibv_get_cq_event()
> followed by an ibv_req_notify_cq(), the CQ polling/emptying comes after these,
> so at the time of arm the CQ isn't empty.

It doesn't show how to re-arm it seems

I'm repeating from memory here, I haven't checked the specs, but that
Sean agrees seems like I'm remembering it right :)

The question you seem to be asking is what happens if you re-arm a
non-empty CQ, do you immediately get an event or not? It should be
easy enough to test on siw, rxe and mlx5 and see

I expect by spec arming a non-empty CQ will not generate an event. The
spec was written to support very simple hardware that would simply
generate an event the next time it writes a CQE then atomically clear
the arm.

Does look like a documentation update is in-order though!

Jason
