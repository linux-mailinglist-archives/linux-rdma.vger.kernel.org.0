Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5546A317
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbhLFRjW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 12:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhLFRjV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 12:39:21 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3FC061746
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 09:35:52 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id g9so10604772qvd.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 09:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6tr1Reds9kQ+9oe0dwUbB2J9W/qli+gaQlDjPxmEfS4=;
        b=F7SoMdCKTWe4fHyJuvunnrOPAxzBB4lpolo6nRqAwGST74pMZWBnqHgRGYsu/7UuYY
         fVXYK2L1YwziaEjkgnmVF1p8OnP0VtWAZjco2ua5k0vIo6svNewaTZovSOTGw1m2dqV8
         NSZE2gNXVzS0BZ4d58XOXuLHNPOrNo39W8g2RpkMZGrcwt9Gp/UqcQn9uvkOcdLjC2FJ
         ymodjvfvinpnzPkfofJZBq/0jgjCkiQqIpMo1u5i1Quh2D3hOwXGV4UHf0GaKRt16yAS
         Gfy/8WptgauXUvqdEnk2d+nQhDjDMfGdfhZiRyPWRFmPSKyLnuWzIEwEAqkOtp1wW7JR
         CTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6tr1Reds9kQ+9oe0dwUbB2J9W/qli+gaQlDjPxmEfS4=;
        b=AxTjo7XF1tGRQ0hH9uWAYt5L34yEtM7zAv9rt6f9oRaRfIrxfZ3thJ4L0ptLHxNX1z
         64cpa8amL094LG/C74dApHfUzmF+Ge2x1VcxAcxRSA2bWPjiU3yvtVNNiahi+kAvtHjN
         Q30o5INiJF7E+GkkupY1EUKUJOYxZKlXEok1v7BmK7nSWGRfD2Sjp71NiKovIZkTVBGv
         P+dzLAaeiYPfjomL+YvnI8/1eD2Ez/G8S9+yGYCQCOWY7aS5XscpeBD7KQX46Czq5U+A
         E6v2zaFLz/DvX0sLxGpjKvRwXZ+4xd+wjo56J7SVPqUrg37GUznXpcS+92jKeLKyPrVO
         888w==
X-Gm-Message-State: AOAM533w+Wl+KtfYP3/ZCZf4ZvCLPafOQODAAWy13WLc3UJATqks59a/
        pQBHun0KT2hRvo46ck3ZBioYhA==
X-Google-Smtp-Source: ABdhPJy5cwucofkTtdDk4ZZ/Cm2K69W2AHPBFpVCP/kzA2+aoLytcEaX+Bm6fPuGDllWHTOeYlMWXA==
X-Received: by 2002:a05:6214:f09:: with SMTP id gw9mr38210398qvb.36.1638812151598;
        Mon, 06 Dec 2021 09:35:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u27sm8429201qtc.58.2021.12.06.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:35:51 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1muHu2-00900W-BG; Mon, 06 Dec 2021 13:35:50 -0400
Date:   Mon, 6 Dec 2021 13:35:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
Message-ID: <20211206173550.GQ5112@ziepe.ca>
References: <000000000000c3eace05d24f0189@google.com>
 <20211206154159.GP5112@ziepe.ca>
 <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 04:46:40PM +0100, Dmitry Vyukov wrote:
> On Mon, 6 Dec 2021 at 16:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Dec 04, 2021 at 01:54:17AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
> >
> > ??
> >
> > This commit is nearly a year old?
> >
> > $ git describe --contains bf152b0b41dc
> > v5.12-rc4~28
> >
> > I think this has probably been fixed since, why did a report for such
> > an old kernel get sent?
> 
> Hi Jason,
> 
> Oh, that's because the arm32 kernel was broken for that period, so
> syzbot tested the latest working kernel. There is a more fresh x86_64
> crash available on the dashboard:
> https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74

??

There is nothing there newer than a year?

Jason
