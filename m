Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F00321D5C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBVQre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 11:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhBVQr2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 11:47:28 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B51C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 08:46:47 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f17so13209134qkl.5
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 08:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oux3bIya7f6glqB3l5NhRGO4M7zOOvy007MEe2S9WwU=;
        b=Ce7We5UWmuoejuiaCLifW9WGYfLarSu1j6AtQQw2j3Nq9vLBo/gSZfECnq/eeffvCo
         0Gis+MD6V2xMvoVbhyiMU35RbDWVIP6aLdezgTEnNuSukvTg22rokLNNlBjdkZN0bpBl
         ipNGjAxdKWDbGJGRQ7tIhYxfVZNYRlS9ayUNoi5w36OtnNUlcXbvYCqRHkXc3gDIvLyp
         yp8DREzNaVmU/1FhaAXHby4wYoQthca70BwTYLvNFNhy/13nEd+zauoYEH4Qrw4pN97B
         0beY2b4u0Q7fM+NQG14uCQug0/kKXrEJ8/boaU9lQNkgBDdd81fKrGjlrb8EC8AME6bL
         3UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oux3bIya7f6glqB3l5NhRGO4M7zOOvy007MEe2S9WwU=;
        b=hmldaJO3nU/fhjtiIE7YnAfndxiXcpuOzMHmfur34/XXEkMqQwdgDMbeF7kEQlrWNI
         2ra29KTzN+SNjOAF+MTV4JTtjT2IFVbjL/JRWEmILEqalBHUBYtXguJ8d2G6JphqWzJe
         JXfOaqRNIdl/tO8pKpyL5wtYK7k0IjoduDLyHDmEtIDFzheKGQKDuPHb3vmFQOY10dBg
         hpHLLkYde1BwxRzqoU6EUxVt54wohBiLQUyKXpGgns5+HYN2cvUdI0xBvOjLdocgPev+
         0k5317AqxjH7+Q9pOQGNChu8jrN+IiHx0ZPnjFpm8JReo3LIFXlXognXCnnQ1qCkOh3R
         /FrQ==
X-Gm-Message-State: AOAM5316BE3jnD0zzKeXfHQiUeeUI33AjwSiFrK2A+sADPPnSx5315T4
        ZIFPR0Is92bv44y/AN0dTGNT9w==
X-Google-Smtp-Source: ABdhPJwd2aLjmgY8Mxcvx4DL7ohzVyVBGDSE1JcyiQKhaA9ytAfF62ugFUH7JdW3YLfvg3Bmdg8tuA==
X-Received: by 2002:a37:9c89:: with SMTP id f131mr22111090qke.112.1614012406931;
        Mon, 22 Feb 2021 08:46:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id y20sm959071qtw.32.2021.02.22.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:46:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEEM9-00ERw6-RV; Mon, 22 Feb 2021 12:46:45 -0400
Date:   Mon, 22 Feb 2021 12:46:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <20210222164645.GK2643399@ziepe.ca>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
 <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
 <YDOq060TvAwLgknl@unreal>
 <20210222155845.GI2643399@ziepe.ca>
 <e1e3bec7-0350-4bdd-50c3-41b21388fc71@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e3bec7-0350-4bdd-50c3-41b21388fc71@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 08:26:10AM -0800, Randy Dunlap wrote:
> On 2/22/21 7:58 AM, Jason Gunthorpe wrote:
> > On Mon, Feb 22, 2021 at 03:00:03PM +0200, Leon Romanovsky wrote:
> >> On Mon, Feb 22, 2021 at 10:39:20AM +0800, Zhu Yanjun wrote:
> >>> On Sun, Feb 21, 2021 at 2:49 PM Leon Romanovsky <leon@kernel.org> wrote:
> >>>>
> >>>> On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> >>>>> commit 6e61907779ba99af785f5b2397a84077c289888a
> >>>>> Author: Julian Braha <julianbraha@gmail.com>
> >>>>> Date:   Fri Feb 19 18:20:57 2021 -0500
> >>>>>
> >>>>>     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
> >>>>>
> >>>>>     When RDMA_RXE is enabled and CRYPTO is disabled,
> >>>>>     Kbuild gives the following warning:
> >>>>>
> >>>>>     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> >>>>>       Depends on [n]: CRYPTO [=n]
> >>>>>       Selected by [y]:
> >>>>>       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
> >>>>>
> >>>>>     This is because RDMA_RXE selects CRYPTO_CRC32,
> >>>>>     without depending on or selecting CRYPTO, despite that config option
> >>>>>     being subordinate to CRYPTO.
> >>>>>
> >>>>>     Signed-off-by: Julian Braha <julianbraha@gmail.com>
> >>>>
> >>>> Please use git sent-email to send patches and please fix crypto Kconfig
> >>>> to enable CRYPTO if CRYPTO_* selected.
> >>>>
> >>>> It is a little bit awkward to request all users of CRYPTO_* to request
> >>>> select CRYPTO too.
> >>>
> >>> The same issue and similar patch is in this link:
> >>>
> >>> https://patchwork.kernel.org/project/linux-rdma/patch/20200915101559.33292-1-fazilyildiran@gmail.com/#23615747
> >>
> >> So what prevents us from fixing CRYPTO Kconfig?
> > 
> > Yes, I would like to see someone deal with this properly, either every
> > place doing select CRYPTO_XX needs fixing or something needs to be
> > done in the crypto layer.
> > 
> > I have no idea about kconfig to give advice, I've added Arnd since he
> > always seems to know :)
> 
> I will Ack the original patch in this thread.

The one from Julian?

> How many Mellanox drivers are you concerned about?

?? This is about rxe

> You don't have to fix any other drivers that have a similar issue.

Why shouldn't they be fixed too?

There is nearly 1000 places that use a 'select CRYPTO_*' in the
kernel.

I see only 60 'select CRYPTO' statements.

Jason
