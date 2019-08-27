Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F899F108
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfH0RBD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 13:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0RBD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 13:01:03 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED072184D;
        Tue, 27 Aug 2019 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566925262;
        bh=R7F9h5uQJlGzntybFGiaLkhr8sE4tt5MZxDxbvAJzNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVEs4Ht8U0ir6fvcOpezFkjKPvmqxAwn+FdEUcX9zNklA+hAq8P9NiwBBnYQ54Lc7
         gNZpwO3748lbaLq8djYP+/uY/W/ZSDieNn3HY+mdUtbrNcmf8yveAUqeGqPbjaNO/d
         WXaBqeDmqOMieK0pReos8pJIDyzAn7IafcP94410=
Date:   Tue, 27 Aug 2019 20:00:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190827170018.GA4725@mtr-leonro.mtl.com>
References: <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
 <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca>
 <20190826153800.GA4752@archlinux-threadripper>
 <20190826154228.GE27349@ziepe.ca>
 <20190826233829.GA36284@archlinux-threadripper>
 <20190827150830.brsvsoopxut2od66@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827150830.brsvsoopxut2od66@treble>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 10:08:30AM -0500, Josh Poimboeuf wrote:
> On Mon, Aug 26, 2019 at 04:38:29PM -0700, Nathan Chancellor wrote:
> > Looks like that comes from tune_qsfp, which gets inlined into
> > tune_serdes but I am far from an objtool expert so I am not
> > really sure what kind of issues I am looking for. Adding Josh
> > and Peter for a little more visibility.
> >
> > Here is the original .o file as well:
> >
> > https://github.com/nathanchance/creduce-files/raw/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool/platform.o.orig
>
>      574:       0f 87 00 0c 00 00       ja     117a <tune_serdes+0xdfa>
>
> It's jumping to la-la-land past the end of the function.

How is it possible?

Thanks

>
> --
> Josh
